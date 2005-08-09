From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 09 Aug 2005 20:18:26 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Rewrite i2c_probe
Message-Id: <20050809201755.15962b81.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

i2c_probe was quite complex and slow, so I rewrote it in a more
efficient and hopefully clearer way.

Note that this slightly changes the way the module parameters are
handled. This shouldn't change anything for the most common cases
though.

For one thing, the function now respects the order of the parameters
for address probing. It used to always do lower addresses first. The
new approach gives the user more control.

For another, ignore addresses don't overrule probe addresses anymore.
This could have been restored the way it was at the cost of a few more
lines of code, but I don't think it's worth it. Both lists are given
as module parameters, so a user would be quite silly to specify the
same addresses in both lists. The normal addresses list is the only
one that isn't controlled by a module parameter, thus is the only one
the user may reasonably want to remove an address from.

Another significant change is the fact that i2c_probe() will no more
stop when a detection function returns -ENODEV. Just because a driver
found a chip it doesn't support isn't a valid reason to stop all
probings for this one driver. This closes the long standing lm_sensors
ticket #1807.

  http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket07

I updated the documentation accordingly.

In terms of algorithmic complexity, the new code is way better. If
I is the ignore address count, P the probe address count, N the
normal address count and F the force address count, the old code
was doing 128 * (F + I + P + N) iterations max, while the new code
does F + P + ((I+1) * N) iterations max. For the most common case
where F, I and P are empty, this is down from 128 * N to N.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/writing-clients |    7 -
 drivers/i2c/i2c-core.c            |  167 ++++++++++++++++++++------------------
 2 files changed, 94 insertions(+), 80 deletions(-)

--- linux-2.6.13-rc4.orig/drivers/i2c/i2c-core.c	2005-07-31 17:37:44.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/i2c-core.c	2005-07-31 20:55:44.000000000 +0200
@@ -662,107 +662,120 @@
  * Will not work for 10-bit addresses!
  * ----------------------------------------------------
  */
