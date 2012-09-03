From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Sep 2012 15:55:27 +0000
Subject: Re: [lm-sensors] Some doubts with fancontrol
Message-Id: <20120903155527.GA6274@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <504241C4.30701@fastmail.fm>
In-Reply-To: <504241C4.30701@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 03, 2012 at 09:36:48AM +0200, Jean Delvare wrote:
> Adding Henrique to Cc.
> 
[ ... ]

> >
> > See above. It can not select 2, since values above 1 are driver and hardware
> > specific. fancontrol does not know about specific hardware and has to play it
> > safe. Which, again, is to select manual mode and the fastest available fan
> > speed.
> 
> That's indeed the logic behind the current implementation. That being
> said, while the fancontrol script cannot switch to pwmN_enable=2
> unconditionally, we could make it remember the pwmN_enable values when
> it starts, and restore these values at exit if they are 2 or above.
> Guenter, what do you think?
> 
Yes, that would be good idea. After all, it is what we are trying to do in at
least some of the drivers. To be on the safe side, we should probably safe
and restore both the pwm value and and pwm_enable.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
