From: lu zhihe <tombowfly@gmail.com>
Date: Mon, 13 Jul 2009 13:24:57 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <73511e6c0907130624n8db8319nbf277cad05e43dae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


>2009/7/13 Jean Delvare <khali@linux-fr.org>:

>> intel-agp.c has 2432 LOC and only deals with AGP/GART table management. I
>> don't think anybody would be amused to see other code in there.
>
> Well, the driver posted by Lu was rather small, and most of it is for
> device management, not functionality. Adding temperature reading to
> another driver would probably fit in 250 lines.

I agree with you.
While, as there is not GM965 North Bridge driver direct process
MCHBAR_I965 (MCH Memory Mapped Register BAR), if any driver module try
to support GM965 thermal sensor, it need to call "pci_get_device",
read the MCHBAR base address, and do ioremap_nocache to access the
Thermal sensor register.

If it doesn't do on drivers/hwmon, it need to do on drivers/char/agp
or some how.


>2009/7/12 Jean Delvare <khali@linux-fr.org>:
>It's a limitation of the device driver model to only let one driver bind t=
o a given device at any given time.

I understand what you means, it DID has PCI driver conflict when two
driver register as PCI device.
While, apggart-intel is registed as PCI driver, gm965temp is as
Platfrom devices driver. Gm965temp uses "pseudo-bus".

Take a "tree -d /sys/device" snapshot:

|-- pci0000:00
| =A0 |-- 0000:00:00.0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0***
| =A0 | =A0 |-- bus -> ../../../bus/pci =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0***
| =A0 | =A0 |-- driver -> ../../../bus/pci/drivers/agpgart-intel =A0 ***
| =A0 | =A0 |-- firmware_node -> ../../LNXSYSTM:00/device:00/PNP0A08:00/PNP=
0C02:00
| =A0 | =A0 |-- power
| =A0 | =A0 `-- subsystem -> ../../../bus/pci
| =A0 |-- 0000:00:02.0
| =A0 | =A0 |-- bus -> ../../../bus/pci
| =A0 | =A0 |-- driver -> ../../../bus/pci/drivers/i915
| =A0 | =A0 |-- drm:card0 -> ../../../class/drm/card0
| =A0 | =A0 |-- drm:controlD64 -> ../../../class/drm/controlD64
| =A0 | =A0 |-- firmware_node -> ../../LNXSYSTM:00/device:00/PNP0A08:00/dev=
ice:07
| =A0 | =A0 |-- graphics:fb1 -> ../../../class/graphics/fb1
| =A0 | =A0 |-- i2c-adapter:i2c-1 -> ../../../class/i2c-adapter/i2c-1
| =A0 | =A0 |-- i2c-adapter:i2c-2 -> ../../../class/i2c-adapter/i2c-2
| =A0 | =A0 |-- power
| =A0 | =A0 `-- subsystem -> ../../../bus/pci
...
|-- platform
| =A0 |-- gm965temp.0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ***
| =A0 | =A0 |-- bus -> ../../../bus/platform =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 **
| =A0 | =A0 |-- driver -> ../../../bus/platform/drivers/gm965temp =A0***
| =A0 | =A0 |-- hwmon:hwmon1 -> ../../../class/hwmon/hwmon1
| =A0 | =A0 |-- power
| =A0 | =A0 `-- subsystem -> ../../../bus/platform
...

In this sysfs layout, I don't think agpgart-intel and gm965temp will confli=
ct.

--
Thx

Lu Zhihe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
