From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <1083317132.40921b8c2399f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I can echo new pwm values to pwm1 and pwm2 in the proc entry, and I
> can hear the speeds change. However, no fan speeds are updated;

This is definitely strange, and I have to admit I'm clueless.

> overflow flags are still shown when pwm values below 228 are issued
> and the fan#_status file displays "4". Whenever there is an overflow
> flag, the speed is reported as -1.

At least this is logical. Bit 2 (value 4) of fan status registers is
for
fan overflow, and the reported speed of -1 is expected in this case.

> Pwmconfig is working a lot better now. It creates a correlation
> list, but only for pwm values 255 and 240, then reports "-1" for
> everything else.

This at least corroborates what you experience when manually setting
the
values.

> Strangely, depending on the fan divisor, those 2 correlation 
> values either make sense (the first is larger than the second) and 
> sometimes it doesn't (the second value is larger).

It's irrelevant. The different values are the result of the limited
accuracy of fan speed measurements. For a fan divisor of 8, 3750 RPM
corresponds to a register value of 16, 3529 RPM to a register value of
17. It's the same speed, with some noise. Same for 2162 RPM and 2181
RPM for a fan divisor of 2: these speeds correspond to register values
of 111 and 110 respectively, so it's simply the same value withe some
noise.

> Other than this issue, I don't see any other problems.

Fine. I wish I was less puzzled by this issue. I've added some debugging
to the driver, just in case, but I doubt it'll reveal anything.

I'd like you to dump the contents of all the fan registers before and
after changing PWM values. I'd like to ensure that at least the driver
does what I think it does. The dump command is:

isadump -f 0xecc0 16

Please alternate dumping and changing pwm values, and provide the
results, together with the debug logs. Maybe it'll reveal something,
although I doubt it. I also read the PWM section of the datasheet once
again, but I cannot find anything explaining what you observe.

> In order to play with fanconfig, I want to be able to see my cpu 
> temperature (so I don't burn it out when I turn off the fans for
> too long), so would you know how easy/difficult it would be to get
> the chip to record the cpu temperature the "normal" way, considering
> it is already being monitored using the chip's other channels? If
> this will require soldering, please let me know.

Search your motherboard for thermal diode inputs. I have one on my Asus
board. We could expect two of these on yours, corresponding to temp1
and temp2. If you have such inputs, then you just have to get
compatible thermal diodes (there's a list in the PC87366 datasheet,
page 206) and use them.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
