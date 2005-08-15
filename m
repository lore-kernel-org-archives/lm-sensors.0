From: lutchann@litech.org (Nathan Lutchansky)
Date: Mon, 15 Aug 2005 19:55:41 +0000
Subject: [lm-sensors] [PATCH 5/5] new flag to disable i2c probing for an
Message-Id: <20050815175505.GF24959@litech.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050815175106.GA24959@litech.org>
In-Reply-To: <20050815175106.GA24959@litech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>

Re-add the flags field to the i2c_adapter structure so we can add a new
flag I2C_ADAPTER_SKIP_PROBE.  When an adapter sets this flag, the bus
will never be probed by any i2c client driver, even if forced addresses
are listed.  Adapters that set this flag will need to use the
i2c_probe_device function to attach new clients.

Signed-off-by: Nathan Lutchansky <lutchann@litech.org>

 drivers/i2c/i2c-core.c |    3 +++
 include/linux/i2c.h    |    4 ++++
 2 files changed, 7 insertions(+)

Index: linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
=================================--- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
@@ -788,6 +788,9 @@ int i2c_probe(struct i2c_adapter *adapte
 	int i, err;
 	int adap_id = i2c_adapter_id(adapter);
 
+	if (adapter->flags & I2C_ADAPTER_SKIP_PROBE)
+		return 0;
+
 	/* Forget it if we can't probe using SMBUS_QUICK */
 	if (! i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
 		return -1;
Index: linux-2.6.13-rc6+gregkh/include/linux/i2c.h
=================================--- linux-2.6.13-rc6+gregkh.orig/include/linux/i2c.h
+++ linux-2.6.13-rc6+gregkh/include/linux/i2c.h
@@ -233,6 +233,7 @@ struct i2c_adapter {
 	unsigned int id;/* = is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
 	unsigned int class;
+	unsigned int flags;		/* div., see below		*/
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
@@ -290,6 +291,9 @@ static inline void i2c_set_adapdata (str
 #define I2C_CLIENT_TEN	0x10			/* we have a ten bit chip address	*/
 						/* Must equal I2C_M_TEN below */
 
+/*flags for the adapter struct: */
+#define I2C_ADAPTER_SKIP_PROBE		0x01	/* Don't probe for devices */
+
 /* i2c adapter classes (bitmask) */
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
