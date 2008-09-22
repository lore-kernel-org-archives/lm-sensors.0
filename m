From: "Gerhart, Bjoern" <bjoern.gerhart@wincor-nixdorf.com>
Date: Mon, 22 Sep 2008 07:51:56 +0000
Subject: Re: [lm-sensors] No Alarm when values not within range
Message-Id: <5E5D87015BF8A54A93DAD6F808B1129ACB0564@DEEXVS13.wincor-nixdorf.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
In-Reply-To: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


> To
> investigate this, we would need a dump of the IT8718F chip together
> with the corresponding sensors output.


sensors-detect tells me the address of the it8718:
---------------------%<--------------------------snip
Found `ITE IT8718F Super IO Sensors'                        Success!
    (address 0x290, driver `it87')
--------------------->%--------------------------snap


So my isadump command and output looks like this (please tell me if I'm wro=
ng with these addresses):
---------------------%<--------------------------snip
[root@wnlpos-gerhart ~]# isadump -y 0x295 0x296
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 13 11 01 00 37 ff 06 37 ff 07 54 09 0f 04 ff 3f
10: 17 ff 46 77 d0 4f 4f 7f 01 ff 02 00 ff 05 05 05
20: 4d 72 cf bd c3 34 5e be bd 2f 1d 80 80 b3 53 53
30: 3f 38 90 51 fa a9 d4 a7 d6 a7 51 28 77 45 d4 a7
40: 1a 14 7f c9 7f c9 5f 74 2d 40 ab 22 ff ff ff ff
50: ff 03 7f 7f 7f 50 08 00 90 00 05 12 00 00 00 00
60: 7f 30 3c 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
70: 7f 7f 7f 00 00 7f ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
90: ff 00 00 00 ff 00 00 00 ff ff ff ff ff ff ff ff
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
--------------------->%--------------------------snap


For testing purpose, before I run isadump, I modified the limits of "CPU VI=
D", "CPU Fan" and "CPU Temp" to extra low values, and restart lm_sensors to=
 accept the new limits. The output of sensors looks like this (No Alarm det=
ected):
---------------------%<--------------------------snip
[root@wnlpos-gerhart ~]# sensors
it8718-isa-0290
Adapter: ISA adapter
CPU VID:     +1.23 V  (min =3D  +0.90 V, max =3D  +1.01 V)
+1.8V:       +1.82 V  (min =3D  +1.30 V, max =3D  +2.30 V)
+3.3V VSB:   +3.31 V  (min =3D  +2.70 V, max =3D  +4.00 V)
+5V VCC:     +5.08 V  (min =3D  +4.49 V, max =3D  +5.70 V)
+12V:       +12.48 V  (min =3D +10.69 V, max =3D +13.70 V)
-12V:       -12.69 V  (min =3D -13.68 V, max =3D -10.30 V)
+1.5V:       +1.50 V  (min =3D  +1.10 V, max =3D  +1.90 V)
+5V VSB:     +5.11 V  (min =3D  +4.49 V, max =3D  +5.70 V)
+3V VBAT:    +3.02 V
CPU Fan:    3169 RPM  (min =3D 29347 RPM)
PS Fan:     1167 RPM  (min =3D  500 RPM)
CPU Temp:    +47.0=C2=B0C  (low  =3D +22.0=C2=B0C, high =3D +28.0=C2=B0C)  =
sensor =3D thermal diode
--------------------->%--------------------------snap


Can you figure out why the Alarm state is not detected?


Regards
Bj=F6rn - Sorry for the signature below, it's automatically appended  :-(


--=20
WINCOR NIXDORF International GmbH=20
Sitz der Gesellschaft: Paderborn=20
Registergericht Paderborn HRB 3507
Gesch=E4ftsf=FChrer: Eckard Heidloff (Vorsitzender), Stefan Auerbach, Dr. J=
=FCrgen Wunram
Vorsitzender des Aufsichtsrats: Karl-Heinz Stiller=20
Steuernummer: 339/5884/0020 - Ust-ID Nr.: DE812927716 - WEEE-Reg.-Nr. DE444=
77193

Diese E-Mail enth=E4lt vertrauliche Informationen. Wenn Sie nicht der richt=
ige Adressat sind oder diese E-Mail irrt=FCmlich erhalten haben, informiere=
n Sie bitte sofort den Absender und vernichten Sie diese E-Mail. Das unerla=
ubte Kopieren sowie die unbefugte Weitergabe dieser E-Mail ist nicht gestat=
tet.

This e-mail may contain confidential information. If you are not the intend=
ed recipient (or have received this e-mail in error) please notify the send=
er immediately and destroy this e-mail. Any unauthorised copying, disclosur=
e or distribution of the material in this e-mail is strictly forbidden.=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
