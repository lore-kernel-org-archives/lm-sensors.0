From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 11:50:24 +0000
Subject: [lm-sensors] [PATCH 1/2] asus_atk0110: Refactor the code
Message-Id: <20091006123515.580798691@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Refactor the code of the new style interface around GGRP (enumeration) and
GITM (read) helpers to mimic ASL code. Also switch the read path to use
dynamic buffers (handled by ACPI core) since ASUS expanded the return buffer
(ASBF) in newer boards (e.g. P7P55D).

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Tested-by: Robert Hancock <hancockrwd@gmail.com>
Tested-by: Thomas Backlund <tmb@mandriva.org>
---
 drivers/hwmon/asus_atk0110.c |  158 +++++++++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 56 deletions(-)

Index: linux-2.6.git/drivers/hwmon/asus_atk0110.c
=================================--- linux-2.6.git.orig/drivers/hwmon/asus_atk0110.c	2009-10-04 01:05:48.000000000 +0200
+++ linux-2.6.git/drivers/hwmon/asus_atk0110.c	2009-10-06 13:41:59.000000000 +0200
@@ -129,9 +129,22 @@
 	char const *acpi_name;
 };
 
-struct atk_acpi_buffer_u64 {
-	union acpi_object buf;
-	u64 value;
+/* Return buffer format:
+ * [0-3] "value" is valid flag
+ * [4-7] value
+ * [8- ] unknown stuff on newer mobos
+ */
+struct atk_acpi_ret_buffer {
+	u32 flags;
+	u32 value;
+	u8 data[];
+};
+
+/* Input buffer used for GITM and SITM methods */
+struct atk_acpi_input_buf {
+	u32 id;
+	u32 param1;
+	u32 param2;
 };
 
 static int atk_add(struct acpi_device *device);
@@ -439,52 +452,110 @@
 	return 0;
 }
 
-static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
+static union acpi_object *atk_ggrp(struct atk_data *data, u16 mux)
 {
-	struct atk_data *data = sensor->data;
 	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_buffer buf;
+	acpi_status ret;
 	struct acpi_object_list params;
-	struct acpi_buffer ret;
 	union acpi_object id;
-	struct atk_acpi_buffer_u64 tmp;
-	acpi_status status;
+	union acpi_object *pack;
 
 	id.type = ACPI_TYPE_INTEGER;
-	id.integer.value = sensor->id;
-
+	id.integer.value = mux;
 	params.count = 1;
 	params.pointer = &id;
 
-	tmp.buf.type = ACPI_TYPE_BUFFER;
-	tmp.buf.buffer.pointer = (u8 *)&tmp.value;
-	tmp.buf.buffer.length = sizeof(u64);
-	ret.length = sizeof(tmp);
-	ret.pointer = &tmp;
+	buf.length = ACPI_ALLOCATE_BUFFER;
+	ret = acpi_evaluate_object(data->enumerate_handle, NULL, &params, &buf);
+	if (ret != AE_OK) {
+		dev_err(dev, "GGRP[%#x] ACPI exception: %s\n", mux,
+				acpi_format_exception(ret));
+		return ERR_PTR(-EIO);
+	}
+	pack = buf.pointer;
+	if (pack->type != ACPI_TYPE_PACKAGE) {
+		/* Execution was successful, but the id was not found */
+		ACPI_FREE(pack);
+		return ERR_PTR(-ENOENT);
+	}
 
+	if (pack->package.count < 1) {
+		dev_err(dev, "GGRP[%#x] package is too small\n", mux);
+		ACPI_FREE(pack);
+		return ERR_PTR(-EIO);
+	}
+	return pack;
+}
+
+static union acpi_object *atk_gitm(struct atk_data *data, u64 id)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct atk_acpi_input_buf buf;
+	union acpi_object tmp;
+	struct acpi_object_list params;
+	struct acpi_buffer ret;
+	union acpi_object *obj;
+	acpi_status status;
+
+	buf.id = id;
+	buf.param1 = 0;
+	buf.param2 = 0;
+
+	tmp.type = ACPI_TYPE_BUFFER;
+	tmp.buffer.pointer = (u8 *)&buf;
+	tmp.buffer.length = sizeof(buf);
+
+	params.count = 1;
+	params.pointer = (void *)&tmp;
+
+	ret.length = ACPI_ALLOCATE_BUFFER;
 	status = acpi_evaluate_object_typed(data->read_handle, NULL, &params,
 			&ret, ACPI_TYPE_BUFFER);
 	if (status != AE_OK) {
-		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
+		dev_warn(dev, "GITM[%#llx] ACPI exception: %s\n", id,
 				acpi_format_exception(status));
-		return -EIO;
+		return ERR_PTR(-EIO);
 	}
