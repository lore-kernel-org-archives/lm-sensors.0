From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 21 Jul 2009 09:27:42 +0000
Subject: [lm-sensors] [PATCH] asus_atk0110: fix limit readings
Message-Id: <20090721092742.GA11055@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On newer Asus boards the "upper" limit of a sensor is encoded as delta from the
"lower" limit. Fix the driver to correctly handle this case.
Note that the bug is purely cosmetic.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Tested-by: Alex Macfarlane Smith <nospam@archifishal.co.uk>
---

 drivers/hwmon/asus_atk0110.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index bff0103..fe4fa29 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -593,7 +593,11 @@ static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 	sensor->data = data;
 	sensor->id = flags->integer.value;
 	sensor->limit1 = limit1->integer.value;
-	sensor->limit2 = limit2->integer.value;
+	if (data->old_interface)
+		sensor->limit2 = limit2->integer.value;
+	else
+		/* The upper limit is expressed as delta from lower limit */
+		sensor->limit2 = sensor->limit1 + limit2->integer.value;
 
 	snprintf(sensor->input_attr_name, ATTR_NAME_SIZE,
 			"%s%d_input", base_name, start + *num);

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
