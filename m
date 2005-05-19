From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040921003855.GC758@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex:

* Alexandre d'Alton <alex@alexdalton.org> [2004-09-20 08:21:53 +0200]:
> If I remember, it is not because depending on the mode (auto or manual
> PWM), the same register has a different behaviour. Jean asked to make
> two sysfs files in order to keep the interface consistant (and
> chip-independant...)

Aha, OK.  Sorry for the noise.

> On Mon, 2004-09-20 at 07:00, Mark M. Hoffman wrote:
> 
> > 
> > Two other things...
> > 
> > (One) In adm1031.c lines 594-595:
> > 
> > > static DEVICE_ATTR(auto_fan##offset##_min_pwm, S_IRUGO | S_IWUSR,       \
> > >                    show_pwm_##offset, set_pwm_##offset)
> > 
> > But those are also used for the sysfs files fan?_pwm in lines 439-440:
> > 
> > > static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,                \
> > >                    show_pwm_##offset, set_pwm_##offset)
> > 
> > That's a bug, right?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
