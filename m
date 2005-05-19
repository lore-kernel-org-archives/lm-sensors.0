From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <1083077465.408e73598ac1f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Awesome. Temp3 appears to be reporting accurate readings (in celcius)
> of what my bios says is the cpu temperature. The high and low
> temperatures are also stated correctly (with the default values,
> according to the pc87366 data sheet). The temperature is also slowly
> rising for temp3, so there there is definitely constant measurement
> happening.

Great :)

> However, temp1 and temp2 still display negative -128 instead of
> zero. I'll look into my board and see if this chip is trying to
> measure other temperatures, but I doubt it.

That's accordingly strange. According to the datasheet, it should
report either +127 (open diode) or 0 (unused). That said, -128 is
obviously no random value. A dump of the registers would appreciate,
see below.

> Also, I tried looking for information about what temp3 should be 
> reporting (the nat.semi. ship temp or the cpu temp) but was unable
> to locate anything. I'll have a closer look.

I have a theory about that. On the PC87366 (as opposed to the PC87365),
there are three additional channels on the VLM (voltage level monitor)
module. They are supposed to be temperature channels. This sounds
strange, and at first (admittedly quick) read I thought that it was
simply the three temperature channels of the TMS (temperature sensor)
module, replicated for convenience (I didn't see how convenient if was,
but still...). Now after reading it once again, the datasheet clearly
states that these are different temperature measurements (thermistor
based, as opposed to thermal diodes). So possibly your CPU temperature
is there, and our temp3 is the PC87366 temperature. This also complies
with the fact that an internal temperature measurement normally cannot
be disabled, to temp3 really has to be the PC87366 temperature.

I will try to implement the three additional temperature channels this
evening. Could you please provide the output for the following
commands:

isadump -f 0xecd0 16 11
isadump -f 0xecd0 16 12
isadump -f 0xecd0 16 13
isadump -f 0xecf0 16 0
isadump -f 0xecf0 16 1
isadump -f 0xecf0 16 2

This will dump the registers value for all six temperature channels,
hopefully this will bring some light ;)

> Fans are working as they have. I can set minimum values without a 
> problem. However I noticed 2 oddities:
> 1:) echoing a value that is greater than the current fan rotation
> speed will yield a different number for minimum in "sensors" or in
> the proc entry.

Nothing unusual here. Fan speed measurements have a limited (and
non-linear) resolution. Only values of the form C/(r*d) can be measured
and used as limits, where C is a clock frequency, r is a register value
and d is the divisor. For the PC87366 the clock is 480000, and d is 1,
2, 4 or 8. r is naturally between 0 and 255. See below.

Note that this is *not* related to the fact that the limit is over the
current measurement.

> 2:) the alarm flags don't wear off even if I set the minimum value
> under the current fans speed (after having a previous setting that
> was higher than the fan speed)

Nice catching, this was a bug. I was clearing the bits for temperatures
and voltages, but not fans. This is fixed, thanks.

> Pwmconfig still appears to be confused about the fans. After running
> it (and after it has shut down both my fans and restarted them), I
> get the overflow flags in "sensors" and the speeds are reported as
> -1.

OK, there must be something wrong then. I invite you to do some tests
manually, rather than using pwmconfig. Just go to the
/proc/sys/dev/sensors/pc87366-isa-ecc0 directory, and try echoing
values (between 0 and 255) to the pwm files. See what happens each
time, and report to me after you have found what is going wrong.

> For he above, even though I echoed fan2 to have a min value of 2170,
> it is reporting 2181. I had a similar problem with fan1's min, but
> echoing 2400 gave no problems.

Remember the formula above. 480000/(2170*2) = 110.59, which is stored
as
110 in the register. When applied the other way around, 480000/(110*2)
= 2181, which is what you get. The difference is because we work with
integer values.

OTOH, 480000/(2400*1) = 200, exactly. So there is no rounding done and
the value you read back is exactly the same.

>   temp1_crit: 127.00 (temp1_crit)
>   temp1_status: 127.00 (temp1_status)
> (...)
>   temp2_crit: 127.00 (temp2_crit)
>   temp2_status: 127.00 (temp2_status)
> (...)
>   temp3_crit: 127.00 (temp3_crit)
>   temp3_status: 127.00 (temp3_status)

I'm surprised by the status values, looks like a bug, most likely in
the
library. I'll take a look.

> Thanks for your continuing work on this driver!

Thanks a lot for testing :) I could hardly do anything without your
help!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
