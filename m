From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:40 +0000
Subject: [lm-sensors] [PATCH] I2C: Centralize 24RF08 corruption prevention
Message-Id: <11259567693076@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Centralize 24RF08 corruption prevention

The 24RF08 corruption would better be prevented at i2c-core level than
at chip driver level, for several reasons:
* The second quick write should happen as soon as possible after the
  first one, so as to limit the risk that another command is issued on
  the bus inbetween, causing the corruption.
* As a matter of fact, the protection code at driver level was reworked
  at least three times already, which proves how hard it is to get it
  right there, while it's straightforward at i2c-core level.
* It's easy to add a new driver that would need the protection, and
  forget to add it. This did happen already.
* As additional probing addresses can be passed to most i2c chip drivers
  as module parameters, virtually every i2c chip driver would need the
  protection if we want to be really safe.
* Why duplicate code when we can easily avoid it?

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4c9337da37c877e53a64696fc8524f642d446cba
tree 30f34691bd61b55b11ec19f6fbc27ae69886eff8
parent a89ba0bc02e82920a0f4137aa5d655ac0366cc28
author Jean Delvare <khali@linux-fr.org> Tue, 09 Aug 2005 20:28:10 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:25 -0700

 Documentation/i2c/porting-clients |    2 ++
 drivers/i2c/chips/eeprom.c        |    5 -----
 drivers/i2c/chips/max6875.c       |    5 -----
 drivers/i2c/i2c-core.c            |   13 ++++++++++---
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -90,6 +90,8 @@ Technical changes:
   device_create_file. Move the driver initialization before any
   sysfs file creation.
   Drop client->id.
+  Drop any 24RF08 corruption prevention you find, as this is now done
+  at the i2c-core level, and doing it twice voids it.
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -161,11 +161,6 @@ int eeprom_detect(struct i2c_adapter *ad
 	struct eeprom_data *data;
 	int err = 0;
 
-	/* prevent 24RF08 corruption */
-	if (kind < 0)
-		i2c_smbus_xfer(adapter, address, 0, 0, 0,
-			       I2C_SMBUS_QUICK, NULL);
-
 	/* There are three ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
 	   (2) Consecutive byte reads (100% overhead)
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -171,11 +171,6 @@ static int max6875_detect(struct i2c_ada
 	struct max6875_data *data;
 	int err = 0;
 
-	/* Prevent 24rf08 corruption (in case of user error) */
-	if (kind < 0)
-		i2c_smbus_xfer(adapter, address, 0, 0, 0,
-			       I2C_SMBUS_QUICK, NULL);
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_BYTE))
 		return 0;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -679,9 +679,16 @@ static int i2c_probe_address(struct i2c_
 		return 0;
 
 	/* Make sure there is something at this address, unless forced */
-	if (kind < 0
-	 && i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
-		return 0;
+	if (kind < 0) {
+		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				   I2C_SMBUS_QUICK, NULL) < 0)
+			return 0;
+
+		/* prevent 24RF08 corruption */
+		if ((addr & ~0x0f) = 0x50)
+			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
+				       I2C_SMBUS_QUICK, NULL);
+	}
 
 	/* Finally call the custom detection function */
 	err = found_proc(adapter, addr, kind);

