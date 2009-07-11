From: lu zhihe <tombowfly@gmail.com>
Date: Sat, 11 Jul 2009 15:19:02 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <73511e6c0907110819t7b6dd307q43557a624ae2871b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

>> +static unsigned long chipset_ids[] =3D {
>> + =A0 =A0 PCI_DEVICE_ID_INTEL_82965GM,
>> + =A0 =A0 PCI_DEVICE_ID_INTEL_82965GME,
>> + =A0 =A0 0
>> +};
>
> These defines do not exist in the current kernel tree. I presume you
> forgot to includes changes to include/linux/pci_ids.h?

   I found these defines on "drivers/char/agp/intel-agp.c", they
defined as "PCI_DEVICE_ID_INTEL_82965GM_HB" and
"PCI_DEVICE_ID_INTEL_82965GME_HB".
While, they are as agpgart device driver, no include in
"include/linux/pci_ids.h".
   If add 82965GM/82965GME define on pci_ids.h, it may duplicate the
definition. But, it seems it's better to move them to pci_ids.h,
because  82915GM and 82945GM are define in it.


> I am also curious what these PCI devices are. We do not want to have
> driver conflicts, so it might make more sense to add hardware
> monitoring functionality to an existing driver than writing a brand new
> driver.

  They are Host Bridge Devices D0:F0. As driver touch North Bridge, it
need to avoid drivers conflict.
Although I test on my Lenovo F31G platform, it seems work.

  But it need to make sure, as your suggestion.

  I check i915.ko and agp-intel.ko. What I found are:
1. i915.ko (drivers/gpu/drm/i915) is registed as Internal Graphics
Device 2(D2:F0-F1) driver.
2. agp-intel.ko (drivers/char/agp/intel-agp.c) is registed as Host
Bridge Devices D0:F0 pci driver.

May be gm965temp will conflict with agp-intel. And I check agp-intel
driver, it don't touch MCHBAR register. For GM965, it only touch:

/* Intel 965G registers */
#define I965_MSAC 0x62
#define I965_IFPADDR    0x70

And it mainly focus on Internal Graphics Device 2(D2:F0-F1) configure
and process.
It don't touch the Thermal sensor register, even don't touch MCHBAR registe=
r.

apg-intel focus on agpgart table setting, so I curious that it should
not add function as hwmon driver too.

What's more. I check hwmon's PCI driver, sis5595, it's ID is
"PCI_DEVICE_ID_SI_503". And it also register on
drivers/i2c/busses/i2c-sis5595 as PCI driver. The situation is similar
as gm965temp and agp-intel.

Above are my opinion for PCI driver conflict.
Please help me to review them?

May be I just make some mistake, and don't notice. :-)

--=20
Thanks,

Lu Zhihe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
