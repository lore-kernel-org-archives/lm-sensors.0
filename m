From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 May 2015 16:21:20 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <20150512162120.GB31693@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, May 12, 2015 at 04:19:47PM +0200, Jean Delvare wrote:
> Hi Roger,
> 
[ ... ]

> > If you want me to add pwm[4-7]_mode then I'll do it... but I can only see
> > reasons not to and if it was me, I'd either remove the existing pwm[1-3]_mode
> > or at least make it a read-only value.
> 
> What I would like is consistency. There is no reason to treat pwm[1-3]
> and pwm[4-7] differently. Your patch adds inconsistency and I don't
> like that. So please add the pwm[4-7]_attributes and we can discuss
> separately whether they should be made read-only in all 6 affected
> drivers. I would be in favor of this change, Guenter, what do you think?
> 

Ok with me. We'll need to do some reading to get an understanding how
the wrong mode would or could cause hardware defects.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
