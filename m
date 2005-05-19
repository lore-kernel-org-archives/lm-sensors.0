From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040329232014.31856a4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329212303.2b47b12d.khali@linux-fr.org>
In-Reply-To: <20040329212303.2b47b12d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ick, no, we should be using the proper kernel call for this, swab16(),
> right?  Care to redo this patch to just fix the drivers and get rid of
> our duplicating of this function.

Oh, I didn't know such a function existed, sorry.

Here's a new patch, hope you like it. Tested to work on my as99127f, btw
(w83781d driver).

Documentation update follows (well, tomorrow it does).

Thanks.

diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/asb100.c linux-2.6.5-rc2/drivers/i2c/chips/asb100.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/asb100.c	Mon Mar 29 20:50:39 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/asb100.c	Mon Mar 29 22:48:24 2004
@@ -862,11 +862,6 @@
 	return 0;
 }
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* The SMBus locks itself, usually, but nothing may access the chip between
    bank switches. */
 static int asb100_read_value(struct i2c_client *client, u16 reg)
@@ -891,17 +886,17 @@
 		/* convert from ISA to LM75 I2C addresses */
 		switch (reg & 0xff) {
 		case 0x50: /* TEMP */
-			res = swap_bytes(i2c_smbus_read_word_data (cl, 0));
+			res = swab16(i2c_smbus_read_word_data (cl, 0));
 			break;
 		case 0x52: /* CONFIG */
 			res = i2c_smbus_read_byte_data(cl, 1);
 			break;
 		case 0x53: /* HYST */
-			res = swap_bytes(i2c_smbus_read_word_data (cl, 2));
+			res = swab16(i2c_smbus_read_word_data (cl, 2));
 			break;
 		case 0x55: /* MAX */
 		default:
-			res = swap_bytes(i2c_smbus_read_word_data (cl, 3));
+			res = swab16(i2c_smbus_read_word_data (cl, 3));
 			break;
 		}
 	}
@@ -939,10 +934,10 @@
 			i2c_smbus_write_byte_data(cl, 1, value & 0xff);
 			break;
 		case 0x53: /* HYST */
-			i2c_smbus_write_word_data(cl, 2, swap_bytes(value));
+			i2c_smbus_write_word_data(cl, 2, swab16(value));
 			break;
 		case 0x55: /* MAX */
-			i2c_smbus_write_word_data(cl, 3, swap_bytes(value));
+			i2c_smbus_write_word_data(cl, 3, swab16(value));
 			break;
 		}
 	}
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/ds1621.c linux-2.6.5-rc2/drivers/i2c/chips/ds1621.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/ds1621.c	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/ds1621.c	Mon Mar 29 22:47:57 2004
@@ -97,11 +97,6 @@
 
 static int ds1621_id = 0;
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
@@ -110,7 +105,7 @@
 	if (reg = DS1621_REG_CONF)
 		return i2c_smbus_read_byte_data(client, reg);
 	else
-		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+		return swab16(i2c_smbus_read_word_data(client, reg));
 }
 
 /* All registers are word-sized, except for the configuration register.
@@ -121,8 +116,7 @@
 	if (reg = DS1621_REG_CONF)
 		return i2c_smbus_write_byte_data(client, reg, value);
 	else
-		return i2c_smbus_write_word_data(client, reg,
-						 swap_bytes(value));
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
 }
 
 static void ds1621_init_client(struct i2c_client *client)
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/gl518sm.c linux-2.6.5-rc2/drivers/i2c/chips/gl518sm.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/gl518sm.c	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/gl518sm.c	Mon Mar 29 22:46:39 2004
@@ -484,18 +484,13 @@
 	return 0;
 }
 
-static inline u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* Registers 0x07 to 0x0c are word-sized, others are byte-sized 
    GL518 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
 static int gl518_read_value(struct i2c_client *client, u8 reg)
 {
 	if ((reg >= 0x07) && (reg <= 0x0c))
-		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+		return swab16(i2c_smbus_read_word_data(client, reg));
 	else
 		return i2c_smbus_read_byte_data(client, reg);
 }
@@ -506,8 +501,7 @@
 static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
 	if ((reg >= 0x07) && (reg <= 0x0c))
-		return i2c_smbus_write_word_data(client, reg,
-						 swap_bytes(value));
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
 	else
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.c linux-2.6.5-rc2/drivers/i2c/chips/lm75.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.c	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/lm75.c	Mon Mar 29 22:46:14 2004
@@ -206,11 +206,6 @@
 	return 0;
 }
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
@@ -219,7 +214,7 @@
 	if (reg = LM75_REG_CONF)
 		return i2c_smbus_read_byte_data(client, reg);
 	else
-		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+		return swab16(i2c_smbus_read_word_data(client, reg));
 }
 
 /* All registers are word-sized, except for the configuration register.
@@ -230,8 +225,7 @@
 	if (reg = LM75_REG_CONF)
 		return i2c_smbus_write_byte_data(client, reg, value);
 	else
-		return i2c_smbus_write_word_data(client, reg,
-						 swap_bytes(value));
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
 }
 
 static void lm75_init_client(struct i2c_client *client)
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/w83781d.c linux-2.6.5-rc2/drivers/i2c/chips/w83781d.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/w83781d.c	Mon Mar 29 20:50:39 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/w83781d.c	Mon Mar 29 22:45:43 2004
@@ -275,11 +275,6 @@
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_client(struct i2c_client *client);
 
-static inline u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 static struct i2c_driver w83781d_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83781d",
@@ -1407,20 +1402,17 @@
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x50:	/* TEMP */
-				res -				    swap_bytes(i2c_smbus_read_word_data(cl, 0));
+				res = swab16(i2c_smbus_read_word_data(cl, 0));
 				break;
 			case 0x52:	/* CONFIG */
 				res = i2c_smbus_read_byte_data(cl, 1);
 				break;
 			case 0x53:	/* HYST */
-				res -				    swap_bytes(i2c_smbus_read_word_data(cl, 2));
+				res = swab16(i2c_smbus_read_word_data(cl, 2));
 				break;
 			case 0x55:	/* OVER */
 			default:
-				res -				    swap_bytes(i2c_smbus_read_word_data(cl, 3));
+				res = swab16(i2c_smbus_read_word_data(cl, 3));
 				break;
 			}
 		}
@@ -1481,12 +1473,10 @@
 				i2c_smbus_write_byte_data(cl, 1, value & 0xff);
 				break;
 			case 0x53:	/* HYST */
-				i2c_smbus_write_word_data(cl, 2,
-							  swap_bytes(value));
+				i2c_smbus_write_word_data(cl, 2, swab16(value));
 				break;
 			case 0x55:	/* OVER */
-				i2c_smbus_write_word_data(cl, 3,
-							  swap_bytes(value));
+				i2c_smbus_write_word_data(cl, 3, swab16(value));
 				break;
 			}
 		}


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
