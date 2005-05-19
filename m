From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <40E99B9B.60702@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if that's the case, then when auto_channels is on, pwm_enable must be zero, one, or don't care?
(in other words, does the pwmconfig script need to change?)
Using pwm_enable as a master configure (off/manual/auto) makes sense to me.

Jean Delvare wrote:
>>We also need a way to turn the whole thing on.
>>I propose we use a new value of 2 in fan[1-3]_pwm_enable to turn on
>>auto-fan.
> 
> 
> fanN_auto_channels does that already. Value 0 = all bits cleared = fan
> speed doesn't depend on temperature, i.e. auto mode disabled.
> 
> 
>>I like the second model. It's for adm1031, etc.
> 
> 
> True.
> 
> 
>>I don't understand the first model. what drivers is it for? 
> 
> 
> IT87xx if I remember correctly.
> 

I don't see how this maps to it87 very well.
In it87, just like the others, the temperature controls the fans,
not vice versa. It's just that the pwm values are selected discretely.
Your naming implied to me that the fan controls the temperature
for it87??? confusing to me anyway.
Shouldn't it87 use the same model as the others, with some additional
entries if necessary?
