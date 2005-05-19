From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499274992999@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10499274993729@kroah.com>
References: <10499274993464@kroah.com>
In-Reply-To: <10499274993464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1033.3.3, 2003/04/07 09:38:53-07:00, greg@kroah.com

i2c: fix up via686a.c driver based on previous i2c api changes.


 drivers/i2c/chips/via686a.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr  9 15:16:40 2003
+++ b/drivers/i2c/chips/via686a.c	Wed Apr  9 15:16:40 2003
@@ -390,8 +390,7 @@
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
 static int via686a_detach_client(struct i2c_client *client);
 
 static inline int via686a_read_value(struct i2c_client *client, u8 reg)
@@ -665,8 +664,7 @@
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-		   unsigned short flags, int kind)
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct via686a_data *data;

