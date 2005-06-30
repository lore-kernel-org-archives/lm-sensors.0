From: blofeldus@yahoo.com (roger blofeld)
Date: Thu, 30 Jun 2005 17:48:27 +0000
Subject: [lm-sensors] [RESEND][PATCH] fix w1 for big-endian
Message-Id: <20050630154751.82729.qmail@web53501.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi
 In the 2.6.13-rc1 code the "rn" structure is in the wrong-endianness
when
passed to w1_attach_slave_device(). This causes problems like the
family and crc being swapped around. The following patch fixes the
problem for me.

 I sent this earlier to greg k-h & lkml, but he said I should send it
here first.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
-------------- next part --------------
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -493,6 +493,7 @@ void w1_slave_found(unsigned long data, 
 	struct w1_reg_num *tmp;
 	int family_found = 0;
 	struct w1_master *dev;
+	u64 rn_le = cpu_to_le64(rn);
 
 	dev = w1_search_master(data);
 	if (!dev) {
@@ -522,10 +523,8 @@ void w1_slave_found(unsigned long data, 
 		slave_count++;
 	}
 
-	rn = cpu_to_le64(rn);
-
 	if (slave_count = dev->slave_count &&
-		rn && ((le64_to_cpu(rn) >> 56) & 0xff) = w1_calc_crc8((u8 *)&rn, 7)) {
+		rn && ((rn >> 56) & 0xff) = w1_calc_crc8((u8 *)&rn_le, 7)) {
 		w1_attach_slave_device(dev, tmp);
 	}
 			
