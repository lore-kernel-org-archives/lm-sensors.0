From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Mar 2006 17:11:11 +0000
Subject: [lm-sensors] [PATCH 2.6.16-mm1 2/3] rtc: m41t00 driver cleanup
Message-Id: <20060327191111.f7b057cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012137.GD9560@mag.az.mvista.com>
In-Reply-To: <20060324012137.GD9560@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Mark,

> This patch does some cleanup to the m41t00 i2c/rtc driver including:
> - use BCD2BIN/BIN2BCD instead of BCD_TO_BIN/BIN_TO_BCD
> - use strlcpy instead of strncpy
> - some whitespace cleanup

Looks overall good, except:

> @@ -214,6 +208,7 @@ m41t00_detach(struct i2c_client *client)
>  
>  static struct i2c_driver m41t00_driver = {
>  	.driver = {
> +		.owner	= THIS_MODULE,
>  		.name	= M41T00_DRV_NAME,
>  	},
>  	.id		= I2C_DRIVERID_STM41T00,

i2c_add_driver sets the owner for you, so it was omitted here on
purpose.

I'll drop that change before pushing the patch to Greg, no need to
resend.

Thanks,
-- 
Jean Delvare

