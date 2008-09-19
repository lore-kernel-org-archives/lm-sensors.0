From: "Gerhart, Bjoern" <bjoern.gerhart@wincor-nixdorf.com>
Date: Fri, 19 Sep 2008 12:51:03 +0000
Subject: [lm-sensors] No Alarm when values not within range
Message-Id: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

in my company we use lm_sensors a while now. Now we want to update to lm_se=
nsors 3.02 due to a new sensors chip (it8718F) in our latest hardware. I al=
ready converted the sensors.conf files into the new syntax. But now I don't=
 get any alarms any more, no matter which sensors chip I use. Here is the o=
utput that sensors gives:

[root@devel etc]# sensors
pc87366-isa-0fb0
Adapter: ISA adapter
-12V:       -12.44 V  (min =3D -13.81 V, max =3D -10.27 V)
+12V:       +12.10 V  (min =3D +10.71 V, max =3D +12.70 V)
+5V VCC:     +5.24 V  (min =3D  +4.50 V, max =3D  +5.70 V)
+1.5V:       +1.51 V  (min =3D  +1.10 V, max =3D  +1.90 V)
+2.5V:       +2.49 V  (min =3D  +1.90 V, max =3D  +2.95 V)
+1.3V VID:   +1.31 V  (min =3D  +1.10 V, max =3D  +1.50 V)
+3.3V VSB:   +3.38 V  (min =3D  +0.00 V, max =3D  +1.00 V)
+3V VBAT:    +2.95 V  (min =3D  +2.40 V, max =3D  +2.95 V)
CPU Fan:    2909 RPM  (min =3D 10000 RPM, div =3D 1)
CPU Temp:    +51.0=B0C  (low  =3D  +0.0=B0C, high =3D  +5.0=B0C)
                      (crit =3D  +5.0=B0C)
Chip Temp:   +39.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
                      (crit =3D +127.0=B0C)


The sensors "+3.3V VSB", "CPU Fan" and "CPU Temp" should give an alarm, but=
 they don't. What's the reason for this behaviour?


Best Regards

  Bj=F6rn Gerhart     WINCOR NIXDORF International GmbH
                    Retail Store Solutions M24
                    Rohrdamm 7, Haus 16
                    13629 Berlin
                    Germany

  Phone             +49 (30) 5017 - 1343
  FAX               +49 (30) 5017 - 1305

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
