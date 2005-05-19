From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: usbvision, I2C_ALGO_USB
Message-Id: <20030804142211.562c3071.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi folks,

It looks like you would like us to assign an I2C_ALGO constant for your
usbvision module:

	.id            = I2C_ALGO_BIT, /* FIXME */

The ID could be:

#define I2C_ALGO_USB         0x150000	/* USB */

Is it OK for you? Or would some other name be more appropriate? Any
comment for this algorithm?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
