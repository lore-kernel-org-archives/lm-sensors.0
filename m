From: lmsensors@kosowsky.org
Date: Sun, 08 Apr 2007 20:17:31 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <m2irc6vcx0.fsf@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06 Apr 2007 13:21:59 -0400, jk wrote:
> > I am then surprised that many more people are not having this
> > problem. It would seem then that this "race condition" would apply to
> > anybody who had more than one i2c bus.
> 
> Let me guess, your kernel is compiled with
> CONFIG_PCI_MULTITHREAD_PROBE=y?
 
I don't know. I am using a standard Fedora Core 2.6.20 kernel and I
don't see that option name in the top level .config file. Should I be
looking elsewhere in the tree for that variable name?
 
> > Perhaps though there are not many people who are using sensord/rrd
> > though... (however, if you are and set up the crontab as recommended
> > then you will get cron email errors mailed to you every 5 minutes :)
> 
> First of all, the right way to look for hardware monitoring devices
> on a reasonably recent Linux 2.6 kernel is through /sys/class/hwmon.
> Historically, tools have been assuming that hardware monitoring devices
> were always presented as I2C devices and looked for them
> in /sys/bus/i2c/devices, but this is no longer correct. Granted though,
> libsensors still identifies i2c devices using their i2c device names
> internally. Maybe we'll need to change that someday. That being said,
> it moves the problem more than it solves it, when more than one
> hardware monitoring device is present on a system (which becomes more
> frequent these days.)

That is good to know about /sys/class/hwmon since that will presumably
solve my problems directly. 

I think though that part of the problem is that many of the user-space
programs and documentation in the lm_sensors tarball (at least in
version 2.10.1) are not updated for recent 2.6 kernels.

For example, the program sens_update_rrd looks in either
/proc/sys/dev/sensors (which is obsolete) or in /sys/bus/i2c/devices
(which gives the problems I have).

Instead it should just go to /sys/class/hwmon and be done with it!

Also, just as a random example, the documentation for sensors.conf
when discussing about the BUS STATEMENT (which I found by your reference
below) only talks about /proc/bus/i2c which is obsolete for 2.6
kernels. Similarly, it references the program
prog/config/grab_busses.sh which only works in 2.4 kernels.

So, I guess the better question is whether anybody plans on updating
the documentation and auxiliary programs in the lm_sensors tarball to
reflect 2.6 kernels in general and "later" 2.6 kernels in particular.

> Secondly, libsensors supports consistent i2c bus numbering for years,
> for specific-device configuration sections. See the "BUS STATEMENT"
> section in sensors.conf(5).
> 
> This doesn't cover all cases, but these are things to keep in mind when
> facing device naming issues.
> 
> -- 
> Jean Delvare
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
