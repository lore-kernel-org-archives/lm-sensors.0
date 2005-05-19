From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030714220222.507245cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have to look about the addresses, my devices are hardwired on 0x38
> and 0x3b, but the datasheet says something completely different about
> possible addresses. Also, the datasheet says reading (one status byte
> with one bit indicating a power loss) is on a different address than
> writing. By now, I have these two addresses as the only probed ones
> (which also conflict with the pcf8574a driver :-( ).

Although the datasheet wasn't easy to understand at first, I think they
say the same as we do. I2C adresses are *7-bit* addresses, but you send
an 8-bit value over the I2C bus, the LSB meaning read (1) or write (0).
That's why the datasheet says the read and write addresses are
different. The address is actually the same, but the byte value you send
is different. When they say the read address is 0x71 and the write
address is 0x70, the real address is 0x70>>1, that is 0x38, which is the
address you see your own chip at. So you really have to consider that
the address range is 0x38-0x3b. Our I2C layer will add the eigth bit in
its own, you don't have to worry about that. And you definitely don't
have to handle a different address for reading and writing. Sounds
clearer now?

> Currently I'm using a sensors- and i2c-2.7.0 patched kernel. But I
> guess "recent" doesn't include that :-)

No, the change occured after 2.7.0 was released. But don't worry about
that, I'll make the few changes needed before integration, it's easy.

> The chip receives an register-address byte followed by n (don't know
> how many, datasheet only specifies 6 at once) data bytes. The register
> address is encreased by every data byte, wrapping around at 7. The
> data has to be written in one physical block, since the device expects
> a new block starting with the register-address after a stop-condition.
> That's why smbus-commands don't work either, I guess.

I'm no I2C vs. SMBus expert, but this seem to make sense.

> Well i2cdump doesn't give ME much info, maybe it does for you (output
> for modes byte, word and i2cblock attached).

Not really useful to me either. The interesting one should have been the
byte mode, but it shows only zeroes (as the others do). In a way, the
data cycles over 8-byte boundaries, and the bits I expected to be zeroes
are, but that's not very helpful since everything is zero. However, this
is the expected data if the LEDs are all off (and the control register
is in a particular state). Was it the case? If it was, I would like to
see the same I2C dump (byte mode) with some LEDs arbirary switched on.
I'm quite pessimistic however, the probability that everything was set
to zero is *low* ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
