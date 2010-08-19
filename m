From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 13:16:30 +0000
Subject: Re: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <20100819151630.1ee5b124@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Charles,

On Thu, 19 Aug 2010 11:06:41 +0200, Jean Delvare wrote:
> On Mon, 16 Aug 2010 08:51:22 -0700, Guenter Roeck wrote:
> > On Mon, 2010-08-16 at 00:07 -0400, Charles Pillar wrote:
> > > Hi all,
> > >    I'm new here, apologies in.advance if I do something wrong. I
> > > believe that I have found a bug in pwmconfig. I first observed this
> > > behavior many many months ago and couldn't find anyone else with the
> > > problem so I just assumed it was just me. I've since stumbled on it
> > > again so I decided to look into it myself. I don't know if anyone is
> > > aware of the behavior I am seeing, but here it is...
> > >=20
> > > Take for example a board with two or more PWM controllable fans both
> > > which of which the speed can be measured. Thus I have:
> > >=20
> > > /sys/class/hwmon/hwmon0/pwm1
> > > /sys/class/hwmon/hwmon0/pwm1_enable
> > > /sys/class/hwmon/hwmon0/fan1_input
> > > /sys/class/hwmon/hwmon0/pwm2
> > > /sys/class/hwmon/hwmon0/pwm2_enable
> > > /sys/class/hwmon/hwmon0/fan2_input
> > > (etc...)
> > >=20
> > > pwm1 & pwm1_enable =3D fan1_input
> > > pwm2 & pwm2_enable =3D fan2_input
> > > (etc...)
> > >=20
> > > I think this would be a fairly common set up? Indeed I have three
> > > machines that are setup this way (1 board has 2 fans, the other 2 have
> > > 3 fans each)
> > >=20
> > > From what I can see, pwmconfig does this:
> > >=20
> > > pwm1_enable=3D0
> > > pwm2_enable=3D0
> > > wait...
> > > for each PWM:
> > >    this pwm_enable=3D1
> > >    this pwm=3D0
> > >    for each fan
> > >       compare this fan before / after
> > >       this pwm_enable=3D0
> > >       check fan returns to normal
> > >    next fan
> > > next pwm
> > >=20
> > > The problem with this logic is that for each PWM, the pwm_enable is
> > > set to 1, then the first fan is tested, after the first fan is tested,
> > > the pwm is disabled and never re-enabled (until the next pwm)...
> > > This means the pwm1=FAn1 correlation is detected, but pwm2=FAn2 is not
> > > - but only because the pwm_enable is still set to 0 when the second
> > > and subsequent fans are tested...
>=20
> Thanks a lot for reporting. I have a hard time believing that this has
> been broken for years and you're the first one to report, but this is
> the case... I'm even more surprised that _I_ did not notice the bug,
> while I have been using pwmconfig a lot and worked a lot on it over the
> past few years.

I tested the old code again to try and understand how I could have
missed the bug so far. The explanation is that the current code is not
only broken, it's also racy. And the race works around the bug, at
least in my case.

The reason why the problem wasn't noticed earlier is because we do not
have an unconditional delay after the faulty pwmdisable $i. We only
wait for the fan to settle if a correlation was found, because we want
to ensure that the fan is back to full speed again. If no correlation
is found, we move on quickly to the next fan input. With some luck,
said fan didn't yet have the time to go back to full speed. Or if it
did, the caching we do in most hwmon drivers will cause the driver to
not return an up-to-date fan speed value. Either way, the correlation
with the second fan is found in my case. If I add a sleep after
pwmdisable $i, then it is no longer found (i.e. the bug can be reliably
triggered.)

Now I am surprised that you managed to repeatedly hit the bug without
the extra sleep. Maybe you are using a driver which doesn't cache fan
speeds?

As a side note, this all suggests that cached fan speeds should be
invalidated each time PWM settings change. I can't remember any hwmon
driver doing this, but they should.

We still want to fix pwmconfig of course, but at least I now understand
why the bug wasn't found earlier.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
