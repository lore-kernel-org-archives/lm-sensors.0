From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: user/kernel bug and memory leak in i2c-dev
Message-Id: <20030806225428.704dd632.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805211609.4a3a66d2.khali@linux-fr.org>
In-Reply-To: <20030805211609.4a3a66d2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks, Marcelo said he applied your patch, so it will show up in the
> next release.

Great.

> -ENOPATCH  :)

-EOVERTEMP ;]

Here it is, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -ru 2.6/drivers/i2c/i2c-dev.c 2.6/drivers/i2c/i2c-dev.c
--- 2.6/drivers/i2c/i2c-dev.c	Sat Aug  2 10:53:19 2003
+++ 2.6/drivers/i2c/i2c-dev.c	Wed Aug  6 09:26:55 2003
@@ -181,6 +181,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -214,7 +215,7 @@
 		return (copy_to_user((unsigned long __user *)arg, &funcs,
 		                     sizeof(unsigned long)))?-EFAULT:0;
 
-        case I2C_RDWR:
+	case I2C_RDWR:
 		if (copy_from_user(&rdwr_arg, 
 				   (struct i2c_rdwr_ioctl_data __user *)arg, 
 				   sizeof(rdwr_arg)))
@@ -231,28 +232,37 @@
 
 		if (rdwr_pa = NULL) return -ENOMEM;
 
+		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+			kfree(rdwr_pa);
+			return -EFAULT;
+		}
+
+		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
+					    GFP_KERNEL);
+		if (data_ptrs = NULL) {
+			kfree(rdwr_pa);
+			return -ENOMEM;
+		}
+
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ ) {
-		    	if(copy_from_user(&(rdwr_pa[i]),
-					&(rdwr_arg.msgs[i]),
-					sizeof(rdwr_pa[i]))) {
-			        res = -EFAULT;
-				break;
-			}
 			/* Limit the size of the message to a sane amount */
 			if (rdwr_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
+			data_ptrs[i] = rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf = NULL) {
 				res = -ENOMEM;
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				data_ptrs[i],
 				rdwr_pa[i].len)) {
-			    	res = -EFAULT;
+					++i; /* Needs to be kfreed too */
+					res = -EFAULT;
 				break;
 			}
 		}
@@ -260,18 +270,18 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
+			kfree(data_ptrs);
 			kfree(rdwr_pa);
 			return res;
 		}
-		if (!res) {
-			res = i2c_transfer(client->adapter,
-				rdwr_pa,
-				rdwr_arg.nmsgs);
-		}
+
+		res = i2c_transfer(client->adapter,
+			rdwr_pa,
+			rdwr_arg.nmsgs);
 		while(i-- > 0) {
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					data_ptrs[i],
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len)) {
 					res = -EFAULT;
@@ -279,6 +289,7 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
+		kfree(data_ptrs);
 		kfree(rdwr_pa);
 		return res;
 
