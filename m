From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: R: i2c-sis5595.c, kernel 2.6.10
Message-Id: <20050122213056.54f64b37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122192536.08fb5248.khali@linux-fr.org>
In-Reply-To: <20050122192536.08fb5248.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> The driver loads and adds the i2c device. i2cdetect -l tells:
> 
> i2c-1 unknown SMBus SIS5595 adapter at 5038 Algorithm unavailable
> i2c-0 dummy   ISA main adapter              ISA bus algorithm

Great, so it somehow works. I'll send the patch to Greg KH for inclusion
into his tree.

> Is there any way to allow sensors to read out the internal voltage
> and temperature values from the sis5595's Data Acquisition Module ?
> Or just check the i2c function (i2cdump !?)

First of all you should try "i2cdetect 1" to find out whether there are
chips on the SMBus or not.

Then you might try loading the sis5595 chip driver (no i2c- prefix).

If it doesn't work, there is always the sensors-detect script which can
hint you at which drivers you should try.

-- 
Jean Delvare
http://khali.linux-fr.org/
