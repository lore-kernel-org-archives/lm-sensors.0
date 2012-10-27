From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Sat, 27 Oct 2012 06:27:25 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JNYJm5XGzW2RDgFys9G+87c7CM5A50kuA7K7UVwf=0URQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1669811628059298851=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1669811628059298851==
Content-Type: multipart/alternative; boundary=f46d0444e869d7715c04cd048808

--f46d0444e869d7715c04cd048808
Content-Type: text/plain; charset=ISO-8859-1

Hm--
Not sure if it matters, but the chip is being identified by the driver as
[   30.548982] w83627ehf: Found W83667HG-B chip at 0x290
but i found the chip on the board, and it has markings on it that is
W83557HG-A as seen here:
https://plus.google.com/photos/118091037272972387274/albums/5803871629918378497?authkey=CPXGsI3ql-i0KA


Also interesting:
-- when booting up, we see this:
BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i}
${i}_enable ${i}_mode; done
pwm1
255
5
0
pwm2
255
5
1
pwm3
255
5
1

When enabling PWM, it automatically changes the PWM2 setting to 127, and
the other two off
BigBox w83627ehf.656 # for i in $(seq 3); do echo 1 >pwm${i}_enable; done
BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do echo $i; cat ${i}
${i}_enable ${i}_mode; done
pwm1
0
1
0
pwm2
127
1
1
pwm3
0
1
1

--f46d0444e869d7715c04cd048808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hm--</div><div>Not sure if it matters, but the chip is being identifie=
d by the driver as=A0</div><div><div>[ =A0 30.548982] w83627ehf: Found W836=
67HG-B chip at 0x290</div></div><div>but i found the chip on the board, and=
 it has markings on it that is W83557HG-A as seen here:</div>

<div><a href=3D"https://plus.google.com/photos/118091037272972387274/albums=
/5803871629918378497?authkey=3DCPXGsI3ql-i0KA">https://plus.google.com/phot=
os/118091037272972387274/albums/5803871629918378497?authkey=3DCPXGsI3ql-i0K=
A</a></div>

<div><br></div><div><br></div>Also interesting:<div>-- when booting up, we =
see this:</div><div><div>BigBox w83627ehf.656 # for i in pwm1 pwm2 pwm3; do=
 echo $i; cat ${i} ${i}_enable ${i}_mode; done</div><div>pwm1</div><div>

255</div><div>5</div><div>0</div><div>pwm2</div><div>255</div><div>5</div><=
div>1</div><div>pwm3</div><div>255</div><div>5</div><div>1</div></div><div>=
<br></div><div>When enabling PWM, it automatically changes the PWM2 setting=
 to 127, and the other two off</div>

<div><div>BigBox w83627ehf.656 # for i in $(seq 3); do echo 1 &gt;pwm${i}_e=
nable; done</div></div><div><div>BigBox w83627ehf.656 # for i in pwm1 pwm2 =
pwm3; do echo $i; cat ${i} ${i}_enable ${i}_mode; done</div><div>pwm1</div>

<div>0</div><div>1</div><div>0</div><div>pwm2</div><div>127</div><div>1</di=
v><div>1</div><div>pwm3</div><div>0</div><div>1</div><div>1</div></div><div=
><br></div><div><br></div><div><br></div>

--f46d0444e869d7715c04cd048808--


--===============1669811628059298851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1669811628059298851==--
