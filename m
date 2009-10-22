From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 22 Oct 2009 01:01:37 +0000
Subject: [lm-sensors] [PATCH] acpi_power_meter: Don't leak ACPI error codes
Message-Id: <20091022010137.GB21723@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

acpi-power-meter: Don't leak ACPI error codes to userspace

If the ACPI methods return an error code, we must return -EINVAL to userspace
to flag the error.  Right now we pass the (positive) number right through,
which causes echo to keep writing bogus values.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/acpi/power_meter.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
index e6bfd77..2ef7030 100644
--- a/drivers/acpi/power_meter.c
+++ b/drivers/acpi/power_meter.c
@@ -294,7 +294,11 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 		return -EINVAL;
 	}
 
-	return data;
+	/* _PTP returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
+
+	return 0;
 }
 
 static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
