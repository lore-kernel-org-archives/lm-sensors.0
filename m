From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Jan 2012 22:41:24 +0000
Subject: Re: [lm-sensors] [w83627ehf] Not all fans are shown (#3)
Message-Id: <20120127224124.GA32220@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127145130.GA29746@ericsson.com>
In-Reply-To: <20120127145130.GA29746@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Fri, Jan 27, 2012 at 12:49:48PM -0500, CC wrote:
[ ... ]
> >
> > I tested all three fan outputs. Another thing is weird: pwm1_mode has
> > its meaning reversed (it's a 3-pin connector and the value 1 is DC
> > mode, in contrast to pwm2 and the documentation).
> >
You lost me there. pwm1 supports both DC and PWM. pwm1_mode should return 0 for DC mode,
1 for pwm mode. The other pwm channels only support pwm mode on the NCT6776F, thus
pwm2_mode and pwm3_mode should both return 1.

Are you saying that reading pwm1_mode returns 1, and pwm2_mode and pwm3_mode
both return 0 ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
