From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Sep 2012 09:03:35 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <20120911110335.68009452@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
	<20120911091204.24fd1510@endymion.delvare>
	<4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Tue, 11 Sep 2012 08:55:34 +0000, R, Durgadoss wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > * Extend libsensors to be able to deal with thermal drivers directly.
> >   If thermal devices are presented with a reasonable sysfs interface,
> >   then why not.
> (...)
> Now that I know about sensors/libsensors, if the purpose of using
> this #define is to expose the thermal zones to 'sensors' command,
> then I think it's better we go with your third option (above), since
> we have the sysfs interfaces standardized (/sys/class/thermal/)

Is there a document describing this sysfs interface?

Will you write and submit the required libsensors patches, or do you
expect me to take care of that?

Note: if the same device can now be registered as both hwmon and
thermal, we will have to find a way to detect that to avoid duplicate
entries in libsensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
