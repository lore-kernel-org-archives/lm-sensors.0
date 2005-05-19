From: kmalkki@cc.hut.fi (Kyosti Malkki)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I have no scope around to check this, but looking into i2c-algo-bit.c,
adap->udelay is used where it is not necessary. As an example, udelay=3
would look roughly like 25/75 duty cycle:

SDA: -._________---._________---.------------.-
SCL: _.___---______.___---______.___---______.-
        ^     ^  ^   ^     ^  ^   ^     ^  ^

Dots just point out where sw goes for next bit, others 1 us wide each.
That is, all bus transitions use adap->udelay, where a rise/fall delay
of 1 us (or less) would do.

Removing the unnecessary 2us marked ^ _above_ :

SDA: -._____-._____-.------.-
SCL: _._---__._---__._---__.-
            ^ ^      ^    ^

When successive bits to put on bus are equal, SDA rise/fall may be
omitted.

SDA: -._____.____-.-----.-
SCL: _._---_.---__.---__.-


Interrupt service and PCI latency may add to the delay time.  Any
decrease is not possible, if write-read sequence is used in
setscl() and setsda(). Right ?

In the process I tested using nominal 1us delay everywhere, and
i2c_adap->udelay only to clock bits in and out.  I believe it does not
violate specs, but will likely fail with higher bus capacitance.
This changes duty-cycle and might break some support, so I won't commit
it now. It does improve the speed upto 333 kbps, using adap->udelay=1.

I have an unrelated patch for i2c-algo-bit just about ready to commit.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
