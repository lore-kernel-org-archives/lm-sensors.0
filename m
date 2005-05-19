From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <200405121209.i4CC9YnP022605@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Which speed is the BIOS reporting for the "missing" fan? If it's
>> really slow, you need a really big clock divider 8). Seems that you have
>> already been trying that though?
>
>Your smiley reminded me I hadnt tried a divisor higher than 4. V value
>of 8 starts giving a value for this. Solved!

Aha, it wasn't meant to be a smiley. I just missed the opening
parenthesis. Glad it helped anyway. However this means that your fan is
really, really slow. Maybe this explains why your system is so hot?

>> As hot has hell! Hardly believable. Maybe you need to change the sensor
>> type?
>
>Changing the sensor type starts to give negative temperatures.

Hm OK, so they had to be correct in the first place.

> The it87 & lm90  M/B temp are starting to agree.

It's both encouraging (means we are probably measuring the temperature
correctly) and frightening (would your system need additional fans?)

> However the it87 CPU temp looks almost 2X the lm90 one.

This is odd. Do you have any conversion formula set in the configuration
file?

Maybe your board uses unconventional thermistors so a formula is needed.
What are your motherboard brand and model exactly? You may need a
"compute" line for the it87's CPU temperature. I think there are some
commented out in the default configuration test for you to try.

>This is odd to me too. It is starting to approach winter here so the
>ambient temperature is not so high. I must compare the BIOS temps.

Yeah, that's definitely the correct thing to do.

>Thanks for your help Jean!

You're welcome :)

Jean
