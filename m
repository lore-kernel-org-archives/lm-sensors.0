From: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 23 Feb 2011 18:33:14 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <4D6552EA.5000405@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2/23/2011 11:22 AM, Guenter Roeck wrote:
> Difficult to imagine that two fans would show spinning if only one does.
> I would think that if you drop pwm2 down to 0 (and of course set its
> mode to manual) should result in fan2 speed dropping, and CPU
> temperature to go up.
> 
> This actually leads to the next question: What temperature changes do
> you see after playing with pwm settings ? If the CPU fan is affected, I
> would think that CPU temperature should go up pretty fast.

It turns out that the cpu fan refuses to stop.  It seems to have a
minimum speed of around 1000 rpm ( max: 2000 ) and is controlled by
pwm2.  pwm1 controls both sysfans, and pwm3 does nothing.  The pwrfan
can not be controlled.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
