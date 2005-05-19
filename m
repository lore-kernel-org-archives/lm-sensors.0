From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: Small fix in the PCF8591 driver
Message-Id: <20040314222342.GB30353@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314194215.GA12324@pc.aurel32.private>
In-Reply-To: <20040314194215.GA12324@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 14, 2004 at 09:30:52PM +0100, Jean Delvare wrote:
> > Please find attached a patch to fix a small bug in pcf8591.c: the
> > function i2c_func_smbus_write_byte_data() was used without checking
> > for it before.
> 
> You check for I2C_FUNC_SMBUS_BYTE_DATA while I believe you really only
> need I2C_FUNC_SMBUS_WRITE_BYTE_DATA. Or am I missing something?
That's right. Please find a new patch attached.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: kernel/chips/pcf8591.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/pcf8591.c,v
retrieving revision 1.6
diff -u -1 -b -p -r1.6 pcf8591.c
--- kernel/chips/pcf8591.c	21 Jan 2003 20:01:26 -0000	1.6
+++ kernel/chips/pcf8591.c	14 Mar 2004 22:26:19 -0000
@@ -181,3 +181,4 @@ int pcf8591_detect(struct i2c_adapter *a
 
-        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE) 
+	                             | I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
                 goto ERROR0;
