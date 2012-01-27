From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Fri, 27 Jan 2012 13:22:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error handling
Message-Id: <CACW_hTZUqXR2F4w6HFAW6JR89Xs=8rCwtTtUGNMjT2oY3de-dQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2780842514200273929=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============2780842514200273929==
Content-Type: multipart/alternative; boundary=f46d042f93cec05b6b04b78261bd

--f46d042f93cec05b6b04b78261bd
Content-Type: text/plain; charset=ISO-8859-1

2012/1/26 Jean Delvare <khali@linux-fr.org>

> On Thu, 5 Jan 2012 15:52:41 +0100, Frans Meulenbroeks wrote:
> > 2012/1/5 Jean Delvare <khali@linux-fr.org>
> > > Are you really still using  LM80 chips? These are pretty old and I did
> > > not expect anyone to be still using them. And certainly not for new
> > > designs... The device (at least the incarnations that existed in
> > > 1998-2000) was not reputed for its reliability...
> >
> > Yes, we still have them and I need to support them (just like LM75).
> > (acutally we're using LM96080). They are not on my board, but we have
> > external fan units that contain these chips, and my board needs to
> support
> > these fan units.
>
> Frans, could you please provide a register dump of your LM96080 chip?
> I'd like to add that to my collection. You can get such a dump using
> the i2c-dev driver + i2cdump (from package i2c-tools.)
>
> Thanks,
>
> Hi Jean,

I hope this is what you are looking for:

root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# cat
fan1_input
3668
root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
i2cdump  1 0x28
No size specified (using byte-data access)
Error: Could not set address to 0x28: Device or resource busy
root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028#
i2cdump -f 1 0x28
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1, address 0x28, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 7f 2d 00 00 3c 18 00 00 00 00 00 00 00 00 00    ??-..<?.........
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 0c 00 00 00 00 00 00 1a 2e ff 00 00 00 00 00 00    ?......?........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08    ..............??
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Not fully sure if this is correct as I had to use -f
Also fan1_input is 3668, which is hex 0e54 but I do not see that value in
the dump.

Feel free to ping me if there is other info you need.

Best regards, Frans

--f46d042f93cec05b6b04b78261bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/26 Jean Delvare <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
On Thu, 5 Jan 2012 15:52:41 +0100, Frans Meulenbroeks wrote:<br>
&gt; 2012/1/5 Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali@=
linux-fr.org</a>&gt;<br>
&gt; &gt; Are you really still using =A0LM80 chips? These are pretty old an=
d I did<br>
&gt; &gt; not expect anyone to be still using them. And certainly not for n=
ew<br>
&gt; &gt; designs... The device (at least the incarnations that existed in<=
br>
&gt; &gt; 1998-2000) was not reputed for its reliability...<br>
&gt;<br>
&gt; Yes, we still have them and I need to support them (just like LM75).<b=
r>
&gt; (acutally we&#39;re using LM96080). They are not on my board, but we h=
ave<br>
&gt; external fan units that contain these chips, and my board needs to sup=
port<br>
&gt; these fan units.<br>
<br>
Frans, could you please provide a register dump of your LM96080 chip?<br>
I&#39;d like to add that to my collection. You can get such a dump using<br=
>
the i2c-dev driver + i2cdump (from package i2c-tools.)<br>
<br>
Thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>Hi Jean,<br><br>I hope this is what you are looking for:<br><br>roo=
t@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# cat fan1_=
input<br>
3668<br>root@(none):/sys/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028=
# i2cdump=A0 1 0x28 <br>No size specified (using byte-data access)<br>Error=
: Could not set address to 0x28: Device or resource busy<br>root@(none):/sy=
s/devices/e0000000.soc8313/e0003100.i2c/i2c-1/1-0028# i2cdump -f 1 0x28 <br=
>
No size specified (using byte-data access)<br>WARNING! This program can con=
fuse your I2C bus, cause data loss and worse!<br>I will probe file /dev/i2c=
-1, address 0x28, mode byte<br>Continue? [Y/n] y<br>=A0=A0=A0=A0 0=A0 1=A0 =
2=A0 3=A0 4=A0 5=A0 6=A0 7=A0 8=A0 9=A0 a=A0 b=A0 c=A0 d=A0 e=A0 f=A0=A0=A0=
 0123456789abcdef<br>
00: 01 7f 2d 00 00 3c 18 00 00 00 00 00 00 00 00 00=A0=A0=A0 ??-..&lt;?....=
.....<br>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 .....=
...........<br>20: 0c 00 00 00 00 00 00 1a 2e ff 00 00 00 00 00 00=A0=A0=A0=
 ?......?........<br>
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08=A0=A0=A0 ..............=
??<br>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ........=
........<br>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..=
..............<br>
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..............=
..<br>70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ........=
........<br>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..=
..............<br>
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..............=
..<br>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ........=
........<br>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..=
..............<br>
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..............=
..<br>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ........=
........<br>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..=
..............<br>
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=A0=A0=A0 ..............=
..<br><br>Not fully sure if this is correct as I had to use -f<br>Also fan1=
_input is 3668, which is hex 0e54 but I do not see that value in the dump.<=
br>
<br>Feel free to ping me if there is other info you need.<br><br>Best regar=
ds, Frans<br>=A0<br></div></div><br>

--f46d042f93cec05b6b04b78261bd--


--===============2780842514200273929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2780842514200273929==--
