From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <20031018155617.66054374.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


** MDS, please read below **

I definitely can't resist answering a 17.7kB report ;)

> I have an Intel SE7501cw2 motherboard with dual 2.4 GHz processors in
> a 1U chassis.  This motherboard has a Winbond w83627hf chip and a max
> 6650 (or 6651) chip.

According to the details given below, this must be a 6651, since the
6650 monitors a single fan.

> Most of my fans are Sunon GM1204PQV1-8A fans, which should run at 9200
> RPM according to the manufacturer.
> 
> I'm running RH9 and lm_sensors 2.8.1.
> 
> If I plug and unplug the fans, I'm able to correlate their readings
> with sensors reports.  max6650-i2c-0-1b's four fans correspond to
> sys3 (J29) sys4 (J30), cpu1 (J16), and cpu2 (J14), respectively. 
> w83627hf's three fans correspond to sys2 (J3), sys1 (J1), and sys5
> (J58).  This information may be useful to someone else.

Nice, at least you got it partly working.

> 1. sensors-detect recommends w83781d, which doesn't seem to work, but
> doesn't recommend w83627hf, which does seem to work.

Already seen that. I have some proposal for a fix but definitely would
like MDS's opinion.

First, the w83781d driver is supposed to handle the w83627hf on the ISA
bus, so it should be investigated why sensors-detect can detect the chip
while the w83781 driver rejects it.

> Driver `w83781d' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)

Second problem. Both detections have the same confidence value, so the
choice is left to sensors-detect - and its choice is rather arbitrary. I
think that we believe that the w83627hf is overall better that the
w83781d when both can be used, so what about raising the confidence to 9
for the w83627hf driver.

MDS, I took a look at sensors-detect and there's a single confidence (8)
value fot all SuperIO probes. Is it a feature? If SuperIO probes are
known to be better that other detections, let's set the confidence value
to 9 instead, it would solve a number of problems. The other possibility
is to move the SuperIO confidence value from the code to the data
structure - allowing a different confidence value for each SuperIO
detection, if that makes more sense. In this case, we would give a
confidence value of 9 to the W83627HF and 8 to all the other ones. This
is a change I'd be able to make by myself, still I'd like to hear your
opinion about that. I've never worked with these SuperIO things before,
maybe you know something I ignore.

> [root@gb0007 lm_sensors-2.8.1]# modprobe w83781d
> [root@gb0007 lm_sensors-2.8.1]# sensors -s
> [root@gb0007 lm_sensors-2.8.1]# sensors

No Winbond chip.

> [root@gb0007 lm_sensors-2.8.1]# rmmod w83781d
> [root@gb0007 lm_sensors-2.8.1]# modprobe w83627hf
> [root@gb0007 lm_sensors-2.8.1]# sensors -s
> [root@gb0007 lm_sensors-2.8.1]# sensors

Still no Winbond chip. Strange, isn't it supposed to be there?

> [root@gb0007 lm_sensors-2.8.1]# rmmod w83781d

That module isn't supposed to be loaded at this moment. There's
something unclear here, the rmmod command should return an error. Can
you test that again, checking with lsmod which modules are loaded each
time? Don't you have some kind of module auto-loading making trouble
here? Taking a look at dmesg while loading/unloading the modules could
help.

> 2. The max6650 fan speed measurement seems to be all or nothing.  If
> there's a (Sunon) fan connected and operational, it reports 7650RPM. 
> If there's no fan connected, it reports 0 RPM.  If I physically slow
> the fan down, it still report 7650 RPM.  (The tachs on the w83627hf
> sensor do show decreased rpm when I impede their fans).
>
> 3. The fan speeds reported (7650 or 18,000-21,000) seem to be
> inconsistent with the advertised speeds.  Changing the divisors
> doesn't seem to affect the reported values.
> 
> 4. The speed control on the max6650 doesn't seem to work.  See below.

Strange. Could be because the driver assumes too much conditions that
aren't correct for your system. The MAX6650 driver was contributed by
John Morris. John, could you please take a look at Mark's problem?

> 5. The w83627hf's "pwm1" setting seems to have no effect:

I think that PWM needs special wiring on the motherboad in order to
work. Could it be that your motherboard doesn't have it?

> 6. The w83627hf's "pwm2" setting is able to reduce the speed of fans 1
> and 2, but only to about half.  I can hear them change speed when I do
> this.  I can't get them to stop completely, though.

This may be a feature more that a bug. Fully starting a fan requires a
higher current. What's more, stopping a fan completely is somewhat
dangerous, isn't it? Same as for PWM1, I think that PWM2 works thank to
adequate wiring on your motherboard, but maybe the wiring and
electronics are such that the W83627HF isn't allowed to lower the fan
speed below a given threshold.

That said, please note that I did not write the w83627hf driver (nor the
max6650 driver, for that matter) so I'm just guessing. Our drivers still
may be buggy, so if you are willing to read the code and compare with
the datasheets, feel free to do so and report errors if you find some.

> 7.  Changes to the "pwm2" setting seem to be transient.  Something
> happens to change it back to 255.
> 
> [root@oscarnode001 root]# cat
> /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     0 1
> [root@oscarnode001 root]# sleep 60
> [root@oscarnode001 root]# cat
> /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     255 1

Don't you by any chance have a monitoring daemon running on the machine?

> 8. Sometimes the "lm75" module loads and detects something.  I'm not
> aware of there being any lm75's or compatible devices on this system. 
> (...)
> 9. The lm75's temperature readings are bogus.  At an earlier point I
> got them to report reasonable values, but I can't get back to that
> state.

Could you provide the output of "i2cdetect 0"? I'd also be interested in
the output of "i2cdump 0 0x1f" since you seem to have an unknown chip
there.

Strangely, sensors-detect didn't report any client found at these
addresses (0x48 and 0x49). Could you run sensors-detect again (unload
all client drivers first) and see if it now does? These LM75s could
actually be emulated by your w83627hf, although it's unusual to see this
behavior when the w83627hf itself is on the ISA (as opposed to I2C) bus.

> 10.  The default value for the sensor type on the  w83627hf's
> temperature sensor, according to sensors.conf, is thermistor (3435). 
> But for me it seems to be defaulting to "1", PII/Celeron Diode.

The "defaults" might be confusing, I agree. This refers to power-up
default for the chip. The BIOS may then reconfigure the chip during the
boot process. I believe that this is what has happened there.

If you believe that we should say the things differently in the
configuration file, suggestions are welcome.

Thanks for the long and detailed report. I doubt we'll be able to
quickly solve all the problems you encountered, since there are many,
still this will help us if similar problems are reported in the future,
plus I hope I clarified some points.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
