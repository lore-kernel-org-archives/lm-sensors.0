From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Tue, 26 Oct 2010 10:38:21 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <536448.3359.qm@web111705.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8122053584803375088=="
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============8122053584803375088==
Content-Type: multipart/alternative; boundary="0-1099347085-1288089501=:3359"

--0-1099347085-1288089501=:3359
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I compiled the k10temp driver with these commands:=0Amahmood@localhost:k10t=
emp$ sudo make all=0Amake[1]: Entering directory `/usr/src/linux-headers-2.=
6.32-25-generic'=0A/usr/src/linux-headers-2.6.32-25-generic/arch/x86/Makefi=
le:81: stack protector =0Aenabled but no compiler support=0A  Building modu=
les, stage 2.=0A  MODPOST 1 modules=0Amake[1]: Leaving directory `/usr/src/=
linux-headers-2.6.32-25-generic'=0Amahmood@localhost:k10temp$ sudo make ins=
tall=0Atest -d /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon || mkdir=
 =0A/lib/modules/2.6.32-25-generic/kernel/drivers/hwmon=0Acp k10temp.ko /li=
b/modules/2.6.32-25-generic/kernel/drivers/hwmon=0Adepmod -a -F /lib/module=
s/2.6.32-25-generic/build/System.map 2.6.32-25-generic=0A=0AI then restart =
the system and check the lsmod:=0Amahmood@localhost:k10temp$ sudo lsmod | g=
rep "k10temp"=0Ak10temp                 3543  0 =0A=0Athe output of "sensor=
s" command is:=0Ak10temp-pci-00c3=0AAdapter: PCI adapter=0Atemp1:       +28=
.0=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C)  =0A=0Ak10temp-pci-00cb=0A=
Adapter: PCI adapter=0Atemp1:       +27.0=B0C  (high =3D +70.0=B0C)        =
          =0A=0Ak10temp-pci-00d3=0AAdapter: PCI adapter=0Atemp1:       +26.=
0=B0C  (high =3D +70.0=B0C)                  =0A=0Ak10temp-pci-00db=0AAdapt=
er: PCI adapter=0Atemp1:       +26.0=B0C  (high =3D +70.0=B0C, crit =3D +70=
.0=B0C)  =0A=0AIs this correct? I should see 16 temperatures.=0A=0A =0A// N=
aderan *Mahmood;=0A=0A=0A=0A=0A________________________________=0AFrom: Jea=
n Delvare <khali@linux-fr.org>=0ATo: Mahmood Naderan <nt_mahmood@yahoo.com>=
=0ACc: lm-sensors <lm-sensors@lm-sensors.org>=0ASent: Mon, October 25, 2010=
 6:37:21 PM=0ASubject: Re: [lm-sensors] k10temp is detected but not shown=
=0A=0AOn Mon, 25 Oct 2010 08:00:07 -0700 (PDT), Mahmood Naderan wrote:=0A> =
>If your kernel doesn't include this driver, yes=0A>=0A> How can I check?=
=0A=0ASensors-detect told you. You even quoted that part in your original=
=0Apost. Furthermore, the Devices page in the wiki tells you in which=0Aker=
nel version the driver was added, so it should be easy to find out,=0Aassum=
ing you know which kernel version you're running.=0A=0A-- =0AJean Delvare=
=0A=0A=0A=0A      
--0-1099347085-1288089501=:3359
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma,new york,times,serif;font-size:12=
pt"><span style=3D"font-family: tahoma,new york,times,serif;">I compiled th=
e k10temp driver with these commands:<br><font size=3D"2"><span style=3D"fo=
nt-family: Courier New,courier,monaco,monospace,sans-serif;">mahmood@</span=
></font></span><font size=3D"2"><span style=3D"font-family: Courier New,cou=
rier,monaco,monospace,sans-serif;">localhost:k10temp$ sudo make all<br>make=
[1]: Entering directory `/usr/src/linux-headers-2.6.32-25-generic'<br>/usr/=
src/linux-headers-2.6.32-25-generic/arch/x86/Makefile:81: stack protector e=
nabled but no compiler support<br>&nbsp; Building modules, stage 2.<br>&nbs=
p; MODPOST 1 modules<br>make[1]: Leaving directory `/usr/src/linux-headers-=
2.6.32-25-generic'<br>mahmood@localhost</span></font><span style=3D"font-fa=
mily: tahoma,new york,times,serif;"><font size=3D"2"><span style=3D"font-fa=
mily: Courier
 New,courier,monaco,monospace,sans-serif;">:k10temp$ sudo make install</spa=
n><br style=3D"font-family: Courier New,courier,monaco,monospace,sans-serif=
;"><span style=3D"font-family: Courier New,courier,monaco,monospace,sans-se=
rif;">test -d /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon || mkdir =
/lib/modules/2.6.32-25-generic/kernel/drivers/hwmon</span><br style=3D"font=
-family: Courier New,courier,monaco,monospace,sans-serif;"><span style=3D"f=
ont-family: Courier New,courier,monaco,monospace,sans-serif;">cp k10temp.ko=
 /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon</span><br style=3D"fon=
t-family: Courier New,courier,monaco,monospace,sans-serif;"><span style=3D"=
font-family: Courier New,courier,monaco,monospace,sans-serif;">depmod -a -F=
 /lib/modules/2.6.32-25-generic/build/System.map 2.6.32-25-generic</span></=
