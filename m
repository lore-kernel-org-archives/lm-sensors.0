From: borat Gunter <borat.gunter@googlemail.com>
Date: Fri, 28 May 2010 10:57:23 +0000
Subject: Re: [lm-sensors] How to get the OID of lm_sensors'value for SNMP
Message-Id: <AANLkTilFDSnv8NHPaJF2lRpKT-bcN9nTSAchFA_JE45W@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8958111359465732098=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinFupaElK-tO7ReqZdi_Xr-i78S5skKU1mcWJn7@mail.gmail.com>
In-Reply-To: <AANLkTinFupaElK-tO7ReqZdi_Xr-i78S5skKU1mcWJn7@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8958111359465732098==
Content-Type: multipart/alternative; boundary=001517475e623b9ce00487a55fa8

--001517475e623b9ce00487a55fa8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I have found it out, CPU Temp's value is stored by me under
.1.3.6.1.4.1.2021.13.16.2.1.3.1.
For anyone who concerned.

regards,
borat

On Thu, May 27, 2010 at 2:06 PM, borat Gunter
<borat.gunter@googlemail.com>wrote:

> Hello everyone,
>
> i have the output of sensors:
>
> printsrv:~ # sensors
> lm85-i2c-0-2e
> Adapter: SMBus I801 adapter at 0400
> V1.5:       +1.46 V  (min =3D  +0.00 V, max =3D  +3.32 V)
> VCore:      +1.31 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:       +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:         +5.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:       +12.12 V  (min =3D  +0.00 V, max =3D +15.94 V)
> CPU_Fan:   2115 RPM  (min =3D    0 RPM)
> fan2:         0 RPM  (min =3D    0 RPM)
> fan3:      1386 RPM  (min =3D    0 RPM)
> fan4:         0 RPM  (min =3D    0 RPM)
> CPU Temp:    +50=C2=B0C  (low  =3D  -127=C2=B0C, high =3D  +127=C2=B0C)
> Board Temp:
>              +41=C2=B0C  (low  =3D  -127=C2=B0C, high =3D  +127=C2=B0C)
> Remote Temp:
>              +36=C2=B0C  (low  =3D  -127=C2=B0C, high =3D  +127=C2=B0C)
> CPU_PWM:   115
> Fan2_PWM:    0
> Fan3_PWM:  115
> vid:      +1.088 V  (VRM Version 10.0)
>
> And now i want to use nagios per snmp to check the "CPU Temp", what do I
> need to do to make the snmp and lm_sensor working together? How do I get =
the
> OID of that value? I tried with snmpwalk ucdavis.ucdExperimental.lmSensor=
s,
> but there is nothing there.
>
> I'd appreciate for any kind of help.
> thanks in advance.
> borat
>
>
>
>

--001517475e623b9ce00487a55fa8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone, <br><br>I have found it out, CPU Temp&#39;s value is stored=
 by me under .1.3.6.1.4.1.2021.13.16.2.1.3.1.<br>For anyone who concerned.<=
br><br>regards,<br>borat<br><br><div class=3D"gmail_quote">On Thu, May 27, =
2010 at 2:06 PM, borat Gunter <span dir=3D"ltr">&lt;<a href=3D"mailto:borat=
.gunter@googlemail.com">borat.gunter@googlemail.com</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hello everyone,<b=
r><br>i have the output of sensors: <br><br>printsrv:~ # sensors<br>lm85-i2=
c-0-2e<br>
Adapter: SMBus I801 adapter at 0400<br>V1.5:=A0=A0=A0=A0=A0=A0 +1.46 V=A0 (=
min =3D=A0 +0.00 V, max =3D=A0 +3.32 V)<br>VCore:=A0=A0=A0=A0=A0 +1.31 V=A0=
 (min =3D=A0 +0.00 V, max =3D=A0 +2.99 V)<br>
V3.3:=A0=A0=A0=A0=A0=A0 +3.28 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.38 V)=
<br>V5:=A0=A0=A0=A0=A0=A0=A0=A0 +5.00 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+6.64 V)<br>V12:=A0=A0=A0=A0=A0=A0 +12.12 V=A0 (min =3D=A0 +0.00 V, max =3D=
 +15.94 V)<br>CPU_Fan:=A0=A0 2115 RPM=A0 (min =3D=A0=A0=A0 0 RPM)<br>fan2:=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM)<br>

fan3:=A0=A0=A0=A0=A0 1386 RPM=A0 (min =3D=A0=A0=A0 0 RPM)<br>fan4:=A0=A0=A0=
=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM)<br>CPU Temp:=A0=A0=A0 +50=
=C2=B0C=A0 (low=A0 =3D=A0 -127=C2=B0C, high =3D=A0 +127=C2=B0C)<br>Board Te=
mp:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41=C2=B0C=A0 (low=A0 =3D=A0 -1=
27=C2=B0C, high =3D=A0 +127=C2=B0C)<br>Remote Temp:<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +36=C2=B0C=A0 (low=A0 =3D=A0 -127=C2=
=B0C, high =3D=A0 +127=C2=B0C)<br>CPU_PWM:=A0=A0 115<br>Fan2_PWM:=A0=A0=A0 =
0<br>Fan3_PWM:=A0 115<br>vid:=A0=A0=A0=A0=A0 +1.088 V=A0 (VRM Version 10.0)=
<br><br>And now i want to use nagios per snmp to check the &quot;CPU Temp&q=
uot;, what do I need to do to make the snmp and lm_sensor working together?=
 How do I get the OID of that value? I tried with snmpwalk ucdavis.ucdExper=
imental.lmSensors, but there is nothing there.<br>

<br>I&#39;d appreciate for any kind of help.<br>thanks in advance.<br><font=
 color=3D"#888888">borat<br><br><br><br>
</font></blockquote></div><br>

--001517475e623b9ce00487a55fa8--


--===============8958111359465732098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8958111359465732098==--
