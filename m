From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 11:50:25 +0000
Subject: [lm-sensors] [PATCH 2/2] asus_atk0110: enable the EC
Message-Id: <20091006123515.692900377@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On newer ASUS boards (e.g. P7P55D) the EC (that - among other things - is
responsible for updating the readings from the hwmon sensors) is disabled
by default since ASUS detected conflict with some tools under Windows.
The following patch checks the state of the EC and enable it if needed;
under Linux native drivers are locked out from ACPI owned resources so
there's no risk of conflict.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Tested-by: Robert Hancock <hancockrwd@gmail.com>
Tested-by: Thomas Backlund <tmb@mandriva.org>
---
 drivers/hwmon/asus_atk0110.c |  185 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 1 deletion(-)

Index: linux-2.6.git/drivers/hwmon/asus_atk0110.c
=================================--- linux-2.6.git.orig/drivers/hwmon/asus_atk0110.c	2009-10-05 17:27:00.000000000 +0200
+++ linux-2.6.git/drivers/hwmon/asus_atk0110.c	2009-10-05 17:27:01.000000000 +0200
@@ -35,18 +35,22 @@
 #define METHOD_OLD_ENUM_FAN	"FSIF"
 
 #define ATK_MUX_HWMON		0x00000006ULL
+#define ATK_MUX_MGMT		0x00000011ULL
 
 #define ATK_CLASS_MASK		0xff000000ULL
 #define ATK_CLASS_FREQ_CTL	0x03000000ULL
 #define ATK_CLASS_FAN_CTL	0x04000000ULL
 #define ATK_CLASS_HWMON		0x06000000ULL
+#define ATK_CLASS_MGMT		0x11000000ULL
 
 #define ATK_TYPE_MASK		0x00ff0000ULL
 #define HWMON_TYPE_VOLT		0x00020000ULL
 #define HWMON_TYPE_TEMP		0x00030000ULL
 #define HWMON_TYPE_FAN		0x00040000ULL
 
-#define HWMON_SENSOR_ID_MASK	0x0000ffffULL
+#define ATK_ELEMENT_ID_MASK	0x0000ffffULL
+
+#define ATK_EC_ID		0x11060004ULL
 
 enum atk_pack_member {
 	HWMON_PACK_FLAGS,
@@ -89,6 +93,9 @@
 	/* new inteface */
 	acpi_handle enumerate_handle;
 	acpi_handle read_handle;
+	acpi_handle write_handle;
+
+	bool disable_ec;
 
 	int voltage_count;
 	int temperature_count;
@@ -529,6 +536,43 @@
 	return obj;
 }
 
+static union acpi_object *atk_sitm(struct atk_data *data,
+		struct atk_acpi_input_buf *buf)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	struct acpi_object_list params;
+	union acpi_object tmp;
+	struct acpi_buffer ret;
+	union acpi_object *obj;
+	acpi_status status;
+
+	tmp.type = ACPI_TYPE_BUFFER;
+	tmp.buffer.pointer = (u8 *)buf;
+	tmp.buffer.length = sizeof(*buf);
+
+	params.count = 1;
+	params.pointer = &tmp;
+
+	ret.length = ACPI_ALLOCATE_BUFFER;
+	status = acpi_evaluate_object_typed(data->write_handle, NULL, &params,
+			&ret, ACPI_TYPE_BUFFER);
+	if (status != AE_OK) {
+		dev_warn(dev, "SITM[%#x] ACPI exception: %s\n", buf->id,
+				acpi_format_exception(status));
+		return ERR_PTR(-EIO);
+	}
+	obj = ret.pointer;
+
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
 static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
 {
 	struct atk_data *data = sensor->data;
@@ -784,6 +828,111 @@
 	return ret;
 }
 
