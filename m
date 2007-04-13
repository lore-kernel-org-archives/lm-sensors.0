From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Apr 2007 08:43:07 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 RESEND] hwmon: documentation for new
Message-Id: <20070413104307.1ef0356f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
In-Reply-To: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 12 Apr 2007 15:57:14 -0700, Juerg Haefliger wrote:
> > > +pwm[5-6]_enable                      RO      Enable of PWM outputs 5-6. Always
> > > +                                     returns 1 since these 2 outputs are
> > > +                                     hard-wired to manual mode.
> >
> > Note that other drivers do not create the file in this case. It is
> > assumed that PWM is always manual if pwmN exists and pwmN_enable
> > doesn't.
> 
> I tried to make it consistent for this driver. If it breaks a common
> standard I will remove these attributes.

No, I'm fine either way. It was only a random comment.

> > > +pmw[1-3]_ramp_rate           RW      Ramp rate of PWM output. Determines how
> > > +                                     fast the PWM duty-cycle will change
> > > +                                     when the PWM is in automatic mode.
> > > +                                     Expressed in ms per PWM step size.
> >
> > s/step size/step/
> 
> Sorry, I don't get this.

I don't think that "expressed in ms per PWM step size" makes much
sense, "expressed in ms per PWM step" sounds better.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
