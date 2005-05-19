From: Nicolas.Mailhot@laPoste.net (Nicolas Mailhot)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Sensors and linux 2.6.0-test4-bk8 question
Message-Id: <1062934034.7923.2.camel@rousalka.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm78@stimpy.netroedge.com
Cc: linux-kernel@vger.kernel.org

Hi,

Please bear with me and enlighten me a bit. I've been fiddling with
2.5/2.6 for some time, and got most of my hardware working (including
acpi...) better than in 2.4. (in fact now I'm using only 2.6). So now I
got to the point where I'm looking at nice-to-have stuff like sensors.

I know libsensors is not yet 2.6 aware, but I thought sensed values
where available in sysfs if one wanted to manually read them. Since I
have via hardware:

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host
Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
00:0c.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04)

I build-in via-pro and VIA686A:
CONFIG_I2C_VIAPRO=3Dy
CONFIG_SENSORS_VIA686A=3Dy

Now there is no sensor-related message as far as I can see in my dmesg,
and I do not seem to find any temperature/fan related info in /sys:

root@rousalka root]# find /sys/| grep i2c
/sys/class/i2c-dev
/sys/class/i2c-dev/i2c-3
/sys/class/i2c-dev/i2c-3/dev
/sys/class/i2c-dev/i2c-3/driver
/sys/class/i2c-dev/i2c-3/device
/sys/class/i2c-dev/i2c-2
/sys/class/i2c-dev/i2c-2/dev
/sys/class/i2c-dev/i2c-2/driver
/sys/class/i2c-dev/i2c-2/device
/sys/class/i2c-dev/i2c-1
/sys/class/i2c-dev/i2c-1/dev
/sys/class/i2c-dev/i2c-1/driver
/sys/class/i2c-dev/i2c-1/device
/sys/class/i2c-dev/i2c-0
/sys/class/i2c-dev/i2c-0/dev
/sys/class/i2c-dev/i2c-0/driver
/sys/class/i2c-dev/i2c-0/device
/sys/class/i2c-adapter
/sys/class/i2c-adapter/i2c-3
/sys/class/i2c-adapter/i2c-3/driver
/sys/class/i2c-adapter/i2c-3/device
/sys/class/i2c-adapter/i2c-2
/sys/class/i2c-adapter/i2c-2/driver
/sys/class/i2c-adapter/i2c-2/device
/sys/class/i2c-adapter/i2c-1
/sys/class/i2c-adapter/i2c-1/driver
/sys/class/i2c-adapter/i2c-1/device
/sys/class/i2c-adapter/i2c-0
/sys/class/i2c-adapter/i2c-0/driver
/sys/class/i2c-adapter/i2c-0/device
/sys/bus/i2c
/sys/bus/i2c/drivers
/sys/bus/i2c/drivers/dev_driver
/sys/bus/i2c/drivers/i2c_adapter
/sys/bus/i2c/devices
/sys/devices/pci0000:00/0000:00:11.0/i2c-3
/sys/devices/pci0000:00/0000:00:11.0/i2c-3/name
/sys/devices/pci0000:00/0000:00:11.0/i2c-3/power
/sys/devices/pci0000:00/0000:00:11.0/i2c-3/power/state
/sys/devices/pci0000:00/0000:00:11.0/i2c-3/detach_state
/sys/devices/legacy/i2c-2
/sys/devices/legacy/i2c-2/name
/sys/devices/legacy/i2c-2/power
/sys/devices/legacy/i2c-2/power/state
/sys/devices/legacy/i2c-2/detach_state
/sys/devices/legacy/i2c-1
/sys/devices/legacy/i2c-1/name
/sys/devices/legacy/i2c-1/power
/sys/devices/legacy/i2c-1/power/state
/sys/devices/legacy/i2c-1/detach_state
/sys/devices/legacy/i2c-0
/sys/devices/legacy/i2c-0/name
/sys/devices/legacy/i2c-0/power
/sys/devices/legacy/i2c-0/power/state
/sys/devices/legacy/i2c-0/detach_state
/sys/cdev/major/i2c

So I'd like to know how I'm supposed to check if the kernel sensors part
works (and eventualy get some useful info out of it)

Regards,

--=20
Nicolas Mailhot
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Ceci est une partie de message
	=3D?ISO-8859-1?Q?num=E9riquement?=3D =3D?ISO-8859-1?Q?_sign=E9e?Url : http=
://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030907/6266a3bd/=
attachment.bin
