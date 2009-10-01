From: Mark Altern <mark.altern@gmail.com>
Date: Thu, 01 Oct 2009 20:25:43 +0000
Subject: [lm-sensors] asus_atk0110 mis-behavior on ASUS p6t
Message-Id: <526fa40a0910011325s517c7997h4caf266190b2b2d0@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6043034810263797271=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6043034810263797271==
Content-Type: multipart/alternative; boundary=001636eee39ea410220474e573be

--001636eee39ea410220474e573be
Content-Type: text/plain; charset=ISO-8859-1

My system: ASUS p6t core i7 920, with ArchLinux, kernel 2.6.31.

Right after I start the computer the CPU diode temp is reported as about
36C, and CPU fan is running at about 500rpm, which is normal. But after a
few minutes, the CPU diode temp become misleading, reported as 47C and the
CPU fan is running 1100rpm, I am pretty sure the 47C Tj temp of CPU is
wrong, because the Core temps of my i7 920 is well below 42. (Tj temp of Cpu
is generally lower than core temp by 5C).  This happens only a few minutes
after startup.

After a few experiments, I find out, blacklisting asus_atk0110 solves this
problem. I loaded w83667hg through lm_sensors, which report right CPU temp,
around 36C consistantly and the CPU fan is NOT spinning loudly at 1100 rpm
anymore, but stay around 500-600rpm. This is the correctly behavior because
the fan and temp output is consistant with the ones I got from my dual boot
windows 7, where I am sure the reading is correct.

So my question is why does asus_atk0110 provides wrong CPU temp and force
the fan speed up? Is this a bug?
Why do people still prefer asus_atk0110 driver than the old ones?

Thanks a lot.

--001636eee39ea410220474e573be
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My system: ASUS p6t core i7 920, with ArchLinux, kernel 2.6.31.<br><br>Righ=
t after I start the computer the CPU diode temp is reported as about 36C, a=
nd CPU fan is running at about 500rpm, which is normal. But after a few min=
utes, the CPU diode temp become misleading, reported as 47C and the CPU fan=
 is running 1100rpm, I am pretty sure the 47C Tj temp of CPU is wrong, beca=
use the Core temps of my i7 920 is well below 42. (Tj temp of Cpu is genera=
lly lower than core temp by 5C).=A0 This happens only a few minutes=A0 afte=
r startup. <br>
<br>After a few experiments, I find out, blacklisting asus_atk0110 solves t=
his problem. I loaded w83667hg through lm_sensors, which report right CPU t=
emp, around 36C consistantly and the CPU fan is NOT spinning loudly at 1100=
 rpm anymore, but stay around 500-600rpm. This is the correctly behavior be=
cause the fan and temp output is consistant with the ones I got from my dua=
l boot windows 7, where I am sure the reading is correct. <br>
<br>So my question is why does asus_atk0110 provides wrong CPU temp and for=
ce the fan speed up? Is this a bug? <br>Why do people still prefer asus_atk=
0110 driver than the old ones? <br><br>Thanks a lot. <br>

--001636eee39ea410220474e573be--


--===============6043034810263797271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6043034810263797271==--
