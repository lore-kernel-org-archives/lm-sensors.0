From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040413192053.01598bde.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think it's a major i2c defect (or design feature :). Bus wasn't
> design to support "autodetection" and decision to use one should be on
> case by case basis.
> 
> In embedded systems (and 4xx is an embedded chip) you usually do NOT 
> autodetect anything...

Still you use the common i2c-core, which does more or less rely on the
fact that autodetection is "implemented". All I meant is that if you do
not implement it (ie basically pretend that all addresses hold a chip)
you have to be aware that the i2c-core, chip drivers and most userspace
tools (i2cdetect and sensors-detect come to mind) will be confused and
won't behave as expected.

But it may be the right thing to do. You know your stuff better than I
do, doubtlessly.

> > There is no data sent, which is why it usually doesn't disturb the
> > chips.
> 
> Well, in patch Evgeniy sent this is not the case. Due to the chip
> design there is no easy way to implement "quick write", so he decided
> to incorrectly issue "full" 1-byte write with random data.
>
> So basically in SMBus speak, "quick" write command I2C_SMBUS_QUICK
> (which maybe harmless) was substituted with I2C_SMBUS_BYTE and _this_
> is wrong and I was trying to explain why.

OK, this is actually what I had understood. I agree with you, it's not
correct at all. Although most chips won't care (they will simply update
their internal register pointer, doesn't harm) others will take it bad
(pcf8547 and pcf8591 for example, and possibly saa1064; more generaly
chips with zero or one register).

> As I've written in my previous e-mails we can implement "quick" write 
> properly (using bit-banging), but it's not very trivial and definitely
> not the way Evgeniy tried to do this.
> 
> You see, I'm not a big fan of i2c-autodetection so it's not a high
> priority item in my list. Although after this long discussion I'm
> starting to think that maybe I'll do this just to get users off my
> back :)

As you wish then :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
