From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Fri, 03 Feb 2006 09:43:50 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060203094350.GA13665@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Jean,

> > (...) And i2c_smbus_xfer_emulated looks to me 
> > as if it were not possible to use it when my adapter doesn't have
> > algo->smbus_xfer.
> 
> Not correct. The i2c-core is able to emulate algo->smbus_xfer using
> algo->master_xfer. See i2c_smbus_xfer() in i2c-core.c for the test, and
> i2c_smbus_xfer_emulated() for the implementation.
I checked that, but my short-term memory played a joke on me.  When
calling i2c_smbus_read_i2c_block_data(...), i2c_smbus_xfer_emulated is
called with size = I2C_SMBUS_I2C_BLOCK_DATA, not I2C_SMBUS_BLOCK_DATA.
If it were I2C_SMBUS_BLOCK_DATA (together with read_write =
I2C_SMBUS_READ) it would fail.

OK, so you're right once more ...

Uwe

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

