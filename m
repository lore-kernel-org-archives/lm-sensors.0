From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 14 Jan 2014 18:46:46 +0000
Subject: Re: [lm-sensors] Test patch
Message-Id: <CAAek22FMHR01907owU3Shzu1q96X_beWmg2XCjXxZqdOgQ82WA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add new PCI ID to k10temp in support of new model "Kaveri" family.

Signed-off-by: Philip Pokorny <ppokorny@penguincomputing.com>

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index d65f3fd..758774f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -210,6 +210,7 @@ static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
        { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
        { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
        { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
+       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
        { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
        {}
 };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
