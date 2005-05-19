From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH i2c-pca] improve debugging output
Message-Id: <1108135767.3181.59.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Rework the pca_xfer() function to always print the number of
successfully completed transfers in a series when debugging, even when
exiting with an error.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/algos/i2c-algo-pca.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-02-01 15:13:51.000000000 +0000
+++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2005-02-11 15:21:09.502036405 +0000
@@ -186,6 +186,7 @@
         int curmsg;
 	int numbytes = 0;
 	int state;
+	int ret;
 
 	state = pca_status(adap);
 	if ( state != 0xF8 ) {
@@ -218,6 +219,7 @@
 	}
 
 	curmsg = 0;
+	ret = -EREMOTEIO;
 	while (curmsg < num) {
 		state = pca_status(adap);
 
@@ -251,7 +253,7 @@
 		case 0x20: /* SLA+W has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+W\n");
 			pca_stop(adap);
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x40: /* SLA+R has been transmitted; ACK has been received */
 			pca_rx_ack(adap, msg->len > 1);
@@ -263,7 +265,7 @@
 				numbytes++;
 				pca_rx_ack(adap, numbytes < msg->len - 1);
 				break;
-			} 
+			}
 			curmsg++; numbytes = 0;
 			if (curmsg = num)
 				pca_stop(adap);
@@ -274,15 +276,15 @@
 		case 0x48: /* SLA+R has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after SLA+R\n");
 			pca_stop(adap);
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after data byte\n");
-			return -EREMOTEIO;
+			goto out;
 
 		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
 			DEB2("Arbitration lost\n");
-			return -EREMOTEIO;
+			goto out;
 			
 		case 0x58: /* Data byte has been received; NOT ACK has been returned */
 			if ( numbytes = msg->len - 1 ) {
@@ -297,21 +299,21 @@
 				     "Not final byte. numbytes %d. len %d\n",
 				     numbytes, msg->len);
 				pca_stop(adap);
-				return -EREMOTEIO;
+				goto out;
 			}
 			break;
 		case 0x70: /* Bus error - SDA stuck low */
 			DEB2("BUS ERROR - SDA Stuck low\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		case 0x90: /* Bus error - SCL stuck low */
 			DEB2("BUS ERROR - SCL Stuck low\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		case 0x00: /* Bus error during master or slave mode due to illegal START or STOP condition */
 			DEB2("BUS ERROR - Illegal START or STOP\n");
 			pca_reset(adap);
-			return -EREMOTEIO;
+			goto out;
 		default:
 			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
 			break;
@@ -319,11 +321,13 @@
 		
 	}
 
-	DEB1(KERN_CRIT "}}} transfered %d messages. "
+	ret = curmsg;
+ out:
+	DEB1(KERN_CRIT "}}} transfered %d/%d messages. "
 	     "status is %#04x. control is %#04x\n", 
-	     num, pca_status(adap),
+	     curmsg, num, pca_status(adap),
 	     pca_get_con(adap));
-	return curmsg;
+	return ret;
 }
 
 static u32 pca_func(struct i2c_adapter *adap)

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
