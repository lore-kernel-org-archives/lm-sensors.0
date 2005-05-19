From: Thomas.Viehweger@marconi.com (Thomas Viehweger)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: cat /proc/dev/i2c-0 gives cat: read: Invalid argument
Message-Id: <OFB2390071.3272C603-ONC1256BF3.003B12AD@uk.marconicomms.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I patched the kernel (linux-2.4.4-2002-03-21) from denx.de with the actual
i2c-2.6.3 sources.

When executing

cat /proc/bus/i2c-0

On my ppc8xx board I got the error "cat: read: Invalid argument".

In i2c-core.c the function i2cproc_bus_read() will be called with a count
of 8192.
After modifying "if (count > 4096)" to "if (count > 8192)" the cat
succeeds.
Here is a more general patch:

Regards,
Thomas Viehweger

--- drivers/i2c/i2c-core.c    9 Jul 2002 13:26:33 -0000      1.3
+++ drivers/i2c/i2c-core.c    11 Jul 2002 14:48:39 -0000
@@ -655,18 +655,19 @@ ssize_t i2cproc_bus_read(struct file * f
     struct i2c_client *client;
     int i,j,k,order_nr,len=0,len_total;
     int order[I2C_CLIENT_MAX];
+#define OUTPUT_LENGTH_PER_LINE 70

-    if (count > 4096)
-         return -EINVAL;
     len_total = file->f_pos + count;
-    /* Too bad if this gets longer (unlikely) */
-    if (len_total > 4096)
-         len_total = 4096;
+    if (len_total > (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE) )
+         /* adjust to maximum file size */
+         len_total = (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE);
     for (i = 0; i < I2C_ADAP_MAX; i++)
          if (adapters[i]->inode = inode->i_ino) {
          /* We need a bit of slack in the kernel buffer; this makes the
             sprintf safe. */
-              if (! (kbuf = kmalloc(count + 80,GFP_KERNEL)))
+              if (! (kbuf = kmalloc(len_total + OUTPUT_LENGTH_PER_LINE,
+                                    GFP_KERNEL)))
                    return -ENOMEM;
               /* Order will hold the indexes of the clients
                  sorted by address */
