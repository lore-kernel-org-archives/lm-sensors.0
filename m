From: Matthew Garrett <mjg@redhat.com>
Date: Fri, 17 Dec 2010 21:58:26 +0000
Subject: [lm-sensors] [PATCH 2/2] applesmc: Perform some more sanity
Message-Id: <1292623106-31684-2-git-send-email-mjg@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101216170018.GA8140@ericsson.com>
In-Reply-To: <20101216170018.GA8140@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: rydberg@euromail.se, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Matthew Garrett <mjg@redhat.com>

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
index 6c98b60..c1eead4 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -744,6 +744,10 @@ static ssize_t applesmc_show_temperature(struct device *dev,
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
