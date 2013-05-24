From: Bruce Kettle <bfromcolo@gmail.com>
Date: Fri, 24 May 2013 03:40:27 +0000
Subject: [lm-sensors] lm-sensors help question
Message-Id: <519EE12B.4030108@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi I have a Biostar a780l3g motherboard with a Phenom II 840 processor. =20
I have Ubuntu 12.04 32-bit installed and current patches (kernel=20
3.5.0-30-generic).  I installed lm-sensors and ran sensors-detect, it=20
properly detected the k10 sensors.  But when I run sensors the output is=20
as follows:

bruce@bruce-A780L3G:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +32.0=B0C  (crit =3D +127.0=B0C)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +23.5=B0C  (high =3D +70.0=B0C)
                        (crit =3D +90.0=B0C, hyst =3D +88.0=B0C)

I was hoping to be able to read core temps, but I don't think either of=20
these are that.

It does not appear that Biostar provides Linux chipset drivers, although=20
your FAQ indicates this should be supported in this version of the=20
kernel.  Is there something I am doing wrong or is the board just not=20
supported?  The sensors did work in Windows 7 in a variety of programs,=20
so I don't think there is a hardware issue.

Thanks




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
