From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:11:25 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop meaningless use of I2C_DF_NOTIFY in
Message-Id: <11305336602705@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop meaningless use of I2C_DF_NOTIFY in i2c_client structures

I2C_DF_NOTIFY is an i2c_driver flag, using it as an i2c_client flag
doesn't make any sense.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 00bffb6e29c5ef12cea7904905f8b959187076c9
tree 76da2f90a3ae3bd697cfbe8d7be358e9892b4f89
parent 6c129be8c7bd1bdbd47ba8e17f6e5053ef04aee8
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:19:52 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:10 -0700

 drivers/i2c/chips/ds1374.c  |    1 -
 drivers/i2c/chips/m41t00.c  |    1 -
 drivers/i2c/chips/rtc8564.c |    2 +-
 3 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
index 0936327..ec640e9 100644
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -199,7 +199,6 @@ static int ds1374_probe(struct i2c_adapt
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, DS1374_DRV_NAME, I2C_NAME_SIZE);
-	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 3f14528..554f7ba 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -180,7 +180,6 @@ m41t00_probe(struct i2c_adapter *adap, i
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &m41t00_driver;
diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index 0b5385c..dd9d42d 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -158,7 +158,7 @@ static int rtc8564_attach(struct i2c_ada
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
 	i2c_set_clientdata(new_client, d);
-	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
+	new_client->flags = I2C_CLIENT_ALLOW_USE;
 	new_client->addr = addr;
 	new_client->adapter = adap;
 	new_client->driver = &rtc8564_driver;

