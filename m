From: charles.grant@psware.com (Charles Grant)
Date: Thu, 25 Jan 2007 23:07:00 +0000
Subject: [lm-sensors] patch to bmcsensors.c
Message-Id: <000501c740d5$85a39350$8101a8c0@PERF.PERFORMANCESOFTWARE>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here are some changes I made to get bmcsensors working on our dual-core Xeon
ATCA carrier (Kontron 8020).

1) I modified the code to send an initial "get device ID" command to
determine which commands are used to subsequently retrieve the SDR data
(this code was taken directly from ipmitool).

2) When retrieving partial buffers for an SDR, the request for the last
buffer would return completion code 0xCA (cannot return number of requested
data bytes), causing the code to half its buffer size, try again, and
ultimately give up.  To get around this, I modified bmcsensors_get_sdr() and
bmcsensors_rcv_sdr_msg() to never request more than the known number of
remaining bytes.

3) Sorry, but I also put "#ifdef DEBUG" around a lot of the printk's

Here's the diff:

--- old/bmcsensors.c     2007-01-10 11:13:47.353446400 -0700
+++ new/bmcsensors.c 2007-01-25 13:56:40.870738100 -0700
@@ -72,5 +72,5 @@
                                    int ctl_name, int *nrels_mag, long
*results);
 #endif
-static void bmcsensors_get_sdr(u16 resid, u16 record, u8 offset);
+static void bmcsensors_get_sdr(u16 resid, u16 record, u8 offset, u8 count);
 static void bmcsensors_get_reading(struct i2c_client *client, int i);
 
@@ -163,9 +163,16 @@
 /* Network Function Codes */
 #define IPMI_NETFN_SENSOR           0x04
+#define IPMI_NETFN_APP                  0x06
 #define IPMI_NETFN_STORAGE         0x0A
 /* Commands */
+#define IPMI_GET_DEVICE_ID           0x01
+#define IPMI_GET_DEVICE_SDR       0x21
 #define IPMI_RESERVE_SDR              0x22
 #define IPMI_GET_SDR                       0x23
 #define IPMI_GET_SENSOR_STATE_READING                      0x2D
+/* Completion codes */
+#define IPMI_CC_NORMAL     0x00
+#define IPMI_CC_CANT_RETURN_NUMBER_BYTES_REQ    0xCA
+#define IPMI_CC_CANT_PROVIDE_RESP 0xCE
 
 /* SDR defs */
@@ -187,4 +194,24 @@
 /* ... YJ */
 /************************************/
+static int use_built_in; /* Uses DeviceSDRs instead of SDRR */
+/* 
+ * Response data from IPM Get Device ID Command (IPMI rev 1.5, section
17.1)
+ * The following really apply to any IPM device, not just BMCs...
+ */
+struct ipm_devid_rsp {
+          uint8_t device_id;
+          uint8_t device_revision;
+          uint8_t fw_rev1;
+          uint8_t fw_rev2;
+          uint8_t ipmi_version;
+          uint8_t adtl_device_support;
+          uint8_t manufacturer_id[3];
+          uint8_t product_id[2];
+          uint8_t aux_fw_rev[4];
+} __attribute__ ((packed));
+
+#define IPM_DEV_DEVICE_ID_SDR_MASK     (0x80)  /* 1 = provides SDRs      */
+#define IPM_DEV_DEVICE_ID_REV_MASK     (0x07)  /* BCD-enoded             */
+
 
 /* unpack based on string type, convert to normal, null terminate */
@@ -296,15 +323,13 @@
            }
 
+#ifdef DEBUG
            if(sd->lim1 >= 0)
                        printk(KERN_INFO "bmcsensors.o: using %s for upper
limit\n",
                                    threshold_text[sd->lim1]);
