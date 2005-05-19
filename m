From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307142236.38144.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Montag, 14. Juli 2003 22:02 you wrote:
> [...]
> the address range is 0x38-0x3b. Our I2C layer will add the eigth bit in
> its own, you don't have to worry about that. And you definitely don't
> have to handle a different address for reading and writing. Sounds
> clearer now?

Definitely, thx :-)

> No, the change occured after 2.7.0 was released. But don't worry about
> that, I'll make the few changes needed before integration, it's easy.

Thx again.

> Not really useful to me either. The interesting one should have been the
> byte mode, but it shows only zeroes (as the others do). In a way, the
> data cycles over 8-byte boundaries, and the bits I expected to be zeroes
> are, but that's not very helpful since everything is zero. However, this
> is the expected data if the LEDs are all off (and the control register
> is in a particular state). Was it the case? If it was, I would like to
> see the same I2C dump (byte mode) with some LEDs arbirary switched on.
> I'm quite pessimistic however, the probability that everything was set
> to zero is *low* ;)

Well, the driver blanks all digits, setting the testmode bit in the 
control-block (all digits on, ignore data). The i2cdump I've sent to you 
was indeed exactly that case. But as I've just checked, output is exactly 
the same when the led's are displaying some random digits at a variable 
brightness.

At Montag, 14. Juli 2003 22:19 you wrote:
> I'll take a look at it tomorrow. BTW, how may I get my hands on such a
> device? I have to say I'd *love* playing around with a 4-digit LCD
> display :) How do you get it plugged on your computer? Using the
> parallel port I guess?

Look at http://www.magoa.net/linux/index.php?view=kathrein
I hope when this driver is released someone will find other "old" devices 
carrying this chip - in my case it's a Kathrein analogue Sat-Twin-Receiver 
(two displays) or Single-Receiver (one display). It's connected to 
i2c-pport indeed. In the meantime, an additional PCF8574 chip has been 
connected to that bus, works fine alltogether (when loading pcf8574 after 
saa1064) :-).

> This is what you are expected to do! The more eyes read you, the better.
> There are only a few dozens persons on the list, on purpose. So people
> on the list *are* interested in the project and will want to know
> everything that's going on.

OK I'll stick to that - thsi mail goes to the right address though :-)))

Greetings,
Sascha
