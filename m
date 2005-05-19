From: minyard@acm.org (Corey Minyard)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Adding an async I2C interface
Message-Id: <41F50E9D.3050702@acm.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sensors <sensors@stimpy.netroedge.com>, lkml <linux-kernel@vger.kernel.org>

I have an IPMI interface driver that sits on top of the I2C code.  I'd
like to get it into the mainstream kernel, but I have a few problems
to solve first before I can do that.  The I2C code is synchronous and
must run from a task context.  The IPMI driver has certain
operations that occur at panic time, including:

   * Storing panic information in IPMI's system event log
   * Extending the watchdog timer so it doesn't go off during panic
     operations (like kernel coredumps).
   * Powering the system off

I can't really put the IPMI SMB interface into the kernel until I can
do those operations.  Also, I understand that some vendors put RTC
chips onto the I2C bus and this must be accessed outside task context,
too.  I would really like add asynchronous interface to the I2C bus
drivers.  I propose:

   * Adding an async send interface to the busses that does a callback
     when the operation is complete.
   * Adding a poll interface to the busses.  The I2C core code could
     call this if a synchronous call is made from task context (much
     like all the current drivers do right now).  For asyncronous
     operation, the I2C core code would call it from a timer
     interrupt.  If the driver supported interrupts, polling from the
     timer interrupt would not be necessary.
   * Add async operations for the user to call, including access to the
     polling code.
   * If the driver didn't support an async send, it would work as it
     does today and the async calls would return ENOSYS.

This way, the bus drivers on I2C could be converted on a
driver-by-driver basis.  The IPMI code could query to see if the
driver supported async operations.  And the RTC code could use it,
too.

Is this ok with the I2C community?  I would do the base work and
convert over a few drivers.

Thanks,

-Corey
