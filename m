From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jan 2013 08:41:41 +0000
Subject: Re: [lm-sensors] "Detected by sensors-detect : No"
Message-Id: <20130107094141.1a930861@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nicolas,

On Sat, 29 Dec 2012 03:00:13 +0100, nicolas maloeuvre wrote:
>  Hello,
> I wonder if i could see and/or control fan speed of my laptop. With
> "sensors-detect", three modules were loaded : coretemp, max6650 and sbs.
> max6650 is a fan speed regulator so i want it.
> http://www.lm-sensors.org/wiki/Devices says that max6650 cannot be detected
> by sensors-detect so there is a contradiction.

The contradiction comes from the fact that you are running an old
version of sensors-detect. As seen in the changelog, detection of the
Maxim MAX6650 was dropped in version 3.3.1 because it was unreliable.

And as a matter of fact, it is very unlikely that you have a Maxim
MAX6650 in your laptop.

> When i launch "sensors"
> there is no fan controller. So fancontrol doesn't work.

Fan speed control on most laptops is achieved either through ACPI or
platform-specific drivers, not generic hwmon ones. sensors-detect
doesn't know about these, nor does fancontrol.

> Driver `sbs':
>   * Bus `Radeon i2c bit bus 0x96'
>     Busdriver `drm', I2C address 0x0b
>     Chip `Smart Battery' (confidence: 5)

FWIW, this is most certainly a misdetection too, as the Smart Battery
would be on your SMBus and not your graphics chip's I2C bus. 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
