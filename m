From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Fri, 16 Nov 2012 06:16:48 +0000
Subject: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0000_01CDC38F.ABAC2E20"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01CDC38F.ABAC2E20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello, All.

	I have been trying to configure lm_sensors to provide alarms for
failing fans, high temperatures, etc.  I get a reasonable output from =
the
sensors command, but when I deliverately create an alarm condition, it =
does
not report as an alarm.  For example, I just pulled the fan on the =
OPT_FAN3
sensor, and the speed dropped from 1800 RPM to 0, but `sensors` does not
report any alarm:

RAID-Server:/usr/share/sensors# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=B0C  (crit =3D +75.0=B0C)                 =20

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.42 V  (min =3D  +0.85 V, max =3D  +1.60 V)
+12V Voltage:      +12.03 V  (min =3D +10.20 V, max =3D +13.80 V)
+5V Voltage:        +4.92 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+3.3V Voltage:      +3.30 V  (min =3D  +2.97 V, max =3D  +3.63 V)
DDR2:               +2.00 V  (min =3D  +1.71 V, max =3D  +2.09 V)
HT:                 +1.28 V  (min =3D  +1.08 V, max =3D  +1.32 V)
SB:                 +1.30 V  (min =3D  +0.99 V, max =3D  +1.21 V)
BR:                 +1.23 V  (min =3D  +1.08 V, max =3D  +1.32 V)
VDDA:               +2.61 V  (min =3D  +2.25 V, max =3D  +2.75 V)
DDR2 TERM.:         +0.98 V  (min =3D  +0.85 V, max =3D  +1.04 V)
VDDNB:              +1.20 V  (min =3D  +1.17 V, max =3D  +1.43 V)
CPU_FAN FAN Speed: 2227 RPM  (min =3D  800 RPM)
CHA_FAN1 FAN Speed:2766 RPM  (min =3D  800 RPM)
CHA_FAN2 FAN Speed:2766 RPM  (min =3D  800 RPM)
OPT_FAN1 FAN Speed:   0 RPM  (min =3D  800 RPM)
OPT_FAN2 FAN Speed:   0 RPM  (min =3D  800 RPM)
OPT_FAN3 FAN Speed:   0 RPM  (min =3D  800 RPM)
PWR_FAN FAN Speed: 1180 RPM  (min =3D  800 RPM)
CHA_FAN3 FAN Speed:   0 RPM  (min =3D  800 RPM)
CPU Temperature:    +41.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)  =

MB Temperature:     +45.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)  =

OPT1:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)  =

OPT2:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)  =

OPT3:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)  =


k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +32.5=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C) =20

------=_NextPart_000_0000_01CDC38F.ABAC2E20
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
Uv7/c5ArwWSPWJ9jb2e/aMtS0P+JwPoYHMMdQEQhHZP5sx4xb73AHXLxQB3mOR528hVN/kJs/x0x
HnNueXJ0b48f1/8IURy3Svpyr3O/dM01P3bP93ffeO8IYDN6L3s/fE9wPW3yFWvsMPoCLaMwIYEw
5GMzGi5QQ/LQ6MAiQ/ccDzHTKZA1bluosIDMiCSfHsETTxRfFWwS1n0AjVAAAAMA3j+vbwAAAwAJ
WQMAAAALAAGACCAGAAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAA4AIIAYAAAAAAMAAAAAAAABG
AAAAABCFAAAAAAAACwAPgAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAADABCACCAGAAAAAADA
AAAAAAAARgAAAAABhQAAAAAAAEAAEoAIIAYAAAAAAMAAAAAAAABGAAAAAGCFAAAAcJpKMgAAAAsA
GYAIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAAAwAcgAggBgAAAAAAwAAAAAAAAEYAAAAAGIUA
AAAAAAALADSACCAGAAAAAADAAAAAAAAARgAAAACChQAAAAAAAAsAHw4BAAAAAgH4DwEAAAAQAAAA
9z9u3oOOKkqz3RROjP9aRAIB+g8BAAAAEAAAAPc/bt6DjipKs90UToz/WkQDAP4PBQAAAAMADTT9
PwUAAwAPNP0/BQACARQ0AQAAABAAAABOSVRB+b+4AQCqADfZbgAAAgF/AAEAAAAxAAAAMDAwMDAw
MDBGNzNGNkVERTgzOEUyQTRBQjNERDE0NEU4Q0ZGNUE0NDA0ODEzQzAwAAAAAAMABhAT/f8jAwAH
EEsFAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEVMTE8sQUxMSUhBVkVCRUVOVFJZSU5H
VE9DT05GSUdVUkVMTVNFTlNPUlNUT1BST1ZJREVBTEFSTVNGT1JGQUlMSU5HRkFOUyxISUdIVEVN
UEVSQVRVUkVTLEVUQ0lHRVRBUgAAAABCzQ==

------=_NextPart_000_0000_01CDC38F.ABAC2E20
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0000_01CDC38F.ABAC2E20--

