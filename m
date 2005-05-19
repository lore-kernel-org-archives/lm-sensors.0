From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <200405111524.i4BFOEZ7088723@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I have a lm-sensors up and running on 2.6.5 kernel, on a VIA KM266 based
>motherboard. My goal is to get the fan noise down.
>
>Most things appear to be working fine. However, while my BIOS reports
>activity of two fans (rightly), lm-sensors only seems to be finding one.
>
>I have tried fidling with the divider to see if that is an issue but
>still I am missing activity on one fan.
>
>Can anyone suggest some steps I might take to get this fan working?

Not really, but here are some hints anyway.

Either the second fan is supposed to be monitored by the it87 and isn't,
or you have another fan monitoring chip on-board.

Which speed is the BIOS reporting for the "missing" fan? If it's
really slow, you need a really big clock divider 8). Seems that you have
already been trying that though?

If there is a second monitoring chipset, a recent version of
sensors-detect should identify it, or at least find it but fail to
identify it.

BTW:

>-12V:     -14.24 V  (min = -12.63 V, max = -11.41 V)   ALARM
>-5V:       -7.71 V  (min =  -5.28 V, max =  -4.81 V)   ALARM

Obviously not monitored (look at your BIOS, I guess they don't show
there at all) so you could add "ignore" lines for these in
/ect/sensors.conf.

>M/B Temp:    +80?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
>CPU Temp:    +96?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor

As hot has hell! Hardly believable. Maybe you need to change the sensor
type?

>lm90-i2c-4-4c
>M/B Temp:    +59?C  (low  =    +0?C, high =   +70?C)   ALARM
>CPU Temp:  +67.6?C  (low  =  +0.0?C, high = +70.0?C)   ALARM

Damn hot too, however. Where are you living? ;)

Strange that the ALARMS show. Do they wear of on second read?

Jean
