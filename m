From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 11 Sep 2012 08:55:34 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
 <20120911091204.24fd1510@endymion.delvare>
In-Reply-To: <20120911091204.24fd1510@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Jean,

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, September 11, 2012 12:42 PM
> To: R, Durgadoss
> Cc: Guenter Roeck; Zhang, Rui; Len Brown; lm-sensors@lm-sensors.org;
> linux-acpi@vger.kernel.org
> Subject: Re: CONFIG_THERMAL_HWMON in thermal_sys.c
> 
> Hi Durga,
> 
> On Tue, 11 Sep 2012 05:07:29 +0000, R, Durgadoss wrote:
> > In thermal_sys.c we have a CONFIG_THERMAL_HWMON.
> > If enabled, this creates sysfs nodes for thermal zones inside
> > hwmon. Do we need this functionality inside thermal_sys.c ?
> > Or is it Ok to remove this ?
> 
> It isn't OK to remove it unless you offer an alternative implementation
> doing the same.
> 
> The idea is that thermal zones and in particular ACPI thermal zones
> show up in the "sensors" command, and are thus available to monitoring
> applications through libsensors. If you want to remove the bridge code

Oh .. I did not know this. Thanks for educating me !!

> from thermal zones to hwmon, you must either:
> * Register every thermal device as a hwmon device explicitly. I don't
>   see any point in doing that, the generic code we have today is
>   certainly easier to maintain.

Completely agree with you. I don't want to do this.

> * Move the generic code somewhere else. I know there have been a lot of
>   discussions about thermal devices lately, I admit I did not follow
>   them. If there's a better place for the generic code now, that's fine
>   with me.
> * Extend libsensors to be able to deal with thermal drivers directly.
>   If thermal devices are presented with a reasonable sysfs interface,
>   then why not.

Yes, The thermal subsystem presents all sysfs under /sys/class/thermal/
as thermal_zoneX and all cooling devices under /sys/class/thermal/
as cooling_deviceY. The framework does some monitoring to manage
the platform thermals.

> 
> But I'm not sure I understand what problem you are trying to solve.
> What's wrong with the current code?

Nothing wrong with the current code. My thought was (before your
mail educated me):
1. Certainly hwmon drivers don't need this #define inside thermal_sys.c
2. Drivers inside thermal subsystem are not gaining anything using this
#define.

Now that I know about sensors/libsensors, if the purpose of using
this #define is to expose the thermal zones to 'sensors' command,
then I think it's better we go with your third option (above), since
we have the sysfs interfaces standardized (/sys/class/thermal/)

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
