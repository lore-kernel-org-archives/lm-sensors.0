From: Matthew Garrett <mjg@redhat.com>
Date: Thu, 16 Dec 2010 15:33:09 +0000
Subject: [lm-sensors] [PATCH 2/2] applesmc: Perform some more sanity
Message-Id: <1292513589-14651-2-git-send-email-mjg@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292513589-14651-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1292513589-14651-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rydberg@euromail.se
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Matthew Garrett <mjg@redhat.com>

It seems that the two-byte temperature format is intended to be signed
("sp78" appears to mean "signed, decimal point, 7 bits before, 8 bits
after") and it doesn't seem terribly plausible that we'll get any of these
machines below freezing. It's probably more reasonable to assume that
negative values indicate errors and drop them.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/hwmon/applesmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index dbe3fa6..d7ec678 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -739,6 +739,10 @@ static ssize_t applesmc_show_temperature(struct device *dev,
 		return ret;
 
 	if (entry->len = 2) {
+		if (buffer[0] >= 0x80) {
+			/* The two byte format is signed - ignore negative */
+			return -EINVAL;
+		}
 		temp = buffer[0] * 1000;
 		temp += (buffer[1] >> 6) * 250;
 	} else {
-- 
1.7.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
