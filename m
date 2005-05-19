From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH] I2C update for 2.6.7-rc1
Message-Id: <10857816433297@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1085781643100@kroah.com>
References: <1085781643100@kroah.com>
In-Reply-To: <1085781643100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1717.6.24, 2004/05/19 00:25:14-07:00, khali@linux-fr.org

[PATCH] I2C: Incomplete AT24RF08 corruption prevention in i2c eeprom

The AT24RF08 corruption prevention trick that is found in the i2c eeprom
driver is not correct. The prevention is activated only conditionally,
while it should be done all the time.


 drivers/i2c/chips/eeprom.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Fri May 28 14:52:32 2004
+++ b/drivers/i2c/chips/eeprom.c	Fri May 28 14:52:32 2004
@@ -203,11 +203,12 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
+	/* prevent 24RF08 corruption */
+	i2c_smbus_write_quick(new_client, 0);
+
 	/* Now, we do the remaining detection. It is not there, unless you force
 	   the checksum to work out. */
 	if (checksum) {
-		/* prevent 24RF08 corruption */
-		i2c_smbus_write_quick(new_client, 0);
 		cs = 0;
 		for (i = 0; i <= 0x3e; i++)
 			cs += i2c_smbus_read_byte_data(new_client, i);

