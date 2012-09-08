From: Andreas Hartmann <andihartmann@01019freenet.de>
Date: Sat, 08 Sep 2012 16:34:16 +0000
Subject: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <504B7388.8020102@01019freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I'm getting this temperature after more than one hour of activity
(mostly idle, load of the machine is: 0,11, 0,17, 0,21):

sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +14.5=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)

14.5=B0C is completely impossible as the surrounding temperature is
> 20=B0C.


fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       85.74 W

I read about this value, which would be the power consumption of the
CPU. If this would be correct, my cpu wouldn't be a cpu but a light bulb
:-) and the fan would most probably run on maximum speed non stop (which
it doesn't do - it's running on minimum).

CPU:       AMD FX(tm)-4100 Quad-Core Processor
Board:     Gigabyte GA-990XA-UD3
Bios:      Award F11 05/17/2012
Kernel:    3.4.10-1.1-desktop 64 bit (openSUSE)
lmsensors: sensors-3.3.2-55.1.x86_64


Do you need more information about the hardware? Feel free to ask!




Thanks for any hint,
kind regards,
Andreas Hartmann

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
