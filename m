From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 24 Sep 2005 20:40:50 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <43359D88.9090701@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> I have another question. Don't I have to do a 14-bit right shift of the
> contents of register the rcba to get the actual base address as its
> stored in bits 14-31 of the register?

I think no, because the bits are reserved just because of it must be aligned to 16KB boundary.
Proper approach would be to mask the reserved registers to 0 but default is 000 anyway.

Hmm it seems that this is not what we want anyway:

When a function is disabled, software must not attempt to re-enable it. A disabled function can
only be re-enabled by a platform reset.

Question is if we really have correct rcba base addr. Can you read some other values and see if they match with register?

Another question is how to get the SMBUS back...

I will try to find out something...

You can find me on IRC freenode.net #linux-sensors.

Regards
Rudolf
