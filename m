From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [PATCH]  i2c/doc/writing-clients
Message-Id: <200209131420.AA00055@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

attached patch fix bug in i2c/doc/writing-clients

Index: writing-clients
=================================RCS file: /home/cvs/i2c/doc/writing-clients,v
retrieving revision 1.16
diff -u -r1.16 writing-clients
--- writing-clients	2001/11/11 23:03:40	1.16
+++ writing-clients	2002/09/13 14:23:51
@@ -448,9 +448,9 @@
     /* Note that we reserve some space for foo_data too. If you don't
        need it, remove it. We do it here to help to lessen memory
        fragmentation. */
-    if (! (new_client = kmalloc(sizeof(struct i2c_client)) + 
+    if (! (new_client = kmalloc(sizeof(struct i2c_client) + 
                                 sizeof(struct foo_data),
-                                GFP_KERNEL)) {
+                                GFP_KERNEL))) {
       err = -ENOMEM;
       goto ERROR0;
     }

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
