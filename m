From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <sovSSBoW.1115884900.2842860.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitri,

> I've a problem with setting fan control. After I find your
> suggestions on http://lkml.org/lkml/2005/1/19/244 I hope you could help
> me.
>
> I have:
> Handle 0x0002
>         DMI type 2, 8 bytes.
>         Base Board Information
>                 Manufacturer: Gigabyte Technology Co., Ltd.
>                 Product Name: 8I845GV
>                 Version: 1.x
>
> lm_sensors detected:
>
> # I2C adapter drivers
> modprobe i2c-i810
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe it87
>
> But there are no pwm registers in /sys/bus/i2c/devices/*/

Which kernel version are you using?

Check your logs when loading the it87 driver. Do you see a complaint
about bogus fan polarity, or any other warning?

--
Jean Delvare
