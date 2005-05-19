From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 1/3
Message-Id: <20050504061313.GB1439@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique> <20050502204136.GE32713@kroah.com>
In-Reply-To: <20050502204136.GE32713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

Greg,

thanks for applying changes. Here is next batch of incremental
patches for ds1337. These were created against 2.6.12-rc2 patched with
ds1337 [123]/4. Changes were discussed with James Chapman privately
and he sent me his Signed-off-by line for submition.


Make time format consistent with other RTC drivers.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-13 11:48:32.000000000 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-18 09:22:45.531771744 +0200
@@ -130,8 +130,8 @@ static int ds1337_get_datetime(struct i2
 		dt->tm_wday = BCD2BIN(buf[3]) - 1;
 		dt->tm_mday = BCD2BIN(buf[4]);
 		val = buf[5] & 0x7f;
-		dt->tm_mon = BCD2BIN(val);
-		dt->tm_year = 1900 + BCD2BIN(buf[6]);
+		dt->tm_mon = BCD2BIN(val) - 1;
+		dt->tm_year = BCD2BIN(buf[6]);
 		if (buf[5] & 0x80)
 			dt->tm_year += 100;
 
@@ -171,12 +171,11 @@ static int ds1337_set_datetime(struct i2
 	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
 	buf[4] = BIN2BCD(dt->tm_wday) + 1;
 	buf[5] = BIN2BCD(dt->tm_mday);
-	buf[6] = BIN2BCD(dt->tm_mon);
-	if (dt->tm_year >= 2000) {
-		val = dt->tm_year - 2000;
+	buf[6] = BIN2BCD(dt->tm_mon) + 1;
+	val = dt->tm_year;
+	if (val >= 100) {
+		val -= 100;
 		buf[6] |= (1 << 7);
-	} else {
-		val = dt->tm_year - 1900;
 	}
 	buf[7] = BIN2BCD(val);
 
