From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <1083158989.408fb1cd9e6ce@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here are the isadump outputs:
> 
> isadump -f 0xecd0 16 11
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 1f 05 02 0b 81 59 ff 00 ff 00
> 
> isadump -f 0xecd0 16 12
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 1f 05 02 0c 81 64 ff 00 ff 00
> 
> isadump -f 0xecd0 16 13
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 1f 05 02 0d 81 5d ff 00 ff 00

Looks like there is something there (all three channels). However, I
read the datasheet again and the conversion from register values to
actual temperatures is somewhat complex, and requires data that only
the motherboard manufacturer could provide. Basically, the values
reported are voltages (like the eleven first channels of the VLM
module). The difference is that one of the two external resistors used
to divide the voltage is a thermistor, i.e. the resitor value depends
on the temperature.

Since I already don't know how to compute the voltages (the wiring
order and the resistor values are only known to the motherboard
manufacturer), it get even worse here since I additionally don't know
the formula of the resistor value depending on the temperature. So,
unless you can get information from your motherboard manufacturer,
we're stuck here.

BTW, did you get a Windows monitoring tool with the motherboard? Maybe
we can learn something from there, if the manufacturer doesn't help.

> Also, I did echo "50 -55 50" > temp3 to set the high and critical 
> temperatures. It reports a temperature of 54 C, but I didn't see an 
> alarm flag (I assumed there should be one).

Actually I wasn't reading the correct bits. I was assuming that bits in
the alert registers were set whenever corresponding limits were
crossed, but it looks like it does only happen after you explicitly
enable each channel to act this way.

I changed the sensors program so that it reads the flags directly from
the channel, much like I am doing for the fans. I also refactored
temperature and voltage code, so sensors should be smaller and work
better :)

> The fans seem to be working with pwmconfig a lot better, though
> still some quirks exist. It can be run (shutting off the fans) and
> there are no longer overflow flags and the readings remain
> accurate (no longer changing to -1).

Yes, yesterday's change fixed that.

> Here is the pwmconfig output (the main strangeness is in the testing
> of pwm3, to which I still have not attached a fan):

I don't see this as a strangeness. pwmconfig doesn't know that you
don't have any fan here, he can't guess it so it just probes it, and
sees that there is no working fan. Then it just ignores it. What else
could be done?

> Testing pwm control pc87366-isa-ecc0/pwm3 ...
>   pc87366-isa-ecc0/fan2 ... speed was 2162 now 1153
>     It appears that fan pc87366-isa-ecc0/fan2
>     is controlled by pwm pc87366-isa-ecc0/pwm3
> Would you like to generate a detailed correlation (y)?
> Would you like to generate a graphical plot using gnuplot (y)?
>     PWM 255 FAN 2162
>     PWM 240 FAN 2162
>     PWM 225 FAN 2162
>     PWM 210 FAN 2162
>     PWM 195 FAN 2162
>     PWM 180 FAN 2162
>     PWM 165 FAN 2162
>     PWM 150 FAN 2162
>     PWM 135 FAN 2162
>     PWM 120 FAN 2162
>     PWM 105 FAN 2162
>     PWM 90 FAN 2162
>     PWM 75 FAN 2162
>     PWM 60 FAN 2162
>     PWM 45 FAN 2162
>     PWM 30 FAN 2162
>     PWM 15 FAN 2162
>     PWM 0 FAN 2162

This is admittedly strange. It first sees a correlation, but then the
fan speed isn't supposed to change. Could it be a bug in pwmconfig?

> However, I did do some pwm changes by echoing values to the pwm files
> in the proc entry. The fans did successfully change speed (I opened
> the case to see them slow down), but there was no change in speed
> reported in "sensors".

Sounds bad. Was it any better when reading from /proc directly?

> I got overflow flags after echoing a value below a certain 
> point.
> For example:
> echo 200 > pwm2 gives me in sensors
> fan2:     2181 RPM  (min = 2000 RPM, div = 2)          OVERFLOW
> which won't go away until I echo at least 228 and run the "sensors" 
> command at least twice.

This looks very odd, but actually I think I see what happens. See
below.

> Hmm, this problem also exists with echoing values lower than 228 to 
> pwm1. This time, I echo a value above or equal to 228 and I have to
> run sensors three times before the flag goes away.
> I am guess this has to do with the the drivers need to refresh
> itself

Correct. There are two different phenomenon here. First, the driver
buffers the readings for 2 seconds. This is meant to protect the chip
against concurent and continuous accesses. Second, when an alarm
triggers and a flag bit is set, further reading of the corresponding
sensor is stopped until you clear it, which the driver does on each
update. But the driver will still report the *old* value (and alert
flag) this time. This is done so that you'll never miss an error.

This basically means that you may need up to 4 seconds (2 updates) to
get valid and up-to-date readings after an error occured.

Now, we can imagine that when you change PWM or otherwise write
anything
to the chip, it temporarily fails measuring the fan speeds, and set
flags, which in turns prevents it from going on. If this is confirmed,
this means that I should forcibly reset the fan alarm flags when
writing anything to it, to kill false alarms.

So I'd like you to test (with the latest kernel driver and user-space
tools) which actions are actually raising errors, and I'll add alarm
clearers for them in the driver.

> (note: in dmesg I get a lot of "pc87360.o: Data update" messages).

Means that debugging is turned on and working :)

> The flags for the fans get updated (both the overflow and alert
> flags) only after running "sensors" a few times.

4 seconds? ;)

(PWM files below)

> 255 0
> 255 0
> 255 1

This revealed a bug, since PWM is supposed to be enabled for all 3
fans.
I was not reading the fan configuration from the proper registers. It's
hopefully fixed now.

This bug was likely to confuse pwmconfig, please retry and see if it
helps.

> One question: there is an enormous difference (by sound of fans)
> going from pwm 255 to 220 (or even 230 to 220), and going from 220
> to anything lower is sometimes not even noticeable. Is this because
> there is an exponential relation between pwm and rpm?

This is too low-level for me. I know that PWM itself is linear, but I
don't know how the fan does physically react to the modulation. I don't
have any PWM-capable system myself so I have to experience with this.

Please test the updated driver and sensors program. As you load the
driver, there should be some debugging output about fan configuration.
Make sure that all bits read 1.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
