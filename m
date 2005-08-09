From: david.vanhoose@comcast.net (David van Hoose)
Date: Tue, 09 Aug 2005 20:36:58 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Rewrite i2c_probe
Message-Id: <PFEDLPHCOBHEOIOMGBIEEENJCAAA.david.vanhoose@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809201755.15962b81.khali@linux-fr.org>
In-Reply-To: <20050809201755.15962b81.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Good thing you brought this up. This is a site of a problem I see.
I snipped all but a particular line in source you are posting so you can
see.

As you can see in the below code, the call to i2c_smbus_xfer() has
I2C_SMBUS_QUICK in the 2nd to last parameter.
Looking at the definition of i2c_smbus_xfer(), we see that the parameters
are:
extern s32 i2c_smbus_xfer (struct i2c_adapter * adapter, u16 addr,
                           unsigned short flags,
                           char read_write, u8 command, int size,
                           union i2c_smbus_data * data);

As the code below shows, the 3rd to last should be I2C_SMBUS_QUICK. Is this
an accurate assumption? If not, can you please explain this? I have seen
this problem pretty much everywhere i2c_smbus_xfer() and
i2c_smbus_xfer_emulated() are called. If this is a semantic bug, I will be
glad to patch this today. You can also see in the removed block that you did
type it as it was before.

What is the verdict?

-David van Hoose

;SNIP through i2c_probe_addresses
+	/* Make sure there is something at this address, unless forced */
+	if (kind < 0
+	 && i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
+		return 0;
+
+	/* Finally call the custom detection function */
+	err = found_proc(adapter, addr, kind);

;SNIP several more lines to i2c_probe

-		/* OK, so we really should examine this address. First check
-		   whether there is some client here at all! */
-		if (i2c_smbus_xfer(adapter,addr,0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
-			if ((err = found_proc(adapter,addr,-1)))
-				return err;
+		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
+			"addr 0x%02x\n", adap_id,
+			address_data->normal_i2c[i]);
+		err = i2c_probe_address(adapter, address_data->normal_i2c[i],
+					-1, found_proc);
+		if (err)
+			return err;

;SNIP end

