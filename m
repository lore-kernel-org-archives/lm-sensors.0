From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: ATI i2c bus driver
Message-Id: <20040108220236.35c5cfa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040102115144.219b5579.khali@linux-fr.org>
In-Reply-To: <20040102115144.219b5579.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The GPIO pins could be bidirectional, but one way at a time. Meaning,
> the read value _GPIO_Y_0 is not valid when _GPIO_EN_0 is set.

I did not see anything similar in Gatos' code.

> Also, I did not find _GPIO_A_0 (nor _1) initialised to 0 in your code.
> I believe this is the value ( 0 = pull low, 1 = hi-Z ) when _GPIO_EN_0
> is set. Makes sense with the inverted setscl&sda.

I did that, it did not help. I believe that both bits were 0 anyway --
the whole register value is 0.

> Did you try without bit_test? You might need some <1 us delay between
> read and write to see the change, the bus has some capacitance even
> without monitor cable.

Yes, I tried without bit_test=1. I2cdetect hangs using 100% CPU, which
makes me think my code is somehow broken, although I don't see where.
I've copied what I read from the gatos code, using i2c-savage4 as a
base, everything seems very simple, but it doesn't work. Would you have
any concrete suggestion of something I could try? Else I think I'll just
give up.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
