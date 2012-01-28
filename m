From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sat, 28 Jan 2012 19:39:35 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error handling
Message-Id: <CACW_hTZDW6kVy7CiL9apXc2sQEJ1zbB4W_Na9ow7nsvzLW68rg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6585110064015846335=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============6585110064015846335==
Content-Type: multipart/alternative; boundary=20cf307f3092f1252c04b79bc570

--20cf307f3092f1252c04b79bc570
Content-Type: text/plain; charset=ISO-8859-1

2012/1/28 Jean Delvare <khali@linux-fr.org>

> On Fri, 27 Jan 2012 14:22:00 +0100, Frans Meulenbroeks wrote:
> > 2012/1/26 Jean Delvare <khali@linux-fr.org>
> > > Frans, could you please provide a register dump of your LM96080 chip?
> > > I'd like to add that to my collection. You can get such a dump using
> > > the i2c-dev driver + i2cdump (from package i2c-tools.)
> >
> > I hope this is what you are looking for:
> >
> > root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# cat
> > fan1_input
> > 3668
> > root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
> > i2cdump  1 0x28
> > No size specified (using byte-data access)
> > Error: Could not set address to 0x28: Device or resource busy
> > root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
> > i2cdump -f 1 0x28
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-1, address 0x28, mode byte
> > Continue? [Y/n] y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 01 7f 2d 00 00 3c 18 00 00 00 00 00 00 00 00 00    ??-..<?.........
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 20: 0c 00 00 00 00 00 00 1a 2e ff 00 00 00 00 00 00    ?......?........
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08    ..............??
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> >
> > Not fully sure if this is correct as I had to use -f
>
> That's perfect, thank you.
>
> > Also fan1_input is 3668, which is hex 0e54 but I do not see that value in
> > the dump.
>
> As is the case of most monitoring chips, the LM96080 doesn't measure
> the fan speed directly. Instead, it measures how much time it takes to
> the fan to spin once, and this time is expressed in units of an
> internal clock (22.5 kHz). The relevant register is 0x28, value is 0x2e
> or 46. The speed is computed as:
>
> RPM = (22.5k * 60) / (register value * divisor)
>
> Where the divisor is 1, 2, 4 or 8, encoded in register 0x05. In your
> case the divisor is 8, which leads to :
>
> 22.5 *  1000 * 60 / (46 * 8) = 3668 RPM
>
> As a side note, a divisor of 4 or even 2 would yield better speed
> measurement accuracy in your case (i.e. you can set fan1_div to 2 in
> your configuration file.)
>
> --
>
> Thanks for the explanation.
Actually I guessed it would be something like this, but didn't get to
digging into it.
Wrt the accuracy. Might try that. Then again we do not bother too much as
we mainly want to monitor the fan for working and are not too interested in
the speed; I'm just monitoring if it does not fall below a treshold value
(and if it does raise an alarm indicating that preventive replacement is
needed.

Frans

--20cf307f3092f1252c04b79bc570
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/28 Jean Delvare <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
On Fri, 27 Jan 2012 14:22:00 +0100, Frans Meulenbroeks wrote:<br>
<div class=3D"im">&gt; 2012/1/26 Jean Delvare &lt;<a href=3D"mailto:khali@l=
inux-fr.org">khali@linux-fr.org</a>&gt;<br>
&gt; &gt; Frans, could you please provide a register dump of your LM96080 c=
hip?<br>
&gt; &gt; I&#39;d like to add that to my collection. You can get such a dum=
p using<br>
&gt; &gt; the i2c-dev driver + i2cdump (from package i2c-tools.)<br>
&gt;<br>
</div><div><div class=3D"h5">&gt; I hope this is what you are looking for:<=
br>
&gt;<br>
&gt; root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# c=
at<br>
&gt; fan1_input<br>
&gt; 3668<br>
&gt; root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#<b=
r>
&gt; i2cdump =A01 0x28<br>
&gt; No size specified (using byte-data access)<br>
&gt; Error: Could not set address to 0x28: Device or resource busy<br>
&gt; root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#<b=
r>
&gt; i2cdump -f 1 0x28<br>
&gt; No size specified (using byte-data access)<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and wo=
rse!<br>
&gt; I will probe file /dev/i2c-1, address 0x28, mode byte<br>
&gt; Continue? [Y/n] y<br>
&gt; =A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f =A0 =A00123456789abcdef<br>
&gt; 00: 01 7f 2d 00 00 3c 18 00 00 00 00 00 00 00 00 00 =A0 =A0??-..&lt;?.=
........<br>
&gt; 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 20: 0c 00 00 00 00 00 00 1a 2e ff 00 00 00 00 00 00 =A0 =A0?......?...=
.....<br>
&gt; 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08 =A0 =A0...........=
...??<br>
&gt; 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt; f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =A0 =A0...........=
.....<br>
&gt;<br>
&gt; Not fully sure if this is correct as I had to use -f<br>
<br>
</div></div>That&#39;s perfect, thank you.<br>
<div class=3D"im"><br>
&gt; Also fan1_input is 3668, which is hex 0e54 but I do not see that value=
 in<br>
&gt; the dump.<br>
<br>
</div>As is the case of most monitoring chips, the LM96080 doesn&#39;t meas=
ure<br>
the fan speed directly. Instead, it measures how much time it takes to<br>
the fan to spin once, and this time is expressed in units of an<br>
internal clock (22.5 kHz). The relevant register is 0x28, value is 0x2e<br>
or 46. The speed is computed as:<br>
<br>
RPM =3D (22.5k * 60) / (register value * divisor)<br>
<br>
Where the divisor is 1, 2, 4 or 8, encoded in register 0x05. In your<br>
case the divisor is 8, which leads to :<br>
<br>
22.5 * =A01000 * 60 / (46 * 8) =3D 3668 RPM<br>
<br>
As a side note, a divisor of 4 or even 2 would yield better speed<br>
measurement accuracy in your case (i.e. you can set fan1_div to 2 in<br>
your configuration file.)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br><br></font></span></blockquote><div>Thanks for the explanation.<br>Ac=
tually I guessed it would be something like this, but didn&#39;t get to dig=
ging into it.<br>Wrt the accuracy. Might try that. Then again we do not bot=
her too much as we mainly want to monitor the fan for working and are not t=
oo interested in the speed; I&#39;m just monitoring if it does not fall bel=
ow a treshold value (and if it does raise an alarm indicating that preventi=
ve replacement is needed.<br>
<br>Frans <br></div></div><br>

--20cf307f3092f1252c04b79bc570--


--===============6585110064015846335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6585110064015846335==--
