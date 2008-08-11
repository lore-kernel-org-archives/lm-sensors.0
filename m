From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 11 Aug 2008 23:42:49 +0000
Subject: [lm-sensors] [PATCH] ibmaem: Don't query the entire sensor
Message-Id: <20080811234249.GC28331@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>

Currently, all sensors are read when the energy meter is queried via sysfs.
This introduces a considerable amount of delay and variation in the sysfs
reading, which is not desirable when trying to profile energy use.  Therefore,
read only the energy meters when a sysfs query comes in for them, and don't
cache the results so that we always get the latest reading.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmaem.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index c9416e6..f660216 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -463,12 +463,18 @@ static int aem_read_sensor(struct aem_data *data, u8 elt, u8 reg,
 }
 
 /* Update AEM energy registers */
+static void update_aem_energy_one(struct aem_data *data, int which)
+{
+	aem_read_sensor(data, AEM_ENERGY_ELEMENT, which,
+			&data->energy[which], 8);
+}
+
 static void update_aem_energy(struct aem_data *data)
 {
-	aem_read_sensor(data, AEM_ENERGY_ELEMENT, 0, &data->energy[0], 8);
+	update_aem_energy_one(data, 0);
 	if (data->ver_major < 2)
 		return;
-	aem_read_sensor(data, AEM_ENERGY_ELEMENT, 1, &data->energy[1], 8);
+	update_aem_energy_one(data, 1);
 }
 
 /* Update all AEM1 sensors */
@@ -849,7 +855,7 @@ static ssize_t aem_show_power(struct device *dev,
 	struct timespec b, a;
 
 	mutex_lock(&data->lock);
-	update_aem_energy(data);
+	update_aem_energy_one(data, attr->index);
 	getnstimeofday(&b);
 	before = data->energy[attr->index];
 
@@ -861,7 +867,7 @@ static ssize_t aem_show_power(struct device *dev,
 		return 0;
 	}
 
-	update_aem_energy(data);
+	update_aem_energy_one(data, attr->index);
 	getnstimeofday(&a);
 	after = data->energy[attr->index];
 	mutex_unlock(&data->lock);
@@ -880,7 +886,9 @@ static ssize_t aem_show_energy(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct aem_data *a = dev_get_drvdata(dev);
-	a->update(a);
+	mutex_lock(&a->lock);
+	update_aem_energy_one(a, attr->index);
+	mutex_unlock(&a->lock);
 
 	return sprintf(buf, "%llu\n",
 			(unsigned long long)a->energy[attr->index] * 1000);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
