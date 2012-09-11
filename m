From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Sep 2012 07:12:04 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <20120911091204.24fd1510@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

Hi Durga,

On Tue, 11 Sep 2012 05:07:29 +0000, R, Durgadoss wrote:
> In thermal_sys.c we have a CONFIG_THERMAL_HWMON.
> If enabled, this creates sysfs nodes for thermal zones inside
> hwmon. Do we need this functionality inside thermal_sys.c ?
> Or is it Ok to remove this ?

It isn't OK to remove it unless you offer an alternative implementation
doing the same.

The idea is that thermal zones and in particular ACPI thermal zones
show up in the "sensors" command, and are thus available to monitoring
applications through libsensors. If you want to remove the bridge code
from thermal zones to hwmon, you must either:
* Register every thermal device as a hwmon device explicitly. I don't
  see any point in doing that, the generic code we have today is
  certainly easier to maintain.
* Move the generic code somewhere else. I know there have been a lot of
  discussions about thermal devices lately, I admit I did not follow
  them. If there's a better place for the generic code now, that's fine
  with me.
* Extend libsensors to be able to deal with thermal drivers directly.
  If thermal devices are presented with a reasonable sysfs interface,
  then why not.

But I'm not sure I understand what problem you are trying to solve.
What's wrong with the current code?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
