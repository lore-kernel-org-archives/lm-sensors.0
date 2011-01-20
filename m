From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 20 Jan 2011 19:23:02 +0000
Subject: Re: [lm-sensors] [PATCHv2] Added driver for Maxim MAX6639
Message-Id: <1295551382.9786.430.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1295545375-4135-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1295545375-4135-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-01-20 at 12:42 -0500, stigge@antcom.de wrote:
> 2-Channel Temperature Monitor with Dual PWM Fan-Speed Controller
> 
> This patch version changes:
> * Minor "const int" addition
> * FAN_FROM_REG() fix to consider rpm_range
> * Added _alarm interfaces
> * Added SENSORS_LIMIT() to set_pwm()
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied to -next.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
