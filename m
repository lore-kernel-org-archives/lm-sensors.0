From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 13:20:22 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117131940.66037b1c@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Nov 2005 12:49:14 +0100 (CET)
"Jean Delvare" <khali@linux-fr.org> wrote:

> OK, so what you call "specific", I call "generic" ;) Sure, exporting
> functions is not suitable for a generic interface. You want to either
> define an ioctl-like interface (f(target, command, &parameter), but Greg

 exactly. or, at least, document what i2c_driver->command should be used
 for. If it can be used for ioctls, and only for them, then we have no problems.

 If we can use command for whatever we want, the i2c_clients_commands
 must be removed, otherwise we are going to have oopses.

 It's just a matter of writing things down.



> > That would bind the i2c driver definitely with its rtc counterpart.
> 
> Exactly the contrary. There would no more be a specific rtc counterpart,
> or at least it would no more bound directly to the i2c part. This is the
> point of having a core and well-defined interfaces.

 I agree, but we still have to define the interface between the i2c_driver
 and the external world, as i2c_driver->command is not adeguately documented.



> platform-rtc <-> rtc-core <-> rtc-i2c
> 
> What you call "rtc counterpart of the rtc-i2c driver" is actually
> platform-specific. The same RTC chip could be used as the system RTC on
> one system, and used differently on other systems. We don't want to
> write as many drivers as platforms for the same chip.

 I agree. I think we are saying similar things with different
 terms.. Let's do an example with the X1205: 

 if you want to use it you must

 modprobe x1205

 if you want to _also_ use it as the system RTC, you should
 _also_

 modprobe rtc-i2c-interfacing-driver

 which will take care of interfacing x1205 with the kernel rtc 
 subsytem.

 Do we agree here?


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

