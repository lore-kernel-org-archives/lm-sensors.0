From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:35 +0000
Subject: [lm-sensors] [PATCH 15/39] k8temp: Enable automatic loading
Message-Id: <1159483787606-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Let the k8temp driver load automatically.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/k8temp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 50162ff..f58b64e 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -133,6 +133,8 @@ static struct pci_device_id k8temp_ids[]
 	{ 0 },
 };
 
+MODULE_DEVICE_TABLE(pci, k8temp_ids);
+
 static int __devinit k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
-- 
1.4.2.1


