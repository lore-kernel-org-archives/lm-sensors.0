From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 11 Sep 2012 09:24:27 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591B72C6@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
	<20120911091204.24fd1510@endymion.delvare>
	<4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
 <20120911110335.68009452@endymion.delvare>
In-Reply-To: <20120911110335.68009452@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, September 11, 2012 2:34 PM
> To: R, Durgadoss
> Cc: Guenter Roeck; Zhang, Rui; Len Brown; lm-sensors@lm-sensors.org;
> linux-acpi@vger.kernel.org
> Subject: Re: CONFIG_THERMAL_HWMON in thermal_sys.c
> 
> On Tue, 11 Sep 2012 08:55:34 +0000, R, Durgadoss wrote:
> > > -----Original Message-----
> > > From: Jean Delvare [mailto:khali@linux-fr.org]
> > > * Extend libsensors to be able to deal with thermal drivers directly.
> > >   If thermal devices are presented with a reasonable sysfs interface,
> > >   then why not.
> > (...)
> > Now that I know about sensors/libsensors, if the purpose of using
> > this #define is to expose the thermal zones to 'sensors' command,
> > then I think it's better we go with your third option (above), since
> > we have the sysfs interfaces standardized (/sys/class/thermal/)
> 
> Is there a document describing this sysfs interface?

It is in Documentation/thermal/sysfs-api.txt

> 
> Will you write and submit the required libsensors patches, or do you
> expect me to take care of that?

I have not tried anything with libsensors until now..so it will take
some time for me. If you can wait, I can happily submit the required
patches :-)

But, we are changing the thermal framework quite a bit these days.
In some time, things should become saner. Until then, we will not
remove this #define and keep it as it is. Once that happens, we can
take care of removing this #defined code and also patching
libsensors.

We can do this now also. I know, we are changing things on
the thermal side (sysfs attribute names etc..).  If we patch 
libsensors now, then we might have to re-visit again, soon.
That's why, I would like to defer this until things settle down on the
Thermal side.

Let me know what you think.

> 
> Note: if the same device can now be registered as both hwmon and
> thermal, we will have to find a way to detect that to avoid duplicate
> entries in libsensors.
 
The hwmon sysfs has a 'name' field. We can pass the same string as the
first argument of the thermal_zone_device_register() call. This will
show up as 'type' attribute under /sys/class/thermal/thermal_zoneX.
So, from user space, we can compare these interfaces and thus avoid
the duplicates.

Thank you Jean,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
