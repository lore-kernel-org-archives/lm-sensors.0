From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Fri, 03 Feb 2006 08:51:35 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060203085134.GB13841@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Jean Delvare wrote:
> Given that all block transfers you do are standard I2C block transfers,
> you may consider switching to i2c_smbus_{read,write}_i2c_block_data for
> SMBus compatibility. This would also make your code more simple, I
> think.
I don't understand how I specify the length of the block to be read for
i2c_smbus_read_i2c_block_data.  And i2c_smbus_xfer_emulated looks to me
as if it were not possible to use it when my adapter doesn't have
algo->smbus_xfer.

Any hints?

Best regards
Uwe

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

