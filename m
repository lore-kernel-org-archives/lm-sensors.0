From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Date: Wed, 12 Dec 2012 19:57:08 +0000
Subject: [lm-sensors] [PATCH] AMD: Add support to sensors-detect for AMD family 16h power driver
Message-Id: <1355342228-9291-1-git-send-email-boris.ostrovsky@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Load fam15h_power driver on family 16h processors

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
---
 prog/detect/sensors-detect |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 2291534..420ab1a 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2349,6 +2349,10 @@ use vars qw(@cpu_ids);
 		driver => "fam15h_power",
 		detect => sub { amd_pci_detect('1604') },
 	}, {
+		name => "AMD Family 16h power sensors",
+		driver => "fam15h_power",
+		detect => sub { amd_pci_detect('1534') },
+	}, {
 		name => "Intel digital thermal sensor",
 		driver => "coretemp",
 		detect => \&coretemp_detect,
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
