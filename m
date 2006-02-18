From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 21:48:16 +0000
Subject: [lm-sensors] MSI KT4V - Strange sensors output.
Message-Id: <20060218224816.25028d9e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
In-Reply-To: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Aha, so the compute formula in sensors.conf must not be correct for
> > your board. That's odd since this means you would have different
> > resistors used for +5V and 5VSB. Or maybe the input order differs. Are
> > the voltage values displayed in the same order in the BIOS and by
> > "sensors"?
> 
> They are in a different order.  Also, I don't have anything labeled
> +3.3V in the BIOS.  Here is the order from my BIOS:
> 
> Vcore
> +5.0V
> +12.0V
> -12.0V
> -5.0V
> Battery
> +5V SB
> 
> And this is from /etc/sensors.conf:
> 
> chip "w83697hf-*"
>     label in0 "VCore"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>     label in7 "V5SB"
>     label in8 "VBat"
> 
> So based on the names, it would appear that in7 and in8 are reversed.

Correct, there are a number of boards where this is the case.

> But if in7 and in8 were really reversed, wouldn't I see 5.xV for VBat
> and 3.xV for V5SB?

Not it you also swap the compute lines. Given that VBat doesn't need
one, it's down to simply replacing "compute in7" by "compute in8".

> Sensors now reports this:
> 
> V5SB:      +4.97 V  (min =  +4.75 V, max =  +5.26 V)
> 
> and previously my BIOS said 5.042V (and would sometimes drop down to
> 4.993V for a second).

Sounds good. Will be slightly different after you switch in7 and in8,
but all in all it should stay within a reasonable range.

-- 
Jean Delvare

