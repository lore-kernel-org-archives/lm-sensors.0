From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Feb 2011 19:56:30 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110222205630.359df5c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 22 Feb 2011 11:29:46 -0800, Guenter Roeck wrote:
> Fwiw, I have a system with TI TMP75AIDGKT (per HW spec). Detection code
> doesn't work for it, since it always returns 0xff when reading registers
> 0x4..0x7. So the lm75 detection code is really of limited value and can
> not be expected to work for all chips supported by the driver.

And it was never meant to. As said before, the detection of the LM75
proper is there only because the chip was once popular on PC
mainboards. None of the other chips supported by the lm75 driver was as
far as I know.

> Here is a register dump:
> 
> root# i2cdump -y 70 0x48
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 10: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 20: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 30: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 40: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 50: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 60: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 70: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 80: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> 90: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> a0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> b0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> c0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> d0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> e0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....
> f0: 13 00 4b 50 ff ff ff ff 13 00 4b 50 ff ff ff ff    ?.KP....?.KP....

Added to my collection, thanks :) But there is no way to detect this
chip reliably.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
