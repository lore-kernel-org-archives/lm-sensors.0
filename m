From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: w83627hf driver: one pwm value, two fan speeds?
Message-Id: <2D6gtWoH.1110188515.0408100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306230902.GA17472@nospam.com>
In-Reply-To: <20050306230902.GA17472@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rutger,

> While trying to control the CPU temperature with the fan speed on a
> P4P800 motherboard + P4 CPU with the w83627hf driver (kernel
> 2.6.11-rc4) just like Asus's Q-Fan (see http://www.wingding.demon.nl/
> for qfan.rb), I encountered a strange effect.

First of all I'd like to comment on this. Asus' Q-Fan isn't a real
thing, it's a marketing name. The underlying technology is Winbond's
automatic fan control logic embedded in their Super-I/O chips (W83627THF
in your case, if I'm not mistaken). Winbond calls that "Cruise Mode".
In fact there are two of these, thermal cruise mode and fan speed cruise
mode. Q-Fan would be thermal cruise mode.

For confirmation, how is Q-Fan presented in Asus' BIOS? I'd guess a
"target CPU temperature" to be chosen by the user?

OTOH is seems that your qfan.rb script is a *software* fan control
script, so it's quite different. Our driver doesn't support either
cruise mode at the moment.

(Also note that we already have two fan control scripts in the lm_sensors
package, one written in perl, one in shell, sharing a common
configuration file.)

> Doing
>
> cd /sys/devices/platform/i2c-1/1-0290
> echo 240 > pwm2
> sleep 1
> echo 192 > pwm2
>
> .will stabilize at a fanspeed of around 3229, while changing the 240
> to 128 will give a fanspeed of around 2136.
>
> Somehow a 'state' is kept somewhere, or the driver has a bug. Is this
> a known bug?

Not known, first report. I would appreciate additional experimental data:
1* What if you sleep for a longer time between changes, say 5 seconds?
2* Result of a 240/128 and 128/240 combination.

Make sure you wait long enough before you conclude, fans may take up to a
minute to stabilize speed.

Did you check that reading from the pwm2 file would always return the
last written value?

Are you loading the w83627hf driver with init=0?

Could you please provide a dump of your chip?
(isadump 0x295 0x296)

Would you have the possibility to test kernel patches?

Thanks,
--
Jean Delvare
