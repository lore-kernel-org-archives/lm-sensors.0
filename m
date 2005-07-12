From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:33 +0000
Subject: [lm-sensors] [PATCH] w1: fix CRC calculation on bigendian platforms.
Message-Id: <11211193771329@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1121119377358@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: johnpol@2ka.mipt.ru

[PATCH] w1: fix CRC calculation on bigendian platforms.

In the 2.6.13-rc1 code the "rn" structure is in the wrong-endianness
when passed to w1_attach_slave_device(). This causes problems like the
family and crc being swapped around.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0e65f82814e9828d3ff54988de9e7c0b36794daa
tree a4d5dfb9ab550160a453c6266fe67d18ace76857
parent 80efa8c72006a1c04004f8fb07b22073348e4bf2
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 30 Jun 2005 22:52:38 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 drivers/w1/w1.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -516,6 +516,7 @@ static void w1_slave_found(unsigned long
 	struct w1_reg_num *tmp;
 	int family_found = 0;
 	struct w1_master *dev;
+	u64 rn_le = cpu_to_le64(rn);
 
 	dev = w1_search_master(data);
 	if (!dev) {
@@ -544,10 +545,8 @@ static void w1_slave_found(unsigned long
 		slave_count++;
 	}
 
-	rn = cpu_to_le64(rn);
-
 	if (slave_count = dev->slave_count &&
-		rn && ((le64_to_cpu(rn) >> 56) & 0xff) = w1_calc_crc8((u8 *)&rn, 7)) {
+		rn && ((rn >> 56) & 0xff) = w1_calc_crc8((u8 *)&rn_le, 7)) {
 		w1_attach_slave_device(dev, tmp);
 	}
 

