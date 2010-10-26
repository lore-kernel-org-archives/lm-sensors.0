From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Tue, 26 Oct 2010 18:46:48 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4CC72218.6080302@maxi-dsl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6834781725279989062=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============6834781725279989062==
Content-Type: multipart/alternative;
 boundary="------------050008010104010807050101"

This is a multi-part message in MIME format.
--------------050008010104010807050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

hi Jean,

Am 25.10.2010 09:30, schrieb Jean Delvare:
> Now there is:
>    http://khali.linux-fr.org/devel/misc/jc42/
>   =20
great - this did again work immediately :-)

'sensors' now gives:
/
karsten:~$ sensors
jc42-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0b00
temp1:       +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM

jc42-i2c-0-19
Adapter: SMBus PIIX4 adapter at 0b00
temp1:       +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM

k10temp-pci-00c3
Adapter: PCI adapter
CPU Temp (internal): +25.0=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)=
 /

So I wanted to change both names and thresholds for the two jc42=20
readings. I succeeded with the names (after understanding the 'bus'=20
statement..), but I did not manage to set temperature thresholds.

The current config file:

bus "i2c-0" "SMBus PIIX4 adapter at 0b00"
/
chip "jc42-i2c-0-18"
         label temp1 "DRAM_0"
         set temp1_min 0
         set temp1_max 65
         set temp1_crit 70

chip "jc42-i2c-0-19"
         label temp1 "DRAM_1"
         set temp1_min 0
         set temp1_max 65
         set temp1_crit 70/

still gives:

/karsten:~$ sensors
jc42-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0b00
DRAM_0:      +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM

jc42-i2c-0-19
Adapter: SMBus PIIX4 adapter at 0b00
DRAM_1:      +21.5=B0C  (low  =3D  +0.0=B0C, high =3D  +0.0=B0C)  ALARM
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM

k10temp-pci-00c3
Adapter: PCI adapter
CPU Temp (internal): +25.5=B0C  (high =3D +70.0=B0C, crit =3D +100.0=B0C)
/
Could you think of an explanation?


thanks and regards -

Karsten

(p.s.: I'll send another mail on the IMSI topic- please let me know once=20
this gets boring / annoying ;-)

--------------050008010104010807050101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
hi Jean,<br>
<br>
Am 25.10.2010 09:30, schrieb Jean Delvare:
<blockquote cite="mid:20101025093023.5fbbd8a0@endymion.delvare"
 type="cite">Now there is:<br>
  <pre wrap="">  <a class="moz-txt-link-freetext" href="http://khali.linux-fr.org/devel/misc/jc42/">http://khali.linux-fr.org/devel/misc/jc42/</a>
  </pre>
</blockquote>
great - this did again work immediately :-)<br>
<br>
'sensors' now gives: <br>
<i><br>
karsten:~$ sensors<br>
jc42-i2c-0-18<br>
Adapter: SMBus PIIX4 adapter at 0b00<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +21.5&deg;C&nbsp; (low&nbsp; =&nbsp; +0.0&deg;C, high =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crit =&nbsp; +0.0&deg;C, hyst =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
<br>
jc42-i2c-0-19<br>
Adapter: SMBus PIIX4 adapter at 0b00<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +21.5&deg;C&nbsp; (low&nbsp; =&nbsp; +0.0&deg;C, high =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crit =&nbsp; +0.0&deg;C, hyst =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
<br>
k10temp-pci-00c3<br>
Adapter: PCI adapter<br>
CPU Temp (internal): +25.0&deg;C&nbsp; (high = +70.0&deg;C, crit = +100.0&deg;C)&nbsp; </i><br>
<br>
So I wanted to change both names and thresholds for the two jc42
readings. I succeeded with the names (after understanding the 'bus'
statement..), but I did not manage to set temperature thresholds.<br>
<br>
The current config file:<br>
<br>
bus "i2c-0" "SMBus PIIX4 adapter at 0b00"<br>
<i><br>
chip "jc42-i2c-0-18"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label temp1 "DRAM_0"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_min 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max 65<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_crit 70<br>
<br>
chip "jc42-i2c-0-19"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label temp1 "DRAM_1"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_min 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_max 65<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set temp1_crit 70</i><br>
<br>
still gives:<br>
<br>
<i>karsten:~$ sensors<br>
jc42-i2c-0-18<br>
Adapter: SMBus PIIX4 adapter at 0b00<br>
DRAM_0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +21.5&deg;C&nbsp; (low&nbsp; =&nbsp; +0.0&deg;C, high =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crit =&nbsp; +0.0&deg;C, hyst =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
<br>
jc42-i2c-0-19<br>
Adapter: SMBus PIIX4 adapter at 0b00<br>
DRAM_1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +21.5&deg;C&nbsp; (low&nbsp; =&nbsp; +0.0&deg;C, high =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crit =&nbsp; +0.0&deg;C, hyst =&nbsp; +0.0&deg;C)&nbsp; ALARM&nbsp; <br>
<br>
k10temp-pci-00c3<br>
Adapter: PCI adapter<br>
CPU Temp (internal): +25.5&deg;C&nbsp; (high = +70.0&deg;C, crit = +100.0&deg;C) <br>
</i><br>
Could you think of an explanation?<br>
<br>
<br>
thanks and regards -<br>
<br>
Karsten<br>
<br>
(p.s.: I'll send another mail on the IMSI topic- please let me know
once this gets boring / annoying ;-)<br>
</body>
</html>

--------------050008010104010807050101--


--===============6834781725279989062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6834781725279989062==--
