From: Joris Creyghton <jorisctn@gmail.com>
Date: Tue, 11 Jan 2011 14:07:22 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294754842.1968.20.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-m894gS2dA8OErRgtJIgF"
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--=-m894gS2dA8OErRgtJIgF
Content-Type: multipart/alternative; boundary="=-PvIDFanKzummKi6eprMF"


--=-PvIDFanKzummKi6eprMF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello Luca,

With your modified version of the driver I have been able to test the
new ATK0110 interface and it indeed delivers a proper value of the MCH
temperature! The recipe of Jean Delvare was invaluable for me.
I have attached the output of the sensors command in both the old and
the new situations.

Now there remains the point of incorporating things properly, so that
one doesn't have to manually re-make the object with every new version
of the kernel headers.

Another point that drew my attention is that the two ATK0110 interfaces
don't agree on the naming of the fan sensors as you can tell from the
two attachments.
Both display 4 fan's, they agree about the CPU fan, but the new
interface assigns one value to a NB fan (North Bridge =? Memory Control
Hub (MCH)). There is no such fan on the Sabertooth board. There are 2
chassis fans and a power fan though.

Thanks so far,

Joris


--=-PvIDFanKzummKi6eprMF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
Hello Luca,<BR>
<BR>
With your modified version of the driver I have been able to test the new ATK0110 interface and it indeed delivers a proper value of the MCH temperature! The recipe of Jean Delvare was invaluable for me.<BR>
I have attached the output of the sensors command in both the old and the new situations.<BR>
<BR>
Now there remains the point of incorporating things properly, so that one doesn't have to manually re-make the object with every new version of the kernel headers.<BR>
<BR>
Another point that drew my attention is that the two ATK0110 interfaces don't agree on the naming of the fan sensors as you can tell from the two attachments.<BR>
Both display 4 fan's, they agree about the CPU fan, but the new interface assigns one value to a NB fan (North Bridge =? Memory Control Hub (MCH)). There is no such fan on the Sabertooth board. There are 2 chassis fans and a power fan though.<BR>
<BR>
Thanks so far,<BR>
<BR>
Joris<BR>
<BR>
</BODY>
</HTML>

--=-PvIDFanKzummKi6eprMF--

--=-m894gS2dA8OErRgtJIgF
Content-Disposition: attachment; filename="sensors_new.txt"
Content-Type: text/plain; name="sensors_new.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +0.93 V  (min =3D  +0.80 V, max =3D  +1.60 V)
+3.3V Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V Voltage:        +5.12 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V Voltage:      +12.25 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU Fan Speed:     1028 RPM  (min =3D  600 RPM)
Chassis1 Fan Speed: 680 RPM  (min =3D  600 RPM)
Chassis2 Fan Speed: 496 RPM  (min =3D  600 RPM)
NB Fan Speed:       777 RPM  (min =3D  600 RPM)
Power Fan Speed:      0 RPM  (min =3D    0 RPM)
CPU Temperature:    +35.0=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D +95.0=C2=
=B0C) =20
MB Temperature:     +32.0=C2=B0C  (high =3D +45.0=C2=B0C, crit =3D +75.0=C2=
=B0C) =20
NB Temperature:     +44.5=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D +95.0=C2=
=B0C) =20


--=-m894gS2dA8OErRgtJIgF
Content-Disposition: attachment; filename="sensors_old.txt"
Content-Type: text/plain; name="sensors_old.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +0.93 V  (min =3D  +0.80 V, max =3D  +1.60 V)
 +3.3 Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
 +5 Voltage:        +5.12 V  (min =3D  +4.50 V, max =3D  +5.50 V)
 +12 Voltage:      +12.25 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU FAN Speed:      948 RPM  (min =3D  600 RPM)
CHASSIS1 FAN Speed: 680 RPM  (min =3D  600 RPM)
CHASSIS2 FAN Speed: 496 RPM  (min =3D  600 RPM)
CHASSIS3 FAN Speed:   0 RPM  (min =3D  600 RPM)
POWER FAN Speed:    774 RPM  (min =3D    0 RPM)
CPU Temperature:    +35.5=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D +75.0=C2=
=B0C) =20
MB Temperature:     +32.0=C2=B0C  (high =3D +45.0=C2=B0C, crit =3D +75.0=C2=
=B0C) =20
MCH Temperature:     +0.0=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D +95.0=C2=
=B0C) =20


--=-m894gS2dA8OErRgtJIgF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-m894gS2dA8OErRgtJIgF--