font><br><br>I then restart the system and check the lsmod:<br><font size=
=3D"2"><span style=3D"font-family: Courier
 New,courier,monaco,monospace,sans-serif;">mahmood@localhost:k10temp$ sudo =
lsmod | grep "k10temp"</span><br style=3D"font-family: Courier New,courier,=
monaco,monospace,sans-serif;"><span style=3D"font-family: Courier New,couri=
er,monaco,monospace,sans-serif;">k10temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3543&nbsp; 0 =
</span></font><br><br>the output of "sensors" command is:<br><font size=3D"=
2"><span style=3D"font-family: Courier New,courier,monaco,monospace,sans-se=
rif;">k10temp-pci-00c3</span><br style=3D"font-family: Courier New,courier,=
monaco,monospace,sans-serif;"><span style=3D"font-family: Courier New,couri=
er,monaco,monospace,sans-serif;">Adapter: PCI adapter</span><br style=3D"fo=
nt-family: Courier New,courier,monaco,monospace,sans-serif;"><span style=3D=
"font-family: Courier New,courier,monaco,monospace,sans-serif;">temp1:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +28.0=B0C&nbsp; (high =3D +70.0=B0C, crit =
=3D
 +70.0=B0C)&nbsp; </span><br style=3D"font-family: Courier New,courier,mona=
co,monospace,sans-serif;"><br style=3D"font-family: Courier New,courier,mon=
aco,monospace,sans-serif;"><span style=3D"font-family: Courier New,courier,=
monaco,monospace,sans-serif;">k10temp-pci-00cb</span><br style=3D"font-fami=
ly: Courier New,courier,monaco,monospace,sans-serif;"><span style=3D"font-f=
amily: Courier New,courier,monaco,monospace,sans-serif;">Adapter: PCI adapt=
er</span><br style=3D"font-family: Courier New,courier,monaco,monospace,san=
s-serif;"><span style=3D"font-family: Courier New,courier,monaco,monospace,=
sans-serif;">temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +27.0=B0C&nbsp; (hi=
gh =3D +70.0=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><br style=3D"font-famil=
y: Courier New,courier,monaco,monospace,sans-serif;"><br style=3D"font-fami=
ly: Courier New,courier,monaco,monospace,sans-serif;"><span style=3D"font-f=
amily: Courier
 New,courier,monaco,monospace,sans-serif;">k10temp-pci-00d3</span><br style=
=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;"><span st=
yle=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;">Adapt=
er: PCI adapter</span><br style=3D"font-family: Courier New,courier,monaco,=
monospace,sans-serif;"><span style=3D"font-family: Courier New,courier,mona=
co,monospace,sans-serif;">temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +26.0=
=B0C&nbsp; (high =3D +70.0=B0C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><br style=
=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;"><br styl=
e=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;"><span s=
tyle=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;">k10t=
emp-pci-00db</span><br style=3D"font-family: Courier New,courier,monaco,mon=
ospace,sans-serif;"><span style=3D"font-family: Courier
 New,courier,monaco,monospace,sans-serif;">Adapter: PCI adapter</span><br s=
tyle=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;"><spa=
n style=3D"font-family: Courier New,courier,monaco,monospace,sans-serif;">t=
emp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +26.0=B0C&nbsp; (high =3D +70.0=
=B0C, crit =3D +70.0=B0C)&nbsp; </span></font><br><br>Is this correct? I sh=
ould see 16 temperatures.<br></span><div>&nbsp;</div><div><div><font style=
=3D"background-color: rgb(255, 255, 255);" color=3D"#0080ff" face=3D"arial,=
 helvetica, sans-serif" size=3D"2"><strong>// Naderan *Mahmood;</strong></f=
ont></div></div><div><br></div><div style=3D"font-family: tahoma,new york,t=
imes,serif; font-size: 12pt;"><br><div style=3D"font-family: tahoma,new yor=
k,times,serif; font-size: 12pt;"><font face=3D"Tahoma" size=3D"2"><hr size=
=3D"1"><b><span style=3D"font-weight: bold;">From:</span></b> Jean Delvare =
&lt;khali@linux-fr.org&gt;<br><b><span style=3D"font-weight: bold;">To:</sp=
an></b> Mahmood Naderan
 &lt;nt_mahmood@yahoo.com&gt;<br><b><span style=3D"font-weight: bold;">Cc:<=
/span></b> lm-sensors &lt;lm-sensors@lm-sensors.org&gt;<br><b><span style=
=3D"font-weight: bold;">Sent:</span></b> Mon, October 25, 2010 6:37:21 PM<b=
r><b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [lm-sensors=
] k10temp is detected but not shown<br></font><br>=0AOn Mon, 25 Oct 2010 08=
:00:07 -0700 (PDT), Mahmood Naderan wrote:<br>&gt; &gt;If your kernel doesn=
't include this driver, yes<br>&gt;<br>&gt; How can I check?<br><br>Sensors=
-detect told you. You even quoted that part in your original<br>post. Furth=
ermore, the Devices page in the wiki tells you in which<br>kernel version t=
he driver was added, so it should be easy to find out,<br>assuming you know=
 which kernel version you're running.<br><br>-- <br>Jean Delvare<br></div><=
/div>=0A</div><br>=0A=0A      </body></html>
--0-1099347085-1288089501=:3359--


--===============8122053584803375088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8122053584803375088==--
