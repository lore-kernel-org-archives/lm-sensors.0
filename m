From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH] I2C update for 2.6.7-rc1
Message-Id: <10857816431296@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10857816431154@kroah.com>
References: <1085781643100@kroah.com>
In-Reply-To: <1085781643100@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1717.6.28, 2004/05/19 00:26:34-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: 0-length transaction temporary fix

this patch adds temporary fix for 0-length requests (e.g. SMBUS_QUICK) to PPC4xx
IIC driver. This i2c controller doesn't support such transactions and this patch
just restores previous driver version behavior making SMBUS_QUICK-based bus scan
at least partially usable. This is temporary kludge until correct bit-banging
emulation is implemented.


 drivers/i2c/busses/i2c-ibm_iic.c |   10 ++++++++++
 1 files changed, 10 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:12 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:12 2004
@@ -455,6 +455,16 @@
 	}		
 	for (i = 0; i < num; ++i){
 		if (unlikely(msgs[i].len <= 0)){
+			if (num = 1 && !msgs[0].len){
+				/* Special case for I2C_SMBUS_QUICK emulation.
+				 * Although this logic is FAR FROM PERFECT, this 
+				 * is what previous driver version did.
+				 * IBM IIC doesn't support 0-length transactions
+				 * (except bit-banging through IICx_DIRECTCNTL).
+				 */
+				DBG("%d: zero-length msg kludge\n", dev->idx); 
+				return 0;
+			}
 			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
 				msgs[i].len, i);
 			return -EINVAL;

