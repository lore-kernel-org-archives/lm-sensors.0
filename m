From: lei yang <yanglei.fage@gmail.com>
Date: Tue, 27 Apr 2010 16:57:22 +0000
Subject: [lm-sensors]  some quesions from the tools
Message-Id: <x2ifb0149a91004270957x1d302278v8eb017b718833a37@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4040148972932896783=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4040148972932896783==
Content-Type: multipart/alternative; boundary=0016362845f49c0c8704853ac9d8

--0016362845f49c0c8704853ac9d8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Experts

I'm new to i2c, I have some questions in the end, can you help me explain
them to me

root@mpc8313erdb:/root> sensors
lm75-i2c-0-48
Adapter: MPC adapter
temp1:       +21.0?C  (high =3D +80.0?C, hyst =3D +75.0?C)
root@mpc8313erdb:/root> ./i2cdetect -l
i2c-0   i2c             MPC adapter                             I2C adapter
i2c-1   i2c             MPC adapter                             I2C adapter
root@mpc8313erdb:/root> ./i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- 0c -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
root@mpc8313erdb:/root> ./i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
root@mpc8313erdb:/root>


Q1:use i2cdetect -l, I can see it detects i2c-0 and i2c-0 why "sensors"
comand just output lm75-i2c-0-48?


Q2:Use ./i2cdetect 0 it detect three adrees :0x48 0x50 0x68, i just know
0x48 is a temperature sensors=EF=BC=8Chow do I know 0x50 and 0x68?
and from demsg |grep 68 I got

root@mpc8313erdb:/root> dmesg |grep 68
On node 0 totalpages: 32768
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125268k/131072k available (4072k kernel code, 5656k reserved, 140k
data, 126k bss, 188k init)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
rtc-ds1307 0-0068: setting system clock to 2010-04-27 23:41:40 UTC
(1272411700)

so 0x68 is rtc device, i can't know 0x50 from demsg,can you show me the way


Q3:Why I got to i2c bus? but why it can't detect one address on bus 1 with
./i2cdetect 1?


Q4:I want to do a full test for the i2c driver of my board, is there some
points about the test?


Thanks
Lei

--0016362845f49c0c8704853ac9d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi Experts</div>
<div>=C2=A0</div>
<div>I&#39;m new to i2c, I have some questions in the end, can you help me =
explain them to me </div>
<div>=C2=A0</div>
<div><a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&g=
t; sensors<br>lm75-i2c-0-48<br>Adapter: MPC adapter<br>temp1:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +21.0?C=C2=A0 (high =3D +80.0?C, hyst =3D +75.0?C)=
</div>
<div><a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&g=
t; ./i2cdetect -l<br>i2c-0=C2=A0=C2=A0 i2c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPC adapter=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I2C a=
dapter<br>i2c-1=C2=A0=C2=A0 i2c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPC adapter=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I2C adapter<br=
>
<a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&gt; ./=
i2cdetect 0<br>WARNING! This program can confuse your I2C bus, cause data l=
oss and worse!<br>I will probe file /dev/i2c-0.<br>I will probe address ran=
ge 0x03-0x77.<br>
Continue? [Y/n] y<br>=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 1=C2=A0 2=C2=A0 3=C2=
=A0 4=C2=A0 5=C2=A0 6=C2=A0 7=C2=A0 8=C2=A0 9=C2=A0 a=C2=A0 b=C2=A0 c=C2=A0=
 d=C2=A0 e=C2=A0 f<br>00:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -- -- -- -- -- -- -- -- -- 0c -- -- --<br>10: -- -- -- -- -- -- -- -=
- -- -- -- -- -- -- -- --<br>20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- =
-- --<br>
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>40: -- -- -- -- -- -=
- -- -- UU -- -- -- -- -- -- --<br>50: 50 -- -- -- -- -- -- -- -- -- -- -- =
-- -- -- --<br>60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --<br>70: -=
- -- -- -- -- -- -- --<br>
<a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&gt; ./=
i2cdetect 1<br>WARNING! This program can confuse your I2C bus, cause data l=
oss and worse!<br>I will probe file /dev/i2c-1.<br>I will probe address ran=
ge 0x03-0x77.<br>
Continue? [Y/n] y<br>=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 1=C2=A0 2=C2=A0 3=C2=
=A0 4=C2=A0 5=C2=A0 6=C2=A0 7=C2=A0 8=C2=A0 9=C2=A0 a=C2=A0 b=C2=A0 c=C2=A0=
 d=C2=A0 e=C2=A0 f<br>00:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -- -- -- -- -- -- -- -- -- -- -- -- --<br>10: -- -- -- -- -- -- -- -=
- -- -- -- -- -- -- -- --<br>20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- =
-- --<br>
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>40: -- -- -- -- -- -=
- -- -- -- -- -- -- -- -- -- --<br>50: -- -- -- -- -- -- -- -- -- -- -- -- =
-- -- -- --<br>60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>70: -=
- -- -- -- -- -- -- --<br>
<a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&gt;</d=
iv>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>Q1:use i2cdetect -l, I can see it detects i2c-0 and i2c-0 why &quot;se=
nsors&quot; comand just output lm75-i2c-0-48?<br></div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>Q2:Use ./i2cdetect 0 it detect three adrees :0x48 0x50 0x68, i just kn=
ow 0x48 is a temperature sensors=EF=BC=8Chow do I know 0x50 and 0x68? </div=
>
<div>and from demsg |grep 68 I got </div>
<div>=C2=A0</div>
<div><a href=3D"mailto:root@mpc8313erdb:/root">root@mpc8313erdb:/root</a>&g=
t; dmesg |grep 68<br>On node 0 totalpages: 32768<br>Inode-cache hash table =
entries: 8192 (order: 3, 32768 bytes)<br>Memory: 125268k/131072k available =
(4072k kernel code, 5656k reserved, 140k data, 126k bss, 188k init)<br>
TCP established hash table entries: 4096 (order: 3, 32768 bytes)<br>rtc-ds1=
307 0-0068: rtc core: registered ds1339 as rtc0<br>rtc-ds1307 0-0068: setti=
ng system clock to 2010-04-27 23:41:40 UTC (1272411700)</div>
<div>=C2=A0</div>
<div>so 0x68 is rtc device, i can&#39;t know 0x50 from demsg,can you show m=
e the way</div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>Q3:Why I got to i2c bus? but why it can&#39;t detect one address on bu=
s 1 with=C2=A0 ./i2cdetect 1?</div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>Q4:I want to do a full test for the i2c driver of my board, is there s=
ome points about the test?</div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div>Thanks</div>
<div>Lei</div>
<div>=C2=A0</div>
<div>=C2=A0</div>
<div><br><br>=C2=A0</div>

--0016362845f49c0c8704853ac9d8--


--===============4040148972932896783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4040148972932896783==--
