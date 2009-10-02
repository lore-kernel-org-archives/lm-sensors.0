From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 02 Oct 2009 12:26:36 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <20091002122636.GA25505@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <51f3faa70909282134o1d60efekeded09f09b192df6@mail.gmail.com>
 <68676e00909290707u70d192f2j2f2d4dd07bd07234@mail.gmail.com>
 <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com>
 <4AC21E7B.70000@mandriva.org>
 <51f3faa70909301638s4eff14edg46420e2e8877fd15@mail.gmail.com>
 <20091001085002.1dbc7eee@hyperion.delvare>
 <51f3faa70910010740s2a412d07qf29f56ad8a3c59eb@mail.gmail.com>
 <20091001144914.GA18675@nb-core2.darkstar.lan>
 <4AC4D6F5.6080005@mandriva.org>
 <68676e00910011205t506604e5y5a0a04fec0821dc0@mail.gmail.com>
In-Reply-To: <68676e00910011205t506604e5y5a0a04fec0821dc0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Backlund <tmb@mandriva.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>

On Thu, Oct 01, 2009 at 09:05:36PM +0200, Luca Tettamanti wrote:
> On Thu, Oct 1, 2009 at 6:21 PM, Thomas Backlund <tmb@mandriva.org> wrote:
> > Luca Tettamanti wrote:
> >>
> >> On Thu, Oct 01, 2009 at 08:40:59AM -0600, Robert Hancock wrote:
> >>>
> >>> On Thu, Oct 1, 2009 at 12:50 AM, Jean Delvare <khali@linux-fr.org> wr=
ote:
> >>>>
> >>>> On Wed, 30 Sep 2009 17:38:21 -0600, Robert Hancock wrote:
> >>>>>
> >>>>> On Tue, Sep 29, 2009 at 8:49 AM, Thomas Backlund <tmb@mandriva.org>
> >>>>> wrote:
> >>>>>>
> >>>>>> Try this one:
> >>>>>> http://marc.info/?l=3Dlinux-kernel&m=125421276407283&w=3D2
> >>>>>
> >>>>> With that patch it's lasted almost a day with no timeouts, previous=
ly
> >>>>> I was getting about one every hour. Has that patch been submitted?
> >>>>
> >>>> Do you mean you're still getting timeouts but they are less frequent,
> >>>> or you did not get any timeout at all so far?
> >>>
> >>> So far no timeout at all (after about 36 hours).
> >>
> >> Good. I have a new patch for you then :P
> >>
> >> This version checks whether the EC is already enabled or not before
> >> touching it
> >> and also restore the state when the module is unloaded.
> >> You should check that the driver keeps working when is unloaded and
> >> reloaded.
> >>
> >
> > I tried your latest patch on a P7P55D Deluxe and get this:
> >>
> >> [ =A0 10.419119] ACPI Error: Field [PR11] at 64 exceeds Buffer [NULL] =
size
> >> 32 (bits) (20090903/dsopcode-596)
> >> [ =A0 10.419125] ACPI Error (psparse-0537): Method parse/execution fai=
led
> >> [\_SB_.PCI0.SBRG.ASOC.GITM] (Node ffff88023f8147a0), AE_AML_BUFFER_LIM=
IT
> >> [ =A0 10.419157] ATK0110 ATK0110:00: GITM[0x11060004] ACPI exception:
> >> AE_AML_BUFFER_LIMIT
> >> [ =A0 10.419158] ATK0110 ATK0110:00: Unable to query EC status
> >> [ =A0 10.419161] ATK0110: probe of ATK0110:00 failed with error -5
>=20
> I see. GITM probably expects the same buffer structure as SITM, though
> in older models the upper bits were never used (hence I never noticed
> the problem). Working on a patch.

Ok, here it is:

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index fe4fa29..6cda109 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -35,18 +35,22 @@
 #define METHOD_OLD_ENUM_FAN	"FSIF"
=20
 #define ATK_MUX_HWMON		0x00000006ULL
+#define ATK_MUX_MGMT		0x00000011ULL
=20
 #define ATK_CLASS_MASK		0xff000000ULL
 #define ATK_CLASS_FREQ_CTL	0x03000000ULL
 #define ATK_CLASS_FAN_CTL	0x04000000ULL
 #define ATK_CLASS_HWMON		0x06000000ULL
+#define ATK_CLASS_MGMT		0x11000000ULL
=20
 #define ATK_TYPE_MASK		0x00ff0000ULL
 #define HWMON_TYPE_VOLT		0x00020000ULL
 #define HWMON_TYPE_TEMP		0x00030000ULL
 #define HWMON_TYPE_FAN		0x00040000ULL
