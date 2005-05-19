From: bradley@greystate.com (Bradley Schatz)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <40A17B4B.4030502@greystate.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Which speed is the BIOS reporting for the "missing" fan? If it's
> really slow, you need a really big clock divider 8). Seems that you have
> already been trying that though?

Your smiley reminded me I hadnt tried a divisor higher than 4. V value 
of 8 starts giving a value for this. Solved!
> 

> BTW:
> 
> 
>>-12V:     -14.24 V  (min = -12.63 V, max = -11.41 V)   ALARM
>>-5V:       -7.71 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
> 
> 
> Obviously not monitored (look at your BIOS, I guess they don't show
> there at all) so you could add "ignore" lines for these in
> /ect/sensors.conf.

Thanks for the hint. Done.


>>M/B Temp:    +80?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
>>CPU Temp:    +96?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor
> 
> 
> As hot has hell! Hardly believable. Maybe you need to change the sensor
> type?
> 

Changing the sensor type starts to give negative temperatures. The it87 
& lm90  M/B temp are starting to agree. However the it87 CPU temp looks 
almost 2X the lm90 one.

> 
>>lm90-i2c-4-4c
>>M/B Temp:    +59?C  (low  =    +0?C, high =   +70?C)   ALARM
>>CPU Temp:  +67.6?C  (low  =  +0.0?C, high = +70.0?C)   ALARM
> 
> 
> Damn hot too, however. Where are you living? ;)

This is odd to me too. It is starting to approach winter here so the 
ambient temperature is not so high. I must compare the BIOS temps.
> 
> Strange that the ALARMS show. Do they wear of on second read?
> 

They do.

Thanks for your help Jean!

-bradley


