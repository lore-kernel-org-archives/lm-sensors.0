From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040509192331.2b89b3cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Care to test again? It should be better.
> 
> Ok, doing better now. Output attached.

Great :)

> Found the following PWM controls:
>    1-0290/fan1_pwm
>    1-0290/fan2_pwm
>    1-0290/fan3_pwm
> 
> Found the following fan sensors:
>    1-0290/fan1_input     current speed: 0 ... skipping!
>    1-0290/fan2_input     current speed: 2667 RPM
>    1-0290/fan3_input     current speed: 0 ... skipping!

OK, so at least it finds the files. This is what the change was all
about.

> Testing pwm control 1-0290/fan1_pwm ...
>   1-0290/fan2_input ... speed was 2667 now 2700
>     no correlation
> 
> Testing pwm control 1-0290/fan2_pwm ...
>   1-0290/fan2_input ... speed was 2667 now 0
>     It appears that fan 1-0290/fan2_input
>     is controlled by pwm 1-0290/fan2_pwm
> Would you like to generate a detailed correlation (y)? 
> Would you like to generate a graphical plot using gnuplot (y)? 
>     PWM 255 FAN 2689
>     PWM 240 FAN 2689
>     PWM 225 FAN 0
>     Fan Stopped at PWM = 225
>     Hit return to continue...
> 
> Testing pwm control 1-0290/fan3_pwm ...
>   1-0290/fan2_input ... speed was 2667 now 2667
>     no correlation
> 
> The problem is fan2_pwm, where only 3 samples are taken. This is not
> enough in this case.

Most likely because you have a low fan divisor. Try increasing it and
try again. You need a high divisor to be able to measure low speed fans,
and lowering PWM lowers fan speed.

Maybe the script could take care of this?

> Bug in script:
> Line 242:
> 		if [ "$S" = "0" -o "S" = "-1" ]
> Shouldn't "S" be "$S" ?

Correct, nice catching. I've fixed it, thanks.

> Problems:
>   - at pwm 240, the fan speed reported in 0 while I still hear it
>   turning.

Same reason: fan divisor must be too low.

>   - at pwm 200, is goes even faster than at 255, and it
>   reports 3139 as rpm(!).

Admittedly strange. Possibly some emergency mode of the chip. I don't
know about the W83627HF, but I know similar chips with that
functionality. On alert conditions (overtemperature...) manual PWM is
disabled and fans are forced to full speed.

> It appears the speed is also depending on the speed from which it
> came. Doing
>   echo 255 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
> will give me +-3100, while doing
>   echo 0 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
> will give me 0. Strange...

No wonder to me. Fans have inertia, it's natural that the "original"
speeds has an influence.

> Where do I report such strange interaction?

Doesn't sound that strange to me. That said, I think that Marius is the
most qualified of us all with PWM issues, so he's the one you want to
address your questions to, if there's really a problem.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