=20
-#define HWMON_SENSOR_ID_MASK	0x0000ffffULL
+#define ATK_ELEMENT_ID_MASK	0x0000ffffULL
+
+#define ATK_EC_ID		0x11060004ULL
=20
 enum atk_pack_member {
 	HWMON_PACK_FLAGS,
@@ -89,6 +93,9 @@ struct atk_data {
 	/* new inteface */
 	acpi_handle enumerate_handle;
 	acpi_handle read_handle;
+	acpi_handle write_handle;
+
+	bool disable_ec;
=20
 	int voltage_count;
 	int temperature_count;
@@ -129,9 +136,22 @@ struct atk_sensor_data {
 	char const *acpi_name;
 };
=20
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
=20
 static int atk_add(struct acpi_device *device);
@@ -439,52 +459,146 @@ static int atk_read_value_old(struct atk_sensor_data=
 *sensor, u64 *value)
 	return 0;
 }
=20
-static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
+static union acpi_object *atk_ggrp(struct atk_data *data, u16 mux)
 {
-	struct atk_data *data =3D sensor->data;
 	struct device *dev =3D &data->acpi_dev->dev;
+	struct acpi_buffer buf;
+	acpi_status ret;
 	struct acpi_object_list params;
-	struct acpi_buffer ret;
 	union acpi_object id;
-	struct atk_acpi_buffer_u64 tmp;
-	acpi_status status;
+	union acpi_object *pack;
=20
 	id.type =3D ACPI_TYPE_INTEGER;
-	id.integer.value =3D sensor->id;
-
+	id.integer.value =3D mux;
 	params.count =3D 1;
 	params.pointer =3D &id;
=20
-	tmp.buf.type =3D ACPI_TYPE_BUFFER;
-	tmp.buf.buffer.pointer =3D (u8 *)&tmp.value;
-	tmp.buf.buffer.length =3D sizeof(u64);
-	ret.length =3D sizeof(tmp);
-	ret.pointer =3D &tmp;
+	buf.length =3D ACPI_ALLOCATE_BUFFER;
+	ret =3D acpi_evaluate_object(data->enumerate_handle, NULL, &params, &buf);
+	if (ret !=3D AE_OK) {
+		dev_err(dev, "GGRP[%#x] ACPI exception: %s\n", mux,
+				acpi_format_exception(ret));
+		return ERR_PTR(-EIO);
+	}
+	pack =3D buf.pointer;
+	if (pack->type !=3D ACPI_TYPE_PACKAGE) {
+		/* Execution was successful, but the id was not found */
+		ACPI_FREE(pack);
+		return ERR_PTR(-ENOENT);
+	}
+
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
+	struct device *dev =3D &data->acpi_dev->dev;
+	struct atk_acpi_input_buf buf;
+	union acpi_object tmp;
+	struct acpi_object_list params;
+	struct acpi_buffer ret;
+	union acpi_object *obj;
+	acpi_status status;
+
+	buf.id =3D id;
+	buf.param1 =3D 0;
+	buf.param2 =3D 0;
=20
+	tmp.type =3D ACPI_TYPE_BUFFER;
+	tmp.buffer.pointer =3D (u8 *)&buf;
+	tmp.buffer.length =3D sizeof(buf);
+
+	params.count =3D 1;
+	params.pointer =3D (void *)&tmp;
+
+	ret.length =3D ACPI_ALLOCATE_BUFFER;
 	status =3D acpi_evaluate_object_typed(data->read_handle, NULL, &params,
 			&ret, ACPI_TYPE_BUFFER);
 	if (status !=3D AE_OK) {
-		dev_warn(dev, "%s: ACPI exception: %s\n", __func__,
+		dev_warn(dev, "GITM[%#llx] ACPI exception: %s\n", id,
 				acpi_format_exception(status));
-		return -EIO;
+		return ERR_PTR(-EIO);
+	}
+	obj =3D ret.pointer;
+
+	/* Sanity check */
+	if (obj->buffer.length < 8) {
+		dev_warn(dev, "Unexpected ASBF length: %u\n",
+				obj->buffer.length);
+		ACPI_FREE(obj);
+		return ERR_PTR(-EIO);
 	}
+	return obj;
+}
=20
-	/* Return buffer format:
-	 * [0-3] "value" is valid flag
-	 * [4-7] value
-	 */
-	if (!(tmp.value & 0xffffffff)) {
+static union acpi_object *atk_sitm(struct atk_data *data,
+		struct atk_acpi_input_buf *buf)
+{
+	struct device *dev =3D &data->acpi_dev->dev;
+	struct acpi_object_list params;
+	union acpi_object tmp;
+	struct acpi_buffer ret;
+	union acpi_object *obj;
+	acpi_status status;
+
+	tmp.type =3D ACPI_TYPE_BUFFER;
+	tmp.buffer.pointer =3D (u8 *)buf;
+	tmp.buffer.length =3D sizeof(*buf);
+
+	params.count =3D 1;
+	params.pointer =3D &tmp;
+
+	status =3D acpi_evaluate_object_typed(data->write_handle, NULL, &params,
+			&ret, ACPI_TYPE_BUFFER);
+	if (status !=3D AE_OK) {
+		dev_warn(dev, "SITM[%#x] ACPI exception: %s\n", buf->id,
+				acpi_format_exception(status));
+		return ERR_PTR(-EIO);
+	}
+	obj =3D ret.pointer;
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
+static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
+{
+	struct atk_data *data =3D sensor->data;
+	struct device *dev =3D &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_ret_buffer *buf;
+	int err =3D 0;
+
+	obj =3D atk_gitm(data, sensor->id);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+
+	buf =3D (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+	if (buf->flags =3D 0) {
 		/* The reading is not valid, possible causes:
 		 * - sensor failure
 		 * - enumeration was FUBAR (and we didn't notice)
 		 */
-		dev_info(dev, "Failure: %#llx\n", tmp.value);
-		return -EIO;
+		dev_warn(dev, "Read failed, sensor =3D %#llx\n", sensor->id);
+		err =3D -EIO;
+		goto out;
 	}
=20
-	*value =3D (tmp.value & 0xffffffff00000000ULL) >> 32;
-
-	return 0;
+	*value =3D buf->value;
+out:
+	ACPI_FREE(obj);
+	return err;
 }
=20
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value)
@@ -713,43 +827,141 @@ cleanup:
 	return ret;
 }
=20
-static int atk_enumerate_new_hwmon(struct atk_data *data)
+static int atk_ec_present(struct atk_data *data)
 {
 	struct device *dev =3D &data->acpi_dev->dev;
-	struct acpi_buffer buf;
-	acpi_status ret;
-	struct acpi_object_list params;
-	union acpi_object id;
 	union acpi_object *pack;
-	int err;
+	union acpi_object *ec;
+	int ret;
 	int i;
=20
-	dev_dbg(dev, "Enumerating hwmon sensors\n");
+	pack =3D atk_ggrp(data, ATK_MUX_MGMT);
+	if (IS_ERR(pack)) {
+		if (PTR_ERR(pack) =3D -ENOENT) {
+			/* The MGMT class does not exists - that's ok */
+			dev_dbg(dev, "Class %#llx not found\n", ATK_MUX_MGMT);
+			return 0;
+		}
+		return PTR_ERR(pack);
+	}
=20
-	id.type =3D ACPI_TYPE_INTEGER;
-	id.integer.value =3D ATK_MUX_HWMON;
-	params.count =3D 1;
-	params.pointer =3D &id;
+	/* Search the EC */
+	ec =3D NULL;
+	for (i =3D 0; i < pack->package.count; i++) {
+		union acpi_object *obj =3D &pack->package.elements[i];
+		union acpi_object *id;
=20
-	buf.length =3D ACPI_ALLOCATE_BUFFER;
-	ret =3D acpi_evaluate_object_typed(data->enumerate_handle, NULL, &params,
-			&buf, ACPI_TYPE_PACKAGE);
-	if (ret !=3D AE_OK) {
-		dev_warn(dev, METHOD_ENUMERATE ": ACPI exception: %s\n",
-				acpi_format_exception(ret));
-		return -ENODEV;
+		if (obj->type !=3D ACPI_TYPE_PACKAGE)
+			continue;
+
+		id =3D &obj->package.elements[0];
+		if (id->type !=3D ACPI_TYPE_INTEGER)
+			continue;
+
+		if (id->integer.value =3D ATK_EC_ID) {
+			ec =3D obj;
+			break;
+		}
 	}
=20
-	/* Result must be a package */
-	pack =3D buf.pointer;
+	ret =3D (ec !=3D NULL);
+	if (!ret)
+		/* The system has no EC */
+		dev_dbg(dev, "EC not found\n");
=20
-	if (pack->package.count < 1) {
-		dev_dbg(dev, "%s: hwmon package is too small: %d\n", __func__,
-				pack->package.count);
-		err =3D -EINVAL;
-		goto out;
+	ACPI_FREE(pack);
+	return ret;
+}
+
+static int atk_ec_enabled(struct atk_data *data)
+{
+	struct device *dev =3D &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_ret_buffer *buf;
+	int err;
+
+	obj =3D atk_gitm(data, ATK_EC_ID);
+	if (IS_ERR(obj)) {
+		dev_err(dev, "Unable to query EC status\n");
+		return PTR_ERR(obj);
+	}
+	buf =3D (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+
+	if (buf->flags =3D 0) {
+		dev_err(dev, "Unable to query EC status\n");
+		err =3D -EIO;
+	} else {
+		err =3D (buf->value !=3D 0);
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
+	struct device *dev =3D &data->acpi_dev->dev;
+	union acpi_object *obj;
+	struct atk_acpi_input_buf sitm;
+	struct atk_acpi_ret_buffer *ec_ret;
+	int err =3D 0;
+
+	sitm.id =3D ATK_EC_ID;
+	sitm.param1 =3D enable;
+	sitm.param2 =3D 0;
+
+	obj =3D atk_sitm(data, &sitm);
+	if (IS_ERR(obj)) {
+		dev_err(dev, "Failed to %sable the EC\n",
+				enable ? "en" : "dis");
+		return PTR_ERR(obj);
+	}
+	ec_ret =3D (struct atk_acpi_ret_buffer *)obj->buffer.pointer;
+	if (ec_ret->flags =3D 0) {
+		dev_err(dev, "Failed to %sable the EC\n",
+				enable ? "en" : "dis");
+		err =3D -EIO;
+	} else {
+		dev_info(dev, "EC %sabled\n",
+				enable ? "en" : "dis");
+	}
+
+	ACPI_FREE(obj);
+	return err;
+}
+
+static int atk_enumerate_new_hwmon(struct atk_data *data)
+{
+	struct device *dev =3D &data->acpi_dev->dev;
+	union acpi_object *pack;
+	int err;
+	int i;
+
+	err =3D atk_ec_present(data);
+	if (err < 0)
+		return err;
+	if (err) {
+		err =3D atk_ec_enabled(data);
+		if (err < 0)
+			return err;
+		/* If the EC was disabled we will disable it again on unload */
+		data->disable_ec =3D err;
+
+		err =3D atk_ec_ctl(data, 1);
+		if (err) {
+			data->disable_ec =3D false;
+			return err;
+		}
 	}
=20
+	dev_dbg(dev, "Enumerating hwmon sensors\n");
+
+	pack =3D atk_ggrp(data, ATK_MUX_HWMON);
+	if (IS_ERR(pack))
+		return PTR_ERR(pack);
+
 	for (i =3D 0; i < pack->package.count; i++) {
 		union acpi_object *obj =3D &pack->package.elements[i];
=20
@@ -758,8 +970,7 @@ static int atk_enumerate_new_hwmon(struct atk_data *dat=
a)
=20
 	err =3D data->voltage_count + data->temperature_count + data->fan_count;
=20
-out:
-	ACPI_FREE(buf.pointer);
+	ACPI_FREE(pack);
 	return err;
 }
=20
@@ -895,6 +1106,15 @@ static int atk_check_new_if(struct atk_data *data)
 	}
 	data->read_handle =3D ret;
=20
+	/* De-multiplexer (write) */
+	status =3D acpi_get_handle(data->atk_handle, METHOD_WRITE, &ret);
+	if (status !=3D AE_OK) {
+		dev_dbg(dev, "method " METHOD_READ " not found: %s\n",
+				 acpi_format_exception(status));
+		return -ENODEV;
+	}
+	data->write_handle =3D ret;
+
 	return 0;
 }
=20
@@ -915,6 +1135,7 @@ static int atk_add(struct acpi_device *device)
 	data->acpi_dev =3D device;
 	data->atk_handle =3D device->handle;
 	INIT_LIST_HEAD(&data->sensor_list);
+	data->disable_ec =3D false;
=20
 	buf.length =3D ACPI_ALLOCATE_BUFFER;
 	ret =3D acpi_evaluate_object_typed(data->atk_handle, BOARD_ID, NULL,
@@ -973,6 +1194,8 @@ static int atk_add(struct acpi_device *device)
 cleanup:
 	atk_free_sensors(data);
 out:
+	if (data->disable_ec)
+		atk_ec_ctl(data, 0);
 	kfree(data);
 	return err;
 }
@@ -988,6 +1211,11 @@ static int atk_remove(struct acpi_device *device, int=
 type)
 	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
=20
+	if (data->disable_ec) {
+		if (atk_ec_ctl(data, 0))
+			dev_err(&device->dev, "Failed to disable EC\n");
+	}
+
 	kfree(data);
=20
 	return 0;

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
