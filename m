From: Charles Pillar <pillarama@gmail.com>
Date: Wed, 28 Jul 2010 06:26:57 +0000
Subject: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3048245064647158041=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3048245064647158041==
Content-Type: multipart/alternative; boundary=000e0cd2419876e0fe048c6c89dd

--000e0cd2419876e0fe048c6c89dd
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
   I'm new here. I believe that I have found a bug in pwmconfig. I first
observed this behavior many many months ago and couldn't find anyone else
with the problem so I just assumed it was just me. I've since stumbled on it
again so I decided to look into it myself. I don't know if anyone is aware
of the behavior I am seeing, but here it is...

Take for example a board with two or more PWM controllable fans both which
of which the speed can be measured. Thus I have:

/sys/class/hwmon/hwmon0/pwm1
/sys/class/hwmon/hwmon0/pwm1_enable
/sys/class/hwmon/hwmon0/fan1_input

/sys/class/hwmon/hwmon0/pwm2
/sys/class/hwmon/hwmon0/pwm2_enable
/sys/class/hwmon/hwmon0/fan2_input
(etc...)

pwm1 & pwm1_enable = fan1_input
pwm2 & pwm2_enable = fan2_input
(etc...)

I think this would be a fairly common set up? Indeed I have three machines
that are setup this way (1 has 2 fans, the other 2 have 3 fans)

From what I can see, pwmconfig does this:

pwm1_enable=0
pwm2_enable=0
wait...
for each PWM:
   this pwm_enable=1
   this pwm=0
   for each fan
      compare this fan before / after
      this pwm_enable=0
      check fan returns to normal
   next fan
next pwm

The problem with this logic is that for each PWM, the pwm_enable is set to
1, then the first fan is tested, after the first fan is tested, the pwm is
disabled and never re-enabled (until the next pwm)...
This means the pwm1=fan1 correlation is detected, but pwm2=fan2 is not - but
only because the pwm_enable is still set to 0 when the second and subsequent
fans are tested...

There are several ways to fix this, but after some pondering, I think that
this logic might be most appropriate:

pwm1_enable=0
pwm2_enable=0
wait...
for each PWM:
   for each fan
      this pwm_enable=1
      this pwm=0
      compare this fan before / after
      this pwm_enable=0
      check fan returns to normal
   next fan
next pwm

This causes the given pwm/fan to stop/start once for each fan input, which
might seem bad, but then each fan is individually checked to make sure that
it has begun spinning again after pwm_enable is set to 0... (as compared to
stopping and starting once per pwm...)

I have a patch which I can supply. It fixes the problem for me, but I'm not
100% sure if it introduces any other problems. Let me know if I should email
it or submit somewhere etc...

I would value hearing what others think about this problem...

Thanks

Charles

--000e0cd2419876e0fe048c6c89dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<div>=A0=A0 I&#39;m new here. I believe that I have found a bug in p=
wmconfig. I first observed this behavior many many months ago and couldn&#3=
9;t find anyone else with the problem so I just assumed it was just me. I&#=
39;ve since stumbled on it again so I decided to look into it myself. I don=
&#39;t know if anyone is aware of the=A0behavior=A0I am seeing, but here it=
 is...</div>
<div><br></div><div>Take for example a board with two or more PWM controlla=
ble fans both which of which the speed can be measured. Thus I have:</div><=
div><br></div><div>/sys/class/hwmon/hwmon0/pwm1</div><div>/sys/class/hwmon/=
hwmon0/pwm1_enable</div>
<div>/sys/class/hwmon/hwmon0/fan1_input</div><div><br></div><div>/sys/class=
/hwmon/hwmon0/pwm2</div><div>/sys/class/hwmon/hwmon0/pwm2_enable</div><div>=
/sys/class/hwmon/hwmon0/fan2_input</div><div>(etc...)</div><div><br></div>
<div>pwm1 &amp; pwm1_enable =3D fan1_input</div><div>pwm2 &amp; pwm2_enable=
 =3D fan2_input</div><div>(etc...)</div><div><br></div><div>I think this wo=
uld be a fairly common set up? Indeed I have three machines that are setup =
this way (1 has 2 fans, the other 2 have 3 fans)</div>
<div><br></div><div>From what I can see, pwmconfig does this:</div><div><br=
></div><div>pwm1_enable=3D0</div><div>pwm2_enable=3D0</div><div>wait...</di=
v><div>for each PWM:</div><div>=A0=A0 this pwm_enable=3D1</div><div>=A0=A0 =
this pwm=3D0</div>
<div>=A0=A0 for each fan</div><div>=A0=A0 =A0 =A0compare this fan before / =
after</div><div>=A0=A0 =A0 =A0this pwm_enable=3D0</div><div>=A0=A0 =A0 =A0c=
heck fan returns to normal</div><div>=A0=A0 next fan</div><div>next pwm</di=
v><div><br></div><div>The problem with this logic is that for each PWM, the=
 pwm_enable is set to 1, then the first fan is tested, after the first fan =
is tested, the pwm is disabled and never re-enabled (until the next pwm)...=
</div>
<div>This means the pwm1=3Dfan1 correlation is detected, but pwm2=3Dfan2 is=
 not - but only because the pwm_enable is still set to 0 when the second an=
d subsequent fans are tested...</div><div><br></div><div>There are several =
ways to fix this, but after some pondering, I think that this logic might b=
e most appropriate:</div>
<div><br></div><div><div>pwm1_enable=3D0</div><div>pwm2_enable=3D0</div><di=
v>wait...</div><div>for each PWM:</div><div>=A0=A0 for each fan</div><div><=
div>=A0=A0 =A0 =A0this pwm_enable=3D1</div><div>=A0=A0 =A0 =A0this pwm=3D0<=
/div></div><div>=A0=A0 =A0 =A0compare this fan before / after</div>
<div>=A0=A0 =A0 =A0this pwm_enable=3D0</div><div>=A0=A0 =A0 =A0check fan re=
turns to normal</div><div>=A0=A0 next fan</div><div>next pwm</div></div><di=
v><br></div><div>This causes the given pwm/fan to stop/start once for each =
fan input, which might seem bad, but then each fan is individually checked =
to make sure that it has begun spinning again after pwm_enable is set to 0.=
.. (as compared to stopping and starting once per pwm...)</div>
<div><br></div><div>I have a patch which I can supply. It fixes the problem=
 for me, but I&#39;m not 100% sure if it introduces any other problems. Let=
 me know if I should email it or submit somewhere etc...</div><div><br>
</div><div>I would value hearing what others think about this problem...</d=
iv><div><br></div><div>Thanks</div><div><br></div><div>Charles</div><div><b=
r></div>

--000e0cd2419876e0fe048c6c89dd--


--===============3048245064647158041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3048245064647158041==--
