From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: ADM1030 Driver (+auto fan speed interface proposal)
Message-Id: <1081959305.407d6389160fc@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081942629.407d22659307f@imp.gcu.info>
In-Reply-To: <1081942629.407d22659307f@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > In the LM85/ADM1027 driver it's called pwm1_zone.
> > 
> > It has the values:
> >    -1:  PWM disabled, fan at 100%
> >    -2:  PWM under manual control ('pwm1' or 'pwm1_value' is
> >         writable)
> >     1:  PWM is controlled by temp1_input
> >     2:  PWM is controlled by temp2_input
> >   123:  PWM is controlled by max value of all three
> >     0:  PWM disabled, fan at 0%
> > 
> > The other parameters have equivalents in the lm85 driver as well.
> > 
> >    zone#_limit   (fan "turn on" temperature  (1*))
> >    zone#_hyst   (range below limit fan remains on.  Fixed at 5 deg
> in 
> > this chip?)
> >    zone#_range  (temperature range (2*))
> >    pwm#_min  (PWM value at low limit.  (4*))
> > 
> > :v)
> 
> Seems to be a good approach, and it has the advantage of already
> beeing implemented on some drivers.

I think that the lm85 driver is actually the only one to do that. Since
it isn't standardized yet, I have to say I do not consider much benefit
in following what was done. Not that I denigrate Philip's work, nor
does it mean that I dislike his approach. All I mean is that if it
happens that this doesn't cover the other chips correctly, or doesn't
fit in the "file names are self-descriptive" rule, we better change
what exists in the name of uniformity.

> Jean, what do you think about that ?

First of all I have to say that I completely ignored that one driver
already has auto fan speed support. Thanks Philip for joining the
conversation and providing some insight about how you did implement it
on your side.

Here are the drawbacks I see at first sight:

1* pwm1_zone = -1 is what other drivers implement with pwm1_enable =
0. I would like to avoid having two ways to express the same thing if
possible. OTOH, one will wonder what happens if a user sets pwm1_enable
= 0 and pwm1_auto at the same time. I don't really know and think that
it'll probably depend on chip's implementation (depends if there are
two separate bits in the chip, or one three-state value).

Likewise, pwm1_zone = 0 is (more or less) pwm_enable = 1 && pwm1 =
0,
and pwm1_zone = -1 is pwm_enable = 1.

I think we better stick to the one file - one value (i.e. one meaning)
philosophy. Philip, I guess that the idea of setting these different
things in a single value were inspired by the way the LM85 implements
it?

2* About the range: the same way we decided that hysteresis values
should be expressed as absolute temperatures and not a difference
relative to another limits, I think we should express the max temp (for
auto fan control) as an absolute value and not a range from the min
temp. The fact that some (most?) chips use a range is obviously made so
as to spare a few bits in the registers. The userspace doesn't care
about these implementation details.

3* I was thinking that what is named pwm1_zone in lm85 could be a
bitfield. Each bit links the corresponding temperature channel to this
PWM. That way we are sure we can extend the values in a consistent way
if a later chip has more than 3 temperature channels, and if it allows
to link more than one, but less than all, channels to a given PWM.

Anyway, this proves that we *really* need to discuss a bit more about a
common interface to this functionality. I will try to read as much as
possible about the various implementations (IT87, LM85, ADM1030 and
W836x7) before the end of the week so as to make sure that I understand
how things do work. I invite each of you to do the same so that our
discussion is as constructive as possible.

Thanks a lot.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
