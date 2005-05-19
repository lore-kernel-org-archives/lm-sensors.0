From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <3F70F740.8040202@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the following loop:

+ for (i=0; i < EEPROM_SIZE; i += I2C_SMBUS_I2C_BLOCK_MAX)
+	if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != 
I2C_SMBUS_I2C_BLOCK_MAX)

Is it possible that EEPROM_SIZE might not be a multiple of the SMBus 
block size?  Is there a way to read less than a full block of data other 
than a byte at a time?

Should EEPROM_SIZE be configurable?  Or is the limitation that addresses 
must be a single byte?  I recall that being a problem when I wanted to 
address the EEPROM memory included in one of the monitoring chip drivers 
I wrote.

:v)

Greg KH wrote:
> Ok, I finally got the sysfs binary file interface hooked up to the
> eeprom driver in 2.6.  Turned out to be easier than I thought.  Below is
> the patch that I'll be sending to Linus in a bit.  If anyone has any
> comments on it, I'd appreciate it.
> 
> thanks,
> 
> greg k-h
> 
> p.s. I added the Viao check too :)
> 
> # I2C: add eeprom i2c chip driver.
> #
> # This is based on the i2c cvs driver, but ported to 2.6 and rewritten
> # to use the sysfs binary file interface.



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
