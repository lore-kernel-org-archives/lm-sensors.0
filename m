From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:28:59 +0000
Subject: [lm-sensors] [PATCH] i2c: Documentation update
Message-Id: <1130533662661@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Documentation update

Update the i2c documentation: kzalloc should be used instead of
kmalloc.

I also fixed a couple other things nearby in writing-clients, as several
past changes had never been reported there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2445eb62e98250f1ec8cbc8cf7c4be9cfafe88e5
tree d378cbfddb05c37d09cf03c71f070b02aed7a9cc
parent deb875c7ff2ef417a2daff41ee4b357098b7ab10
author Jean Delvare <khali@linux-fr.org> Mon, 17 Oct 2005 23:16:25 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:12 -0700

 Documentation/i2c/porting-clients |    2 +-
 Documentation/i2c/writing-clients |   16 +++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
index 4849dfd..184fac2 100644
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -82,7 +82,7 @@ Technical changes:
   exit and exit_free. For i2c+isa drivers, labels should be named
   ERROR0, ERROR1 and ERROR2. Don't forget to properly set err before
   jumping to error labels. By the way, labels should be left-aligned.
-  Use memset to fill the client and data area with 0x00.
+  Use kzalloc instead of kmalloc.
   Use i2c_set_clientdata to set the client data (as opposed to
   a direct access to client->data).
   Use strlcpy instead of strcpy to copy the client name.
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 1882811..e94d9c6 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -55,6 +55,7 @@ be very useful.
 An example structure is below.
 
   struct foo_data {
+    struct i2c_client client;
     struct semaphore lock; /* For ISA access in `sensors' drivers. */
     int sysctl_id;         /* To keep the /proc directory entry for 
                               `sensors' drivers. */
@@ -307,22 +308,15 @@ For now, you can ignore the `flags' para
        client structure, even though we cannot fill it completely yet.
        But it allows us to access several i2c functions safely */
     
-    /* Note that we reserve some space for foo_data too. If you don't
-       need it, remove it. We do it here to help to lessen memory
-       fragmentation. */
-    if (! (new_client = kmalloc(sizeof(struct i2c_client) + 
-                                sizeof(struct foo_data),
-                                GFP_KERNEL))) {
+    if (!(data = kzalloc(sizeof(struct foo_data), GFP_KERNEL))) {
       err = -ENOMEM;
       goto ERROR0;
     }
 
-    /* This is tricky, but it will set the data to the right value. */
-    client->data = new_client + 1;
-    data = (struct foo_data *) (client->data);
+    new_client = &data->client;
+    i2c_set_clientdata(new_client, data);
 
     new_client->addr = address;
-    new_client->data = data;
     new_client->adapter = adapter;
     new_client->driver = &foo_driver;
     new_client->flags = 0;
@@ -448,7 +442,7 @@ much simpler than the attachment code, f
       release_region(client->addr,LM78_EXTENT);
     /* HYBRID SENSORS CHIP ONLY END */
 
-    kfree(client); /* Frees client data too, if allocated at the same time */
+    kfree(data);
     return 0;
   }
 

