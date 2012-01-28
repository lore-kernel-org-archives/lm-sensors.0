From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Jan 2012 12:56:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Disable setting DC mode for pwm2, pwm3 on NCT6776F
Message-Id: <20120128135624.64d30c0f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Jan 2012 13:28:04 +0100, CC wrote:
> What's more important than terminology is the fact that setting pwm2
> to other modes works (as is to be expected since this one has a 4-pin
> connector with a PWM signal, and the others don't). It's pwm1 and pwm3
> that should be disabled. Maybe the code got the enumeration somewhere
> else wrong?

Maybe you could let the guys with the experience and datasheets write
driver code? We apperciate your testing and feedback, don't get me
wrong, but your conclusions aren't exactly scientifically correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
