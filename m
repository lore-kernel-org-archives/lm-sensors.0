From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 09:06:41 +0000
Subject: Re: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <20100819110641.17df02c9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Charles, Guenter,

On Mon, 16 Aug 2010 08:51:22 -0700, Guenter Roeck wrote:
> On Mon, 2010-08-16 at 00:07 -0400, Charles Pillar wrote:
> > Hi all,
> >    I'm new here, apologies in.advance if I do something wrong. I
> > believe that I have found a bug in pwmconfig. I first observed this
> > behavior many many months ago and couldn't find anyone else with the
> > problem so I just assumed it was just me. I've since stumbled on it
> > again so I decided to look into it myself. I don't know if anyone is
> > aware of the behavior I am seeing, but here it is...
> >=20
> > Take for example a board with two or more PWM controllable fans both
> > which of which the speed can be measured. Thus I have:
> >=20
> > /sys/class/hwmon/hwmon0/pwm1
> > /sys/class/hwmon/hwmon0/pwm1_enable
> > /sys/class/hwmon/hwmon0/fan1_input
> > /sys/class/hwmon/hwmon0/pwm2
> > /sys/class/hwmon/hwmon0/pwm2_enable
> > /sys/class/hwmon/hwmon0/fan2_input
> > (etc...)
> >=20
> > pwm1 & pwm1_enable =3D fan1_input
> > pwm2 & pwm2_enable =3D fan2_input
> > (etc...)
> >=20
> > I think this would be a fairly common set up? Indeed I have three
> > machines that are setup this way (1 board has 2 fans, the other 2 have
> > 3 fans each)
> >=20
> > From what I can see, pwmconfig does this:
> >=20
> > pwm1_enable=3D0
> > pwm2_enable=3D0
> > wait...
> > for each PWM:
> >    this pwm_enable=3D1
> >    this pwm=3D0
> >    for each fan
> >       compare this fan before / after
> >       this pwm_enable=3D0
> >       check fan returns to normal
> >    next fan
> > next pwm
> >=20
> > The problem with this logic is that for each PWM, the pwm_enable is
> > set to 1, then the first fan is tested, after the first fan is tested,
> > the pwm is disabled and never re-enabled (until the next pwm)...
> > This means the pwm1=FAn1 correlation is detected, but pwm2=FAn2 is not
> > - but only because the pwm_enable is still set to 0 when the second
> > and subsequent fans are tested...

Thanks a lot for reporting. I have a hard time believing that this has
been broken for years and you're the first one to report, but this is
the case... I'm even more surprised that _I_ did not notice the bug,
while I have been using pwmconfig a lot and worked a lot on it over the
past few years.

> >=20
> > There are several ways to fix this, but after some pondering, I think
> > that this logic might be most appropriate:
> >=20
> > pwm1_enable=3D0
> > pwm2_enable=3D0
> > wait...
> > for each PWM:
> >    for each fan
> >       this pwm_enable=3D1
> >       this pwm=3D0
> >       compare this fan before / after
> >       this pwm_enable=3D0
> >       check fan returns to normal
> >    next fan
> > next pwm
> >=20
>=20
> I would suggest something like
>=20
> pwm1_enable=3D0
> pwm2_enable=3D0
> wait...
> for each PWM:
>    this pwm_enable=3D1
>    this pwm=3D0
>    for each fan
>       check fan speed
>       if speed lower than threshold:
>           mark fan as controlled by this pwm
>           this pwm_enable=3D0
>           verify fan speed returned to normal
>           this pwm_enable=3D1
>           this pwm=3D0
>    next fan
>    this pwm_enable=3D0
> next pwm
>=20
> This would also solve your problem while reducing the number of times
> pwm needs to be turned on and off.
>
> > This causes the given pwm/fan to stop/start once for each fan input,
> > which might seem bad, but then each fan is individually checked to
> > make sure that it has begun spinning again after pwm_enable is set to
> > 0... (as compared to stopping and starting once per pwm...)
> > I have a patch which I can supply. It fixes the problem for me, but
> > I'm not 100% sure if it introduces any other problems. Let me know if
> > I should email it or submit somewhere etc...
> >=20
> > I would value hearing what others think about this problem...

I think I would prefer a radically different approach:

pwm1_enable=3D0
pwm2_enable=3D0
wait...
for each PWM:
   this pwm_enable=3D1
   this pwm=3D0
   for each fan
      check and store fan speed
   next fan
   this pwm_enable=3D0

   for each fan
      verify fan speed returned to normal
   next fan

   for each fan
      check stored fan speed
      if speed lower than threshold:
          mark fan as controlled by this pwm
   next fan
next pwm

This idea is to split the inner for loop into individual actions. This
requires more code, but when dealing with hardware, doing the right
thing in a timely manner is more important than saving a couple lines
of code and CPU cycles. My approach has three merits:
* It is more obviously correct (or, if the code is broken, more
  obviously broken.) Each inner for loop will do only one thing, so
  hopefully it will do it well.
* It limits the number of PWM on/off to the minimum, as well as the
  zero duty cycle time (fan potentially off).
* It warns about stuck fans faster than other approaches do.

Opinions?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
