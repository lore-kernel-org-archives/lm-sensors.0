From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Tue, 26 Oct 2010 11:09:10 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <5251.11442.qm@web111712.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4260001683562272813=="
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============4260001683562272813==
Content-Type: multipart/alternative; boundary="0-992873082-1288091350=:11442"

--0-992873082-1288091350=:11442
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Do you have several, different CPU models in your system?=0ATwo AMD cpu (=
each has 8 cores) on one motherboard=0A=0A =0A>Why should you?=0ABecause th=
e lm-sensor for core-i7 (that has 8 cores) shows 8 cpu temperatures=0A=0ARe=
gards,=0A=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A____________________________=
____=0AFrom: Jean Delvare <khali@linux-fr.org>=0ATo: Mahmood Naderan <nt_ma=
hmood@yahoo.com>=0ACc: lm-sensors <lm-sensors@lm-sensors.org>=0ASent: Tue, =
October 26, 2010 2:29:45 PM=0ASubject: Re: [lm-sensors] k10temp is detected=
 but not shown=0A=0AOn Tue, 26 Oct 2010 03:38:21 -0700 (PDT), Mahmood Nader=
an wrote:=0A> I compiled the k10temp driver with these commands:=0A> mahmoo=
d@localhost:k10temp$ sudo make all=0A> make[1]: Entering directory `/usr/sr=
c/linux-headers-2.6.32-25-generic'=0A> /usr/src/linux-headers-2.6.32-25-gen=
eric/arch/x86/Makefile:81: stack protector =0A=0A> enabled but no compiler =
support=0A>   Building modules, stage 2.=0A>   MODPOST 1 modules=0A> make[1=
]: Leaving directory `/usr/src/linux-headers-2.6.32-25-generic'=0A> mahmood=
@localhost:k10temp$ sudo make install=0A> test -d /lib/modules/2.6.32-25-ge=
neric/kernel/drivers/hwmon || mkdir =0A> /lib/modules/2.6.32-25-generic/ker=
nel/drivers/hwmon=0A> cp k10temp.ko /lib/modules/2.6.32-25-generic/kernel/d=
rivers/hwmon=0A> depmod -a -F /lib/modules/2.6.32-25-generic/build/System.m=
ap 2.6.32-25-generic=0A> =0A> I then restart the system and check the lsmod=
:=0A> mahmood@localhost:k10temp$ sudo lsmod | grep "k10temp"=0A> k10temp   =
              3543  0 =0A> =0A> the output of "sensors" command is:=0A> k10=
temp-pci-00c3=0A> Adapter: PCI adapter=0A> temp1:       +28.0=B0C  (high =
=3D +70.0=B0C, crit =3D +70.0=B0C)  =0A> =0A> k10temp-pci-00cb=0A> Adapter:=
 PCI adapter=0A> temp1:       +27.0=B0C  (high =3D +70.0=B0C)              =
    =0A> =0A> k10temp-pci-00d3=0A> Adapter: PCI adapter=0A> temp1:       +2=
6.0=B0C  (high =3D +70.0=B0C)                  =0A> =0A> k10temp-pci-00db=
=0A> Adapter: PCI adapter=0A> temp1:       +26.0=B0C  (high =3D +70.0=B0C, =
crit =3D +70.0=B0C)  =0A=0ASurprising that some CPUs have the critical limi=
t and some don't... Do=0Ayou have several, different CPU models in your sys=
tem?=0A=0A> Is this correct? I should see 16 temperatures.=0A=0AWhy should =
you?=0A=0A-- =0AJean Delvare=0A=0A=0A=0A      
--0-992873082-1288091350=:11442
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New,courier,monaco,monospace,san=
s-serif;font-size:10pt"><font size=3D"3"><span style=3D"font-family: tahoma=
,new york,times,serif;">&gt; Do you have several, different CPU models in y=
our system?</span><br style=3D"font-family: tahoma,new york,times,serif;"><=
span style=3D"font-family: tahoma,new york,times,serif;">Two AMD cpu (each =
has 8 cores) on one motherboard</span><br style=3D"font-family: tahoma,new =
york,times,serif;"></font><div><font size=3D"3"><span style=3D"font-family:=
 tahoma,new york,times,serif;">&nbsp;</span><br style=3D"font-family: tahom=
a,new york,times,serif;"><span style=3D"font-family: tahoma,new york,times,=
serif;">&gt;Why should you?</span><br style=3D"font-family: tahoma,new york=
,times,serif;"><span style=3D"font-family: tahoma,new york,times,serif;">Be=
cause the lm-sensor for core-i7 (that has 8 cores) shows 8 cpu temperatures=
</span><br
 style=3D"font-family: tahoma,new york,times,serif;"><br style=3D"font-fami=
