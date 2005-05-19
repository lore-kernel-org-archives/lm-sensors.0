From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: strange i2cdetect output
Message-Id: <3DD68BFC.AF9D6EFF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021116181757.3c4ab409.khali@linux-fr.org>
In-Reply-To: <20021116181757.3c4ab409.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The adapter is broken or the bus is hung.
Reboot. 
Also, if an algo_bit adapter, rmmod i2c-algo-bit and then insmod
i2c-algo-bit bit_test=1.

Perhaps error handling in whatever adapter you are using could be
improved.


Jean Delvare wrote:
> 
> Hi everybody,
> 
> I have come accross a very strange i2cdetect output. The machine is a
> Sony Vaio GR114EK.
> 
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
> 
> Tricky, heh? Every address of the I2C bus pretends to contain a chip.
> Has someone ever seen something like this? Is there something we should
> do to prevent this? I've to admit I'm puzzled on this one.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
