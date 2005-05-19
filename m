From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] More i2c driver changes for 2.5.69
Message-Id: <10525245942470@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10525245932907@kroah.com>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1083.2.2, 2003/05/09 13:58:10-07:00, mark@alpha.dyndns.org

[PATCH] I2C: add more classes

Add I2C classes for analog and digital cameras, and fix a typo.


 include/linux/i2c.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri May  9 16:48:20 2003
+++ b/include/linux/i2c.h	Fri May  9 16:48:20 2003
@@ -281,10 +281,12 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_ADAP_CLASS_SMBUS      (1<<0)        /* lm_sensors, ... */
-#define I2C_ADAP_CLASS_TV_ANALOG  (1<<1)        /* bttv + friends */
-#define I2C_ADAP_CLASS_TV_DIGINAL (1<<2)        /* dbv cards */
-#define I2C_ADAP_CLASS_DDC        (1<<3)        /* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
+#define I2C_ADAP_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
+#define I2C_ADAP_CLASS_TV_DIGITAL	(1<<2)	/* dbv cards */
+#define I2C_ADAP_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
+#define I2C_ADAP_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the

