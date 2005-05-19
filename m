From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: No fan values with W83637HF
Message-Id: <20041212191109.6353500a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3ekhyb7b9.fsf@eos.attique.in>
In-Reply-To: <m3ekhyb7b9.fsf@eos.attique.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hum, I change the value of files in /sys/bus/i2c/devices/0-0290 (like
> /sys/bus/i2c/devices/1-0290/fan2_pwm) but it does not made obvious
> changes on the fan speed reported. Is there a pointer to a useful doc
> about that?

Three possibilities:

1* Your motherboard isn't wired for PWM support. There's nothing more
you can do.

2* Your fans don't like the PWM frequency your monitoring chip uses.
This can be tinkered with.

You can easily differenciate by setting PWM value to 0 (fan stopped). In
the first case the fan won't stop, in the second it will. Don't leave it
off too long ;)

Make sure you have pwmN_enable set to 1, providing such a file exists
for you (depend on the chip).

3* The chip is in automatic fan control mode. Not too sure about what
would happen then.

> Apart from that, will the sensors reset the BIOS power down on extr?me
> heat? This would be quite concerning (despite the fact that I never
> manage to reach such temperatures under GNU/Linux)?

This much depends on the chip configuration and the motherboard wiring,
so I just can't tell, sorry.

-- 
Jean Delvare
http://khali.linux-fr.org/
