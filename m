From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <rmcXL5jF.1091799320.9184290.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Just for curiosity I tried to use 90 as fan1_pwm value. I opened the
>case to confirm if fan was still running.
>As you will see at *woops.txt (result of woops.sh), I found a
>strange behaviour. I don't know if it is important, but I thought you
>should know.
>I made another test (attached) trying to help.

I think that you refer to the fact that sometimes the driver will report
0 RPM while you can still see the fan (slowly) spin. This is a hardware
design limitation, common to almost all hardware monitoring chipsets.
This is not a problem in this specific driver.

Fan speeds are not measured directly. Instead, the chipsets will count
how many cycles of a given clock can fit between two turns (or,
partically, two half turns) of the fan. The result is stored in a
register and some maths are needed to get the RPM value.

The problem here is that the registers are almost alwats 8-bit wide. This
means that the greater count that can fit is 255. As a result, if the
chipset uses for example a 1 MHz clock and the fan emits to
ticks/revolution (standard), the lowest speed you can measure is
1000000/(2*255) = 1960 RPM

To allow for slower fan monitoring, chipsets can usually divide the
source clock by 2, 4, 8 or even more. With a divider of 8, the lowest
speed you can measure would be 1000000/(8*2*255) = 245 RPM which is far
better. The drawback is that you then lose resolution on higher speeds,
which is why the highest dividers are usually not used by default.

So you can try increasing the divider to 8 and should be able to monitor
much slower fans.

The SMSC chips have the particularity that the fan min also influences
the lowest measurable fan speed (for other chips, only the divider
matters) so things are even more complex. For a clock of 983040*2 Hz,
divider of 8, you should be able to specify the min speed down to 640
RPM. If you do, the lowest fan speed you will be able to measure is 483
RPM. Below this, the driver will return 0. If you set the min speed to
1000 RPM, the lowest fan speed you will be able to measure is 702 RPM.

You may read the SMSC LPC47M14x datasheet for calculation details if you
are interested.

I plan to modifiy the driver at a later time so that it can select the
best divider automatically. That way, the end user won't have to know
anything about the internals. But for now I prefer to have the driver
merged into the main tree. Improvements can be added later.

>I am trying to give you the best information I can, to help as much
>as I can, but I am worried about disturbing you a lot.
>I mean, I have never helped testing software like this, so I am
>always thinking if I am being a problem more than a helper. :-)

You do very well. I consider the testing over and will send the patch to
Greg as soon as I am back home.

>Thank you for coding the driver.

Thanks again for testing :)

Jean Delvare
