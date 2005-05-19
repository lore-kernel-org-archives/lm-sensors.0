From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c versioning
Message-Id: <3C043305.233767D@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok gang,
we now have rudimentary versioning in i2c.
i2c.h contains:
	
	#define I2C_DATE "20011118"
	#define I2C_VERSION "2.6.2"

now how am I supposed to use this in an ifdef?

I want to add block read capability to eeprom,
but only if it's supported in i2c.

So i need
#if I2C_VERSION > 2.6.2
i2c_smbus_i2c_block_read_data(...)
#else
regular read...
#endif

but of course that doesn't work because I2C_VERSION is a string.

Do we need something better, like three integers MAJOR, MINOR, whatever
like the kernel has?
Or can I do it somehow with strings?

#ifdef I2C_VERSION
#if I2C_VERSION[0] * 100 + I2C_VERSION[2] * 10 + I2C_VERSION[4] > 262
...
#endif
#endif
