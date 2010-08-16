From: Charles Pillar <pillarama@gmail.com>
Date: Mon, 16 Aug 2010 04:19:19 +0000
Subject: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <AANLkTimrcZ6rTTCn8th4fKYaE0LeNSpxfYYhyVYKZNmw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,
=A0=A0 I'm new here, apologies in.advance if I do something wrong. I
believe that I have found a bug in pwmconfig. I first observed this
behavior many many months ago and couldn't find anyone else with the
problem so I just assumed it was just me. I've since stumbled on it
again so I decided to look into it myself. I don't know if anyone is
aware of the behavior I am seeing, but here it is...

Take for example a board with two or more PWM controllable fans both
which of which the speed can be measured. Thus I have:

/sys/class/hwmon/hwmon0/pwm1
/sys/class/hwmon/hwmon0/pwm1_enable
/sys/class/hwmon/hwmon0/fan1_input
/sys/class/hwmon/hwmon0/pwm2
/sys/class/hwmon/hwmon0/pwm2_enable
/sys/class/hwmon/hwmon0/fan2_input
(etc...)

pwm1 & pwm1_enable =3D fan1_input
pwm2 & pwm2_enable =3D fan2_input
(etc...)

I think this would be a fairly common set up? Indeed I have three
machines that are setup this way (1 board has 2 fans, the other 2 have
3 fans each)

From what I can see, pwmconfig does this:

pwm1_enable=3D0
pwm2_enable=3D0
wait...
for each PWM:
=A0=A0 this pwm_enable=3D1
=A0=A0 this pwm=3D0
=A0=A0 for each fan
=A0=A0 =A0 =A0compare this fan before / after
=A0=A0 =A0 =A0this pwm_enable=3D0
=A0=A0 =A0 =A0check fan returns to normal
=A0=A0 next fan
next pwm

The problem with this logic is that for each PWM, the pwm_enable is
set to 1, then the first fan is tested, after the first fan is tested,
the pwm is disabled and never re-enabled (until the next pwm)...
This means the pwm1=FAn1 correlation is detected, but pwm2=FAn2 is not
- but only because the pwm_enable is still set to 0 when the second
and subsequent fans are tested...

There are several ways to fix this, but after some pondering, I think
that this logic might be most appropriate:

pwm1_enable=3D0
pwm2_enable=3D0
wait...
for each PWM:
=A0=A0 for each fan
=A0=A0 =A0 =A0this pwm_enable=3D1
=A0=A0 =A0 =A0this pwm=3D0
=A0=A0 =A0 =A0compare this fan before / after
=A0=A0 =A0 =A0this pwm_enable=3D0
=A0=A0 =A0 =A0check fan returns to normal
=A0=A0 next fan
next pwm

This causes the given pwm/fan to stop/start once for each fan input,
which might seem bad, but then each fan is individually checked to
make sure that it has begun spinning again after pwm_enable is set to
0... (as compared to stopping and starting once per pwm...)
I have a patch which I can supply. It fixes the problem for me, but
I'm not 100% sure if it introduces any other problems. Let me know if
I should email it or submit somewhere etc...

I would value hearing what others think about this problem...

Thanks
Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
