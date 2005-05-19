From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] I2C chip drivers return -EINVAL on error
Message-Id: <20040410222630.22d70d38.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Well make it a real error, like -EINVAL or something, so userspace
> > has a chance to report it properly.  Not just -1.
> 
> Oh, I guess we want to correct it87.c and fscher.c in that way too
> then.
> 
> I had this to my todo list.

(I meant: I *add* this...)

OK, here is the patch. Should apply cleanly on top of all the other
patches I sent you today (kmalloc, error paths, w83781d pwm).

Thanks.

--- linux-2.6.5-mm3/drivers/i2c/chips/fscher.c.orig	Sat Apr 10 10:33:18 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/fscher.c	Sat Apr 10 22:19:22 2004
@@ -512,7 +512,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
-		return -1;
+		return -EINVAL;
 	}
 
 	/* bits 2..7 reserved => mask with 0x03 */
--- linux-2.6.5-mm3/drivers/i2c/chips/it87.c.orig	Sat Apr 10 16:19:46 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/it87.c	Sat Apr 10 22:17:17 2004
@@ -367,7 +367,7 @@
 	else if (val = 2)
 	    data->sensor |= 8 << nr;
 	else if (val != 0)
-		return -1;
+		return -EINVAL;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	return count;
 }
--- linux-2.6.5-mm3/drivers/i2c/chips/pcf8591.c.orig	Sat Apr 10 08:51:58 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/pcf8591.c	Sat Apr 10 21:56:37 2004
@@ -130,8 +130,9 @@
 	{
 		data->aout = value;
 		i2c_smbus_write_byte_data(client, data->control, data->aout);
+		return count;
 	}
-	return count;
+	return -EINVAL;
 }
 
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
