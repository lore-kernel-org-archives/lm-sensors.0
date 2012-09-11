From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 13:45:05 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <20120911134505.GA4123@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
 <20120911091204.24fd1510@endymion.delvare>
 <4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
 <20120911110335.68009452@endymion.delvare>
 <4D68720C2E767A4AA6A8796D42C8EB591B72C6@BGSMSX101.gar.corp.intel.com>
 <20120911114921.2e39e28c@endymion.delvare>
In-Reply-To: <20120911114921.2e39e28c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Tue, Sep 11, 2012 at 11:49:21AM +0200, Jean Delvare wrote:
> On Tue, 11 Sep 2012 09:24:27 +0000, R, Durgadoss wrote:
> > I have not tried anything with libsensors until now..so it will take
> > some time for me. If you can wait, I can happily submit the required
> > patches :-)
> > 
> > But, we are changing the thermal framework quite a bit these days.
> > In some time, things should become saner. Until then, we will not
> > remove this #define and keep it as it is. Once that happens, we can
> > take care of removing this #defined code and also patching
> > libsensors.
> > 
> > We can do this now also. I know, we are changing things on
> > the thermal side (sysfs attribute names etc..).  If we patch 
> > libsensors now, then we might have to re-visit again, soon.
> > That's why, I would like to defer this until things settle down on the
> > Thermal side.
> > 
> > Let me know what you think.
> 
> I agree, let's wait for the interface to stabilize, there's no point in
> updating libsensors publicly now if the interface is going to change in
> a near future.
> 
> That being said you may also want to anticipate a bit in private, to
> make sure that the interface as it exists today is enough for
> libsensors.
> 
> > > Note: if the same device can now be registered as both hwmon and
> > > thermal, we will have to find a way to detect that to avoid duplicate
> > > entries in libsensors.
> >  
> > The hwmon sysfs has a 'name' field. We can pass the same string as the
> > first argument of the thermal_zone_device_register() call. This will
> > show up as 'type' attribute under /sys/class/thermal/thermal_zoneX.
> > So, from user space, we can compare these interfaces and thus avoid
> > the duplicates.
> 
> This is a start, yes. However the name isn't necessarily unique, so
> more tricks may be needed.
> 
I do wonder what is going to happen with existing hwmon temperature sensor
drivers which are needed as thermal drivers. Re-write/copy ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