+static int atk_ec_present(struct atk_data *data)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *pack;
+	union acpi_object *ec;
+	int ret;
+	int i;
+
+	pack = atk_ggrp(data, ATK_MUX_MGMT);
+	if (IS_ERR(pack)) {
+		if (PTR_ERR(pack) = -ENOENT) {
+			/* The MGMT class does not exists - that's ok */
+			dev_dbg(dev, "Class %#llx not found\n", ATK_MUX_MGMT);
+			return 0;
+		}
+		return PTR_ERR(pack);
+	}
+
+	/* Search the EC */
+	ec = NULL;
+	for (i = 0; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+		union acpi_object *id;
+
+		if (obj->type != ACPI_TYPE_PACKAGE)
+			continue;
+
+		id = &obj->package.elements[0];
+		if (id->type != ACPI_TYPE_INTEGER)
+			continue;
+
+		if (id->integer.value = ATK_EC_ID) {
+			ec = obj;
+			break;
+		}
+	}
+
+	ret = (ec != NULL);
+	if (!ret)
+		/* The system has no EC */
+		dev_dbg(dev, "EC not found\n");
+
+	ACPI_FREE(pack);
+	return ret;
+}
+
+static int atk_ec_enabled(struct atk_data *data)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_ret_buffer *buf;
+	int err;
+
+	obj = atk_gitm(data, ATK_EC_ID);
+	if (IS_ERR(obj)) {
+		dev_err(dev, "Unable to query EC status\n");
+		return PTR_ERR(obj);
+	}
+	buf = (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+
+	if (buf->flags = 0) {
+		dev_err(dev, "Unable to query EC status\n");
+		err = -EIO;
+	} else {
+		err = (buf->value != 0);
+		dev_dbg(dev, "EC is %sabled\n",
+				err ? "en" : "dis");
+	}
+
+	ACPI_FREE(obj);
+	return err;
+}
+
+static int atk_ec_ctl(struct atk_data *data, int enable)
+{
+	struct device *dev = &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_input_buf sitm;
+	struct atk_acpi_ret_buffer *ec_ret;
+	int err = 0;
+
+	sitm.id = ATK_EC_ID;
+	sitm.param1 = enable;
+	sitm.param2 = 0;
+
+	obj = atk_sitm(data, &sitm);
+	if (IS_ERR(obj)) {
+		dev_err(dev, "Failed to %sable the EC\n",
+				enable ? "en" : "dis");
+		return PTR_ERR(obj);
+	}
+	ec_ret = (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+	if (ec_ret->flags = 0) {
+		dev_err(dev, "Failed to %sable the EC\n",
+				enable ? "en" : "dis");
+		err = -EIO;
+	} else {
+		dev_info(dev, "EC %sabled\n",
+				enable ? "en" : "dis");
+	}
+
+	ACPI_FREE(obj);
+	return err;
+}
+
 static int atk_enumerate_new_hwmon(struct atk_data *data)
 {
 	struct device *dev = &data->acpi_dev->dev;
@@ -791,6 +940,23 @@
 	int err;
 	int i;
 
+	err = atk_ec_present(data);
+	if (err < 0)
+		return err;
+	if (err) {
+		err = atk_ec_enabled(data);
+		if (err < 0)
+			return err;
+		/* If the EC was disabled we will disable it again on unload */
+		data->disable_ec = err;
+
+		err = atk_ec_ctl(data, 1);
+		if (err) {
+			data->disable_ec = false;
+			return err;
+		}
+	}
+
 	dev_dbg(dev, "Enumerating hwmon sensors\n");
 
 	pack = atk_ggrp(data, ATK_MUX_HWMON);
@@ -941,6 +1107,15 @@
 	}
 	data->read_handle = ret;
 
+	/* De-multiplexer (write) */
+	status = acpi_get_handle(data->atk_handle, METHOD_WRITE, &ret);
+	if (status != AE_OK) {
+		dev_dbg(dev, "method " METHOD_READ " not found: %s\n",
+				 acpi_format_exception(status));
+		return -ENODEV;
+	}
+	data->write_handle = ret;
+
 	return 0;
 }
 
@@ -961,6 +1136,7 @@
 	data->acpi_dev = device;
 	data->atk_handle = device->handle;
 	INIT_LIST_HEAD(&data->sensor_list);
+	data->disable_ec = false;
 
 	buf.length = ACPI_ALLOCATE_BUFFER;
 	ret = acpi_evaluate_object_typed(data->atk_handle, BOARD_ID, NULL,
@@ -1019,6 +1195,8 @@
 cleanup:
 	atk_free_sensors(data);
 out:
+	if (data->disable_ec)
+		atk_ec_ctl(data, 0);
 	kfree(data);
 	return err;
 }
@@ -1034,6 +1212,11 @@
 	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
 
+	if (data->disable_ec) {
+		if (atk_ec_ctl(data, 0))
+			dev_err(&device->dev, "Failed to disable EC\n");
+	}
+
 	kfree(data);
 
 	return 0;



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
