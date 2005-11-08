From: gregkh@suse.de (Greg KH)
Date: Tue, 08 Nov 2005 06:53:11 +0000
Subject: [lm-sensors] [PATCH] i2c: writing-client doc update complement
Message-Id: <11314291491176@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: writing-client doc update complement

My latest update to the writing-clients i2c documentation file was
incomplete, here's the complement.

Large parts of this file are still way out-of-date, but at least now
the memory allocation and freeing instructions are consistent.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a852daa00ad91350fe603da47becaf3d5af4f2bd
tree cfc31cd212deea34d866ec021aee886f0224c199
parent f093182d313edde9b1f86dbdaf40ba4da2dbd0e7
author Jean Delvare <khali@linux-fr.org> Wed, 02 Nov 2005 21:42:48 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 07 Nov 2005 21:46:37 -0800

 Documentation/i2c/writing-clients |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index cff7b65..d19993c 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -412,7 +412,7 @@ For now, you can ignore the `flags' para
         release_region(address,FOO_EXTENT);
     /* SENSORS ONLY END */
     ERROR1:
-      kfree(new_client);
+      kfree(data);
     ERROR0:
       return err;
   }
@@ -443,7 +443,7 @@ much simpler than the attachment code, f
       release_region(client->addr,LM78_EXTENT);
     /* HYBRID SENSORS CHIP ONLY END */
 
-    kfree(data);
+    kfree(i2c_get_clientdata(client));
     return 0;
   }
 

