From: Joe Perches <joe@perches.com>
Date: Tue, 02 Feb 2010 07:22:10 +0000
Subject: [lm-sensors] [PATCH 04/10] drivers/hwmon/vt8231.c: Fix continuation
Message-Id: <4a6cb6ef5a33d29220f021e2f28c7d676fff5e09.1265095094.git.joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1265095093.git.joe@perches.com>
In-Reply-To: <cover.1265095093.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Roger Lucas <vt8231@hiddenengine.co.uk>, lm-sensors@lm-sensors.org

String constants that are continued on subsequent lines with \
are not good.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hwmon/vt8231.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index d47b4c9..e6078c9 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -948,8 +948,7 @@ static int __devinit vt8231_pci_probe(struct pci_dev *dev,
 
 	address = val & ~(VT8231_EXTENT - 1);
 	if (address = 0) {
-		dev_err(&dev->dev, "base address not set -\
-				 upgrade BIOS or use force_addr=0xaddr\n");
+		dev_err(&dev->dev, "base address not set - upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
-- 
1.6.6.rc0.57.gad7a


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
