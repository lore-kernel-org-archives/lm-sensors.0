From: charles.grant@psware.com (Charles Grant)
Date: Sat, 27 Jan 2007 00:27:42 +0000
Subject: [lm-sensors] [PATCH] bmcsensors / get device ID
Message-Id: <002c01c741a9$f56899e0$8101a8c0@PERF.PERFORMANCESOFTWARE>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's a patch I made to get bmcsensors working on our dual-core Xeon ATCA
carrier (Kontron 8020).  

I modified the code to send an initial "get device ID" command to determine
which commands should be used subsequently to retrieve SDR data (this code
was taken directly from ipmitool).


--- old/bmcsensors.c	2007-01-10 11:13:47.353446400 -0700
+++ new/bmcsensors.c	2007-01-26 16:07:26.296806900 -0700
@@ -163,9 +163,16 @@
 /* Network Function Codes */
 #define IPMI_NETFN_SENSOR	0x04
+#define IPMI_NETFN_APP		0x06
 #define IPMI_NETFN_STORAGE	0x0A
 /* Commands */
+#define IPMI_GET_DEVICE_ID	0x01
+#define IPMI_GET_DEVICE_SDR	0x21
 #define IPMI_RESERVE_SDR		0x22
 #define IPMI_GET_SDR		0x23
 #define IPMI_GET_SENSOR_STATE_READING		0x2D
+/* Completion codes */
+#define IPMI_CC_NORMAL	0x00
+#define IPMI_CC_CANT_RETURN_NUMBER_BYTES_REQ	0xCA
+#define IPMI_CC_CANT_PROVIDE_RESP 0xCE
 
 /* SDR defs */
@@ -187,4 +194,24 @@
 /* ... YJ */
 /************************************/
+static int use_built_in;	/* Uses DeviceSDRs instead of SDRR */
+/* 
+ * Response data from IPM Get Device ID Command (IPMI rev 1.5, section
17.1)
+ * The following really apply to any IPM device, not just BMCs...
+ */
+struct ipm_devid_rsp {
+	uint8_t device_id;
+	uint8_t device_revision;
+	uint8_t fw_rev1;
+	uint8_t fw_rev2;
+	uint8_t ipmi_version;
+	uint8_t adtl_device_support;
+	uint8_t manufacturer_id[3];
+	uint8_t product_id[2];
+	uint8_t aux_fw_rev[4];
+} __attribute__ ((packed));
+
+#define IPM_DEV_DEVICE_ID_SDR_MASK     (0x80)	/* 1 = provides SDRs      */
+#define IPM_DEV_DEVICE_ID_REV_MASK     (0x07)	/* BCD-enoded             */
+
 
 /* unpack based on string type, convert to normal, null terminate */
@@ -639,7 +666,29 @@
 static void bmcsensors_rcv_msg(struct ipmi_msg *msg)
 {
+	struct ipm_devid_rsp *devid;
 
 	switch(state) {
 		case STATE_INIT:
+#ifdef DEBUG
+		    printk(KERN_DEBUG "bmcsensors.o: Got init response\n");
+#endif
+			devid = (struct ipm_devid_rsp *)&msg->data[1];
+			if (devid->device_revision &
IPM_DEV_DEVICE_ID_SDR_MASK) {
+				if ((devid->adtl_device_support & 0x02) =
0) {
+					if ((devid->adtl_device_support &
0x01)) {
+						printk(KERN_DEBUG
"bmcsensors.o: Using Device SDRs\n");
+						use_built_in = 1;
+					} else {
+						printk(KERN_ERR
"bmcsensors.o: Error obtaining SDR info\n");
+					}
+				} else {
+					printk(KERN_DEBUG "bmcsensors.o:
Using SDR from Repository \n");
+				}
+			}
+
+			state = STATE_RESERVE;
+			bmcsensors_reserve_sdr();
+			break;
+
 		case STATE_RESERVE:
 			resid = (((u16)msg->data[2]) << 8) | msg->data[1];
@@ -710,6 +759,7 @@
 			state = STATE_UNCANCEL;
 		}
-	} else if (msg->msg.data[0] != 0 && msg->msg.data[0] != 0xca &&
-	           msg->msg.data[0] != 0xce) {
+	} else if ( (msg->msg.data[0] != IPMI_CC_NORMAL) &&
+				(msg->msg.data[0] !IPMI_CC_CANT_RETURN_NUMBER_BYTES_REQ) &&
+				(msg->msg.data[0] !IPMI_CC_CANT_PROVIDE_RESP) ) {
 	  /* YJ : accept  0xce */
 		printk(KERN_ERR
@@ -735,6 +785,6 @@
 {
 #ifdef DEBUG
-	printk(KERN_INFO "bmcsensors.o: Send BMC msg, cmd: 0x%x\n",
-		       msg->cmd);
+	printk(KERN_INFO "bmcsensors.o: Send BMC msg, netfn: 0x%x cmd:
0x%x\n",
+		       msg->netfn, msg->cmd);
 #endif
 	bmc_client.adapter->algo->slave_send((struct i2c_adapter *)
&bmc_client,
@@ -743,8 +793,23 @@
 }
 
+/* Compose and send a "device ID" message */
+static void bmcsensors_get_device_id(void)
+{
+	tx_message.netfn = IPMI_NETFN_APP;
+	tx_message.cmd = IPMI_GET_DEVICE_ID;
+	tx_message.data_len = 0;
+	tx_message.data = NULL;
+	printk(KERN_INFO "bmcsensors.o: get device id...\n");
+	bmcsensors_send_message(&tx_message);
+}
+
 /* Compose and send a "reserve SDR" message */
 static void bmcsensors_reserve_sdr(void)
 {
-	tx_message.netfn = IPMI_NETFN_STORAGE;
+	if (use_built_in) {
+		tx_message.netfn = IPMI_NETFN_SENSOR;
+	} else {
+		tx_message.netfn = IPMI_NETFN_STORAGE;
+	}
 	tx_message.cmd = IPMI_RESERVE_SDR;
 	tx_message.data_len = 0;
@@ -761,6 +826,11 @@
 		       res_id, record, offset);
 #endif
-	tx_message.netfn = IPMI_NETFN_STORAGE;
-	tx_message.cmd = IPMI_GET_SDR;
+	if (use_built_in) {		
+		tx_message.netfn = IPMI_NETFN_SENSOR;
+		tx_message.cmd = IPMI_GET_DEVICE_SDR;
+	} else {
+		tx_message.netfn = IPMI_NETFN_STORAGE;
+		tx_message.cmd = IPMI_GET_SDR;
+	}
 	tx_message.data_len = 6;
 	tx_message.data = tx_msg_data;
@@ -830,5 +900,5 @@
 	/* send our first message, which kicks things off */
 	printk(KERN_INFO "bmcsensors.o: Registered client, scanning for
sensors...\n");
-	bmcsensors_reserve_sdr();
+	bmcsensors_get_device_id();
 	/* don't call i2c_register_entry until we scan the SDR's */
 	return 0;
@@ -881,5 +951,5 @@
 			state = STATE_READING;
 #ifdef DEBUG
-			printk(KERN_DEBUG "bmcsensors.o: starting update\n",
j);
+			printk(KERN_DEBUG "bmcsensors.o: starting
update\n");
 #endif
 			bmcsensors_get_reading(client, 0);
@@ -1089,4 +1159,5 @@
 	}
 	/* ... YJ */
+	use_built_in = 0;
 
 	return i2c_add_driver(&bmcsensors_driver);


--------------------
Chuck Grant
Performance Software




