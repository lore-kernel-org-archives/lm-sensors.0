From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Sep 2009 07:48:06 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090910094806.4306fdbe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Martin,

On Sun, 23 Aug 2009 13:07:13 +0200, Martin MOKREJ=A6 wrote:
> Hi,
>   I am trying to figure out how to setup lm-sensors on my ASUS L3C/S
> laptop (ICH3-M chipset) with P4-M processor. It all started with these
> lines in dmesg(1) output:
>=20
> i2c /dev entries driver
> i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 11 (level, low) -=
> IRQ 11
> ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe81f] conflicts with ACPI regio=
n SMB0 [0xe800-0xe80f]
> ACPI: Device needs an ACPI driver
> i801_smbus: probe of 0000:00:1f.3 failed with error -16
> iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
> input: AT Translated Set 2 keyboard as /class/input/input5
> iTCO_wdt: Found a ICH3-M TCO device (Version=3D1, TCOBASE=3D0xe460)
> iTCO_wdt: initialized. heartbeat0 sec (nowayout=3D0)
> iTCO_vendor_support: vendor-support=3D0
>=20
>=20
>=20
>=20
>   Apparently I do not have something enabled in my kernel (currently 2.6.=
31-rc6-git6).
> ;)
>=20
>   Here is the output from
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/hotplug/unhide_IC=
H_SMBus?revB83&format=3Draw
>=20
> # ~/bin/unhide_ICH_SMBus=20
> Enabling SMBus PCI device ...
> Rescanning the bus ...
> /root/bin/unhide_ICH_SMBus: line 33: /sys/bus/pci/slots//0000:00:1f.0/pow=
er: No such file or directory
> Failed to enable the SMBUS
> # ls -la /sys/bus/pci/slots/
> total 0
> drwxr-xr-x 2 root root 0 Aug 23 12:29 .
> drwxr-xr-x 5 root root 0 Aug 23  2009 ..
> #
>=20
> What kernel option should I enable?

CONFIG_HOTPLUG and/or CONFIG_HOTPLUG_PCI presumably. But you don't
actually need to use the unhide_ICH_SMBus script in the first place, as
the SMBus device is _not_ hidden (you do see it in the output of lspci).

Better see this post from Hans:
http://hansdegoede.livejournal.com/7932.html

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
