From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [PATCH] i2c driver changes for 2.5.68
Message-Id: <1051228746126@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1051228746305@kroah.com>
References: <10512287461373@kroah.com>
In-Reply-To: <10512287461373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1179.3.8, 2003/04/24 11:14:04-07:00, greg@kroah.com

[PATCH] i2c: fix up the media drivers due to removing flags paramater of callback function


 drivers/media/video/msp3400.c    |    6 ++----
 drivers/media/video/saa5249.c    |    2 +-
 drivers/media/video/saa7111.c    |    2 +-
 drivers/media/video/tda7432.c    |    3 +--
 drivers/media/video/tda9840.c    |    2 +-
 drivers/media/video/tda9875.c    |    3 +--
 drivers/media/video/tda9887.c    |    3 +--
 drivers/media/video/tea6415c.c   |    2 +-
 drivers/media/video/tea6420.c    |    2 +-
 drivers/media/video/tuner-3036.c |    3 +--
 drivers/media/video/tuner.c      |    3 +--
 drivers/media/video/tvaudio.c    |    3 +--
 12 files changed, 13 insertions(+), 21 deletions(-)


diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/msp3400.c	Thu Apr 24 16:46:31 2003
@@ -1208,8 +1208,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int msp_attach(struct i2c_adapter *adap, int addr,
-		      unsigned short flags, int kind);
+static int msp_attach(struct i2c_adapter *adap, int addr, int kind);
 static int msp_detach(struct i2c_client *client);
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
@@ -1233,8 +1232,7 @@
 	},
 };
 
-static int msp_attach(struct i2c_adapter *adap, int addr,
-		      unsigned short flags, int kind)
+static int msp_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp;
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/saa5249.c	Thu Apr 24 16:46:31 2003
@@ -149,7 +149,7 @@
 
 static struct i2c_client client_template;
 
-static int saa5249_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)		
+static int saa5249_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	int pgbuf;
 	int err;
diff -Nru a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/saa7111.c	Thu Apr 24 16:46:31 2003
@@ -66,7 +66,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-static int saa7111_attach(struct i2c_adapter *adap, int addr, unsigned short flags, int kind)
+static int saa7111_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	int i;
 	struct saa7111 *decoder;
diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tda7432.c	Thu Apr 24 16:46:31 2003
@@ -312,8 +312,7 @@
  * i2c interface functions *
  * *********************** */
 
-static int tda7432_attach(struct i2c_adapter *adap, int addr,
-			  unsigned short flags, int kind)
+static int tda7432_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tda7432 *t;
 	struct i2c_client *client;
diff -Nru a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
--- a/drivers/media/video/tda9840.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tda9840.c	Thu Apr 24 16:46:31 2003
@@ -178,7 +178,7 @@
 	return 0;
 }
 
-static int tda9840_detect(struct i2c_adapter *adapter, int address, unsigned short flags, int kind)
+static int tda9840_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct	i2c_client *client;
 	int result = 0;
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tda9875.c	Thu Apr 24 16:46:31 2003
@@ -240,8 +240,7 @@
 	return(0);
 }
 
-static int tda9875_attach(struct i2c_adapter *adap, int addr,
-			  unsigned short flags, int kind)
+static int tda9875_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tda9875 *t;
 	struct i2c_client *client;
diff -Nru a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tda9887.c	Thu Apr 24 16:46:31 2003
@@ -345,8 +345,7 @@
 
 /* ---------------------------------------------------------------------- */
 
-static int tda9887_attach(struct i2c_adapter *adap, int addr,
-			  unsigned short flags, int kind)
+static int tda9887_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tda9887 *t;
 
diff -Nru a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
--- a/drivers/media/video/tea6415c.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tea6415c.c	Thu Apr 24 16:46:31 2003
@@ -55,7 +55,7 @@
 static int tea6415c_id = 0;
 
 /* this function is called by i2c_probe */
-static int tea6415c_detect(struct i2c_adapter *adapter, int address, unsigned short flags, int kind)
+static int tea6415c_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct	i2c_client *client = 0;
 	int err = 0;
diff -Nru a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
--- a/drivers/media/video/tea6420.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tea6420.c	Thu Apr 24 16:46:31 2003
@@ -95,7 +95,7 @@
 }
 
 /* this function is called by i2c_probe */
-static int tea6420_detect(struct i2c_adapter *adapter, int address, unsigned short flags, int kind)
+static int tea6420_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct	i2c_client *client;
 	int err = 0, i = 0;
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tuner-3036.c	Thu Apr 24 16:46:31 2003
@@ -114,8 +114,7 @@
 /* ---------------------------------------------------------------------- */
 
 static int 
-tuner_attach(struct i2c_adapter *adap, int addr,
-	     unsigned short flags, int kind)
+tuner_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	static unsigned char buffer[] = { 0x29, 0x32, 0x2a, 0, 0x2b, 0 };
 
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tuner.c	Thu Apr 24 16:46:31 2003
@@ -776,8 +776,7 @@
 
 /* ---------------------------------------------------------------------- */
 
-static int tuner_attach(struct i2c_adapter *adap, int addr,
-			unsigned short flags, int kind)
+static int tuner_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tuner *t;
 	struct i2c_client *client;
diff -Nru a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c	Thu Apr 24 16:46:31 2003
+++ b/drivers/media/video/tvaudio.c	Thu Apr 24 16:46:31 2003
@@ -1326,8 +1326,7 @@
 /* ---------------------------------------------------------------------- */
 /* i2c registration                                                       */
 
-static int chip_attach(struct i2c_adapter *adap, int addr,
-		       unsigned short flags, int kind)
+static int chip_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;