ly: tahoma,new york,times,serif;"><span style=3D"font-family: tahoma,new yo=
rk,times,serif;">Regards,</span></font><br></div><div><div><font style=3D"b=
ackground-color: rgb(255, 255, 255);" color=3D"#0080ff" face=3D"arial, helv=
etica, sans-serif" size=3D"2"><strong>// Naderan *Mahmood;</strong></font><=
/div></div><div><br></div><div style=3D"font-family: Courier New,courier,mo=
naco,monospace,sans-serif; font-size: 10pt;"><br><div style=3D"font-family:=
 tahoma,new york,times,serif; font-size: 12pt;"><font face=3D"Tahoma" size=
=3D"2"><hr size=3D"1"><b><span style=3D"font-weight: bold;">From:</span></b=
> Jean Delvare &lt;khali@linux-fr.org&gt;<br><b><span style=3D"font-weight:=
 bold;">To:</span></b> Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;<br><b><=
span style=3D"font-weight: bold;">Cc:</span></b> lm-sensors &lt;lm-sensors@=
lm-sensors.org&gt;<br><b><span style=3D"font-weight: bold;">Sent:</span></b=
> Tue, October 26, 2010
 2:29:45 PM<br><b><span style=3D"font-weight: bold;">Subject:</span></b> Re=
: [lm-sensors] k10temp is detected but not shown<br></font><br>=0AOn Tue, 2=
6 Oct 2010 03:38:21 -0700 (PDT), Mahmood Naderan wrote:<br>&gt; I compiled =
the k10temp driver with these commands:<br>&gt; mahmood@localhost:k10temp$ =
sudo make all<br>&gt; make[1]: Entering directory `/usr/src/linux-headers-2=
.6.32-25-generic'<br>&gt; /usr/src/linux-headers-2.6.32-25-generic/arch/x86=
/Makefile:81: stack protector <br>&gt; enabled but no compiler support<br>&=
gt;&nbsp;  Building modules, stage 2.<br>&gt;&nbsp;  MODPOST 1 modules<br>&=
gt; make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-25-generic'<b=
r>&gt; mahmood@localhost:k10temp$ sudo make install<br>&gt; test -d /lib/mo=
dules/2.6.32-25-generic/kernel/drivers/hwmon || mkdir <br>&gt; /lib/modules=
/2.6.32-25-generic/kernel/drivers/hwmon<br>&gt; cp k10temp.ko /lib/modules/=
2.6.32-25-generic/kernel/drivers/hwmon<br>&gt; depmod -a -F /lib/modules/2.=
6.32-25-generic/build/System.map 2.6.32-25-generic<br>&gt; <br>&gt; I then =
restart the system and check the lsmod:<br>&gt;
 mahmood@localhost:k10temp$ sudo lsmod | grep "k10temp"<br>&gt; k10temp&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  3543&nbsp; 0 <br>&gt; =
<br>&gt; the output of "sensors" command is:<br>&gt; k10temp-pci-00c3<br>&g=
t; Adapter: PCI adapter<br>&gt; temp1:&nbsp; &nbsp; &nbsp;  +28.0=B0C&nbsp;=
 (high =3D +70.0=B0C, crit =3D +70.0=B0C)&nbsp; <br>&gt; <br>&gt; k10temp-p=
ci-00cb<br>&gt; Adapter: PCI adapter<br>&gt; temp1:&nbsp; &nbsp; &nbsp;  +2=
7.0=B0C&nbsp; (high =3D +70.0=B0C)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; <br>&gt; <br>&gt; k10temp-pci-00d3<br>&gt; Adapter: P=
CI adapter<br>&gt; temp1:&nbsp; &nbsp; &nbsp;  +26.0=B0C&nbsp; (high =3D +7=
0.0=B0C)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>=
&gt; <br>&gt; k10temp-pci-00db<br>&gt; Adapter: PCI adapter<br>&gt; temp1:&=
nbsp; &nbsp; &nbsp;  +26.0=B0C&nbsp; (high =3D +70.0=B0C, crit =3D +70.0=B0=
C)&nbsp; <br><br>Surprising that some CPUs have the critical limit and some=
 don't...
 Do<br>you have several, different CPU models in your system?<br><br>&gt; I=
s this correct? I should see 16 temperatures.<br><br>Why should you?<br><br=
>-- <br>Jean Delvare<br></div></div>=0A</div><br>=0A=0A=0A=0A=0A=0A=0A=0A  =
    </body></html>
--0-992873082-1288091350=:11442--


--===============4260001683562272813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4260001683562272813==--