-/* Return: kind (>= 0) if force found, -1 if not found */
-static inline int i2c_probe_forces(struct i2c_adapter *adapter, int addr,
-				   unsigned short **forces)
-{
-	unsigned short kind;
-	int j, adap_id = i2c_adapter_id(adapter);
-
-	for (kind = 0; forces[kind]; kind++) {
-		for (j = 0; forces[kind][j] != I2C_CLIENT_END; j += 2) {
-			if ((forces[kind][j] = adap_id ||
-			     forces[kind][j] = ANY_I2C_BUS)
-			 && forces[kind][j + 1] = addr) {
-				dev_dbg(&adapter->dev, "found force parameter, "
-					"addr 0x%02x, kind %u\n", addr, kind);
-				return kind;
-			}
-		}
+static int i2c_probe_address(struct i2c_adapter *adapter, int addr, int kind,
+			     int (*found_proc) (struct i2c_adapter *, int, int))
+{
+	int err;
+
+	/* Make sure the address is valid */
+	if (addr < 0x03 || addr > 0x77) {
+		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
+			 addr);
+		return -EINVAL;
 	}
 
-	return -1;
+	/* Skip if already in use */
+	if (i2c_check_addr(adapter, addr))
+		return 0;
+
+	/* Make sure there is something at this address, unless forced */
+	if (kind < 0
+	 && i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
+		return 0;
+
+	/* Finally call the custom detection function */
+	err = found_proc(adapter, addr, kind);
+
+	/* -ENODEV can be returned if there is a chip at the given address
+	   but it isn't supported by this chip driver. We catch it here as
+	   this isn't an error. */
+	return (err = -ENODEV) ? 0 : err;
 }
 
 int i2c_probe(struct i2c_adapter *adapter,
 	      struct i2c_client_address_data *address_data,
 	      int (*found_proc) (struct i2c_adapter *, int, int))
 {
-	int addr,i,found,err;
+	int i, err;
 	int adap_id = i2c_adapter_id(adapter);
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
 	if (! i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
 		return -1;
 
-	for (addr = 0x00; addr <= 0x7f; addr++) {
-
-		/* Skip if already in use */
-		if (i2c_check_addr(adapter,addr))
-			continue;
-
-		/* If it is in one of the force entries, we don't do any detection
-		   at all */
-		found = 0;
-
-		if (address_data->forces) {
-			int kind = i2c_probe_forces(adapter, addr,
-						    address_data->forces);
-			if (kind >= 0) { /* force found */
-				if ((err = found_proc(adapter, addr, kind)))
-					return err;
-				continue;
-			}
-		}
-
-		/* If this address is in one of the ignores, we can forget about
-		   it right now */
-		for (i = 0;
-		     !found && (address_data->ignore[i] != I2C_CLIENT_END);
-		     i += 2) {
-			if (((adap_id = address_data->ignore[i]) || 
-			    ((address_data->ignore[i] = ANY_I2C_BUS))) &&
-			    (addr = address_data->ignore[i+1])) {
-				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, "
-					"addr %04x\n", adap_id ,addr);
-				found = 1;
+	/* Force entries are done first, and are not affected by ignore
+	   entries */
+	if (address_data->forces) {
+		unsigned short **forces = address_data->forces;
+		int kind;
+
+		for (kind = 0; forces[kind]; kind++) {
+			for (i = 0; forces[kind][i] != I2C_CLIENT_END;
+			     i += 2) {
+				if (forces[kind][i] = adap_id
+				 || forces[kind][i] = ANY_I2C_BUS) {
+					dev_dbg(&adapter->dev, "found force "
+						"parameter for adapter %d, "
+						"addr 0x%02x, kind %d\n",
+						adap_id, forces[kind][i + 1],
+						kind);
+					err = i2c_probe_address(adapter,
+						forces[kind][i + 1],
+						kind, found_proc);
+					if (err)
+						return err;
+				}
 			}
 		}
-		if (found) 
-			continue;
+	}
 
-		/* Now, we will do a detection, but only if it is in the normal or 
-		   probe entries */  
-		for (i = 0;
-		     !found && (address_data->normal_i2c[i] != I2C_CLIENT_END);
-		     i += 1) {
-			if (addr = address_data->normal_i2c[i]) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, "
-					"addr %02x\n", adap_id, addr);
-			}
+	/* Probe entries are done second, and are not affected by ignore
+	   entries either */
+	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {
+		if (address_data->probe[i] = adap_id
+		 || address_data->probe[i] = ANY_I2C_BUS) {
+			dev_dbg(&adapter->dev, "found probe parameter for "
+				"adapter %d, addr 0x%02x\n", adap_id,
+				address_data->probe[i + 1]);
+			err = i2c_probe_address(adapter,
+						address_data->probe[i + 1],
+						-1, found_proc);
+			if (err)
+				return err;
 		}
+	}
 
-		for (i = 0;
-		     !found && (address_data->probe[i] != I2C_CLIENT_END);
-		     i += 2) {
-			if (((adap_id = address_data->probe[i]) ||
-			    ((address_data->probe[i] = ANY_I2C_BUS))) &&
-			    (addr = address_data->probe[i+1])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, "
-					"addr %04x\n", adap_id,addr);
+	/* Normal entries are done last, unless shadowed by an ignore entry */
+	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
+		int j, ignore;
+
+		ignore = 0;
+		for (j = 0; address_data->ignore[j] != I2C_CLIENT_END;
+		     j += 2) {
+			if ((address_data->ignore[j] = adap_id ||
+			     address_data->ignore[j] = ANY_I2C_BUS)
+			 && address_data->ignore[j + 1]
+			    = address_data->normal_i2c[i]) {
+				dev_dbg(&adapter->dev, "found ignore "
+					"parameter for adapter %d, "
+					"addr 0x%02x\n", adap_id,
+					address_data->ignore[j + 1]);
 			}
+			ignore = 1;
+			break;
 		}
-		if (!found) 
+		if (ignore)
 			continue;
 
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
 	}
+
 	return 0;
 }
 
--- linux-2.6.13-rc4.orig/Documentation/i2c/writing-clients	2005-07-31 17:37:44.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/writing-clients	2005-07-31 20:55:44.000000000 +0200
@@ -241,9 +241,10 @@
 parts are between /* SENSORS ONLY START */ and /* SENSORS ONLY END */
 markers. 
 
-This function should only return an error (any value != 0) if there is
-some reason why no more detection should be done anymore. If the
-detection just fails for this address, return 0.
+Returning an error different from -ENODEV in a detect function will cause
+the detection to stop: other addresses and adapters won't be scanned.
+This should only be done on fatal or internal errors, such as a memory
+shortage or i2c_attach_client failing.
 
 For now, you can ignore the `flags' parameter. It is there for future use.
 

-- 
Jean Delvare
