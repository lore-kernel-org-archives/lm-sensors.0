From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040705204705.2e2a8991.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> if that's the case, then when auto_channels is on, pwm_enable must be
> zero, one, or don't care?(in other words, does the pwmconfig script
> need to change?) Using pwm_enable as a master configure
> (off/manual/auto) makes sense to me.

I thought that pwm_enable would be the master command, ie:
pwm = 0: fan to full speed
pwm = 1, auto_channels = 0: manual pwm
pwm = 1, auto_channels > 0: auto pwm

But I didn't consider the pwm scripts. Would it be complicated to update
these scripts according to the model I propose?

-- 
Jean Delvare
http://khali.linux-fr.org/
