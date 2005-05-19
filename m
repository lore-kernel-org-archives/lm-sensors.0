From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <20040526230539.07e56f0a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, it's been a while. I've been busy with schoolwork for the past
> weeks, sorry for not stating that earlier. I have been following your
> e-mails to me, and I would like to thank you for not only continuing
> driver development, but continuing to do specific work on my
> motherboard. That is just awesome. I will definitely have more time
> now that school is out.

No problem.

> First of all, the P4U-LA most closely resembles the appearance of my 
> board and the layout is probably exactly the same as mine. Thanks for 
> looking into this. I have looked into the P4B-MX before, and I know I 
> found something wrong with it when comparing it to mine. Right now, I 
> can say it is very similar to my board, but the layout is slightly 
> different. Do these boards have computation differences with the
> sensor chip?

They do. Rudolf Marek could extract information from the P4B-MX BIOS.
The thermistor computations are probably similar to yours, but the
voltage computations seem to differ (although the pin order would be the
same).

> It is awesome to see thermistor support and it appears to be
> functioning well. Temps 4, 5, and 6 all hover around 40, and my bios
> reports a single cpu temperature of 40 degrees (but it keeps rising
> steadily, while sensors doesn't seem to reflect this). I left my bios
> showing for a while, and it hit around 45 degrees celsius, but I have
> not seen such a temperature reported in sensors. I will experiment
> with changing the environment temperature this weekend and e-mail the
> results.

I'm not surprised. BIOSes usually have very poor idling loops (not
really idling if you see what I mean), while Linux (or any decent OS)
does actually idle. If you give some work to your CPU, you should see at
least one of the temperatures raise to 45 degrees C or more.

> By the way, what are all these new temperature values reporting?

I can't say. Most likely, one of the thermistors is located in the CPU
socket so it's a rough approximation of the CPU temp. The two others are
probably located as random locations on your motherboard.

If you have a hair dryer you may try to (reasonably) heat various
locations and see how the thermistor values change.

> Oddity: When I try to set limits in the new temp proc entries, the 
> changes are not reflected in sensors, or a number that is completely 
> different is shown, and I am guessing this is due to the computations
> in the sensors.conf file.
> For example: cat temp4 gives me 3.02 3.02 3.02 1.34 when I echo 34 63
> 23 -128 to temp4; sensors then reports
> temp4:       +36 C  (low  =   -24 C, high =   -24 C)   ALARM
> temp4_crit:
>              -24 C
> If I then echo 22 55 77 99 to temp 5, cat temp 5 shows 3.02 3.02 3.02 
> 1.22, and sensors reports -25 for low, high, and crit temperatures for
> both temps 4 and 5. Echoing 22 55 77 99 to temp6 produces the same 
> output when cat'ed, and then the values for all the highs, lows, and 
> crits change to -24.

Aha. You're doing the completely wrong thing here. Thermistor-based
temperatures are completely different from diode-based temperatures.
Thermistor-base temperatures are reported by the driver as a voltage.
The library converts it to an equivalent temperature. This is what the
forumlas in sensors.conf are for.

So if you want to specify a limit, set it in sensors.conf and use
sensors -s. BTW, I suggest that you don't try critical limits for
thermistor, they cannot work for the moment (and I suspect a design bug
that will make them definitively useless, actually).

The big values you were trying to write wouldn't make sense. You were
asking for "the temperature those voltage equivalent is 34V" while the
max voltage is 3.02V. So the driver does its best and picks 3.02V, which
in turns converts to -24 (or -25) degrees C.

The higher the temperature, the lower the voltage.

> I can work with temp3 perfectly, but now the first value echoed is
> the high temp and the second is the low temp. It used to be the other
> way around, so I'm not sure if this was intended (though it probably 
> shouldn't make any difference).

This is how it was meant to be, and I didn't remember it was wrong in
the first place. But certainly you have a better memory than me (nothing
to be proud of ;)).

> Hmm, okay just noticed something. With the voltages, if I echo a value
> that is close to the original values, then the new values do get
> updated in the file. So now I'm not sure if this is a bug, or just the
> fact I was echoing unnecessarily large numbers, and I'm guessing the
> latter....

Correct. See explanation above.

> As for the fans, pwm no longer functions (understandable, since my 
> motherboard isn't doing things conventionally anyway), but the speeds 
> still appear correctly (as if pwm was set to 255). The pwm files show
> 0 1, and echoing any new value has no effect.

I suspect side effects however, as said in my other reply. Would be nice
if you could investigate. I really suspect that your PWM outputs are not
properly wired and that activating them brings trouble all other the
place. Strange because your chip configuration would suggest that the
pins (1, 3 and 5) are really used for PWM. We didn't forcibly enable PWM
on your chip, did we? Again, I can't remember... :/

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
