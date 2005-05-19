From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307152025.52219.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Dienstag, 15. Juli 2003 19:37 you wrote:
> You should modify your "detection" procedure in the same way. Actually,
> I don't think you did it the right way at all. The "kind" parameter is
> set according to the force options that are passed to the module as you
> load it. kind < 0 means no force parameter was set (default). kind = 0
> means force, but no particular chip, kind > 0 means force a given kind
> of chip. Since there is only one chip in your driver, = 0 and > 0 are
> all the same. What's more, you don't have to take the address into
> account. You won't be called for an address you don't like unless the
> force parameter is used. And if it is used, you have to trust it. So you
> should have the following detection procedure:
>
> kind < 0: set kind to saa1064, try to detect the chip (see below)
> kind >= 0: set kind to saa1064, don't try to detect the chip

Ok I'll do this but no more programming for today. It's damn hot here and I 
just can't _think_ :-)

I've re-checked the current pcf8574 sources, and of course I found the bug 
in mine pretty quickly :-). But if this chip is really impossible to 
detect, I think just setting saa1064 for kind in every case would make 
sense.

> As you noticed, the saa1064 doesn't really want to be detected. However,
> I still think there are things we can check:
> 1* The MSB of the control register has to be zero.
> 2* Registers 0x05 to 0x07 should be set to 0x00 (unless we can't read
> from them).
> 3* Registers should cycle over 8-byte boundaries.

But how can this actually be checked when the chip doesn't provide any read 
operation (according to the data sheet is doesn't). It reads a status byte 
where only one bit is significant. I'll add read support for this byte 
tomorrow, too, maybe some of the other bits are static or something. 

> Unfortunately, this couldn't be confirmed by i2cdump. I'd like you to
> insist, this would really help. Maybe the chip doesn't like the was
> i2cdump reads it. You still could try adding these checks in your driver
> code (for kind < 0) and see if the module still loads. Another
> possibility is to add detection to sensors-detect (what I could do.)

I assumed that sensors-detect should contain all detectable chips, for 
scanning unknown busses. So I assumed both kinds of detection would be 
necessary :-)

> Same for me a few weeks ago. And it feels great actually, isn't it? :)

Definitely :-)
Well, the main problem really was to find something useful to start with.

> Bug, definitely. I noticed this too, because I didn't do so in my own
> driver... I'll check every driver tomorrow. Anyway, drivers that get
> mkpatched must be OK, or I guess someone would have noticed, by the
> time...

Well at least for i2c-core, i2c-dev and i2c-proc, they are 
double-initialized (first by init and later again by init_module) when the 
construct is missing. Clearly those drivers did NOT work as expected after 
initialization in the kernel. /dev/i2c-0 was not existent, but i2c-1 was 
responding etc.

Greetings,
Sascha
