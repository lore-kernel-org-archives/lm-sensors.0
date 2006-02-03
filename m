From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Feb 2006 09:16:42 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060203101642.167cb18c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Uwe,

> Jean Delvare wrote:
> > Given that all block transfers you do are standard I2C block transfers,
> > you may consider switching to i2c_smbus_{read,write}_i2c_block_data for
> > SMBus compatibility. This would also make your code more simple, I
> > think.
>
> I don't understand how I specify the length of the block to be read for
> i2c_smbus_read_i2c_block_data.

Oops. This is a bug (or at least lack of fundamental feature) in the
current implementation of i2c_smbus_read_i2c_block_data. I want to fix
it for some times now but always postponed it due to the compatibility
issues it raises :(

So there is no way you can use i2c_smbus_read_i2c_block_data in your
driver at the moment; stick to i2c_transfer for now.

> (...) And i2c_smbus_xfer_emulated looks to me 
> as if it were not possible to use it when my adapter doesn't have
> algo->smbus_xfer.

Not correct. The i2c-core is able to emulate algo->smbus_xfer using
algo->master_xfer. See i2c_smbus_xfer() in i2c-core.c for the test, and
i2c_smbus_xfer_emulated() for the implementation.

-- 
Jean Delvare

