From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Small fix in the PCF8591 driver
Message-Id: <20040316133056.GA15887@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314194215.GA12324@pc.aurel32.private>
In-Reply-To: <20040314194215.GA12324@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 15, 2004 at 10:00:56PM +0100, Jean Delvare wrote:
> > That's right. Please find a new patch attached.
> 
> Your patch is bogus. Please check it.
Oops, sorry. I am not using a 2.6 kernel anymore, and so I didn't tried
to build lm-sensors to test my fix.

I hope this patch is the good one.

Cheers,
Aurelien
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
+++ kernel/chips/pcf8591.c	16 Mar 2004 12:31:03 -0000
@@ -181,3 +181,4 @@ int pcf8591_detect(struct i2c_adapter *a
 
-        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+                                     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
                 goto ERROR0;
