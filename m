From: Roman Evstifeev <someuniquename@gmail.com>
Date: Wed, 02 Jun 2010 16:57:15 +0000
Subject: [lm-sensors] control f71889fg pwm on 2.6.34
Message-Id: <AANLkTimzIutXVn2W2ZE1LQ-dXbNEMfuUfJ4G1733cFsM@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5798862651250544042=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5798862651250544042==
Content-Type: multipart/alternative; boundary=0015175ce21268fc8804880efb5b

--0015175ce21268fc8804880efb5b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi. I have Mainboard* with F71889FG-based controller.
* - MSI P41T-C31 (
http://www.msi.com/index.php?func=3Dproddesc&maincat_no=3D1&prod_no=3D1792 =
)

After f71882fg module loaded - it creates bunch of the sysfs entries, and i
can succesfully read temperature and fan speed values from it. But i can't
control the pwm with it.
I tried pwmconfig utility as well as writing to sysfs files directly. sysfs
values get changed, but actual fan speed does not.


************* dmesg ************
[   14.238796] f71882fg: Found f71889fg chip at 0xa00, revision 21
[   14.238935] f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode
[   14.238936] f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode
[   14.238938] f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode


*********************** sensors *********************
linux-md9k:/sys/class/hwmon # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +39.0=B0C  (high =3D +76.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +38.0=B0C  (high =3D +76.0=B0C, crit =3D +100.0=B0C)

f71889fg-isa-0a00
Adapter: ISA adapter
in0:         +1.69 V
in1:         +1.08 V  (max =3D  +2.04 V)
in2:         +1.10 V
in3:         +0.96 V
in4:         +0.02 V
in5:         +0.02 V
in6:         +0.01 V
in7:         +1.69 V
in8:         +1.62 V
fan1:          0 RPM  ALARM
fan2:          0 RPM  ALARM
fan3:       1538 RPM
temp1:       +18.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D Intel
PECI
temp2:       +33.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +109.0=B0C, hyst =3D +105.0=B0C)  sensor =
=3D
thermistor
temp3:       +33.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sensor =
=3D
transistor

**************** trying manual control ************
linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3_enable
1
linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3
255
linux-md9k:/sys/class/hwmon # echo 140 > hwmon2/device/pwm3
linux-md9k:/sys/class/hwmon # echo 0 > hwmon2/device/pwm3
linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3
0
*********************************************************


Can somebody please help me debug this?

--0015175ce21268fc8804880efb5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi. I have Mainboard* with F71889FG-based controller.
<br>
* - MSI P41T-C31 ( <a href=3D"http://www.msi.com/index.php?func=3Dproddesc&=
amp;maincat_no=3D1&amp;prod_no=3D1792">http://www.msi.com/index.php?func=3D=
proddesc&amp;maincat_no=3D1&amp;prod_no=3D1792</a> )<br><br>After f71882fg =
module loaded - it creates bunch of the sysfs entries, and i can succesfull=
y read temperature and fan speed values from it. But i can&#39;t control th=
e pwm with it.<br>
I tried pwmconfig utility as well as writing to sysfs files directly. sysfs=
 values get changed, but actual fan speed does not.<br><br><br>************=
* dmesg ************<br>[=A0=A0 14.238796] f71882fg: Found f71889fg chip at=
 0xa00, revision 21<br>
[=A0=A0 14.238935] f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode<br>=
[=A0=A0 14.238936] f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode<br>=
[=A0=A0 14.238938] f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode<br>=
<br><br>
*********************** sensors *********************<br>linux-md9k:/sys/cl=
ass/hwmon # sensors<br>coretemp-isa-0000<br>Adapter: ISA adapter<br>Core 0:=
=A0=A0=A0=A0=A0 +39.0=B0C=A0 (high =3D +76.0=B0C, crit =3D +100.0=B0C)=A0 <=
br><br>coretemp-isa-0001<br>
Adapter: ISA adapter<br>Core 1:=A0=A0=A0=A0=A0 +38.0=B0C=A0 (high =3D +76.0=
=B0C, crit =3D +100.0=B0C)=A0 <br><br>f71889fg-isa-0a00<br>Adapter: ISA ada=
pter<br>in0:=A0=A0=A0=A0=A0=A0=A0=A0 +1.69 V<br>in1:=A0=A0=A0=A0=A0=A0=A0=
=A0 +1.08 V=A0 (max =3D=A0 +2.04 V)=A0=A0 <br>in2:=A0=A0=A0=A0=A0=A0=A0=A0 =
+1.10 V<br>
in3:=A0=A0=A0=A0=A0=A0=A0=A0 +0.96 V<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0 +0.02 =
V<br>in5:=A0=A0=A0=A0=A0=A0=A0=A0 +0.02 V<br>in6:=A0=A0=A0=A0=A0=A0=A0=A0 +=
0.01 V<br>in7:=A0=A0=A0=A0=A0=A0=A0=A0 +1.69 V<br>in8:=A0=A0=A0=A0=A0=A0=A0=
=A0 +1.62 V<br>fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 ALARM<br>fan2:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 ALARM<br>fan3:=A0=A0=A0=A0=A0=A0 1538 RPM=
<br>
temp1:=A0=A0=A0=A0=A0=A0 +18.0=B0C=A0 (high =3D +255.0=B0C, hyst =3D +251.0=
=B0C)=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)=A0 sensor =3D Intel PECI<br>=
temp2:=A0=A0=A0=A0=A0=A0 +33.0=B0C=A0 (high =3D +255.0=B0C, hyst =3D +251.0=
=B0C)=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (crit =3D +109.0=B0C, hyst =3D +105.0=B0C)=A0 sensor =3D thermistor<br>
temp3:=A0=A0=A0=A0=A0=A0 +33.0=B0C=A0 (high =3D +255.0=B0C, hyst =3D +253.0=
=B0C)=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)=A0 sensor =3D transistor<br>=
<br>**************** trying manual control ************<br>linux-md9k:/sys/=
class/hwmon # cat hwmon2/device/pwm3_enable <br>
1<br>linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3<br>255<br>linux-m=
d9k:/sys/class/hwmon # echo 140 &gt; hwmon2/device/pwm3<br>linux-md9k:/sys/=
class/hwmon # echo 0 &gt; hwmon2/device/pwm3<br>linux-md9k:/sys/class/hwmon=
 # cat hwmon2/device/pwm3<br>
0<br>*********************************************************<br><br><br>C=
an somebody please help me debug this?<br>

--0015175ce21268fc8804880efb5b--


--===============5798862651250544042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5798862651250544042==--
