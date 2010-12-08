From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Dec 2010 09:22:29 +0000
Subject: [lm-sensors] Patch[1/2] Adding Core and Package Thermal Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C0E05F4E@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F4Ebgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Yu, Fenghua" <fenghua.yu@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Zhang, Rui" <rui.zhang@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>

--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F4Ebgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Fenghua,

This patch adds the core and package thermal threshold support to coretemp.=
c.
These thresholds can be read/written using the hwmon sysfs interfaces
temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].

These thresholds are managed dynamically to generate interrupts,
to do power management.

This patch is generated against the stable Linux-2.6 tree.

Kindly review and merge.
-------------------------------------------------------------------------

From: Durgadoss R <durgadoss.r@intel.com>

Date: Tue, 7 Dec 2010 03:27:00 +0530
Subject: [PATCH 1/2] Adding_Threshold_support_to_coretemp

This patch adds the core and package threshold support to coretemp.c.
These thresholds can be read/written using the sysfs interfaces
temp1_core_thresh[0/1] and temp1_pkg_thresh[0/1].
These can be used to generate interrupts, to do dynamic power management.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 arch/x86/include/asm/msr-index.h |   12 ++
 drivers/hwmon/coretemp.c         |  225 ++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 233 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h
index 3ea3dc4..f0fea26 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -253,6 +253,18 @@
 #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
 #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
=20
+/* Threshold Support */
+#define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
+#define THERM_OFFSET_THRESHOLD0        8
+#define THERM_MASK_THRESHOLD0          (0x7f << THERM_OFFSET_THRESHOLD0)
+#define THERM_INT_THRESHOLD1_ENABLE    (1 << 23)
+#define THERM_OFFSET_THRESHOLD1        16
+#define THERM_MASK_THRESHOLD1          (0x7f << THERM_OFFSET_THRESHOLD1)
+#define THERM_STATUS_THRESHOLD0        (1 << 6)
+#define THERM_LOG_THRESHOLD0           (1 << 7)
+#define THERM_STATUS_THRESHOLD1        (1 << 8)
+#define THERM_LOG_THRESHOLD1           (1 << 9)
+
 /* MISC_ENABLE bits: architectural */
 #define MSR_IA32_MISC_ENABLE_FAST_STRING	(1ULL << 0)
 #define MSR_IA32_MISC_ENABLE_TCC		(1ULL << 1)
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 42de98d..7aea83e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,6 +41,10 @@
=20
 typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 		SHOW_NAME } SHOW;
+/* C indicates core thermal thresholds
+ * P indicates Package thermal thresholds
+ */
+enum thresholds { C_TTHRESH0, C_TTHRESH1, P_TTHRESH0, P_TTHRESH1 } THRESH;
=20
 /*
  * Functions declaration
@@ -59,9 +63,18 @@ struct coretemp_data {
 	int temp;
 	int tjmax;
 	int ttarget;
+	int c_tthresh0;
+	int c_tthresh1;
+	int p_tthresh0;
+	int p_tthresh1;
+	int pkg_support;	/* zero if pkg thresh support is not there */
 	u8 alarm;
 };
=20
+static int set_core_threshold(struct coretemp_data *data, int val,
+						enum thresholds thresh);
+static int set_pkg_threshold(struct coretemp_data *data, int val,
+						enum thresholds thresh);
 /*
  * Sysfs stuff
  */
@@ -104,6 +117,48 @@ static ssize_t show_temp(struct device *dev,
 	return err;
 }
