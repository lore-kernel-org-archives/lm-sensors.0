From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 11:01:40 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070409130140.0dd73ea7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08 Apr 2007 16:17:31 -0400, lmsensors@kosowsky.org wrote:
> On 06 Apr 2007 13:21:59 -0400, jk wrote:
> > > I am then surprised that many more people are not having this
> > > problem. It would seem then that this "race condition" would apply to
> > > anybody who had more than one i2c bus.
> > 
> > Let me guess, your kernel is compiled with
> > CONFIG_PCI_MULTITHREAD_PROBE=y?
>  
> I don't know. I am using a standard Fedora Core 2.6.20 kernel and I
> don't see that option name in the top level .config file. Should I be
> looking elsewhere in the tree for that variable name?

No, .config is the right place to look at. I'm asking because this is
the only option I know of which may cause a given kernel to number i2c
busses differently across reboots. If not that, maybe the Fedora Core
init scripts are doing something unexpected, in which case we can't
help.

> > First of all, the right way to look for hardware monitoring devices
> > on a reasonably recent Linux 2.6 kernel is through /sys/class/hwmon.
> > Historically, tools have been assuming that hardware monitoring devices
> > were always presented as I2C devices and looked for them
> > in /sys/bus/i2c/devices, but this is no longer correct. Granted though,
> > libsensors still identifies i2c devices using their i2c device names
> > internally. Maybe we'll need to change that someday. That being said,
> > it moves the problem more than it solves it, when more than one
> > hardware monitoring device is present on a system (which becomes more
> > frequent these days.)
> 
> That is good to know about /sys/class/hwmon since that will presumably
> solve my problems directly. 
> 
> I think though that part of the problem is that many of the user-space
> programs and documentation in the lm_sensors tarball (at least in
> version 2.10.1) are not updated for recent 2.6 kernels.

True. Their number is hopefully shrinking, but there may be a couple
scripts still not ported.

> For example, the program sens_update_rrd looks in either
> /proc/sys/dev/sensors (which is obsolete) or in /sys/bus/i2c/devices
> (which gives the problems I have).

/proc/sys/dev/sensors isn't really obsolete, it is the right place to
look at for 2.4 kernels.

sens_update_rrd is not maintained as far as I know so I am not
surprised if you have some problems with it.

> Instead it should just go to /sys/class/hwmon and be done with it!

No, doing so would break compatility with older kernels. The right
thing to do is to look in /sys/class/hwmon first and fallback to old
places if that didn't work. This is what libsensors does.

> Also, just as a random example, the documentation for sensors.conf
> when discussing about the BUS STATEMENT (which I found by your reference
> below) only talks about /proc/bus/i2c which is obsolete for 2.6
> kernels. Similarly, it references the program
> prog/config/grab_busses.sh which only works in 2.4 kernels.
> 
> So, I guess the better question is whether anybody plans on updating
> the documentation and auxiliary programs in the lm_sensors tarball to
> reflect 2.6 kernels in general and "later" 2.6 kernels in particular.

What about you? Maybe you could stop complaining and actually help the
project?

I don't use sens_update_rrd myself, nor prog/config/grab_busses.sh, nor
bus statements. You do. Why would you expect me or anyone else to fix
them?

> > Secondly, libsensors supports consistent i2c bus numbering for years,
> > for specific-device configuration sections. See the "BUS STATEMENT"
> > section in sensors.conf(5).
> > 
> > This doesn't cover all cases, but these are things to keep in mind when
> > facing device naming issues.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
