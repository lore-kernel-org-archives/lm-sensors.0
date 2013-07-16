From: =?ISO-8859-1?Q?Simon_Sandstr=F6m?= <gurka@acc.umu.se>
Date: Tue, 16 Jul 2013 17:04:39 +0000
Subject: [lm-sensors] Module asus_atk0110 - Fan speed often shows zero instead of correct value
Message-Id: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1540659712166052124=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1540659712166052124==
Content-Type: multipart/alternative; boundary=089e0115f112f21dec04e1a3f813

--089e0115f112f21dec04e1a3f813
Content-Type: text/plain; charset=ISO-8859-1

Hello

I'm having trouble with the asus_atk0110 kernel module. The speed for fan3
(CHASSI2 FAN) often just shows zero, but once in awhile it shows the actual
speed of the fan. I've checked the fan, and it does spin at all time and it
also shows the correct speed at all time in BIOS.

There is also a slight delay when reading the input with "cat
/sys/class/hwmon/hwmon0/fan3_input". When the speed is zero, it takes
approx. 0.3s and when it shows the correct speed (700RPM) it takes 0.1s.
All other fan inputs respond with no delay (0.001s).

$ uname -a
Linux 3.2.0-4-amd64 #1 SMP Debian 3.2.46-1 x86_64 GNU/Linux

$ lsmod | grep asus_atk0110
asus_atk0110           17297  0

$ sensors --version
sensors version 3.3.2 with libsensors version 3.3.2

Does anyone else have this problem, or any similar problem? I could just
connect the fan to fan4 and ignore fan3, but for some reason the minimum
speed for fan4 is 800RPM (the others are 600RPM), and I like my fans
running at 700RPM..

Thanks

Simon

--089e0115f112f21dec04e1a3f813
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello<div><br></div><div>I&#39;m having trouble with the a=
sus_atk0110 kernel module. The speed for fan3 (CHASSI2 FAN) often just show=
s zero, but once in awhile it shows the actual speed of the fan. I&#39;ve c=
hecked the fan, and it does spin at all time and it also shows the correct =
speed at all time in BIOS.</div>
<div><br></div><div>There is also a slight delay when reading the input wit=
h &quot;cat /sys/class/hwmon/hwmon0/fan3_input&quot;. When the speed is zer=
o, it takes approx. 0.3s and when it shows the correct speed (700RPM) it ta=
kes 0.1s. All other fan inputs respond with no delay (0.001s).</div>
<div><br></div><div>$ uname -a</div><div>Linux 3.2.0-4-amd64 #1 SMP Debian =
3.2.46-1 x86_64 GNU/Linux<br></div><div><br></div><div>$ lsmod | grep asus_=
atk0110</div><div>asus_atk0110 =A0 =A0 =A0 =A0 =A0 17297 =A00</div><div><br=
></div><div>
$ sensors --version</div><div>sensors version 3.3.2 with libsensors version=
 3.3.2<br></div><div><br></div><div>Does anyone else have this problem, or =
any similar problem? I could just connect the fan to fan4 and ignore fan3, =
but for some reason the minimum speed for fan4 is 800RPM (the others are 60=
0RPM), and I like my fans running at 700RPM..</div>
<div><br></div><div>Thanks</div><div><br></div><div>Simon</div></div>

--089e0115f112f21dec04e1a3f813--


--===============1540659712166052124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1540659712166052124==--
