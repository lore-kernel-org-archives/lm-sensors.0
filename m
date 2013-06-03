From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Jun 2013 14:19:58 +0000
Subject: Re: [lm-sensors] Module load order dependency
Message-Id: <20130603161958.380973fd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <51A9CC8D.2010105@sat.dundee.ac.uk>
In-Reply-To: <51A9CC8D.2010105@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 03 Jun 2013 14:43:32 +0100, Paul Crawford wrote:
> > "lm-sensors outputs"? If you need to access hardware monitoring
> > information, please use libsensors. The problems you mentioned with
> > fancontrol precisely come from the fact that it does not use
> > libsensors. libsensors gives hardware monitoring devices stable names.
> 
> I will look in to that option, though a quick look at the man page shows 
> there is very little documentation on what you actually do with each 
> function.

I believe the manual page libsensors(3) is pretty complete. What do you
think is missing? Suggestions are welcome, and patches even more so ;)

> > (...)
> > subsystem) have tried it but it simply doesn't work. For most subsystems
> > this is now handles by udev, unfortunately hwmon devices have no node
> > in /dev so udev is of no use in our case.
> 
> In the past the watchdog used /dev/temperature for a single reading 
> (though in unspecified units) and I had assumed the /sys/class/hwmon 
> devices could be used in a similar manner.

I didn't know /dev/temperature had ever existed.

> It would be much nicer if 
> there was a /dev entry that had stable names for the underlying hardware.

The problem is that there is no read(2), write(2) or ioctl(2)
implemented for hwmon devices, so the point of having device nodes is
hard to justify.

> > (...)
> > Note though that I do not have the problem you describe with openSUSE.
> > Maybe I am just very lucky, or maybe Debian/Ubuntu starts more services
> > in parallel. If they would wait for driver autoloading to be finished
> > before starting the lm_sensors and then fancontrol services, that would
> > probably solve your problem.
> 
> Ubuntu has gone to using the upstart system for start-up and one of its 
> selling features is the greater options for paralleled starting. 
> Unfortunately the last couple of years have shown lots of problems with 
> part-migrated packages that are not started properly due to dependencies 
> that have not been properly covered.
> 
> I think though the problem here is the autoload takes place along side 
> the manual load of /etc/modules and due to the enumeration issue who (of 
> the hardware modules) gets there first changes the system behaviour.

We agree on the analysis. I suppose this could be solved by adding a
(somewhat artificial, granted) dependency between both "services" (or
whatever upstart calls these.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
