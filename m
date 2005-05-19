From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <Pine.LNX.4.58.0502081439060.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Khali,

> Don't know which ones you missed, but the HF has actually 9: 7 at
> 0x20-0x26, and 2 at 0x50-0x51 (VSB and Vbat, bank 5). The EHF
> additionally has one at 0x52 (bank5), labelled vin4.

Yes it seems I missed such as VSB etc. I compared pins only.

>
> > Some pins are shared, what happen if they are used for other function?
> > They will return zero? Or bogus?
>
> For the 2.6 driver, the sysfs file should simply not be created. We can
> check the Super-I/O configuration to know which functions are enabled
> and which aren't. For the 2.4 driver we can't prevent the file from
> being created, so care should be taken that zero values are returned and
> writes to the files, if apply, are ignored, when the function is
> disabled. Or maybe we won't write a driver for 2.4 at all, if there is
> no request to do so.

(For example if configured as VID output we would read register with
output value and if as VID input we would read input)

> Interesting. I wonder if this is really new or simply wasn't documented
> for older chips.

I found this in HF pdf. And in EHF it is again reserved.

 Anyway, I don't think we can use this. For one thing,
> the I2C driver wouldn't possibly access this bit. For another, we could
> easily deadlock the ISA driver if either the SMBus gets stuck in the
> middle of a transaction, of some random write to 0x295 sets the bit and
> never clears it.

It is read-only.

> But to say the truth, I simply don't plan to implement i2c support for
> this chip at all. I just don't see the point when we can detect the
> chip much more reliably as a Super-I/O chip, and have a much faster and
> more reliable registrer access through ISA.

Yes it sounds very reasonable.

> Side note: The ISA address is said to be aligned on 2-byte a boudary, not
> 8-byte as expected. I wonder if the older chips supported that too. Not
> that it really matters, however.

0010 1001 0010 (0x292)

lowest bits listen at 101 and 110

So 0x292 would not work (0x295 would be used). I think they made a
mistake.

regards

Rudolf
