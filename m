From: corentin.labbe@geomatys.fr (corentin.labbe)
Date: Sun, 11 Feb 2007 15:44:08 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <45CF39C8.3020301@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

i saw some problems in your code:

On line 141 you excess the 80 characters width
+ static ssize_t get_fan(struct device *dev, struct device_attribute *devattr, char *buf, int nr)


On the comment you have written "MAX6650 also" instead of "MAX6551 also"
  * This module has only been tested with the MAX6650 chip. It should
  * work with the MAX6650 also, though with reduced functionality. It
  * does not distinguish max6650 and max6651 chips.


You must use dev_dbg instead of #ifdef debug


On line 535 the while(0) is useless
erase the max6650_init_client function
+static void max6650_init_client(struct i2c_client *client)
+{
+	/* Nothing to do here - assume the BIOS has initialized the chip */
+	while(0)
+	{
+		;
+	}
+}


Don't use down() up()
replace with mutex

On line 553
	MAX6650_REG_TACH0, MAX6650_REG_TACH1,
	MAX6650_REG_TACH2, MAX6650_REG_TACH3
	one per line
	"," at the end
like
static const u8 tach_reg[] {
	MAX6650_REG_TACH0,
	MAX6650_REG_TACH1,
	MAX6650_REG_TACH2,
	MAX6650_REG_TACH3,
};

	
Why use max6650_read_value and max6650_write_value?
replace with i2c_smbus_write_byte_data and i2c_smbus_read_byte_data directly

Check error return code of i2c_detach_client(client);
like
if ((err = i2c_detach_client(client)))
	return err;


Don't use many device_create_file
use sysfs_create_group


