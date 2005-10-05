From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 20:46:14 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051005204529.3e233cf9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> > > /* Addresses to scan */
> > > static unsigned short normal_i2c[] = {0x2c, 0x2e, I2C_CLIENT_END};
> > 
> > 0x2d is missing.
> 
> Is the chip ever actually implemented at that address?

Why not? The datasheet says it can. It even says that the 24-pin
version of the chip always has this address.

> It may be that all known implementations use 0x2c for a single chip
> motherboard and 0x2c + 0x2e for a dual chip motherboard.

Why would we assume this? Adding 0x2d doesn't cost us much. The
original driver did support it (it supported 0x2c - 0x2e as a *range*,
not individual values!) and sensors-detect as well.

Thanks,
-- 
Jean Delvare
