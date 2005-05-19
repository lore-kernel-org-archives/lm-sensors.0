From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040705193636.435c5335.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> We also need a way to turn the whole thing on.
> I propose we use a new value of 2 in fan[1-3]_pwm_enable to turn on
> auto-fan.

fanN_auto_channels does that already. Value 0 = all bits cleared = fan
speed doesn't depend on temperature, i.e. auto mode disabled.

> I like the second model. It's for adm1031, etc.

True.

> I don't understand the first model. what drivers is it for? 

IT87xx if I remember correctly.

-- 
Jean Delvare
http://khali.linux-fr.org/
