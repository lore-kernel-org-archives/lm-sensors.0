From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 16 Dec 2005 03:57:48 +0000
Subject: [lm-sensors] mlseep() --> Kernel hangs with i2c-i801 driver?
Message-Id: <20051216035748.GB4026@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051215173818.18283.qmail@web31211.mail.mud.yahoo.com>
In-Reply-To: <20051215173818.18283.qmail@web31211.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

Please use linefeeds.  Please start a new thread when appropriate.

* MK GU <mkgu_2005 at yahoo.ca> [2005-12-15 12:38:18 -0500]:
>   I am using the i2c-i801 bus driver for our own device driver. In my
> project, the SMB Alert signal is used to generate an interrupt (IRQ 11
> for our ICH6 SMBus controller on my host). I call the function
> i2c_smbus_xfer() to do data transfers. I got error messages and my
> kernel hangs when this function is called in a tasklet handler function
> set by my interrupt handler. But there is no problem when calling this
> function outside the interrupt handler and its tasklet handler. Further
> debug messages show that the error messages occured during the call to
> function msleep(1) in i801_block_transaction(). Part of the error
> messages is shown below:
> [...]

Yeah, that's by design.  The function i2c_smbus_xfer() can sleep, which is
not allowed in a tasklet.  Use a workqueue instead.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