+	obj = ret.pointer;
 
-	/* Return buffer format:
-	 * [0-3] "value" is valid flag
-	 * [4-7] value
-	 */
-	if (!(tmp.value & 0xffffffff)) {
+	/* Sanity check */
+	if (obj->buffer.length < 8) {
+		dev_warn(dev, "Unexpected ASBF length: %u\n",
+				obj->buffer.length);
+		ACPI_FREE(obj);
+		return ERR_PTR(-EIO);
+	}
+	return obj;
+}
+
+static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
+{
+	struct atk_data *data = sensor->data;
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_ret_buffer *buf;
+	int err = 0;
+
+	obj = atk_gitm(data, sensor->id);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+
+	buf = (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+	if (buf->flags = 0) {
 		/* The reading is not valid, possible causes:
 		 * - sensor failure
 		 * - enumeration was FUBAR (and we didn't notice)
 		 */
-		dev_info(dev, "Failure: %#llx\n", tmp.value);
-		return -EIO;
+		dev_warn(dev, "Read failed, sensor = %#llx\n", sensor->id);
+		err = -EIO;
+		goto out;
 	}
 
-	*value = (tmp.value & 0xffffffff00000000ULL) >> 32;
-
-	return 0;
+	*value = buf->value;
+out:
+	ACPI_FREE(obj);
+	return err;
 }
 
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value)
@@ -716,39 +787,15 @@
 static int atk_enumerate_new_hwmon(struct atk_data *data)
 {
 	struct device *dev = &data->acpi_dev->dev;
-	struct acpi_buffer buf;
-	acpi_status ret;
-	struct acpi_object_list params;
-	union acpi_object id;
 	union acpi_object *pack;
 	int err;
 	int i;
 
 	dev_dbg(dev, "Enumerating hwmon sensors\n");
 
-	id.type = ACPI_TYPE_INTEGER;
-	id.integer.value = ATK_MUX_HWMON;
-	params.count = 1;
-	params.pointer = &id;
-
-	buf.length = ACPI_ALLOCATE_BUFFER;
-	ret = acpi_evaluate_object_typed(data->enumerate_handle, NULL, &params,
-			&buf, ACPI_TYPE_PACKAGE);
-	if (ret != AE_OK) {
-		dev_warn(dev, METHOD_ENUMERATE ": ACPI exception: %s\n",
-				acpi_format_exception(ret));
-		return -ENODEV;
-	}
-
-	/* Result must be a package */
-	pack = buf.pointer;
-
-	if (pack->package.count < 1) {
-		dev_dbg(dev, "%s: hwmon package is too small: %d\n", __func__,
-				pack->package.count);
-		err = -EINVAL;
-		goto out;
-	}
+	pack = atk_ggrp(data, ATK_MUX_HWMON);
+	if (IS_ERR(pack))
+		return PTR_ERR(pack);
 
 	for (i = 0; i < pack->package.count; i++) {
 		union acpi_object *obj = &pack->package.elements[i];
@@ -758,8 +805,7 @@
 
 	err = data->voltage_count + data->temperature_count + data->fan_count;
 
-out:
-	ACPI_FREE(buf.pointer);
+	ACPI_FREE(pack);
 	return err;
 }
 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