=20
+static ssize_t show_threshold(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct coretemp_data *data =3D coretemp_update_device(dev);
+
+	if (!data->valid)
+		return -EINVAL;
+
+	switch (attr->index) {
+	case C_TTHRESH0:
+		return sprintf(buf, "%d\n", data->c_tthresh0);
+	case C_TTHRESH1:
+		return sprintf(buf, "%d\n", data->c_tthresh1);
+	case P_TTHRESH0:
+		return sprintf(buf, "%d\n", data->p_tthresh0);
+	case P_TTHRESH1:
+		return sprintf(buf, "%d\n", data->p_tthresh1);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t set_threshold(struct device *dev,
+		struct device_attribute *devattr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
+	struct coretemp_data *data =3D coretemp_update_device(dev);
+	unsigned long val;
+	int err;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (attr->index =3D=3D C_TTHRESH0 || attr->index =3D=3D C_TTHRESH1)
+		err =3D set_core_threshold(data, val, attr->index);
+	else
+		err =3D set_pkg_threshold(data, val, attr->index);
+
+	return (err) ? -EINVAL : count;
+}
+
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
 			  SHOW_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
@@ -114,12 +169,23 @@ static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_al=
arm, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABE=
L);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
=20
+static SENSOR_DEVICE_ATTR(temp1_core_thresh0, S_IWUSR | S_IRUGO,
+				show_threshold,	set_threshold, C_TTHRESH0);
+static SENSOR_DEVICE_ATTR(temp1_core_thresh1, S_IWUSR | S_IRUGO,
+				show_threshold, set_threshold, C_TTHRESH1);
+static SENSOR_DEVICE_ATTR(temp1_pkg_thresh0, S_IWUSR | S_IRUGO,
+				show_threshold,	set_threshold, P_TTHRESH0);
+static SENSOR_DEVICE_ATTR(temp1_pkg_thresh1, S_IWUSR | S_IRUGO,
+				show_threshold, set_threshold, P_TTHRESH1);
+
 static struct attribute *coretemp_attributes[] =3D {
 	&sensor_dev_attr_name.dev_attr.attr,
 	&sensor_dev_attr_temp1_label.dev_attr.attr,
 	&dev_attr_temp1_crit_alarm.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_core_thresh0.dev_attr.attr,
+	&sensor_dev_attr_temp1_core_thresh1.dev_attr.attr,
 	NULL
 };
=20
@@ -298,6 +364,114 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
=20
+static int set_core_threshold(struct coretemp_data *data, int temp,
+						enum thresholds thresh)
+{
+	u32 eax, edx, l;
+	int diff;
+
+	if (temp > data->tjmax)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	diff =3D (data->tjmax - temp)/1000;
+
+	/* Mask the thermal vector in the lapic */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+
+	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, &eax, &edx);
+
+	if (thresh =3D=3D C_TTHRESH0) {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD0) |
+					(diff << THERM_OFFSET_THRESHOLD0);
+		data->c_tthresh0 =3D temp;
+	} else {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD1) |
+					(diff << THERM_OFFSET_THRESHOLD1);
+		data->c_tthresh1 =3D temp;
+	}
+
+	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
+
+	/* Unmask the thermal vector */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int set_pkg_threshold(struct coretemp_data *data, int temp,
+						enum thresholds thresh)
+{
+	u32 eax, edx, l;
+	int diff;
+
+	if (temp > data->tjmax)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	diff =3D (data->tjmax - temp)/1000;
+
+	/* Mask the thermal vector in the lapic */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+
+	rdmsr_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_INTERRUPT, &eax, &edx);
+
+	if (thresh =3D=3D P_TTHRESH0) {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD0) |
+					(diff << THERM_OFFSET_THRESHOLD0);
+		data->p_tthresh0 =3D temp;
+	} else {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD1) |
+					(diff << THERM_OFFSET_THRESHOLD1);
+		data->p_tthresh1 =3D temp;
+	}
+
+	wrmsr_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_INTERRUPT, eax, edx);
+
+	/* Unmask the thermal vector */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int __devinit enable_thresh_support(struct coretemp_data *data)
+{
+	u32 eax, edx, l;
+
+	/* Mask the thermal vector in the lapic */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+
+	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, &eax, &edx);
+
+	eax |=3D (THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
+
+	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
+
+	if (!data->pkg_support)
+		goto exit;
+
+	rdmsr_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_INTERRUPT, &eax, &edx);
+
+	eax |=3D (THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
+
+	wrmsr_on_cpu(data->id, MSR_IA32_PACKAGE_THERM_INTERRUPT, eax, edx);
+
+exit:
+	/* Unmask the thermal vector */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+	return 0;
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -316,8 +490,11 @@ static int __devinit coretemp_probe(struct platform_de=
vice *pdev)
 	data->core_id =3D c->cpu_core_id;
 #endif
 	data->name =3D "coretemp";
-	mutex_init(&data->update_lock);
=20
+	if (cpu_has(c, X86_FEATURE_PTS))
+		data->pkg_support =3D 1;
+
+	mutex_init(&data->update_lock);
 	/* test if we can access the THERM_STATUS MSR */
 	err =3D rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
 	if (err) {
@@ -353,6 +530,30 @@ static int __devinit coretemp_probe(struct platform_de=
vice *pdev)
 	data->tjmax =3D get_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
=20
+	/* Enable threshold support */
+	enable_thresh_support(data);
+
+	/* Set Initial Core thresholds */
+	set_core_threshold(data, 0, C_TTHRESH0);
+	set_core_threshold(data, 90000, C_TTHRESH1);
+
+	/* Set Initial Package thresholds, if HW support is available */
+	if (data->pkg_support) {
+		set_pkg_threshold(data, 0, P_TTHRESH0);
+		set_pkg_threshold(data, 80000, P_TTHRESH1);
+	}
+
+	if (data->pkg_support) {
+		err =3D device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh0.dev_attr);
+		if (err)
+			goto exit_free;
+		err =3D device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh1.dev_attr);
+		if (err)
+			goto exit_pkg_thresh0;
+	}
+
 	/*
 	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
 	 * on older CPUs but not in this register,
@@ -371,12 +572,12 @@ static int __devinit coretemp_probe(struct platform_d=
evice *pdev)
 			err =3D device_create_file(&pdev->dev,
 					&sensor_dev_attr_temp1_max.dev_attr);
 			if (err)
-				goto exit_free;
+				goto exit_pkg_thresh1;
 		}
 	}
=20
 	if ((err =3D sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-		goto exit_dev;
+		goto exit_dev_max;
=20
 	data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -390,8 +591,14 @@ static int __devinit coretemp_probe(struct platform_de=
vice *pdev)
=20
 exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-exit_dev:
+exit_dev_max:
 	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+exit_pkg_thresh1:
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh1.dev_attr);
+exit_pkg_thresh0:
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh0.dev_attr);
 exit_free:
 	kfree(data);
 exit:
@@ -405,6 +612,16 @@ static int __devexit coretemp_remove(struct platform_d=
evice *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
 	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_core_thresh0.dev_attr);
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_core_thresh1.dev_attr);
+	if (data->pkg_support) {
+		device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh0.dev_attr);
+		device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_thresh1.dev_attr);
+	}
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
--=20
1.6.5.2


--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F4Ebgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-Adding_Threshold_support_to_coretemp.patch"
Content-Description: 0001-Adding_Threshold_support_to_coretemp.patch
Content-Disposition: attachment;
	filename="0001-Adding_Threshold_support_to_coretemp.patch"; size=11053;
	creation-date="Wed, 08 Dec 2010 14:29:02 GMT";
	modification-date="Wed, 08 Dec 2010 02:20:33 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogVHVlLCA3IERl
YyAyMDEwIDAzOjI3OjAwICswNTMwClN1YmplY3Q6IFtQQVRDSCAxLzJdIEFkZGluZ19UaHJlc2hv
bGRfc3VwcG9ydF90b19jb3JldGVtcAoKVGhpcyBwYXRjaCBhZGRzIHRoZSBjb3JlIGFuZCBwYWNr
YWdlIHRocmVzaG9sZCBzdXBwb3J0IHRvIGNvcmV0ZW1wLmMuClRoZXNlIHRocmVzaG9sZHMgY2Fu
IGJlIHJlYWQvd3JpdHRlbiB1c2luZyB0aGUgc3lzZnMgaW50ZXJmYWNlcwp0ZW1wMV9jb3JlX3Ro
cmVzaFswLzFdIGFuZCB0ZW1wMV9wa2dfdGhyZXNoWzAvMV0uClRoZXNlIGNhbiBiZSB1c2VkIHRv
IGdlbmVyYXRlIGludGVycnVwdHMsIHRvIGRvIGR5bmFtaWMgcG93ZXIgbWFuYWdlbWVudC4KClNp
Z25lZC1vZmYtYnk6IER1cmdhZG9zcyBSIDxkdXJnYWRvc3MuckBpbnRlbC5jb20+Ci0tLQogYXJj
aC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmggfCAgIDEyICsrCiBkcml2ZXJzL2h3bW9uL2Nv
cmV0ZW1wLmMgICAgICAgICB8ICAyMjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjMzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaAppbmRleCAzZWEzZGM0Li5mMGZlYTI2IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tc3ItaW5kZXguaApAQCAtMjUzLDYgKzI1MywxOCBAQAogI2RlZmluZSBQQUNLQUdF
X1RIRVJNX0lOVF9MT1dfRU5BQkxFCQkoMSA8PCAxKQogI2RlZmluZSBQQUNLQUdFX1RIRVJNX0lO
VF9QTE5fRU5BQkxFCQkoMSA8PCAyNCkKIAorLyogVGhyZXNob2xkIFN1cHBvcnQgKi8KKyNkZWZp
bmUgVEhFUk1fSU5UX1RIUkVTSE9MRDBfRU5BQkxFICAgICgxIDw8IDE1KQorI2RlZmluZSBUSEVS
TV9PRkZTRVRfVEhSRVNIT0xEMCAgICAgICAgOAorI2RlZmluZSBUSEVSTV9NQVNLX1RIUkVTSE9M
RDAgICAgICAgICAgKDB4N2YgPDwgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDApCisjZGVmaW5lIFRI
RVJNX0lOVF9USFJFU0hPTEQxX0VOQUJMRSAgICAoMSA8PCAyMykKKyNkZWZpbmUgVEhFUk1fT0ZG
U0VUX1RIUkVTSE9MRDEgICAgICAgIDE2CisjZGVmaW5lIFRIRVJNX01BU0tfVEhSRVNIT0xEMSAg
ICAgICAgICAoMHg3ZiA8PCBUSEVSTV9PRkZTRVRfVEhSRVNIT0xEMSkKKyNkZWZpbmUgVEhFUk1f
U1RBVFVTX1RIUkVTSE9MRDAgICAgICAgICgxIDw8IDYpCisjZGVmaW5lIFRIRVJNX0xPR19USFJF
U0hPTEQwICAgICAgICAgICAoMSA8PCA3KQorI2RlZmluZSBUSEVSTV9TVEFUVVNfVEhSRVNIT0xE
MSAgICAgICAgKDEgPDwgOCkKKyNkZWZpbmUgVEhFUk1fTE9HX1RIUkVTSE9MRDEgICAgICAgICAg
ICgxIDw8IDkpCisKIC8qIE1JU0NfRU5BQkxFIGJpdHM6IGFyY2hpdGVjdHVyYWwgKi8KICNkZWZp
bmUgTVNSX0lBMzJfTUlTQ19FTkFCTEVfRkFTVF9TVFJJTkcJKDFVTEwgPDwgMCkKICNkZWZpbmUg
TVNSX0lBMzJfTUlTQ19FTkFCTEVfVENDCQkoMVVMTCA8PCAxKQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9od21vbi9jb3JldGVtcC5jIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5jCmluZGV4IDQyZGU5
OGQuLjdhZWE4M2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYworKysgYi9k
cml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKQEAgLTQxLDYgKzQxLDEwIEBACiAKIHR5cGVkZWYgZW51
bSB7IFNIT1dfVEVNUCwgU0hPV19USk1BWCwgU0hPV19UVEFSR0VULCBTSE9XX0xBQkVMLAogCQlT
SE9XX05BTUUgfSBTSE9XOworLyogQyBpbmRpY2F0ZXMgY29yZSB0aGVybWFsIHRocmVzaG9sZHMK
KyAqIFAgaW5kaWNhdGVzIFBhY2thZ2UgdGhlcm1hbCB0aHJlc2hvbGRzCisgKi8KK2VudW0gdGhy
ZXNob2xkcyB7IENfVFRIUkVTSDAsIENfVFRIUkVTSDEsIFBfVFRIUkVTSDAsIFBfVFRIUkVTSDEg
fSBUSFJFU0g7CiAKIC8qCiAgKiBGdW5jdGlvbnMgZGVjbGFyYXRpb24KQEAgLTU5LDkgKzYzLDE4
IEBAIHN0cnVjdCBjb3JldGVtcF9kYXRhIHsKIAlpbnQgdGVtcDsKIAlpbnQgdGptYXg7CiAJaW50
IHR0YXJnZXQ7CisJaW50IGNfdHRocmVzaDA7CisJaW50IGNfdHRocmVzaDE7CisJaW50IHBfdHRo
cmVzaDA7CisJaW50IHBfdHRocmVzaDE7CisJaW50IHBrZ19zdXBwb3J0OwkvKiB6ZXJvIGlmIHBr
ZyB0aHJlc2ggc3VwcG9ydCBpcyBub3QgdGhlcmUgKi8KIAl1OCBhbGFybTsKIH07CiAKK3N0YXRp
YyBpbnQgc2V0X2NvcmVfdGhyZXNob2xkKHN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhLCBpbnQg
dmFsLAorCQkJCQkJZW51bSB0aHJlc2hvbGRzIHRocmVzaCk7CitzdGF0aWMgaW50IHNldF9wa2df
dGhyZXNob2xkKHN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhLCBpbnQgdmFsLAorCQkJCQkJZW51
bSB0aHJlc2hvbGRzIHRocmVzaCk7CiAvKgogICogU3lzZnMgc3R1ZmYKICAqLwpAQCAtMTA0LDYg
KzExNyw0OCBAQCBzdGF0aWMgc3NpemVfdCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LAog
CXJldHVybiBlcnI7CiB9CiAKK3N0YXRpYyBzc2l6ZV90IHNob3dfdGhyZXNob2xkKHN0cnVjdCBk
ZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwgY2hhciAq
YnVmKQoreworCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciA9IHRvX3NlbnNv
cl9kZXZfYXR0cihkZXZhdHRyKTsKKwlzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSA9IGNvcmV0
ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2KTsKKworCWlmICghZGF0YS0+dmFsaWQpCisJCXJldHVybiAt
RUlOVkFMOworCisJc3dpdGNoIChhdHRyLT5pbmRleCkgeworCWNhc2UgQ19UVEhSRVNIMDoKKwkJ
cmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIGRhdGEtPmNfdHRocmVzaDApOworCWNhc2UgQ19U
VEhSRVNIMToKKwkJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIGRhdGEtPmNfdHRocmVzaDEp
OworCWNhc2UgUF9UVEhSRVNIMDoKKwkJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIGRhdGEt
PnBfdHRocmVzaDApOworCWNhc2UgUF9UVEhSRVNIMToKKwkJcmV0dXJuIHNwcmludGYoYnVmLCAi
JWRcbiIsIGRhdGEtPnBfdHRocmVzaDEpOworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOwor
CX0KK30KKworc3RhdGljIHNzaXplX3Qgc2V0X3RocmVzaG9sZChzdHJ1Y3QgZGV2aWNlICpkZXYs
CisJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjb25zdCBjaGFyICpidWYsIHNp
emVfdCBjb3VudCkKK3sKKwlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKmF0dHIgPSB0
b19zZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7CisJc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEg
PSBjb3JldGVtcF91cGRhdGVfZGV2aWNlKGRldik7CisJdW5zaWduZWQgbG9uZyB2YWw7CisJaW50
IGVycjsKKworCWlmIChzdHJpY3Rfc3RydG91bChidWYsIDEwLCAmdmFsKSkKKwkJcmV0dXJuIC1F
SU5WQUw7CisKKwlpZiAoYXR0ci0+aW5kZXggPT0gQ19UVEhSRVNIMCB8fCBhdHRyLT5pbmRleCA9
PSBDX1RUSFJFU0gxKQorCQllcnIgPSBzZXRfY29yZV90aHJlc2hvbGQoZGF0YSwgdmFsLCBhdHRy
LT5pbmRleCk7CisJZWxzZQorCQllcnIgPSBzZXRfcGtnX3RocmVzaG9sZChkYXRhLCB2YWwsIGF0
dHItPmluZGV4KTsKKworCXJldHVybiAoZXJyKSA/IC1FSU5WQUwgOiBjb3VudDsKK30KKwogc3Rh
dGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9pbnB1dCwgU19JUlVHTywgc2hvd190ZW1wLCBO
VUxMLAogCQkJICBTSE9XX1RFTVApOwogc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9j
cml0LCBTX0lSVUdPLCBzaG93X3RlbXAsIE5VTEwsCkBAIC0xMTQsMTIgKzE2OSwyMyBAQCBzdGF0
aWMgREVWSUNFX0FUVFIodGVtcDFfY3JpdF9hbGFybSwgU19JUlVHTywgc2hvd19hbGFybSwgTlVM
TCk7CiBzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX2xhYmVsLCBTX0lSVUdPLCBzaG93
X25hbWUsIE5VTEwsIFNIT1dfTEFCRUwpOwogc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUihuYW1l
LCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwsIFNIT1dfTkFNRSk7CiAKK3N0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFIodGVtcDFfY29yZV90aHJlc2gwLCBTX0lXVVNSIHwgU19JUlVHTywKKwkJCQlz
aG93X3RocmVzaG9sZCwJc2V0X3RocmVzaG9sZCwgQ19UVEhSRVNIMCk7CitzdGF0aWMgU0VOU09S
X0RFVklDRV9BVFRSKHRlbXAxX2NvcmVfdGhyZXNoMSwgU19JV1VTUiB8IFNfSVJVR08sCisJCQkJ
c2hvd190aHJlc2hvbGQsIHNldF90aHJlc2hvbGQsIENfVFRIUkVTSDEpOworc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUih0ZW1wMV9wa2dfdGhyZXNoMCwgU19JV1VTUiB8IFNfSVJVR08sCisJCQkJ
c2hvd190aHJlc2hvbGQsCXNldF90aHJlc2hvbGQsIFBfVFRIUkVTSDApOworc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUih0ZW1wMV9wa2dfdGhyZXNoMSwgU19JV1VTUiB8IFNfSVJVR08sCisJCQkJ
c2hvd190aHJlc2hvbGQsIHNldF90aHJlc2hvbGQsIFBfVFRIUkVTSDEpOworCiBzdGF0aWMgc3Ry
dWN0IGF0dHJpYnV0ZSAqY29yZXRlbXBfYXR0cmlidXRlc1tdID0gewogCSZzZW5zb3JfZGV2X2F0
dHJfbmFtZS5kZXZfYXR0ci5hdHRyLAogCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfbGFiZWwuZGV2
X2F0dHIuYXR0ciwKIAkmZGV2X2F0dHJfdGVtcDFfY3JpdF9hbGFybS5hdHRyLAogCSZzZW5zb3Jf
ZGV2X2F0dHJfdGVtcDFfaW5wdXQuZGV2X2F0dHIuYXR0ciwKIAkmc2Vuc29yX2Rldl9hdHRyX3Rl
bXAxX2NyaXQuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2NvcmVfdGhy
ZXNoMC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfY29yZV90aHJlc2gx
LmRldl9hdHRyLmF0dHIsCiAJTlVMTAogfTsKIApAQCAtMjk4LDYgKzM2NCwxMTQgQEAgc3RhdGlj
IHZvaWQgX19kZXZpbml0IGdldF91Y29kZV9yZXZfb25fY3B1KHZvaWQgKmVkeCkKIAlyZG1zcihN
U1JfSUEzMl9VQ09ERV9SRVYsIGVheCwgKih1MzIgKillZHgpOwogfQogCitzdGF0aWMgaW50IHNl
dF9jb3JlX3RocmVzaG9sZChzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSwgaW50IHRlbXAsCisJ
CQkJCQllbnVtIHRocmVzaG9sZHMgdGhyZXNoKQoreworCXUzMiBlYXgsIGVkeCwgbDsKKwlpbnQg
ZGlmZjsKKworCWlmICh0ZW1wID4gZGF0YS0+dGptYXgpCisJCXJldHVybiAtRUlOVkFMOworCisJ
bXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOworCisJZGlmZiA9IChkYXRhLT50am1heCAt
IHRlbXApLzEwMDA7CisKKwkvKiBNYXNrIHRoZSB0aGVybWFsIHZlY3RvciBpbiB0aGUgbGFwaWMg
Ki8KKwlsID0gYXBpY19yZWFkKEFQSUNfTFZUVEhNUik7CisJYXBpY193cml0ZShBUElDX0xWVFRI
TVIsIGwgfCBBUElDX0xWVF9NQVNLRUQpOworCisJcmRtc3Jfb25fY3B1KGRhdGEtPmlkLCBNU1Jf
SUEzMl9USEVSTV9JTlRFUlJVUFQsICZlYXgsICZlZHgpOworCisJaWYgKHRocmVzaCA9PSBDX1RU
SFJFU0gwKSB7CisJCWVheCA9IChlYXggJiB+VEhFUk1fTUFTS19USFJFU0hPTEQwKSB8CisJCQkJ
CShkaWZmIDw8IFRIRVJNX09GRlNFVF9USFJFU0hPTEQwKTsKKwkJZGF0YS0+Y190dGhyZXNoMCA9
IHRlbXA7CisJfSBlbHNlIHsKKwkJZWF4ID0gKGVheCAmIH5USEVSTV9NQVNLX1RIUkVTSE9MRDEp
IHwKKwkJCQkJKGRpZmYgPDwgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDEpOworCQlkYXRhLT5jX3R0
aHJlc2gxID0gdGVtcDsKKwl9CisKKwl3cm1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RI
RVJNX0lOVEVSUlVQVCwgZWF4LCBlZHgpOworCisJLyogVW5tYXNrIHRoZSB0aGVybWFsIHZlY3Rv
ciAqLworCWwgPSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlhcGljX3dyaXRlKEFQSUNfTFZU
VEhNUiwgbCAmIH5BUElDX0xWVF9NQVNLRUQpOworCisJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRh
dGVfbG9jayk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgc2V0X3BrZ190aHJlc2hvbGQo
c3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEsIGludCB0ZW1wLAorCQkJCQkJZW51bSB0aHJlc2hv
bGRzIHRocmVzaCkKK3sKKwl1MzIgZWF4LCBlZHgsIGw7CisJaW50IGRpZmY7CisKKwlpZiAodGVt
cCA+IGRhdGEtPnRqbWF4KQorCQlyZXR1cm4gLUVJTlZBTDsKKworCW11dGV4X2xvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKKworCWRpZmYgPSAoZGF0YS0+dGptYXggLSB0ZW1wKS8xMDAwOworCisJ
LyogTWFzayB0aGUgdGhlcm1hbCB2ZWN0b3IgaW4gdGhlIGxhcGljICovCisJbCA9IGFwaWNfcmVh
ZChBUElDX0xWVFRITVIpOworCWFwaWNfd3JpdGUoQVBJQ19MVlRUSE1SLCBsIHwgQVBJQ19MVlRf
TUFTS0VEKTsKKworCXJkbXNyX29uX2NwdShkYXRhLT5pZCwgTVNSX0lBMzJfUEFDS0FHRV9USEVS
TV9JTlRFUlJVUFQsICZlYXgsICZlZHgpOworCisJaWYgKHRocmVzaCA9PSBQX1RUSFJFU0gwKSB7
CisJCWVheCA9IChlYXggJiB+VEhFUk1fTUFTS19USFJFU0hPTEQwKSB8CisJCQkJCShkaWZmIDw8
IFRIRVJNX09GRlNFVF9USFJFU0hPTEQwKTsKKwkJZGF0YS0+cF90dGhyZXNoMCA9IHRlbXA7CisJ
fSBlbHNlIHsKKwkJZWF4ID0gKGVheCAmIH5USEVSTV9NQVNLX1RIUkVTSE9MRDEpIHwKKwkJCQkJ
KGRpZmYgPDwgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDEpOworCQlkYXRhLT5wX3R0aHJlc2gxID0g
dGVtcDsKKwl9CisKKwl3cm1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1BBQ0tBR0VfVEhF
Uk1fSU5URVJSVVBULCBlYXgsIGVkeCk7CisKKwkvKiBVbm1hc2sgdGhlIHRoZXJtYWwgdmVjdG9y
ICovCisJbCA9IGFwaWNfcmVhZChBUElDX0xWVFRITVIpOworCWFwaWNfd3JpdGUoQVBJQ19MVlRU
SE1SLCBsICYgfkFQSUNfTFZUX01BU0tFRCk7CisKKwltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0
ZV9sb2NrKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBfX2RldmluaXQgZW5hYmxlX3Ro
cmVzaF9zdXBwb3J0KHN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhKQoreworCXUzMiBlYXgsIGVk
eCwgbDsKKworCS8qIE1hc2sgdGhlIHRoZXJtYWwgdmVjdG9yIGluIHRoZSBsYXBpYyAqLworCWwg
PSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlhcGljX3dyaXRlKEFQSUNfTFZUVEhNUiwgbCB8
IEFQSUNfTFZUX01BU0tFRCk7CisKKwlyZG1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RI
RVJNX0lOVEVSUlVQVCwgJmVheCwgJmVkeCk7CisKKwllYXggfD0gKFRIRVJNX0lOVF9USFJFU0hP
TEQwX0VOQUJMRSB8IFRIRVJNX0lOVF9USFJFU0hPTEQxX0VOQUJMRSk7CisKKwl3cm1zcl9vbl9j
cHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQVCwgZWF4LCBlZHgpOworCisJaWYg
KCFkYXRhLT5wa2dfc3VwcG9ydCkKKwkJZ290byBleGl0OworCisJcmRtc3Jfb25fY3B1KGRhdGEt
PmlkLCBNU1JfSUEzMl9QQUNLQUdFX1RIRVJNX0lOVEVSUlVQVCwgJmVheCwgJmVkeCk7CisKKwll
YXggfD0gKFRIRVJNX0lOVF9USFJFU0hPTEQwX0VOQUJMRSB8IFRIRVJNX0lOVF9USFJFU0hPTEQx
X0VOQUJMRSk7CisKKwl3cm1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1BBQ0tBR0VfVEhF
Uk1fSU5URVJSVVBULCBlYXgsIGVkeCk7CisKK2V4aXQ6CisJLyogVW5tYXNrIHRoZSB0aGVybWFs
IHZlY3RvciAqLworCWwgPSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlhcGljX3dyaXRlKEFQ
SUNfTFZUVEhNUiwgbCAmIH5BUElDX0xWVF9NQVNLRUQpOworCXJldHVybiAwOworfQorCiBzdGF0
aWMgaW50IF9fZGV2aW5pdCBjb3JldGVtcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogewogCXN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhOwpAQCAtMzE2LDggKzQ5MCwxMSBA
QCBzdGF0aWMgaW50IF9fZGV2aW5pdCBjb3JldGVtcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCWRhdGEtPmNvcmVfaWQgPSBjLT5jcHVfY29yZV9pZDsKICNlbmRpZgogCWRh
dGEtPm5hbWUgPSAiY29yZXRlbXAiOwotCW11dGV4X2luaXQoJmRhdGEtPnVwZGF0ZV9sb2NrKTsK
IAorCWlmIChjcHVfaGFzKGMsIFg4Nl9GRUFUVVJFX1BUUykpCisJCWRhdGEtPnBrZ19zdXBwb3J0
ID0gMTsKKworCW11dGV4X2luaXQoJmRhdGEtPnVwZGF0ZV9sb2NrKTsKIAkvKiB0ZXN0IGlmIHdl
IGNhbiBhY2Nlc3MgdGhlIFRIRVJNX1NUQVRVUyBNU1IgKi8KIAllcnIgPSByZG1zcl9zYWZlX29u
X2NwdShkYXRhLT5pZCwgTVNSX0lBMzJfVEhFUk1fU1RBVFVTLCAmZWF4LCAmZWR4KTsKIAlpZiAo
ZXJyKSB7CkBAIC0zNTMsNiArNTMwLDMwIEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1w
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJZGF0YS0+dGptYXggPSBnZXRf
dGptYXgoYywgZGF0YS0+aWQsICZwZGV2LT5kZXYpOwogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIGRhdGEpOwogCisJLyogRW5hYmxlIHRocmVzaG9sZCBzdXBwb3J0ICovCisJZW5hYmxlX3Ro
cmVzaF9zdXBwb3J0KGRhdGEpOworCisJLyogU2V0IEluaXRpYWwgQ29yZSB0aHJlc2hvbGRzICov
CisJc2V0X2NvcmVfdGhyZXNob2xkKGRhdGEsIDAsIENfVFRIUkVTSDApOworCXNldF9jb3JlX3Ro
cmVzaG9sZChkYXRhLCA5MDAwMCwgQ19UVEhSRVNIMSk7CisKKwkvKiBTZXQgSW5pdGlhbCBQYWNr
YWdlIHRocmVzaG9sZHMsIGlmIEhXIHN1cHBvcnQgaXMgYXZhaWxhYmxlICovCisJaWYgKGRhdGEt
PnBrZ19zdXBwb3J0KSB7CisJCXNldF9wa2dfdGhyZXNob2xkKGRhdGEsIDAsIFBfVFRIUkVTSDAp
OworCQlzZXRfcGtnX3RocmVzaG9sZChkYXRhLCA4MDAwMCwgUF9UVEhSRVNIMSk7CisJfQorCisJ
aWYgKGRhdGEtPnBrZ19zdXBwb3J0KSB7CisJCWVyciA9IGRldmljZV9jcmVhdGVfZmlsZSgmcGRl
di0+ZGV2LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfcGtnX3RocmVzaDAuZGV2X2F0dHIp
OworCQlpZiAoZXJyKQorCQkJZ290byBleGl0X2ZyZWU7CisJCWVyciA9IGRldmljZV9jcmVhdGVf
ZmlsZSgmcGRldi0+ZGV2LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfcGtnX3RocmVzaDEu
ZGV2X2F0dHIpOworCQlpZiAoZXJyKQorCQkJZ290byBleGl0X3BrZ190aHJlc2gwOworCX0KKwog
CS8qCiAJICogcmVhZCB0aGUgc3RpbGwgdW5kb2N1bWVudGVkIElBMzJfVEVNUEVSQVRVUkVfVEFS
R0VULiBJdCBleGlzdHMKIAkgKiBvbiBvbGRlciBDUFVzIGJ1dCBub3QgaW4gdGhpcyByZWdpc3Rl
ciwKQEAgLTM3MSwxMiArNTcyLDEyIEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1wX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCQllcnIgPSBkZXZpY2VfY3JlYXRl
X2ZpbGUoJnBkZXYtPmRldiwKIAkJCQkJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9tYXguZGV2X2F0
dHIpOwogCQkJaWYgKGVycikKLQkJCQlnb3RvIGV4aXRfZnJlZTsKKwkJCQlnb3RvIGV4aXRfcGtn
X3RocmVzaDE7CiAJCX0KIAl9CiAKIAlpZiAoKGVyciA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmcGRl
di0+ZGV2LmtvYmosICZjb3JldGVtcF9ncm91cCkpKQotCQlnb3RvIGV4aXRfZGV2OworCQlnb3Rv
IGV4aXRfZGV2X21heDsKIAogCWRhdGEtPmh3bW9uX2RldiA9IGh3bW9uX2RldmljZV9yZWdpc3Rl
cigmcGRldi0+ZGV2KTsKIAlpZiAoSVNfRVJSKGRhdGEtPmh3bW9uX2RldikpIHsKQEAgLTM5MCw4
ICs1OTEsMTQgQEAgc3RhdGljIGludCBfX2RldmluaXQgY29yZXRlbXBfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAogZXhpdF9jbGFzczoKIAlzeXNmc19yZW1vdmVfZ3JvdXAo
JnBkZXYtPmRldi5rb2JqLCAmY29yZXRlbXBfZ3JvdXApOwotZXhpdF9kZXY6CitleGl0X2Rldl9t
YXg6CiAJZGV2aWNlX3JlbW92ZV9maWxlKCZwZGV2LT5kZXYsICZzZW5zb3JfZGV2X2F0dHJfdGVt
cDFfbWF4LmRldl9hdHRyKTsKK2V4aXRfcGtnX3RocmVzaDE6CisJZGV2aWNlX3JlbW92ZV9maWxl
KCZwZGV2LT5kZXYsCisJCQkJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9wa2dfdGhyZXNoMS5kZXZf
YXR0cik7CitleGl0X3BrZ190aHJlc2gwOgorCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2
LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfcGtnX3RocmVzaDAuZGV2X2F0dHIpOwogZXhp
dF9mcmVlOgogCWtmcmVlKGRhdGEpOwogZXhpdDoKQEAgLTQwNSw2ICs2MTIsMTYgQEAgc3RhdGlj
IGludCBfX2RldmV4aXQgY29yZXRlbXBfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiAJaHdtb25fZGV2aWNlX3VucmVnaXN0ZXIoZGF0YS0+aHdtb25fZGV2KTsKIAlzeXNmc19y
ZW1vdmVfZ3JvdXAoJnBkZXYtPmRldi5rb2JqLCAmY29yZXRlbXBfZ3JvdXApOwogCWRldmljZV9y
ZW1vdmVfZmlsZSgmcGRldi0+ZGV2LCAmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX21heC5kZXZfYXR0
cik7CisJZGV2aWNlX3JlbW92ZV9maWxlKCZwZGV2LT5kZXYsCisJCQkJJnNlbnNvcl9kZXZfYXR0
cl90ZW1wMV9jb3JlX3RocmVzaDAuZGV2X2F0dHIpOworCWRldmljZV9yZW1vdmVfZmlsZSgmcGRl
di0+ZGV2LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfY29yZV90aHJlc2gxLmRldl9hdHRy
KTsKKwlpZiAoZGF0YS0+cGtnX3N1cHBvcnQpIHsKKwkJZGV2aWNlX3JlbW92ZV9maWxlKCZwZGV2
LT5kZXYsCisJCQkJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9wa2dfdGhyZXNoMC5kZXZfYXR0cik7
CisJCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJf
dGVtcDFfcGtnX3RocmVzaDEuZGV2X2F0dHIpOworCX0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBOVUxMKTsKIAlrZnJlZShkYXRhKTsKIAlyZXR1cm4gMDsKLS0gCjEuNi41LjIKCg==

--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F4Ebgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F4Ebgsmsx502garc_--
