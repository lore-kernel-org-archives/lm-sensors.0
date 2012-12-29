From: nicolas maloeuvre <nicolas.maloeuvre@gmail.com>
Date: Sat, 29 Dec 2012 02:00:13 +0000
Subject: [lm-sensors] "Detected by sensors-detect : No"
Message-Id: <CAB2-rMZxKzF8cqBG2uSATBXoUodJ8Q=QRZySzm84QUoy8B7Chw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8484928992161845647=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8484928992161845647==
Content-Type: multipart/alternative; boundary=14dae93410c509f97404d1f424cc

--14dae93410c509f97404d1f424cc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

 Hello,
I wonder if i could see and/or control fan speed of my laptop. With
"sensors-detect", three modules were loaded : coretemp, max6650 and sbs.
max6650 is a fan speed regulator so i want it.
http://www.lm-sensors.org/wiki/Devices says that max6650 cannot be detected
by sensors-detect so there is a contradiction. When i launch "sensors"
there is no fan controller. So fancontrol doesn't work.

I think it is normal that lm_sensor does not detect my fan controller
because it is listed as "undetectable" in your website. If i want to write
a program for control it, which advice will you give me?
I see that i have access to :
 /lib/modules/3.4.11-1.fu2012.i686/kernel/drivers/hwmon/max6650.ko
Do you think i can use it? how can we use a .ko file?

Sincerely,
Nicolas Maloeuvre

>sensors-detect :
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Driver `max6650':
  * Bus `Radeon i2c bit bus 0x96'
    Busdriver `drm', I2C address 0x1b
    Chip `Maxim MAX6650/MAX6651' (confidence: 2)
  * Bus `Radeon i2c bit bus 0x96'
    Busdriver `drm', I2C address 0x1f
    Chip `Maxim MAX6650/MAX6651' (confidence: 2)
  * Bus `Radeon i2c bit bus 0x96'
    Busdriver `drm', I2C address 0x48
    Chip `Maxim MAX6650/MAX6651' (confidence: 2)
  * Bus `Radeon i2c bit bus 0x96'
    Busdriver `drm', I2C address 0x4b
    Chip `Maxim MAX6650/MAX6651' (confidence: 2)

Driver `sbs':
  * Bus `Radeon i2c bit bus 0x96'
    Busdriver `drm', I2C address 0x0b
    Chip `Smart Battery' (confidence: 5)

>sensors :
acpitz-virtual-0
Adapter: Virtual device
temp1:        +69.0=B0C

radeon-pci-0100
Adapter: PCI adapter
temp1:        +69.5=B0C

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +69.0=B0C  (high =3D +80.0=B0C, crit =3D +85.0=B0C)
Core 0:         +67.0=B0C  (high =3D +80.0=B0C, crit =3D +85.0=B0C)
Core 1:         +69.0=B0C  (high =3D +80.0=B0C, crit =3D +85.0=B0C)

>uname -a:
Linux localhost.Nicolas 3.4.11-1.fu2012.i686 #1 SMP Sat Sep 29 07:35:39 EDT
2012 i686 i686 i386 GNU/Linux

--14dae93410c509f97404d1f424cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>=A0Hello,<br></div>I wonder if i =
could see and/or control fan speed of my laptop. With &quot;sensors-detect&=
quot;, three modules were loaded : coretemp, max6650 and sbs. max6650 is a =
fan speed regulator so i want it.<br>
<a href=3D"http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.or=
g/wiki/Devices</a> says that max6650 cannot be detected by sensors-detect s=
o there is a contradiction. When i launch &quot;sensors&quot; there is no f=
an controller. So fancontrol doesn&#39;t work.<br>
<br></div><div>I think it is normal that lm_sensor does not detect my fan c=
ontroller because it is listed as &quot;undetectable&quot; in your website.=
 If i want to write a program for control it, which advice will you give me=
?<br>
</div><div>I see that i have access to :<br>=A0/lib/modules/3.4.11-1.fu2012=
.i686/kernel/drivers/hwmon/max6650.ko<br></div>Do you think i can use it? h=
ow can we use a .ko file?<br></div><div><br></div><div>Sincerely,<br></div>
<div>Nicolas Maloeuvre<br></div><div><br></div>&gt;sensors-detect :<br>Now =
follows a summary of the probes I have just done.<br>Just press ENTER to co=
ntinue: <br><br>Driver `coretemp&#39;:<br>=A0 * Chip `Intel digital thermal=
 sensor&#39; (confidence: 9)<br>
<br>Driver `max6650&#39;:<br>=A0 * Bus `Radeon i2c bit bus 0x96&#39;<br>=A0=
=A0=A0 Busdriver `drm&#39;, I2C address 0x1b<br>=A0=A0=A0 Chip `Maxim MAX66=
50/MAX6651&#39; (confidence: 2)<br>=A0 * Bus `Radeon i2c bit bus 0x96&#39;<=
br>=A0=A0=A0 Busdriver `drm&#39;, I2C address 0x1f<br>
=A0=A0=A0 Chip `Maxim MAX6650/MAX6651&#39; (confidence: 2)<br>=A0 * Bus `Ra=
deon i2c bit bus 0x96&#39;<br>=A0=A0=A0 Busdriver `drm&#39;, I2C address 0x=
48<br>=A0=A0=A0 Chip `Maxim MAX6650/MAX6651&#39; (confidence: 2)<br>=A0 * B=
us `Radeon i2c bit bus 0x96&#39;<br>
=A0=A0=A0 Busdriver `drm&#39;, I2C address 0x4b<br>=A0=A0=A0 Chip `Maxim MA=
X6650/MAX6651&#39; (confidence: 2)<br><br>Driver `sbs&#39;:<br>=A0 * Bus `R=
adeon i2c bit bus 0x96&#39;<br>=A0=A0=A0 Busdriver `drm&#39;, I2C address 0=
x0b<br>=A0=A0=A0 Chip `Smart Battery&#39; (confidence: 5)<br>
<br></div>&gt;sensors :<br>acpitz-virtual-0<br>Adapter: Virtual device<br>t=
emp1:=A0=A0=A0=A0=A0=A0=A0 +69.0=B0C=A0 <br><br>radeon-pci-0100<br>Adapter:=
 PCI adapter<br>temp1:=A0=A0=A0=A0=A0=A0=A0 +69.5=B0C=A0 <br><br>coretemp-i=
sa-0000<br>Adapter: ISA adapter<br>
Physical id 0:=A0 +69.0=B0C=A0 (high =3D +80.0=B0C, crit =3D +85.0=B0C)<br>=
Core 0:=A0=A0=A0=A0=A0=A0=A0=A0 +67.0=B0C=A0 (high =3D +80.0=B0C, crit =3D =
+85.0=B0C)<br>Core 1:=A0=A0=A0=A0=A0=A0=A0=A0 +69.0=B0C=A0 (high =3D +80.0=
=B0C, crit =3D +85.0=B0C)<br><br></div>&gt;uname -a:<br>Linux localhost.Nic=
olas 3.4.11-1.fu2012.i686 #1 SMP Sat Sep 29 07:35:39 EDT 2012 i686 i686 i38=
6 GNU/Linux<br>
<br><div><div><br></div></div></div>

--14dae93410c509f97404d1f424cc--


--===============8484928992161845647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8484928992161845647==--
