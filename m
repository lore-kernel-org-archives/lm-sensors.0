From: rddunlap@osdl.org (Randy.Dunlap)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] W1: fix printk format warning
Message-Id: <20050302215345.6e8d51df.rddunlap@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Use 'unsigned long long' for __u64 printk:

drivers/w1/w1.c:415: warning: long long unsigned int format, __u64 arg (arg 6)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat: drivers/w1/w1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/w1/w1.c~w1_printk ./drivers/w1/w1.c
--- ./drivers/w1/w1.c~w1_printk	2005-03-01 23:37:54.000000000 -0800
+++ ./drivers/w1/w1.c	2005-03-02 13:17:15.534605432 -0800
@@ -413,7 +413,8 @@ static int w1_attach_slave_device(struct
 	if (!f) {
 		spin_unlock(&w1_flock);
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
-			  rn->family, rn->family, rn->id, rn->crc);
+			  rn->family, rn->family,
+			  (unsigned long long)rn->id, rn->crc);
 		kfree(sl);
 		return -ENODEV;
 	}


---
