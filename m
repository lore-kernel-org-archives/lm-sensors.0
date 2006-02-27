From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 22:14:58 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: Rename register parameters
Message-Id: <20060227231458.1870d756.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Darren Jenkins <darrenrjenkins at gmail.com>
Content-Disposition: inline; filename=hwmon-rename-register-parameters.patch

"register" is a reserved keyword so using it as a parameter name
can confuse some compilers, most notably ICC.

The patch below just renames all occurences to reg which fits the actual
function declarations.

Signed-off-by: Darren Jenkins <darrenrjenkins at gmail.com>
---
 drivers/hwmon/adm1026.c  |    5 ++---
 drivers/hwmon/fscpos.c   |    4 ++--
 drivers/hwmon/it87.c     |    5 ++---
 drivers/hwmon/lm78.c     |    4 ++--
 drivers/hwmon/lm85.c     |    4 ++--
 drivers/hwmon/sis5595.c  |    4 ++--
 drivers/hwmon/w83627hf.c |    5 ++---
 drivers/hwmon/w83781d.c  |    5 ++---
 8 files changed, 16 insertions(+), 20 deletions(-)

--- linux-2.6.16-rc4.orig/drivers/hwmon/adm1026.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/adm1026.c	2006-02-19 19:20:17.000000000 +0100
@@ -299,9 +299,8 @@
 static int adm1026_detect(struct i2c_adapter *adapter, int address,
 	int kind);
 static int adm1026_detach_client(struct i2c_client *client);
-static int adm1026_read_value(struct i2c_client *client, u8 register);
-static int adm1026_write_value(struct i2c_client *client, u8 register,
-	int value); 
+static int adm1026_read_value(struct i2c_client *client, u8 reg);
+static int adm1026_write_value(struct i2c_client *client, u8 reg, int value);
 static void adm1026_print_gpio(struct i2c_client *client);
 static void adm1026_fixup_gpio(struct i2c_client *client); 
 static struct adm1026_data *adm1026_update_device(struct device *dev);
--- linux-2.6.16-rc4.orig/drivers/hwmon/fscpos.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/fscpos.c	2006-02-19 19:02:40.000000000 +0100
@@ -90,8 +90,8 @@
 static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscpos_detach_client(struct i2c_client *client);
 
-static int fscpos_read_value(struct i2c_client *client, u8 register);
-static int fscpos_write_value(struct i2c_client *client, u8 register, u8 value);
+static int fscpos_read_value(struct i2c_client *client, u8 reg);
+static int fscpos_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct fscpos_data *fscpos_update_device(struct device *dev);
 static void fscpos_init_client(struct i2c_client *client);
 
--- linux-2.6.16-rc4.orig/drivers/hwmon/it87.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/it87.c	2006-02-19 19:20:11.000000000 +0100
@@ -225,9 +225,8 @@
 static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
 static int it87_detach_client(struct i2c_client *client);
 
-static int it87_read_value(struct i2c_client *client, u8 register);
-static int it87_write_value(struct i2c_client *client, u8 register,
-			u8 value);
+static int it87_read_value(struct i2c_client *client, u8 reg);
+static int it87_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct it87_data *it87_update_device(struct device *dev);
 static int it87_check_pwm(struct i2c_client *client);
 static void it87_init_client(struct i2c_client *client, struct it87_data *data);
--- linux-2.6.16-rc4.orig/drivers/hwmon/lm78.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/lm78.c	2006-02-19 19:03:00.000000000 +0100
@@ -158,8 +158,8 @@
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm78_detach_client(struct i2c_client *client);
 
-static int lm78_read_value(struct i2c_client *client, u8 register);
-static int lm78_write_value(struct i2c_client *client, u8 register, u8 value);
+static int lm78_read_value(struct i2c_client *client, u8 reg);
+static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct lm78_data *lm78_update_device(struct device *dev);
 static void lm78_init_client(struct i2c_client *client);
 
--- linux-2.6.16-rc4.orig/drivers/hwmon/lm85.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/lm85.c	2006-02-19 19:03:00.000000000 +0100
@@ -374,8 +374,8 @@
 			int kind);
 static int lm85_detach_client(struct i2c_client *client);
 
-static int lm85_read_value(struct i2c_client *client, u8 register);
-static int lm85_write_value(struct i2c_client *client, u8 register, int value);
+static int lm85_read_value(struct i2c_client *client, u8 reg);
+static int lm85_write_value(struct i2c_client *client, u8 reg, int value);
 static struct lm85_data *lm85_update_device(struct device *dev);
 static void lm85_init_client(struct i2c_client *client);
 
--- linux-2.6.16-rc4.orig/drivers/hwmon/sis5595.c	2006-02-18 17:16:17.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/sis5595.c	2006-02-19 19:03:00.000000000 +0100
@@ -193,8 +193,8 @@
 static int sis5595_detect(struct i2c_adapter *adapter);
 static int sis5595_detach_client(struct i2c_client *client);
 
-static int sis5595_read_value(struct i2c_client *client, u8 register);
-static int sis5595_write_value(struct i2c_client *client, u8 register, u8 value);
+static int sis5595_read_value(struct i2c_client *client, u8 reg);
+static int sis5595_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct sis5595_data *sis5595_update_device(struct device *dev);
 static void sis5595_init_client(struct i2c_client *client);
 
--- linux-2.6.16-rc4.orig/drivers/hwmon/w83627hf.c	2006-02-18 17:16:17.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/w83627hf.c	2006-02-19 19:19:47.000000000 +0100
@@ -332,9 +332,8 @@
 static int w83627hf_detect(struct i2c_adapter *adapter);
 static int w83627hf_detach_client(struct i2c_client *client);
 
-static int w83627hf_read_value(struct i2c_client *client, u16 register);
-static int w83627hf_write_value(struct i2c_client *client, u16 register,
-			       u16 value);
+static int w83627hf_read_value(struct i2c_client *client, u16 reg);
+static int w83627hf_write_value(struct i2c_client *client, u16 reg, u16 value);
 static struct w83627hf_data *w83627hf_update_device(struct device *dev);
 static void w83627hf_init_client(struct i2c_client *client);
 
--- linux-2.6.16-rc4.orig/drivers/hwmon/w83781d.c	2006-02-19 09:40:51.000000000 +0100
+++ linux-2.6.16-rc4/drivers/hwmon/w83781d.c	2006-02-19 19:19:35.000000000 +0100
@@ -272,9 +272,8 @@
 static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
-static int w83781d_read_value(struct i2c_client *client, u16 register);
-static int w83781d_write_value(struct i2c_client *client, u16 register,
-			       u16 value);
+static int w83781d_read_value(struct i2c_client *client, u16 reg);
+static int w83781d_write_value(struct i2c_client *client, u16 reg, u16 value);
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_client(struct i2c_client *client);
 

-- 
Jean Delvare

