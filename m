From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Mar 2009 08:39:48 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <20090327093948.2927a5c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergio,

On Fri, 27 Mar 2009 06:03:20 +0300, sergio wrote:
> Jean Delvare wrote:
> 
> > Honestly, fan speed control under busybox doesn't strike me as the most
> > needed feature.
> Why? Many home nas'es and high performance routers have a fan.

And they need it to be software controlled? I doubt it. I'd expect them
to either have low-speed fans that don't need control, or if they need
control, I'd expect hardware control (either thermostatic or
finer-grained but controlled by the hardware monitoring chip itself.)
Anything else would be bad design.

Do you actually know of one NAS or router running busybox and needing
software-based fan speed control? Or is this just a theory?

> >>> A third possibility which was discussed in the thread I mentioned above
> >>> is a helper binary, linked with libsensors, which would take care of
> >>> translating hwmonN names to libsensors chip names and back.
> >> IMHO this is worst way.
> > Why that?
> It's look like a crutch.

Apparently I wasn't clear but I expected a detailed explanation. "I
don't like it" alone doesn't qualify, and thus doesn't let us make any
progress towards a solution.

> >> (Really, on machine with lenny it87 loads via force_load in
> >> initramfs-tools hook, so it87 is (always?) first.)
> > What is force_load? And why do you need it?
> force_load is function for initramfs-tools hook script (which runs at
> build time). It adds a module (and its dependencies) to the initramfs
> image and also unconditionally loads the module during boot.

That's kind of a misnomer, as it isn't forcing anything. It just load
the driver early.

> I need it for speed down fan, because it very noisy. Why i need do it at
> initrd time? This initrd waits for password for encrypted rootfs...

OK, I understand your setup now. But I fail to see how the it87 driver
alone helps. Loading the it87 driver shouldn't change any fan speed. So
I suppose that you also included the fancontrol script in your
initramfs, or maybe some custom script just slowing down one fan?

> >> So hwmon names jumping it's not very big problem for me.
> > Why are you reporting it then?
> Because the problem exists. And i would like that it was not.

> > There may be other similar daemons that can be extended.
> So, now only fancontrol can manage fan speed.

This isn't what I said, and this isn't correct. Just search for "fan
control" on Freshmeat for example, it returns a number of projects. And
there may be more, but please don't expect me to do your homework. I
simply do not have the time for this.

> >> May be should add possibility to define real path to device 
> >> (/sys/devices/platform/it87.552)?
> > This is a possibility, yes, and it shouldn't be too hard to implement.
> > Want to give it a try?
> See attachment.

Please don't compress patches, it only makes them harder to review.

Review:

> diff -Naur lm_sensors-3.1.0.orig/doc/fancontrol.txt lm_sensors-3.1.0/doc/fancontrol.txt
> --- lm_sensors-3.1.0.orig/doc/fancontrol.txt	2009-01-29 11:58:36.000000000 +0300
> +++ lm_sensors-3.1.0/doc/fancontrol.txt	2009-03-27 05:42:12.000000000 +0300
> @@ -99,10 +99,9 @@
>  VARIABLE2=[...]
>  
>  Each variable has its own line. The variable name is followed by an equal sign
> -and the device=value pairs. These consist of the relative path to the pwm
> -output (from /sys/bus/i2c/devices or /sys/class/hwmon depending on the kernel
> -version) for which the value is valid, equal sign followed by the value and
> -are separated by a blank.
> +and the device=value pairs. These consist of the path to the pwm output for
> +which the value is valid, equal sign followed by the value and are separated
> +by a blank. Path can be absolute or relative (from /sys/bus/i2c/devices or /sys/class/hwmon depending on the kernel version).

Please fold long lines.

>  
>  Example:
>  
> diff -Naur lm_sensors-3.1.0.orig/prog/pwm/fancontrol lm_sensors-3.1.0/prog/pwm/fancontrol
> --- lm_sensors-3.1.0.orig/prog/pwm/fancontrol	2009-02-28 22:42:51.000000000 +0300
> +++ lm_sensors-3.1.0/prog/pwm/fancontrol	2009-03-27 05:58:30.000000000 +0300
> @@ -159,8 +159,11 @@
>  	LoadConfig /etc/fancontrol
>  fi
>  
> -# Detect if config file uses the hwmon class or not yet
> -if echo "${AFCPWM[0]}" | egrep -q '^hwmon[0-9]'
> +# Detect path to sensors
> +if echo "${AFCPWM[0]}" | egrep -q '^/'
> +then
> +	DIR=/
> +elif echo "${AFCPWM[0]}" | egrep -q '^hwmon[0-9]'
>  then
>  	DIR=/sys/class/hwmon
>  else

Simple enough, the only drawback is that you can't mix absolute and
relative paths in the same configuration file. As not all hwmon class
devices have a device backing them up, this could be a problem for some
users.

Maybe it is the right time to rework this part of the script and
resolve each path in the configuration file separately. Absolute paths
would stay as is, and relative paths would be prefixed with
either /sys/class/hwmon/ (if they start with hwmon[0-9])
or /sys/bus/i2c/devices/ (if they don't).

Also, to be truly useful for users, the possibility to use absolute
paths should be used by the pwmconfig script, by following and
resolving the device link of hwmon class devices before writing the
configuration file. Care to give it a try?

> diff -Naur lm_sensors-3.1.0.orig/prog/pwm/fancontrol.8 lm_sensors-3.1.0/prog/pwm/fancontrol.8
> --- lm_sensors-3.1.0.orig/prog/pwm/fancontrol.8	2009-01-29 11:58:36.000000000 +0300
> +++ lm_sensors-3.1.0/prog/pwm/fancontrol.8	2009-03-27 01:01:06.000000000 +0300
> @@ -81,10 +81,9 @@
>  .fi
>  .PP
>  Each variable has its own line. The variable name is followed by an equal sign
> -and the device=value pairs. These consist of the relative path to the pwm
> -output (from /sys/bus/i2c/devices or /sys/class/hwmon
> -depending on the kernel version) for which the value is valid, equal sign
> -followed by the value and are separated by a blank. Example:
> +and the device=value pairs. These consist of the path to the pwm output for
> +which the value is valid, equal sign followed by the value and are separated
> +by a blank. Path can be absolute or relative (from /sys/bus/i2c/devices or /sys/class/hwmon depending on the kernel version). Example:

Please fold long lines.

>  .IP
>  MINTEMP=w83627hf-isa-0290/pwm2@ w83627hf-isa-0290/pwm1T

Totally outdated example, BTW, it should be updated.

>  .PP


> > Not to say that it can't be done properly for hwmon devices. But do
> > you have some concrete proposal? "Let's just use udev" doesn't tell me
> > much.
> I don't clearly understand how udev works.

OK, so it was just hand-waiving. Wonderful.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
