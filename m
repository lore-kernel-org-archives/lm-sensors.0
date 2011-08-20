From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Aug 2011 12:57:26 +0000
Subject: [lm-sensors] [PATCH v2 2/3] hwmon: (ibmaem) Make instance
Message-Id: <20110820145726.06122125@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is no good reason that I can see why the failure to initialize
one instance should prevent other instances from being initialized.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/ibmaem.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- linux-3.1-rc2.orig/drivers/hwmon/ibmaem.c	2011-08-20 10:17:55.000000000 +0200
+++ linux-3.1-rc2/drivers/hwmon/ibmaem.c	2011-08-20 10:19:24.000000000 +0200
@@ -246,8 +246,6 @@ static void aem_bmc_gone(int iface);
 static void aem_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
 
 static void aem_remove_sensors(struct aem_data *data);
-static int aem_init_aem1(struct aem_ipmi_data *probe);
-static int aem_init_aem2(struct aem_ipmi_data *probe);
 static int aem1_find_sensors(struct aem_data *data);
 static int aem2_find_sensors(struct aem_data *data);
 static void update_aem1_sensors(struct aem_data *data);
@@ -648,7 +646,7 @@ id_err:
 }
 
 /* Find and initialize all AEM1 instances */
-static int aem_init_aem1(struct aem_ipmi_data *probe)
+static void aem_init_aem1(struct aem_ipmi_data *probe)
 {
 	int num, i, err;
 
@@ -659,11 +657,8 @@ static int aem_init_aem1(struct aem_ipmi
 			dev_err(probe->bmc_device,
 				"Error %d initializing AEM1 0x%X\n",
 				err, i);
-			return err;
 		}
 	}
-
-	return 0;
 }
 
 /* Probe functions for AEM2 devices */
@@ -783,7 +778,7 @@ id_err:
 }
 
 /* Find and initialize all AEM2 instances */
-static int aem_init_aem2(struct aem_ipmi_data *probe)
+static void aem_init_aem2(struct aem_ipmi_data *probe)
 {
 	struct aem_find_instance_resp fi_resp;
 	int err;
@@ -802,12 +797,9 @@ static int aem_init_aem2(struct aem_ipmi
 			dev_err(probe->bmc_device,
 				"Error %d initializing AEM2 0x%X\n",
 				err, fi_resp.module_handle);
-			return err;
 		}
 		i++;
 	}
-
-	return 0;
 }
 
 /* Probe a BMC for AEM firmware instances */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
