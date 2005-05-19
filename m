From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: w83627hf - i2c - chip
Message-Id: <JZj4crVb.1097829064.8415090.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I am just curious.
>I have a dual AMD motherboard, gigabyte.
>It has a winbond chip, w83627hf
>
>Why do the temperatures always seem skewed - they seem low...?
>Why wouldn't the winbond chip just return the correct temperatures?
>(not something that needs to have a calculation after it is returned
>to userspace)
>
>How would I go about verifing the temperatures are correct? Maybe my
>numbers are correct...
>
>Sample output:
>joe@jedi /usr/src/linux-2.6.9-rc4/drivers/i2c/chips $ sensors
>w83627hf-isa-0290
>Adapter: ISA adapter
>VCore 1:   +1.52 V  (min =  +0.00 V, max =  +0.00 V)
>VCore 2:   +1.54 V  (min =  +0.00 V, max =  +0.00 V)
>+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
>+5V:       +4.84 V  (min =  +4.76 V, max =  +5.24 V)
>+12V:     +11.67 V  (min = +10.82 V, max = +13.19 V)
>-12V:     -12.61 V  (min = -13.18 V, max = -10.80 V)
>-5V:       -5.25 V  (min =  -5.25 V, max =  -4.75 V)
>V5SB:      +5.24 V  (min =  +4.76 V, max =  +5.24 V)
>VBat:      +3.01 V  (min =  +2.40 V, max =  +3.60 V)
>fan1:        0 RPM  (min =    0 RPM, div = 2)
>fan2:        0 RPM  (min =    0 RPM, div = 2)
>fan3:        0 RPM  (min =    0 RPM, div = 2)
>M/B:         +29 C  (high =   +45 C, hyst =   +42 C)   sensor = thermistor
>CPU1:      +32.0 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
>CPU2:      +42.5 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
>ERROR: Can't get VID data!
>alarms:
>beep_enable:
>          Sound alarm disabled

Easy. The reported temperatures are those of the CPU socket, below the
CPU. Not the internal CPU temperature which would be way higher and
change much faster.

>if i use a calculated value like from another chip in sensors.conf i get
>these:
>M/B:         +52 C  (high =   +45 C, hyst =   +43 C)   sensor >thermistor   ALARM
>CPU1:      +53.3 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor
>CPU2:      +56.8 C  (high =   +80 C, hyst =   +77 C)   sensor = thermistor

These computations are weird ways to approximate the CPU temperature from
the socket temperature. They do not correspond to a real temperature.
Some motherboard makers (Asus...) do such computations in the BIOS setup
screen too (and after that, user complain because lm_sensors yields
different values). I don't think it's clever. Internal CPU temperature
changes very fast (like +10 degree C in a second), while the socket
temperature varies very slowly. Also, there is no simple correlation
between socket and CPU temperature. Depends on the CPU, heatsink, fan
and ambient temperature. I prefer to have a real, physical temperature
value for the socket than a guessed (and wrong) value for the CPU
temperature.

>Also, my motherboard manual says I have a w83627hf, but lm90 also
>works, but it only displays MB temp and CPU1 temp and from what I
>understand, lm90 does not support 3 temperatures...

What is your motherboard brand/model?

You are right, the LM90 only supports one local and one remote
temperature sensor. However, it is possible that the LM90 is
multiplexed, either on the SMBus (two LM90 chips) or at the diode level
(one LM90 but two thermal sensors).

Please provide the output of sensors-detect (after unloading all the
monitoring chip drivers).

It's kind of fun since we were just discussing the way we are going to
handle the SMBus multiplexing on another board (and all boards which
need it in general).

Jean Delvare
