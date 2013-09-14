From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:24 +0000
Subject: [lm-sensors] [PATCH 01/12] hwmon: Remove unnecessary semicolons
Message-Id: <1379147615-7703-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Semicolons after closing } of conditional blocks are not needed
and can be removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1026.c |    6 +++---
 drivers/hwmon/asc7621.c |   12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 3a6d9ef..b3498ac 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -616,7 +616,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 		data->gpio = gpio;
 
 		data->last_reading = jiffies;
-	}; /* last_reading */
+	}	/* last_reading */
 
 	if (!data->valid ||
 	    time_after(jiffies, data->last_config + ADM1026_CONFIG_INTERVAL)) {
@@ -700,7 +700,7 @@ static struct adm1026_data *adm1026_update_device(struct device *dev)
 		}
 
 		data->last_config = jiffies;
-	}; /* last_config */
+	}	/* last_config */
 
 	data->valid = 1;
 	mutex_unlock(&data->update_lock);
@@ -1791,7 +1791,7 @@ static int adm1026_detect(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		/* We need to be able to do byte I/O */
 		return -ENODEV;
-	};
+	}
 
 	/* Now, we do the remaining detection. */
 
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 3ad9d84..8d9f2a0 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -138,7 +138,7 @@ static inline u8 read_byte(struct i2c_client *client, u8 reg)
 		dev_err(&client->dev,
 			"Unable to read from register 0x%02x.\n", reg);
 		return 0;
-	};
+	}
 	return res & 0xff;
 }
 
@@ -149,7 +149,7 @@ static inline int write_byte(struct i2c_client *client, u8 reg, u8 data)
 		dev_err(&client->dev,
 			"Unable to write value 0x%02x to register 0x%02x.\n",
 			data, reg);
-	};
+	}
 	return res;
 }
 
@@ -1030,7 +1030,7 @@ static struct asc7621_data *asc7621_update_device(struct device *dev)
 			}
 		}
 		data->last_high_reading = jiffies;
-	};			/* last_reading */
+	}			/* last_reading */
 
 	/* Read all the low priority registers. */
 
@@ -1044,7 +1044,7 @@ static struct asc7621_data *asc7621_update_device(struct device *dev)
 			}
 		}
 		data->last_low_reading = jiffies;
-	};			/* last_reading */
+	}			/* last_reading */
 
 	data->valid = 1;
 
@@ -1084,11 +1084,11 @@ static void asc7621_init_client(struct i2c_client *client)
 		dev_err(&client->dev,
 			"Client (%d,0x%02x) config is locked.\n",
 			i2c_adapter_id(client->adapter), client->addr);
-	};
+	}
 	if (!(value & 0x04)) {
 		dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
 			i2c_adapter_id(client->adapter), client->addr);
-	};
+	}
 
 /*
  * Start monitoring
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
