From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: [patch] from kernel 2.4 i2c-dev and i2c-core for CVS
Message-Id: <3D973146.215A8D4A@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
Below are two patches that showed up in the 2.4 kernel
from Alan Cox.  i2c-dev limits the amount of data copied
from/to user_space from/to kernel_space in
i2cdev_read and i2cdev_write.
i2c-core.c changes len_total from and int to size_t.
I've tested on 2.2, 2.4 and 2.5 kernels.  If no one objects
I'll update CVS to reflect Alan's changes.
Albert
--- i2c-dev.c.orig      2002-09-29 12:26:18.000000000 -0400
+++ i2c-dev.c   2002-09-29 12:29:48.000000000 -0400
@@ -145,6 +145,9 @@
 
        struct i2c_client *client = (struct i2c_client *)file->private_data;
 
+       if (count > 8192)
+               count = 8192;
+
        /* copy user space data to kernel space. */
        tmp = kmalloc(count,GFP_KERNEL);
        if (tmp=NULL)
@@ -173,6 +176,9 @@
        struct inode *inode = file->f_dentry->d_inode;
 #endif /* DEBUG */
 
+       if (count > 8192)
+               count = 8192;
+
        /* copy user space data to kernel space. */
        tmp = kmalloc(count,GFP_KERNEL);
        if (tmp=NULL)
---------------
--- i2c-core.c.orig     2002-09-29 12:32:45.000000000 -0400
+++ i2c-core.c  2002-09-29 12:46:10.000000000 -0400
@@ -654,7 +654,8 @@
        struct inode * inode = file->f_dentry->d_inode;
        char *kbuf;
        struct i2c_client *client;
-       int i,j,k,order_nr,len=0,len_total;
+       int i,j,k,order_nr,len=0;
+       size_t len_total;
        int order[I2C_CLIENT_MAX];
 #define OUTPUT_LENGTH_PER_LINE 70
 
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@attbi.com
