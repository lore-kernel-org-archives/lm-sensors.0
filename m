From: Clive Messer <clive@vacuumtube.org.uk>
Date: Tue, 10 Mar 2009 14:17:01 +0000
Subject: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <200903101417.01449.clive@vacuumtube.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Thank you for the Asus ACPI driver.

I've seen several reports of it being used with 'older' Asus boards - P5B, =

P5K, P5Q, etc. etc. I've been using the driver with a P6T Deluxe (Core i7 /=
=20
X58 chipset).

[clivem@c7p6t:~]$ sensors  =20
atk0110-acpi-0             =20
Adapter: ACPI interface    =20
VCore:       +1.23 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V:       +3.30 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V:         +5.02 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V:       +11.91 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan:    4326 RPM  (min =3D  600 RPM)               =20
CH1 Fan:       0 RPM  (min =3D  600 RPM)               =20
CH2 Fan:    3443 RPM  (min =3D  600 RPM)
CH3 Fan:       0 RPM  (min =3D  600 RPM)
PWR Fan:    1205 RPM  (min =3D    0 RPM)
CPU Temp:    +62.0=B0C  (high =3D +60.0=B0C, crit =3D +75.0=B0C)
MB Temp:     +41.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

(Sensor descriptions are renamed from default values - I prefer them shorte=
r.)

Not that it really matters - just a curiosity. The CPU temp reports +5 degC=
=20
hotter with atk0110 driver and -5 degC cooler with native w83667hg, compare=
d=20
to coretemp driver. (Yes, coretemp is relative anyway.....)

Regards

Clive
--=20
Clive Messer <clive@vacuumtube.org.uk>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
