From: Igor Santos <igorsantos07@gmail.com>
Date: Thu, 10 Sep 2009 22:20:55 +0000
Subject: [lm-sensors] Problems with DG45ID sensors
Message-Id: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0835913276436920839=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0835913276436920839==
Content-Type: multipart/alternative; boundary=000feaf08120fe9e690473409cf9

--000feaf08120fe9e690473409cf9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I've been asking for help at superuser.com, but nobody could help me.
I've tried the last version of sensors-detect script, but it just gives me
the same modules to load up...

This is my computer:
Intel Core2duo e4700
Motherboard Intel DG45ID
GeForce 9800 GT
2 HD's, one SATA and one PATA with adapter

It tolds me to load i2c-i801, lm85 and coretemp modules. And so I did.

I can see properly my Videocard temp (I think it's provided by nvidia,
right?) and both HD (but sometimes the IDE disk simply goes 0=B0). My CPU
temps looks correct too.

But all the temps from my motherboard are zeroed.
Take a look at the full output:

igoru[~]$ sensors
> lm85-i2c-0-2e
> Adapter: SMBus I801 adapter at e000
> V1.5: +0.00 V (min =3D +0.00 V, max =3D +3.32 V)
> VCore: +0.00 V (min =3D +0.00 V, max =3D +2.99 V)
> V3.3: +0.00 V (min =3D +0.00 V, max =3D +4.38 V)
> V5: +0.00 V (min =3D +0.00 V, max =3D +6.64 V)
> V12: +0.00 V (min =3D +0.00 V, max =3D +15.94 V)
> CPU_Fan: 0 RPM (min =3D 0 RPM) ALARM
> fan2: 0 RPM (min =3D 0 RPM) ALARM
> fan3: 0 RPM (min =3D 0 RPM) ALARM
> fan4: 0 RPM (min =3D 0 RPM) ALARM
> CPU Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> Board Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> Remote Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> cpu0_vid: +2.050 V
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0: +57.0=B0C (high =3D +78.0=B0C, crit =3D +100.0=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1: +57.0=B0C (high =3D +78.0=B0C, crit =3D +100.0=B0C)
>


What should I do?


Thank you in advance,

Igor Santos
  Programador Web

--000feaf08120fe9e690473409cf9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,<br clear=3D"all"></div><div><br></div><div>I&#39;ve been asking=
 for help at <a href=3D"http://superuser.com">superuser.com</a>, but nobody=
 could help me.</div><div>I&#39;ve tried the last version of sensors-detect=
 script, but it just gives me the same modules to load up...</div>
<div><br></div><div>This is my computer:</div><div>Intel Core2duo e4700</di=
v><div>Motherboard Intel DG45ID</div><div>GeForce 9800 GT</div><div>2 HD&#3=
9;s, one SATA and one PATA with adapter</div><div><br></div><div>It tolds m=
e to load i2c-i801, lm85 and coretemp modules. And so I did.</div>
<div><br></div><div>I can see properly my Videocard temp (I think it&#39;s =
provided by nvidia, right?) and both HD (but sometimes the IDE disk simply =
goes 0=B0). My CPU temps looks correct too.</div><div><br></div><div>But al=
l the temps from my motherboard are zeroed.</div>
<div>Take a look at the full output:</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">igoru[~]$ sensors<br>lm85-i2c-0-2e<br>Adapter: SMBus I801 ad=
apter at e000<br>
V1.5:        +0.00 V  (min =3D  +0.00 V, max =3D  +3.32 V)   <br>VCore:    =
   +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   <br>V3.3:        +0.00 V=
  (min =3D  +0.00 V, max =3D  +4.38 V)   <br>V5:          +0.00 V  (min =3D=
  +0.00 V, max =3D  +6.64 V)   <br>
V12:         +0.00 V  (min =3D  +0.00 V, max =3D +15.94 V)   <br>CPU_Fan:  =
     0 RPM  (min =3D    0 RPM)  ALARM<br>fan2:          0 RPM  (min =3D    =
0 RPM)  ALARM<br>fan3:          0 RPM  (min =3D    0 RPM)  ALARM<br>fan4:  =
        0 RPM  (min =3D    0 RPM)  ALARM<br>
CPU Temp:     +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  <br>Boa=
rd Temp:   +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  <br>Remote=
 Temp:  +0.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  <br>cpu0_vid:=
   +2.050 V<br><br>coretemp-isa-0000<br>
Adapter: ISA adapter<br>Core 0:      +57.0=B0C  (high =3D +78.0=B0C, crit =
=3D +100.0=B0C)  <br><br>coretemp-isa-0001<br>Adapter: ISA adapter<br>Core =
1:      +57.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)<br></blockquot=
e><div><br></div>
<div><br></div><div>What should I do?</div><div><br></div><div><br></div><d=
iv>Thank you in advance,</div><div><br></div>Igor Santos<br> =A0 Programado=
r Web<br>

--000feaf08120fe9e690473409cf9--


--===============0835913276436920839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0835913276436920839==--
