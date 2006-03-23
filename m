From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:52 +0000
Subject: [lm-sensors] [PATCH 35/36] I2C: hwmon: Rename register parameters
Message-Id: <11431538322701-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"register" is a reserved keyword so using it as a parameter name
can confuse some compilers, most notably ICC.

The patch below just renames all occurences to reg which fits the actual
function declarations.

Signed-off-by: Darren Jenkins <darrenrjenkins at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

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

f6c27fc17c5e575c5471fb344bdbd5f5f6072136
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 8646ec1..6d4f8b8 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -299,9 +299,8 @@ static int adm1026_attach_adapter(struct
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
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 758978e..6dc4846 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -90,8 +90,8 @@ static int fscpos_attach_adapter(struct 
 static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind);
 static int fscpos_detach_client(struct i2c_client *client);
 
-static int fscpos_read_value(struct i2c_client *client, u8 register);
-static int fscpos_write_value(struct i2c_client *client, u8 register, u8 value);
+static int fscpos_read_value(struct i2c_client *client, u8 reg);
+static int fscpos_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct fscpos_data *fscpos_update_device(struct device *dev);
 static void fscpos_init_client(struct i2c_client *client);
 
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 122ff9c..06df92b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -225,9 +225,8 @@ static int it87_isa_attach_adapter(struc
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
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 36d1192..94be3d7 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -158,8 +158,8 @@ static int lm78_isa_attach_adapter(struc
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind);
 static int lm78_detach_client(struct i2c_client *client);
 
-static int lm78_read_value(struct i2c_client *client, u8 register);
-static int lm78_write_value(struct i2c_client *client, u8 register, u8 value);
+static int lm78_read_value(struct i2c_client *client, u8 reg);
+static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct lm78_data *lm78_update_device(struct device *dev);
 static void lm78_init_client(struct i2c_client *client);
 
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 095e58a..342e966 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -374,8 +374,8 @@ static int lm85_detect(struct i2c_adapte
 			int kind);
 static int lm85_detach_client(struct i2c_client *client);
 
-static int lm85_read_value(struct i2c_client *client, u8 register);
-static int lm85_write_value(struct i2c_client *client, u8 register, int value);
+static int lm85_read_value(struct i2c_client *client, u8 reg);
+static int lm85_write_value(struct i2c_client *client, u8 reg, int value);
 static struct lm85_data *lm85_update_device(struct device *dev);
 static void lm85_init_client(struct i2c_client *client);
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 4db0dd8..6f3fda7 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -193,8 +193,8 @@ static struct pci_dev *s_bridge;	/* poin
 static int sis5595_detect(struct i2c_adapter *adapter);
 static int sis5595_detach_client(struct i2c_client *client);
 
-static int sis5595_read_value(struct i2c_client *client, u8 register);
-static int sis5595_write_value(struct i2c_client *client, u8 register, u8 value);
+static int sis5595_read_value(struct i2c_client *client, u8 reg);
+static int sis5595_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct sis5595_data *sis5595_update_device(struct device *dev);
 static void sis5595_init_client(struct i2c_client *client);
 
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 992e344..71fb7f1 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -332,9 +332,8 @@ struct w83627hf_data {
 static int w83627hf_detect(struct i2c_adapter *adapter);
 static int w83627hf_detach_client(struct i2c_client *client);
 
-static int w83627hf_read_value(struct i2c_client *client, u16 register);
-static int w83627hf_write_value(struct i2c_client *client, u16 register,
-			       u16 value);
+static int w83627hf_read_value(struct i2c_client *client, u16 reg);
+static int w83627hf_write_value(struct i2c_client *client, u16 reg, u16 value);
 static struct w83627hf_data *w83627hf_update_device(struct device *dev);
 static void w83627hf_init_client(struct i2c_client *client);
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 8b17132..e4c7003 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -272,9 +272,8 @@ static int w83781d_isa_attach_adapter(st
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
1.2.4



