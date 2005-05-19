From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <20040526220709.28844607.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> +5V:       +3.38 V  (min = +11.48 V, max =  11.48 V)       ALARM
> Vcore:     +0.78 V  (min =  +3.02 V, max =   3.02 V)       ALARM
> +12V:      +6.04 V  (min = +17.00 V, max =  17.00 V)       ALARM
> 5VSB:      +2.47 V  (min =  +4.48 V, max =   5.47 V)       ALARM

I'm really disappointed by this. The configuration file I sent to you
was supposed to make these readings correct. They don't...

I suspect that your strange PWM behavior is having negative side effects
on the rest of the chip. Could you please do some basic checks and
confirm, or infirm, this theory. I'd hope that if you set all PWM to 0
again (which is the default value for you, don't ask why) the voltage
readings would be better.

If you can get better readings (and even if you can't, BTW) I'd
appreciate a new dump from the whole chip as performed by my script:
http://jdelvare.net1.nerim.net/sensors/pc87366/dump-pc87366.sh

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
