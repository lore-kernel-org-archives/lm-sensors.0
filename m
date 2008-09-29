From: "Pierre Bauduin" <pierre@baudu.in>
Date: Mon, 29 Sep 2008 08:42:43 +0000
Subject: [lm-sensors] on a "via686a-*" sensors reports always the same
Message-Id: <7cd7a3e80809290142w32aea211l3b35834000a1cbef@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8528778293086057966=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8528778293086057966==
Content-Type: multipart/alternative; 
	boundary="----=_Part_12871_4400105.1222677763621"

------=_Part_12871_4400105.1222677763621
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

I'm having problems with sensors on a machine based on a Fujitsu-Siemens MS=
I
MS-6340 motherboard.

The sensors chipset is chip "via686a-*"

The munin plugins always report the same temperatures:
[pbn@akagi] /home/pbn/Documents/other>munin-run sensors_temp
temp1.value 23.2
temp2.value 23.2
temp3.value 146.2

Obviously the temp3.value is bogus, so I added "ignore temp3" in
/etc/sensors3.conf. Then I get:
[pbn@akagi] /home/pbn/Documents/other>munin-run sensors_temp
temp1.value 23.2
temp2.value 23.2

Not surprisingly, the sensors_temp munin plugins calls the sensors command.
Here is the output of the sensors command:
[pbn@akagi] /home/pbn/Documents/other>sensors
via686a-isa-6000
Adapter: ISA adapter
CPU core:    +3.10 V  (min =3D  +3.00 V, max =3D  +1.57 V)
+2.5V:       +3.00 V  (min =3D  +3.10 V, max =3D  +3.10 V)
I/O:         +4.13 V  (min =3D  +4.13 V, max =3D  +4.12 V)
+5V:         +6.44 V  (min =3D  +6.44 V, max =3D  +6.44 V)
+12V:       +15.60 V  (min =3D +15.60 V, max =3D +15.12 V)
CPU Fan:       0 RPM  (min =3D    0 RPM, div =3D 2)
P/S Fan:    5672 RPM  (min =3D    0 RPM, div =3D 2)
SYS Temp:    +23.2 =B0C  (high =3D +146.2 =B0C, hyst =3D +146.2 =B0C)
CPU Temp:    +23.2 =B0C  (high =3D +125.2 =B0C, hyst =3D +146.2 =B0C)
SBr Temp:   +146.2 =B0C  (high =3D +146.2 =B0C, hyst =3D +146.2 =B0C)
[pbn@akagi] /home/pbn/Documents/other>

So ... everything in sensors' output always has the same value... ouch !

... perhaps did I do something wrong ?
... perhaps did I forget somethin ?

Thank you,
--=20
Pierre Bauduin

------=_Part_12871_4400105.1222677763621
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Hi there,<br><br>I&#39;m having problems with sensors on a=
 machine based on a Fujitsu-Siemens MSI MS-6340 motherboard.<br><br>The sen=
sors chipset is chip &quot;via686a-*&quot;<br><br>The munin plugins always =
report the same temperatures:<br>

<span style=3D"font-family: courier new,monospace;">[pbn@akagi] /home/pbn/D=
ocuments/other&gt;munin-run sensors_temp</span><br style=3D"font-family: co=
urier new,monospace;"><span style=3D"font-family: courier new,monospace;">t=
emp1.value 23.2</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">temp2.value 23.2</span>=
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">temp3.value 146.2</span><br><br>Obviously the te=
mp3.value is bogus, so I added &quot;ignore temp3&quot; in /etc/sensors3.co=
nf. Then I get:<br>

<span style=3D"font-family: courier new,monospace;">[pbn@akagi] /home/pbn/D=
ocuments/other&gt;munin-run sensors_temp</span><br style=3D"font-family: co=
urier new,monospace;">

<span style=3D"font-family: courier new,monospace;">temp1.value 23.2</span>=
<br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">temp2.value 23.2</span>=
<br><br>Not surprisingly, the sensors_temp munin plugins calls the sensors =
command. Here is the output of the sensors command:<br><span style=3D"font-=
family: courier new,monospace;">[pbn@akagi] /home/pbn/Documents/other&gt;se=
nsors</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">via686a-isa-6000</span>=
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">Adapter: ISA adapter</span><br style=3D"font-fam=
ily: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">CPU core:&nbsp;&nbsp;&n=
bsp; +3.10 V&nbsp; (min =3D&nbsp; +3.00 V, max =3D&nbsp; +1.57 V)</span><br=
 style=3D"font-family: courier new,monospace;"><span style=3D"font-family: =
courier new,monospace;">+2.5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.00 V&=
nbsp; (min =3D&nbsp; +3.10 V, max =3D&nbsp; +3.10 V)</span><br style=3D"fon=
t-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">I/O:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.13 V&nbsp; (min =3D&nbsp; +4.13 V, max =3D=
&nbsp; +4.12 V)</span><br style=3D"font-family: courier new,monospace;"><sp=
an style=3D"font-family: courier new,monospace;">+5V:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; +6.44 V&nbsp; (min =3D&nbsp; +6.44 V, max =3D&nb=
sp; +6.44 V)</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">+12V:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; +15.60 V&nbsp; (min =3D +15.60 V, max =3D +15.12 V)</spa=
n><br style=3D"font-family: courier new,monospace;"><span style=3D"font-fam=
ily: courier new,monospace;">CPU Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 2)</span><br style=3D"=
font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">P/S Fan:&nbsp;&nbsp;&nb=
sp; 5672 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 2)</span><br s=
tyle=3D"font-family: courier new,monospace;"><span style=3D"font-family: co=
urier new,monospace;">SYS Temp:&nbsp;&nbsp;&nbsp; +23.2 =B0C&nbsp; (high =
=3D +146.2 =B0C, hyst =3D +146.2 =B0C)</span><br style=3D"font-family: cour=
ier new,monospace;">

<span style=3D"font-family: courier new,monospace;">CPU Temp:&nbsp;&nbsp;&n=
bsp; +23.2 =B0C&nbsp; (high =3D +125.2 =B0C, hyst =3D +146.2 =B0C)</span><b=
r style=3D"font-family: courier new,monospace;"><span style=3D"font-family:=
 courier new,monospace;">SBr Temp:&nbsp;&nbsp; +146.2 =B0C&nbsp; (high =3D =
+146.2 =B0C, hyst =3D +146.2 =B0C)</span><br style=3D"font-family: courier =
new,monospace;">

<span style=3D"font-family: courier new,monospace;">[pbn@akagi] /home/pbn/D=
ocuments/other&gt;</span><br><br>So ... everything in sensors&#39; output a=
lways has the same value... ouch !<br><span style=3D"font-family: courier n=
ew,monospace;"></span><br>

... perhaps did I do something wrong ?<br>... perhaps did I forget somethin=
 ?<br><br>Thank you,<br>-- <br>Pierre Bauduin<br><br>
</div>

------=_Part_12871_4400105.1222677763621--


--===============8528778293086057966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8528778293086057966==--
