From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Sun, 28 Nov 2010 07:39:39 +0000
Subject: Re: [lm-sensors] how to rename sensor variables
Message-Id: <266325.43857.qm@web111701.mail.gq1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3072822432847436025=="
List-Id: <lm-sensors.vger.kernel.org>
References: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
In-Reply-To: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============3072822432847436025==
Content-Type: multipart/alternative; boundary="0-1669910879-1290929979=:43857"

--0-1669910879-1290929979=:43857
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

There is nothing about k10temp in sensors3.conf.=0A=0Amahmood@localhost:~$ =
cat /etc/sensors3.conf | grep "*k10temp*"=0Amahmood@localhost:~$ =0A=0A=0A =
=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A________________________________=0AFr=
om: Andrey Repin <hell-for-yahoo@umail.ru>=0ATo: Mahmood Naderan <nt_mahmoo=
d@yahoo.com>; lm-sensors@lm-sensors.org=0ASent: Sun, November 28, 2010 10:5=
7:50 AM=0ASubject: Re: [lm-sensors] how to rename sensor variables=0A=0AGre=
etings, Mahmood Naderan!=0A=0A> temp1:       +43.0=C2=B0C  (high =3D -58.0=
=C2=B0C, hyst =3D +99.0=C2=B0C)  sensor =3D thermistor=0A> temp2:       +41=
.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)  sensor =3D therm=
istor=0A> temp3:       -60.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=
=C2=B0C)  sensor =3D transistor=0A> cpu0_vid:   +0.375 V=0A> k10temp-pci-00=
c3=0A> Adapter: PCI adapter=0A> temp1:       +26.0=C2=B0C  (high =3D +70.0=
=C2=B0C, crit =3D +70.0=C2=B0C)=0A=0A> How can I rename "tempX" to a more m=
eanningful name?=0A> Thanks,=0A=0Aman sensors.conf sometimes?=0A=0A=0A--=0A=
WBR,=0AAndrey Repin (hell-for-yahoo@umail.ru) 28.11.2010, <10:26>=0A=0ASorr=
y for my terrible english...=0A=0A=0A      
--0-1669910879-1290929979=:43857
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:Courier New,courier,monaco,monospace,san=
s-serif;font-size:10pt"><font size=3D"3"><span style=3D"font-family: tahoma=
,new york,times,serif;">There is nothing about k10temp in sensors3.conf.</s=
pan></font><br><br>mahmood@localhost:~$ cat /etc/sensors3.conf | grep "*k10=
temp*"<br>mahmood@localhost:~$ <br><br><div>&nbsp;</div><div><div><font sty=
le=3D"background-color: rgb(255, 255, 255);" color=3D"#0080ff" face=3D"aria=
l, helvetica, sans-serif" size=3D"2"><strong>// Naderan *Mahmood;</strong><=
/font></div></div><div><br></div><div style=3D"font-family: Courier New,cou=
rier,monaco,monospace,sans-serif; font-size: 10pt;"><br><div style=3D"font-=
family: tahoma,new york,times,serif; font-size: 12pt;"><font face=3D"Tahoma=
" size=3D"2"><hr size=3D"1"><b><span style=3D"font-weight: bold;">From:</sp=
an></b> Andrey Repin &lt;hell-for-yahoo@umail.ru&gt;<br><b><span style=3D"f=
ont-weight:
 bold;">To:</span></b> Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;; lm-sen=
sors@lm-sensors.org<br><b><span style=3D"font-weight: bold;">Sent:</span></=
b> Sun, November 28, 2010 10:57:50 AM<br><b><span style=3D"font-weight: bol=
d;">Subject:</span></b> Re: [lm-sensors] how to rename sensor variables<br>=
</font><br>=0AGreetings, Mahmood Naderan!<br><br>&gt; temp1:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; +43.0=C2=B0C&nbsp; (high =3D -58.0=C2=B0C, hyst =3D +=
99.0=C2=B0C)&nbsp; sensor =3D thermistor<br>&gt; temp2:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; +41.5=C2=B0C&nbsp; (high =3D +80.0=C2=B0C, hyst =3D +75.0=
=C2=B0C)&nbsp; sensor =3D thermistor<br>&gt; temp3:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -60.0=C2=B0C&nbsp; (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=
=B0C)&nbsp; sensor =3D transistor<br>&gt; cpu0_vid:&nbsp;&nbsp; +0.375 V<br=
>&gt; k10temp-pci-00c3<br>&gt; Adapter: PCI adapter<br>&gt; temp1:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; +26.0=C2=B0C&nbsp; (high =3D +70.0=C2=B0C, crit=
 =3D +70.0=C2=B0C)<br><br>&gt; How can I rename "tempX" to a more meanningf=
ul name?<br>&gt; Thanks,<br><br>man sensors.conf sometimes?<br><br><br>--<b=
r>WBR,<br> Andrey Repin (<a ymailto=3D"mailto:hell-for-yahoo@umail.ru" href=
=3D"mailto:hell-for-yahoo@umail.ru">hell-for-yahoo@umail.ru</a>) 28.11.2010=
, &lt;10:26&gt;<br><br>Sorry for my terrible
 english...<br><br></div></div>=0A</div><br>=0A=0A      </body></html>
--0-1669910879-1290929979=:43857--


--===============3072822432847436025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3072822432847436025==--
