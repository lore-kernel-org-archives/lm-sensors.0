From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Jun 2009 12:10:56 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624141056.5dd5d47d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Konstantin,

On Wed, 24 Jun 2009 11:47:38 +0200, Konstantin Kletschke wrote:
> It is not possible to change the pwm of the CPU fan. Changing the value
> of pwm2 results in changing pwm1. May be this is only a little tiny
> offset in the amounts of pwms or another tiny little bit missing.
> Is there any change to get a datasheet of this chip or can somebody
> provide one?
> 
> > cat pwm1 pwm2 pwm3
> 66
> 55
> 255
> 
> > echo "77" >> pwm2

Note that the >> doesn't buy you anything, > is enough. These are
virtual files.

> 
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 255

This is very odd. Which kernel are you running exactly? I have a hard
time understanding how this can happen at all. Does writing to pwm3
change the value of pwm2, too?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
