From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Aug 2005 09:45:32 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, third try [1/2]
Message-Id: <FlIx3Nou.1123141068.5848300.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Eric,

[Eric J. Bowersox]
> This is i2cblock-2.6.13-rc3-mm3.patch, against 2.6.13-rc3-mm3, which
> reintroduces the i2c_smbus_read_block_data function into i2c-core,
> because the lm93 driver needs it.

I'm of course fine with the reintroduction of a standard smbus function
you need, but I'd like you to fix formal issues this patch has:

* Please place the i2c_smbus_read_block_data function (and declarations)
before i2c_smbus_write_block_data rather than after. All other pairs
have read before write.

* There should be one space after each comma (except at line end). I know
the original code you took from 2.6.5 wasn't correct in this respect,
but as we are adding it back now, let's do it with standard coding
style.

Can you please send an updated patch addressing these points?

Thanks,
--
Jean Delvare