-#ifdef DEBUG
            else
                        printk(KERN_INFO "bmcsensors.o: no readable upper
limit\n");
-#endif
            if(sd->lim2 >= 0)
                        printk(KERN_INFO "bmcsensors.o: using %s for lower
limit\n",
                                    threshold_text[sd->lim2]);
-#ifdef DEBUG
            else
                        printk(KERN_INFO "bmcsensors.o: no readable lower
limit\n");
@@ -322,5 +347,7 @@
 
            
+#ifdef DEBUG
            printk(KERN_INFO "bmcsensors.o: building proc table\n");
+#endif
            if(!(bmcsensors_dir_table = kmalloc((sdrd_count + 1) *
sizeof(struct ctl_table), GFP_KERNEL))) {
                        printk(KERN_ERR "bmcsensors.o: no memory\n");
@@ -368,4 +395,5 @@
                        }
                        sdrd[i].sysctl = bmcsensors_dir_table[i].ctl_name;
+#ifdef DEBUG
                        printk(KERN_INFO "bmcsensors.o: registering sensor
%d: (type 0x%.2x) "
                                    "(fmt=%d; m=%d; b=%d; k1=%d; k2=%d;
cap=0x%.2x; mask=0x%.4x)\n",
@@ -373,8 +401,11 @@
                                    sdrd[i].m, sdrd[i].b,sdrd[i].k & 0xf,
sdrd[i].k >> 4,
                                    sdrd[i].capab, sdrd[i].thresh_mask);
+#endif
                        if(sdrd[i].id_length > 0) {
                                    ipmi_sprintf(id, sdrd[i].id,
sdrd[i].string_type, sdrd[i].id_length);
+#ifdef DEBUG
                                    printk(KERN_INFO "bmcsensors.o:
sensors.conf: label %s \"%s\"\n",
 
bmcsensors_dir_table[i].procname, id);
+#endif
                        }
                        bmcsensors_select_thresholds(sdrd + i);
@@ -411,5 +442,7 @@
            bmc_data.sysctl_id = i;
 
+#ifdef DEBUG
            printk(KERN_INFO "bmcsensors.o: %d reservations cancelled\n",
errorcount);
+#endif
            printk(KERN_INFO "bmcsensors.o: registered %d temp, %d volt, %d
current, %d fan sensors\n",
                                    temps, volts, currs, fans);
@@ -459,5 +492,9 @@
            unsigned char * data;
            u8 id[SDR_MAX_UNPACKED_ID_LENGTH];
+          int bytesleft;
 
+#ifdef DEBUG
+          printk(KERN_INFO "bmcsensors.o: data_len=0x%x cc=0x%x\n",
msg->data_len, *msg->data);
+#endif
 
            if(msg->data[0] != 0) {
@@ -472,5 +509,5 @@
                        printk(KERN_INFO "bmcsensors.o: Reducing SDR request
size to %d\n", ipmi_sdr_partial_size);
 #endif
-                       bmcsensors_get_sdr(0, 0, 0);
+                      bmcsensors_get_sdr(0, 0, 0, 0);
                        return STATE_SDR;
            }
@@ -483,14 +520,20 @@
                                    rx_msg_data_offset +ipmi_sdr_partial_size;
                        }
-                       if(rx_msg_data_offset > rx_msg_data[7] + 7) {
-                                   /* got last chunk */
-                                   rx_msg_data_offset =  0;
-                                   data = rx_msg_data;
-                       } else {
+
+                      /* compute total bytes remaining based on sensor
record bytes remaining */
+                      bytesleft = (int)rx_msg_data[7] + 8 -
rx_msg_data_offset;
+
+                      if (bytesleft > 0) {
                                    /* get more */
                                    record = (rx_msg_data[4] << 8) |
rx_msg_data[3];
-                                   bmcsensors_get_sdr(resid, record,
rx_msg_data_offset - 3);
+                                  bmcsensors_get_sdr(resid, record,
rx_msg_data_offset - 3, bytesleft);
                                    return STATE_SDR;
                        }
+                      else {
+                                  /* got last chunk */
+                                  rx_msg_data_offset = 0;
+                                  data = rx_msg_data;
+                      }
+
            } else {
                        data = msg->data;        /* got it in one chunk */
@@ -533,7 +576,9 @@
                                                else
                                                            ipmi_sprintf(id,
&data[(ipmi_ver = 0x90?30:35)], data[(ipmi_ver = 0x90?29:34)] >> 6,
data[(ipmi_ver = 0x90?29:34)] & 0x1f);
+#ifdef DEBUG
                                                printk(KERN_INFO
                                                       "bmcsensors.o:
skipping non-threshold sensor \"%s\"\n",
                                                       id);
+#endif
                                    } else {
                                                /* add entry to sdrd table
*/
@@ -623,5 +668,7 @@
                        } else {
                      /* YJ ...*/
+#ifdef DEBUG
                          printk(KERN_INFO "bmcsensors.o: all sensors
detected\n");
+#endif
                          rstate = STATE_PROCTABLE;
                          /* YJ bmcsensors_build_proc_table() call by thread
*/
@@ -631,5 +678,5 @@
            } else {
 
-                       bmcsensors_get_sdr(0, nextrecord, 0);
+                      bmcsensors_get_sdr(0, nextrecord, 0, 0);
            }
            return rstate;
@@ -639,7 +686,29 @@
 static void bmcsensors_rcv_msg(struct ipmi_msg *msg)
 {
+          struct ipm_devid_rsp *devid;
 
            switch(state) {
                        case STATE_INIT:
+#if DEBUG
+                          printk(KERN_DEBUG "bmcsensors.o: Got init
response\n");
+#endif
+                                  devid = (struct ipm_devid_rsp
*)&msg->data[1];
+                                  if (devid->device_revision &
IPM_DEV_DEVICE_ID_SDR_MASK) {
+                                              if
((devid->adtl_device_support & 0x02) = 0) {
+                                                          if
((devid->adtl_device_support & 0x01)) {
+
printk(KERN_DEBUG "bmcsensors.o: Using Device SDRs\n");
+
use_built_in = 1;
+                                                          } else {
+
printk(KERN_ERR "bmcsensors.o: Error obtaining SDR info\n");
+                                                          }
+                                              } else {
+                                                          printk(KERN_DEBUG
"bmcsensors.o: Using SDR from Repository \n");
+                                              }
+                                  }
+
+                                  state = STATE_RESERVE;
+                                  bmcsensors_reserve_sdr();
+                                  break;
+
                        case STATE_RESERVE:
                                    resid = (((u16)msg->data[2]) << 8) |
msg->data[1];
@@ -647,5 +716,5 @@
                                    printk(KERN_DEBUG "bmcsensors.o: Got
first resid 0x%.4x\n", resid);
 #endif
-                                   bmcsensors_get_sdr(0, 0, 0);
+                                  bmcsensors_get_sdr(0, 0, 0, 0);
                                    state = STATE_SDR;
                                    break;
@@ -677,5 +746,5 @@
 #endif
                                    rx_msg_data_offset = 0;
-                                   bmcsensors_get_sdr(0, nextrecord, 0);
+                                  bmcsensors_get_sdr(0, nextrecord, 0, 0);
                                    state = STATE_SDR;
                                    break;
@@ -710,6 +779,7 @@
                                    state = STATE_UNCANCEL;
                        }
-           } else if (msg->msg.data[0] != 0 && msg->msg.data[0] != 0xca &&
-                      msg->msg.data[0] != 0xce) {
+          } else if ( (msg->msg.data[0] != IPMI_CC_NORMAL) &&
+                                              (msg->msg.data[0] !IPMI_CC_CANT_RETURN_NUMBER_BYTES_REQ) &&
+                                              (msg->msg.data[0] !IPMI_CC_CANT_PROVIDE_RESP) ) {
              /* YJ : accept  0xce */
                        printk(KERN_ERR
@@ -735,6 +805,6 @@
 {
 #ifdef DEBUG
-           printk(KERN_INFO "bmcsensors.o: Send BMC msg, cmd: 0x%x\n",
-                              msg->cmd);
+          printk(KERN_INFO "bmcsensors.o: Send BMC msg, netfn: 0x%x cmd:
0x%x\n",
+                             msg->netfn, msg->cmd);
 #endif
            bmc_client.adapter->algo->slave_send((struct i2c_adapter *)
&bmc_client,
@@ -743,24 +813,53 @@
 }
 
+/* Compose and send a "device ID" message */
+static void bmcsensors_get_device_id(void)
+{
+          tx_message.netfn = IPMI_NETFN_APP;
+          tx_message.cmd = IPMI_GET_DEVICE_ID;
+          tx_message.data_len = 0;
+          tx_message.data = NULL;
+#ifdef DEBUG
+          printk(KERN_INFO "bmcsensors.o: get device id...\n");
+#endif
+          bmcsensors_send_message(&tx_message);
+}
+
 /* Compose and send a "reserve SDR" message */
 static void bmcsensors_reserve_sdr(void)
 {
-           tx_message.netfn = IPMI_NETFN_STORAGE;
+          if (use_built_in) {
+                      tx_message.netfn = IPMI_NETFN_SENSOR;
+          } else {
+                      tx_message.netfn = IPMI_NETFN_STORAGE;
+          }
            tx_message.cmd = IPMI_RESERVE_SDR;
            tx_message.data_len = 0;
            tx_message.data = NULL;
+#ifdef DEBUG
            printk(KERN_INFO "bmcsensors.o: reserve_sdr...\n");
+#endif
            bmcsensors_send_message(&tx_message);
 }
 
 /* Componse and send a "get SDR" message */
-static void bmcsensors_get_sdr(u16 res_id, u16 record, u8 offset)
+static void bmcsensors_get_sdr(u16 res_id, u16 record, u8 offset, u8 count)
 {
 #ifdef DEBUG
-           printk(KERN_DEBUG "bmcsensors.o: Get SDR 0x%x 0x%x 0x%x\n",
-                              res_id, record, offset);
+          printk(KERN_DEBUG "bmcsensors.o: Get SDR 0x%x 0x%x 0x%x 0x%x\n",
+                             res_id, record, offset, count);
 #endif
-           tx_message.netfn = IPMI_NETFN_STORAGE;
-           tx_message.cmd = IPMI_GET_SDR;
+          if (use_built_in) {                       
+                      tx_message.netfn = IPMI_NETFN_SENSOR;
+                      tx_message.cmd = IPMI_GET_DEVICE_SDR;
+          } else {
+                      tx_message.netfn = IPMI_NETFN_STORAGE;
+                      tx_message.cmd = IPMI_GET_SDR;
+          }
+
+          /* Reset count to default value if necessary */
+          if (count = 0 || count > ipmi_sdr_partial_size)
+                      count = ipmi_sdr_partial_size;
+
            tx_message.data_len = 6;
            tx_message.data = tx_msg_data;
@@ -770,5 +869,5 @@
            tx_msg_data[3] = record >> 8;
            tx_msg_data[4] = offset;
-           tx_msg_data[5] = ipmi_sdr_partial_size;
+          tx_msg_data[5] = count;
            bmcsensors_send_message(&tx_message);
 }
@@ -830,5 +929,5 @@
            /* send our first message, which kicks things off */
            printk(KERN_INFO "bmcsensors.o: Registered client, scanning for
sensors...\n");
-           bmcsensors_reserve_sdr();
+          bmcsensors_get_device_id();
            /* don't call i2c_register_entry until we scan the SDR's */
            return 0;
@@ -881,5 +980,5 @@
                                    state = STATE_READING;
 #ifdef DEBUG
-                                   printk(KERN_DEBUG "bmcsensors.o:
starting update\n", j);
+                                  printk(KERN_DEBUG "bmcsensors.o: starting
update\n");
 #endif
                                    bmcsensors_get_reading(client, 0);
@@ -1064,5 +1163,7 @@
     state = STATE_DONE;
     
+#ifdef DEBUG
     printk(KERN_INFO "bmcsensors.o: bmcsensor thread done\n" );
+#endif
     
   }
@@ -1089,4 +1190,5 @@
            }
            /* ... YJ */
+          use_built_in = 0;
 
            return i2c_add_driver(&bmcsensors_driver);


--------------------
Chuck Grant
Performance Software
(623) 337-8011




