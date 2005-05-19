From: rutger@nospam.com (rutger@nospam.com)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040509190723.GA26411@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 09, 2004 at 07:23:31PM +0200, Jean Delvare wrote:
> > The problem is fan2_pwm, where only 3 samples are taken. This is not
> > enough in this case.
> 
> Most likely because you have a low fan divisor. Try increasing it and
> try again. You need a high divisor to be able to measure low speed fans,
> and lowering PWM lowers fan speed.

Ok, fan_divisor set to 64 and reran pwmconfig. I get a better curve now:

    PWM 255 FAN 2636
    PWM 240 FAN 3013
    PWM 225 FAN 2343
    PWM 210 FAN 2343
    PWM 195 FAN 2109
    PWM 180 FAN 1917
    PWM 165 FAN 1622
    PWM 150 FAN 1406
    PWM 135 FAN 1917
    PWM 120 FAN 1506
    PWM 105 FAN 1406
    PWM 90 FAN 1240
    PWM 75 FAN 0

> Maybe the script could take care of this?

Why not take the highest working divisor? You can check this I think
by re-reading the fan*_div after echoing a new value. At least, that's
what I did...

> >   - at pwm 200, is goes even faster than at 255, and it
> >   reports 3139 as rpm(!).
> 
> Admittedly strange. Possibly some emergency mode of the chip. I don't
> know about the W83627HF, but I know similar chips with that
> functionality. On alert conditions (overtemperature...) manual PWM is
> disabled and fans are forced to full speed.

No, it's not the full speed. Some combinations entered manual give
even higher values: I can get to 3500rpm.
> 
> > It appears the speed is also depending on the speed from which it
> > came. Doing
> >   echo 255 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
> > will give me +-3100, while doing
> >   echo 0 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
> > will give me 0. Strange...
> 
> No wonder to me. Fans have inertia, it's natural that the "original"
> speeds has an influence.

No, I monitor the RPMs with
  while true; do cat fan2_input; sleep 2; done

Now I echo values in another xterm, and I see the fan stabilizing to
different values depending on the sequence of value which I echo-d. So
there is some kind of state somewhere.

So, in short:
echo 0 >fan2_pwm; sleep 5; echo 199 >fan2_pwm; sleep 5; cat fan2_input
..gives values 1917 and 2109 repeatedly.
echo 255 >fan2_pwm; sleep 5; echo 199 >fan2_pwm; sleep 5; cat fan2_input
..gives values 3013 and 3515 repeatedly. The fan also sounds 'faster'.

I can get to 4218rpm, which is very noisy..


> > Where do I report such strange interaction?
> 
> Doesn't sound that strange to me. That said, I think that Marius is the
> most qualified of us all with PWM issues, so he's the one you want to
> address your questions to, if there's really a problem.

Ok, Marius left in the header...

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
