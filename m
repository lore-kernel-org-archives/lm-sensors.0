From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <40B3E8C6.2050103@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, it's been a while. I've been busy with schoolwork for the past
weeks, sorry for not stating that earlier. I have been following your
e-mails to me, and I would like to thank you for not only continuing
driver development, but continuing to do specific work on my
motherboard. That is just awesome. I will definitely have more time now 
that school is out.

First of all, the P4U-LA most closely resembles the appearance of my 
board and the layout is probably exactly the same as mine. Thanks for 
looking into this. I have looked into the P4B-MX before, and I know I 
found something wrong with it when comparing it to mine. Right now, I 
can say it is very similar to my board, but the layout is slightly 
different. Do these boards have computation differences with the sensor 
chip?

lm_sensors cvs 05/25/04 @ 6:10 pm EST

*note: I am using the sensors.conf modification you sent me through 
e-mail for all of this.

It is awesome to see thermistor support and it appears to be functioning 
well. Temps 4, 5, and 6 all hover around 40, and my bios reports a 
single cpu temperature of 40 degrees (but it keeps rising steadily, 
while sensors doesn't seem to reflect this). I left my bios showing for 
a while, and it hit around 45 degrees celsius, but I have not seen such 
a temperature reported in sensors. I will experiment with changing the 
environment temperature this weekend and e-mail the results.

By the way, what are all these new temperature values reporting?

Oddity: When I try to set limits in the new temp proc entries, the 
changes are not reflected in sensors, or a number that is completely 
different is shown, and I am guessing this is due to the computations in 
the sensors.conf file.
For example: cat temp4 gives me 3.02 3.02 3.02 1.34 when I echo 34 63 23 
-128 to temp4; sensors then reports
temp4:       +36 C  (low  =   -24 C, high =   -24 C)   ALARM
temp4_crit:
             -24 C
If I then echo 22 55 77 99 to temp 5, cat temp 5 shows 3.02 3.02 3.02 
1.22, and sensors reports -25 for low, high, and crit temperatures for 
both temps 4 and 5. Echoing 22 55 77 99 to temp6 produces the same 
output when cat'ed, and then the values for all the highs, lows, and 
crits change to -24.

Different combinations of echoed values also produce different outputs:
echoed 0 70 to temp4 and cat'ing shows 0.00 3.02 3.02 1.31 and sensors 
reports
temp4:       +37 C  (low  =   -25 C, high =  -273 C)
temp4_crit:
             -25 C


I can work with temp3 perfectly, but now the first value echoed is the 
high temp and the second is the low temp. It used to be the other way 
around, so I'm not sure if this was intended (though it probably 
shouldn't make any difference).
cat temp3 shows 66 0 100 54 and sensors shows
S-IO Temp:   +53 C  (low  =    +0 C, high =   +66 C)
S-IO Crit:  +100 C

I have noticed a similar oddity with echoing settings for the voltages. 
cat in1 originally showed 1.18 1.44 0.90, then I echoed 10 20 30 to in1, 
and cat'ing it again gives 3.02 3.02 0.90. Sensors reports
+5V:       +3.42 V  (min = +11.48 V, max =  11.48 V)       ALARM

Hmm, okay just noticed something. With the voltages, if I echo a value 
that is close to the original values, then the new values do get updated 
in the file. So now I'm not sure if this is a bug, or just the fact I 
was echoing unnecessarily large numbers, and I'm guessing the latter....

As for the fans, pwm no longer functions (understandable, since my 
motherboard isn't doing things conventionally anyway), but the speeds 
still appear correctly (as if pwm was set to 255). The pwm files show 0 
1, and echoing any new value has no effect. Of course, pwmconfig chokes, 
but produces odd (and probably meaningless) results:
Found the following fan sensors:
   pc87366-isa-ecc0/fan1     current speed: 3779 RPM
   pc87366-isa-ecc0/fan2     current speed: 2105 RPM
   pc87366-isa-ecc0/fan3     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control pc87366-isa-ecc0/pwm1 ...
  pc87366-isa-ecc0/fan1 ... speed was 3779 now 0
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm1
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 3478
    PWM 240 FAN 3503
    PWM 225 FAN 2580
    PWM 210 FAN 0
    Fan Stopped at PWM = 210

  pc87366-isa-ecc0/fan2 ... speed was 2105 now 882
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm1
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 2123
    PWM 240 FAN 1061
    PWM 225 FAN 888
    PWM 210 FAN 2142
    PWM 195 FAN 2123
    PWM 180 FAN 2105
    PWM 165 FAN 1818
    PWM 150 FAN 1702
    PWM 135 FAN 1528
    PWM 120 FAN 1860
    PWM 105 FAN 1935
    PWM 90 FAN 1578
    PWM 75 FAN 1702
    PWM 60 FAN 2123
    PWM 45 FAN 2123
    PWM 30 FAN 1052
    PWM 15 FAN 2105
    PWM 0 FAN 2105


Testing pwm control pc87366-isa-ecc0/pwm2 ...
  pc87366-isa-ecc0/fan1 ... speed was 3779 now 0
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm2
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 3503
    PWM 240 FAN 0
    Fan Stopped at PWM = 240

  pc87366-isa-ecc0/fan2 ... speed was 2105 now 1764
    no correlation

Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3779 now 1538
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm3
    Fan pc87366-isa-ecc0/fan1 has not returned to speed, please investigate!
  pc87366-isa-ecc0/fan2 ... speed was 2105 now 1846
    no correlation

Testing is complete.
Please verify that all fans have returned to their normal speed.

And that's all I've seen so far. I should be more prompt now in replying 
to e-mails, so if you need anything specific, I'd be glad to do it. I 
know that my in8 and in9 dumps from a while back were incorrect, so if 
you need me to do that again, I'll do so.

Thanks again!
