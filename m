From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 25 Feb 2006 18:10:13 +0000
Subject: [lm-sensors] pwmconfig minstart minstop problem
Message-Id: <44009D85.3040506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ROUBACH Philippe wrote:
> Hello
> 
> 1. My config
> Asus A7N8X-X with asb100 and w83l785ts
> Q-fan features disabled

Maybe your PWM is just reversed and there might be some prolem with asb100 because the
support was reverse enginered.

Please can you work out what excatcly causes that you cannot the control the fan anymore?
(find the sequence of echo .. >pwm1 that will cause the troubles)

When done with it please post it back here so we can investigate what and where went wrong.

Regards
Rudolf


