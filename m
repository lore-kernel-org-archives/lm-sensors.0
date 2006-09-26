From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 21:09:40 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <20060926230940.c49bd44a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > 2 - sensors-deamon locks the directory to preclude loss of alarms (is 
> > > this possible ? bad idea ?)
> >
> > Which daemon?
>
> sensorsd - not that it matters.

The only sensorsd I know of runs on OpenBSD. Did you mean sensord?
Sensord wasn't designed to be a central access point to the sensors
data, it's merely a resident monitoring application and nothing more.

> But Ive added a couple lines to Doc/hwmon/sysfs-interface, on the 
> assumption that
> app-writers will read it, where they now learn of libsensors, but might 
> miss this fact otherwise.
> 
> 
> Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>
> 
> $ diffstat diff.doc-touches.20060926.140844
>  Documentation/hwmon/sysfs-interface |    8 ++++----
> 
> 
> diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.18-rc6-mm2-sk/Documentation/hwmon/sysfs-interface doc-touches/Documentation/hwmon/sysfs-interface
> --- linux-2.6.18-rc6-mm2-sk/Documentation/hwmon/sysfs-interface	2006-09-07 16:09:40.000000000 -0600
> +++ doc-touches/Documentation/hwmon/sysfs-interface	2006-09-26 14:04:19.000000000 -0600
> @@ -23,6 +23,7 @@ voltages between 0 and +4V. Other voltag
>  range using external resistors. Since the values of these resistors
>  can change from motherboard to motherboard, the conversions cannot be
>  hard coded into the driver and have to be done in user space.
> +Therefore, all sysfs values are fixed point numbers.

I see no cause-to-consequence relation here, so why the "therefore"?
What problem are you trying to address by moving this sentence around?

>  For this reason, even if we aim at a chip-independent libsensors, it will
>  still require a configuration file (e.g. /etc/sensors.conf) for proper
> @@ -35,8 +36,9 @@ access this data in a simple and consist
>  will have to implement conversion, labeling and hiding of inputs. For
>  this reason, it is still not recommended to bypass the library.
>  
> -If you are developing a userspace application please send us feedback on
> -this standard.
> +If you are developing a userspace application please send us feedback
> +on this standard.  Note that applications are expected to read all the
> +sysfs files at once, you may miss transient alarms otherwise.

Or you could leave the "on" where it was, so that the diff doesn't look
bigger than it really is?

You are putting the things in the wrong order, I think. The
applications are not expected to read all the sysfs values at once, it
just happens to be what they all do at the moment. And nothing really
wrong will happen if they don't. The different behavior of transient
alarms is a minor annoyance, because, as I explained earlier, nobody
really cares about transient alarms. In fact, people may even be
_happy_ to miss them. So why frighten them with something we don't
expect to bother them at all?

>  Note that this standard isn't completely established yet, so it is subject
>  to changes. If you are writing a new hardware monitoring driver those
> @@ -48,8 +50,6 @@ Each chip gets its own directory in the 
>  find all sensor chips, it is easier to follow the device symlinks from
>  /sys/class/hwmon/hwmon*.
>  
> -All sysfs values are fixed point numbers.
> -
>  There is only one value per file, unlike the older /proc specification.
>  The common scheme for files naming is: <type><number>_<item>. Usual
>  types for sensor chips are "in" (voltage), "temp" (temperature) and

-- 
Jean Delvare

