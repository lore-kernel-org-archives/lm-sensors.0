From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <20030924180407.GE10443@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 23, 2003 at 06:45:36PM -0700, Philip Pokorny wrote:
> In the following loop:
> 
> + for (i=0; i < EEPROM_SIZE; i += I2C_SMBUS_I2C_BLOCK_MAX)
> +	if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != 
> I2C_SMBUS_I2C_BLOCK_MAX)
> 
> Is it possible that EEPROM_SIZE might not be a multiple of the SMBus 
> block size?  Is there a way to read less than a full block of data other 
> than a byte at a time?

Probably, I left this alone from what used to be in the cvs tree.  Now
it looks like it's been changed.

> Should EEPROM_SIZE be configurable?  Or is the limitation that addresses 
> must be a single byte?  I recall that being a problem when I wanted to 
> address the EEPROM memory included in one of the monitoring chip drivers 
> I wrote.

I thought I remembered some mention of different sized eeproms.  And
yes, it could be made configurable if people need that in the future.

thanks for taking a look at it.

greg k-h
