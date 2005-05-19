From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1834 Update
Message-Id: <20041204162319.69a97d4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The chip on the MSI KT8 Neo is actually a Winbond w83697hf and is not 
> detected correctly during sensors-detect.

What was sensors-detect detecting? Please attach the complete log.

> pwmconfig can't detect a usable a correlation:
> 
> Testing pwm control 1-0290/fan1_pwm ...
>   1-0290/fan1_input ... speed was 3229 now 0
>     It appears that fan 1-0290/fan1_input
>     is controlled by pwm 1-0290/fan1_pwm
> Would you like to generate a detailed correlation (y)?
>     PWM 255 FAN 3229
>     PWM 240 FAN 3214
>     PWM 225 FAN 3214
>     PWM 210 FAN 3229
>     PWM 195 FAN 3229
>     PWM 180 FAN 3229
>     PWM 165 FAN 3229
>     PWM 150 FAN 3229
>     PWM 135 FAN 3229
>     PWM 120 FAN 3229
>     PWM 105 FAN 3214
>     PWM 90 FAN 3214
>     PWM 75 FAN 3229
>     PWM 60 FAN 3214
>     PWM 45 FAN 3214
>     PWM 30 FAN 3214
>     PWM 15 FAN 3169
>     PWM 0 FAN 0
>     Fan Stopped at PWM = 0

This is admittedly a strange behavior, I can't remember of a similar
report. Maybe you need to adjust the PWM clock. This is done by register
0 of the chip (which you can write to by running "isaset 0x295 0x296 0
<value>" as root). Default value is 1 and results in a 125kHz clock. You
can increase the value up to 127, resulting frequency being
125kHz/value. If you set the MSB to 1, the base clock changes from
125kHz to 1MHz (and again you can divide it by changing the 7 other
bits). I'd suggest you try this 

I doubt it'll really help, but if you have some spare time and really
want it to work, you may want to give it a try.

-- 
Jean Delvare
http://khali.linux-fr.org/
