From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030715182821.6020a140.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Here's the driver.

OK, I took a look. Overall it's great, but some things would need to be
fixed:

1* We do not support old kernels. Thus:

  #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \
      (LINUX_VERSION_CODE = KERNEL_VERSION(2,3,0))
  #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
  #endif

is unnecessary. Did you find such code in one of our drivers?

2* According to the datasheet, the SAA1064 has four possible I2C
addresses, ranging from 0x38 to 0x3b. So, you will want to replace:

  static unsigned short normal_i2c[] = { 0x38, 0x3b, SENSORS_I2C_END };
  static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };

with:

  static unsigned short normal_i2c[] = { SENSORS_I2C_END };
  static unsigned short normal_i2c_range[] = { 0x38, 0x3b,
SENSORS_I2C_END };

3* Use hexa where it makes more sense than decimal. For example,

  #define SAA1064_INIT 127

would better be written:

  #define SAA1064_INIT 0x7f

because it really is a bitfield.

4* Use C99 style struct initializers. The following:

  static struct i2c_driver saa1064_driver = {
	/* name */ "SAA1064 sensor chip driver",
	/* id */ I2C_DRIVERID_SAA1064,
	/* flags */ I2C_DF_NOTIFY,
	/* attach_adapter */ &saa1064_attach_adapter,
	/* detach_client */ &saa1064_detach_client,
	/* command */ &saa1064_command,
	/* inc_use */ &saa1064_inc_use,
	/* dec_use */ &saa1064_dec_use
  };

should be:

  static struct i2c_driver saa1064_driver = {
	.name           = "SAA1064 sensor chip driver",
	.id             = I2C_DRIVERID_SAA1064,
	.flags          = I2C_DF_NOTIFY,
	.attach_adapter = &saa1064_attach_adapter,
	.detach_client  = &saa1064_detach_client,
	.command        = &saa1064_command,
	.inc_use        = &saa1064_inc_use,
	.dec_use        = &saa1064_dec_use
  };


Now, more important: is it working OK, at least for you? :)


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
