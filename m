From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Mon, 03 Jun 2013 13:43:32 +0000
Subject: Re: [lm-sensors] Module load order dependency
Message-Id: <51AC9D84.40701@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <51A9CC8D.2010105@sat.dundee.ac.uk>
In-Reply-To: <51A9CC8D.2010105@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,
> The latest version of fancontrol supports absolute device paths, which
> should help a bit in this respect. It isn't perfect yet, because:
> 1* pwmconfig still writes relative paths so you have to
>     edit /etc/fancontrol manually. I have just created a ticket for that:
>     http://www.lm-sensors.org/ticket/2388

Thanks for that.

> 2* Absolute paths aren't necessarily persistent. PCI and platform
>     device paths are persistent but I2C bus numbers are not. So using
>     absolute paths doesn't guarantee that fancontrol will find the
>     devices it looks for after every reboot.

OK, I had not realised there was yet another aspect to the enumeration 
beyond the module load order :(

> "lm-sensors outputs"? If you need to access hardware monitoring
> information, please use libsensors. The problems you mentioned with
> fancontrol precisely come from the fact that it does not use
> libsensors. libsensors gives hardware monitoring devices stable names.

I will look in to that option, though a quick look at the man page shows 
there is very little documentation on what you actually do with each 
function.

> subsystem) have tried it but it simply doesn't work. For most subsystems
> this is now handles by udev, unfortunately hwmon devices have no node
> in /dev so udev is of no use in our case.

In the past the watchdog used /dev/temperature for a single reading 
(though in unspecified units) and I had assumed the /sys/class/hwmon 
devices could be used in a similar manner. It would be much nicer if 
there was a /dev entry that had stable names for the underlying hardware.

> The code there is horrible ;)

Indeed, but it seems to work!

> /etc/modules is a Debian/Ubuntu specific approach. Your workaround
> should work fine as far as I can see, although this is obviously a step
> backwards (driver autoloading is a great feature.) Unfortunately we

autoloading is great until it shows up something unstable in the system 
behaviour!

> Note though that I do not have the problem you describe with openSUSE.
> Maybe I am just very lucky, or maybe Debian/Ubuntu starts more services
> in parallel. If they would wait for driver autoloading to be finished
> before starting the lm_sensors and then fancontrol services, that would
> probably solve your problem.

Ubuntu has gone to using the upstart system for start-up and one of its 
selling features is the greater options for paralleled starting. 
Unfortunately the last couple of years have shown lots of problems with 
part-migrated packages that are not started properly due to dependencies 
that have not been properly covered.

I think though the problem here is the autoload takes place along side 
the manual load of /etc/modules and due to the enumeration issue who (of 
the hardware modules) gets there first changes the system behaviour.

Regards, Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
