From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 10 Dec 2010 09:42:15 +0000
Subject: [lm-sensors] Patch[1/1] Adding Core Thermal Threshold Support to
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1077008@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C1077008bgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

--_002_D6D887BA8C9DFF48B5233887EF04654105C1077008bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Fenghua/Jean,

I am submitting a patch to enable core thermal threshold
Support to coretemp.c. There are two core thermal thresholds
available through sysfs interfaces temp1_core_thresh[0/1].

The expectation is that thresh0 is lesser than the current temperature
and thresh1 is higher than the current temperature. Whenever the current
temperature crosses these limits, an interrupt is generated.
This interrupt is handles by the user space to do power
Management via CPU throttling, etc..

This patch is generated against stable Linux-2.6 kernel.

Kindly review and merge.
-------------------------------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Fri, 10 Dec 2010 02:16:36 +0530
Subject: [PATCH] Adding_Threshold_support_to_coretemp

This patch adds the core thermal threshold support to coretemp.c.
These thresholds can be read/written using the sysfs interface
temp1_core_thresh[0/1]. These can be used to generate interrupts,
to do dynamic power management.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 arch/x86/include/asm/msr-index.h |   12 ++++
 drivers/hwmon/coretemp.c         |  122 ++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h
index 3ea3dc4..31cefad 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -253,6 +253,18 @@
 #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
 #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
=20
+/* Thermal Thresholds Support */
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
index 42de98d..fe0699f 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -42,6 +42,9 @@
 typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 		SHOW_NAME } SHOW;
=20
+/* C indicates core thermal thresholds */
+enum thresholds { C_TTHRESH0, C_TTHRESH1} THRESH;
+
 /*
  * Functions declaration
  */
@@ -59,9 +62,13 @@ struct coretemp_data {
 	int temp;
 	int tjmax;
 	int ttarget;
+	int c_tthresh0;
+	int c_tthresh1;
 	u8 alarm;
 };
=20
+static int set_core_threshold(struct coretemp_data *data, int val,
+						enum thresholds thresh);
 /*
  * Sysfs stuff
  */
@@ -104,6 +111,41 @@ static ssize_t show_temp(struct device *dev,
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
+	err =3D set_core_threshold(data, val, attr->index);
+
+	return (err) ? -EINVAL : count;
+}
+
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
 			  SHOW_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
@@ -114,12 +156,19 @@ static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_al=
arm, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABE=
L);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
=20
+static SENSOR_DEVICE_ATTR(temp1_core_thresh0, S_IWUSR | S_IRUGO,
+				show_threshold,	set_threshold, C_TTHRESH0);
+static SENSOR_DEVICE_ATTR(temp1_core_thresh1, S_IWUSR | S_IRUGO,
+				show_threshold, set_threshold, C_TTHRESH1);
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
@@ -298,6 +347,66 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
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
+	/* Unmask the thermal vector */
+	l =3D apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
+	return 0;
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -353,6 +462,15 @@ static int __devinit coretemp_probe(struct platform_de=
vice *pdev)
 	data->tjmax =3D get_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
=20
+	/* Enable threshold support */
+	enable_thresh_support(data);
+
+	/* Set Initial Core thresholds.
+	 * The lower and upper threshold values here are assumed
+	 */
+	set_core_threshold(data, 0, C_TTHRESH0);
+	set_core_threshold(data, 90000, C_TTHRESH1);
+
 	/*
 	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
 	 * on older CPUs but not in this register,
@@ -405,6 +523,10 @@ static int __devexit coretemp_remove(struct platform_d=
evice *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
 	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_core_thresh0.dev_attr);
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_core_thresh1.dev_attr);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
--=20
1.6.5.2


--_002_D6D887BA8C9DFF48B5233887EF04654105C1077008bgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-Adding_Threshold_support_to_coretemp.patch"
Content-Description: 0001-Adding_Threshold_support_to_coretemp.patch
Content-Disposition: attachment;
	filename="0001-Adding_Threshold_support_to_coretemp.patch"; size=7064;
	creation-date="Fri, 10 Dec 2010 14:19:17 GMT";
	modification-date="Fri, 10 Dec 2010 02:19:55 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogRnJpLCAxMCBE
ZWMgMjAxMCAwMjoxNjozNiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFkZGluZ19UaHJlc2hvbGRf
c3VwcG9ydF90b19jb3JldGVtcAoKVGhpcyBwYXRjaCBhZGRzIHRoZSBjb3JlIHRoZXJtYWwgdGhy
ZXNob2xkIHN1cHBvcnQgdG8gY29yZXRlbXAuYy4KVGhlc2UgdGhyZXNob2xkcyBjYW4gYmUgcmVh
ZC93cml0dGVuIHVzaW5nIHRoZSBzeXNmcyBpbnRlcmZhY2UKdGVtcDFfY29yZV90aHJlc2hbMC8x
XS4gVGhlc2UgY2FuIGJlIHVzZWQgdG8gZ2VuZXJhdGUgaW50ZXJydXB0cywKdG8gZG8gZHluYW1p
YyBwb3dlciBtYW5hZ2VtZW50LgoKU2lnbmVkLW9mZi1ieTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9z
cy5yQGludGVsLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCB8ICAg
MTIgKysrKwogZHJpdmVycy9od21vbi9jb3JldGVtcC5jICAgICAgICAgfCAgMTIyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEzNCBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21zci1pbmRleC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKaW5kZXgg
M2VhM2RjNC4uMzFjZWZhZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWlu
ZGV4LmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKQEAgLTI1Myw2ICsy
NTMsMTggQEAKICNkZWZpbmUgUEFDS0FHRV9USEVSTV9JTlRfTE9XX0VOQUJMRQkJKDEgPDwgMSkK
ICNkZWZpbmUgUEFDS0FHRV9USEVSTV9JTlRfUExOX0VOQUJMRQkJKDEgPDwgMjQpCiAKKy8qIFRo
ZXJtYWwgVGhyZXNob2xkcyBTdXBwb3J0ICovCisjZGVmaW5lIFRIRVJNX0lOVF9USFJFU0hPTEQw
X0VOQUJMRSAgICAoMSA8PCAxNSkKKyNkZWZpbmUgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDAgICAg
ICAgIDgKKyNkZWZpbmUgVEhFUk1fTUFTS19USFJFU0hPTEQwICAgICAgICAgICgweDdmIDw8IFRI
RVJNX09GRlNFVF9USFJFU0hPTEQwKQorI2RlZmluZSBUSEVSTV9JTlRfVEhSRVNIT0xEMV9FTkFC
TEUgICAgKDEgPDwgMjMpCisjZGVmaW5lIFRIRVJNX09GRlNFVF9USFJFU0hPTEQxICAgICAgICAx
NgorI2RlZmluZSBUSEVSTV9NQVNLX1RIUkVTSE9MRDEgICAgICAgICAgKDB4N2YgPDwgVEhFUk1f
T0ZGU0VUX1RIUkVTSE9MRDEpCisjZGVmaW5lIFRIRVJNX1NUQVRVU19USFJFU0hPTEQwICAgICAg
ICAoMSA8PCA2KQorI2RlZmluZSBUSEVSTV9MT0dfVEhSRVNIT0xEMCAgICAgICAgICAgKDEgPDwg
NykKKyNkZWZpbmUgVEhFUk1fU1RBVFVTX1RIUkVTSE9MRDEgICAgICAgICgxIDw8IDgpCisjZGVm
aW5lIFRIRVJNX0xPR19USFJFU0hPTEQxICAgICAgICAgICAoMSA8PCA5KQorCiAvKiBNSVNDX0VO
QUJMRSBiaXRzOiBhcmNoaXRlY3R1cmFsICovCiAjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxF
X0ZBU1RfU1RSSU5HCSgxVUxMIDw8IDApCiAjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxFX1RD
QwkJKDFVTEwgPDwgMSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyBiL2Ry
aXZlcnMvaHdtb24vY29yZXRlbXAuYwppbmRleCA0MmRlOThkLi5mZTA2OTlmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKKysrIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5j
CkBAIC00Miw2ICs0Miw5IEBACiB0eXBlZGVmIGVudW0geyBTSE9XX1RFTVAsIFNIT1dfVEpNQVgs
IFNIT1dfVFRBUkdFVCwgU0hPV19MQUJFTCwKIAkJU0hPV19OQU1FIH0gU0hPVzsKIAorLyogQyBp
bmRpY2F0ZXMgY29yZSB0aGVybWFsIHRocmVzaG9sZHMgKi8KK2VudW0gdGhyZXNob2xkcyB7IENf
VFRIUkVTSDAsIENfVFRIUkVTSDF9IFRIUkVTSDsKKwogLyoKICAqIEZ1bmN0aW9ucyBkZWNsYXJh
dGlvbgogICovCkBAIC01OSw5ICs2MiwxMyBAQCBzdHJ1Y3QgY29yZXRlbXBfZGF0YSB7CiAJaW50
IHRlbXA7CiAJaW50IHRqbWF4OwogCWludCB0dGFyZ2V0OworCWludCBjX3R0aHJlc2gwOworCWlu
dCBjX3R0aHJlc2gxOwogCXU4IGFsYXJtOwogfTsKIAorc3RhdGljIGludCBzZXRfY29yZV90aHJl
c2hvbGQoc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEsIGludCB2YWwsCisJCQkJCQllbnVtIHRo
cmVzaG9sZHMgdGhyZXNoKTsKIC8qCiAgKiBTeXNmcyBzdHVmZgogICovCkBAIC0xMDQsNiArMTEx
LDQxIEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfdGVtcChzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJcmV0
dXJuIGVycjsKIH0KIAorc3RhdGljIHNzaXplX3Qgc2hvd190aHJlc2hvbGQoc3RydWN0IGRldmlj
ZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYp
Cit7CisJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlICphdHRyID0gdG9fc2Vuc29yX2Rl
dl9hdHRyKGRldmF0dHIpOworCXN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhID0gY29yZXRlbXBf
dXBkYXRlX2RldmljZShkZXYpOworCisJaWYgKCFkYXRhLT52YWxpZCkKKwkJcmV0dXJuIC1FSU5W
QUw7CisKKwlzd2l0Y2ggKGF0dHItPmluZGV4KSB7CisJY2FzZSBDX1RUSFJFU0gwOgorCQlyZXR1
cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+Y190dGhyZXNoMCk7CisJY2FzZSBDX1RUSFJF
U0gxOgorCQlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+Y190dGhyZXNoMSk7CisJ
ZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorfQorCitzdGF0aWMgc3NpemVfdCBzZXRf
dGhyZXNob2xkKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmRldmF0dHIsIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQoreworCXN0cnVjdCBzZW5z
b3JfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciA9IHRvX3NlbnNvcl9kZXZfYXR0cihkZXZhdHRyKTsK
KwlzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSA9IGNvcmV0ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2
KTsKKwl1bnNpZ25lZCBsb25nIHZhbDsKKwlpbnQgZXJyOworCisJaWYgKHN0cmljdF9zdHJ0b3Vs
KGJ1ZiwgMTAsICZ2YWwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWVyciA9IHNldF9jb3JlX3Ro
cmVzaG9sZChkYXRhLCB2YWwsIGF0dHItPmluZGV4KTsKKworCXJldHVybiAoZXJyKSA/IC1FSU5W
QUwgOiBjb3VudDsKK30KKwogc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9pbnB1dCwg
U19JUlVHTywgc2hvd190ZW1wLCBOVUxMLAogCQkJICBTSE9XX1RFTVApOwogc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUih0ZW1wMV9jcml0LCBTX0lSVUdPLCBzaG93X3RlbXAsIE5VTEwsCkBAIC0x
MTQsMTIgKzE1NiwxOSBAQCBzdGF0aWMgREVWSUNFX0FUVFIodGVtcDFfY3JpdF9hbGFybSwgU19J
UlVHTywgc2hvd19hbGFybSwgTlVMTCk7CiBzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAx
X2xhYmVsLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwsIFNIT1dfTEFCRUwpOwogc3RhdGljIFNF
TlNPUl9ERVZJQ0VfQVRUUihuYW1lLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwsIFNIT1dfTkFN
RSk7CiAKK3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIodGVtcDFfY29yZV90aHJlc2gwLCBTX0lX
VVNSIHwgU19JUlVHTywKKwkJCQlzaG93X3RocmVzaG9sZCwJc2V0X3RocmVzaG9sZCwgQ19UVEhS
RVNIMCk7CitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX2NvcmVfdGhyZXNoMSwgU19J
V1VTUiB8IFNfSVJVR08sCisJCQkJc2hvd190aHJlc2hvbGQsIHNldF90aHJlc2hvbGQsIENfVFRI
UkVTSDEpOworCiBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqY29yZXRlbXBfYXR0cmlidXRlc1td
ID0gewogCSZzZW5zb3JfZGV2X2F0dHJfbmFtZS5kZXZfYXR0ci5hdHRyLAogCSZzZW5zb3JfZGV2
X2F0dHJfdGVtcDFfbGFiZWwuZGV2X2F0dHIuYXR0ciwKIAkmZGV2X2F0dHJfdGVtcDFfY3JpdF9h
bGFybS5hdHRyLAogCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfaW5wdXQuZGV2X2F0dHIuYXR0ciwK
IAkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2NyaXQuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rl
dl9hdHRyX3RlbXAxX2NvcmVfdGhyZXNoMC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0
dHJfdGVtcDFfY29yZV90aHJlc2gxLmRldl9hdHRyLmF0dHIsCiAJTlVMTAogfTsKIApAQCAtMjk4
LDYgKzM0Nyw2NiBAQCBzdGF0aWMgdm9pZCBfX2RldmluaXQgZ2V0X3Vjb2RlX3Jldl9vbl9jcHUo
dm9pZCAqZWR4KQogCXJkbXNyKE1TUl9JQTMyX1VDT0RFX1JFViwgZWF4LCAqKHUzMiAqKWVkeCk7
CiB9CiAKK3N0YXRpYyBpbnQgc2V0X2NvcmVfdGhyZXNob2xkKHN0cnVjdCBjb3JldGVtcF9kYXRh
ICpkYXRhLCBpbnQgdGVtcCwKKwkJCQkJCWVudW0gdGhyZXNob2xkcyB0aHJlc2gpCit7CisJdTMy
IGVheCwgZWR4LCBsOworCWludCBkaWZmOworCisJaWYgKHRlbXAgPiBkYXRhLT50am1heCkKKwkJ
cmV0dXJuIC1FSU5WQUw7CisKKwltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CisKKwlk
aWZmID0gKGRhdGEtPnRqbWF4IC0gdGVtcCkvMTAwMDsKKworCS8qIE1hc2sgdGhlIHRoZXJtYWwg
dmVjdG9yIGluIHRoZSBsYXBpYyAqLworCWwgPSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlh
cGljX3dyaXRlKEFQSUNfTFZUVEhNUiwgbCB8IEFQSUNfTFZUX01BU0tFRCk7CisKKwlyZG1zcl9v
bl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQVCwgJmVheCwgJmVkeCk7CisK
KwlpZiAodGhyZXNoID09IENfVFRIUkVTSDApIHsKKwkJZWF4ID0gKGVheCAmIH5USEVSTV9NQVNL
X1RIUkVTSE9MRDApIHwKKwkJCQkJKGRpZmYgPDwgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDApOwor
CQlkYXRhLT5jX3R0aHJlc2gwID0gdGVtcDsKKwl9IGVsc2UgeworCQllYXggPSAoZWF4ICYgflRI
RVJNX01BU0tfVEhSRVNIT0xEMSkgfAorCQkJCQkoZGlmZiA8PCBUSEVSTV9PRkZTRVRfVEhSRVNI
T0xEMSk7CisJCWRhdGEtPmNfdHRocmVzaDEgPSB0ZW1wOworCX0KKworCXdybXNyX29uX2NwdShk
YXRhLT5pZCwgTVNSX0lBMzJfVEhFUk1fSU5URVJSVVBULCBlYXgsIGVkeCk7CisKKwkvKiBVbm1h
c2sgdGhlIHRoZXJtYWwgdmVjdG9yICovCisJbCA9IGFwaWNfcmVhZChBUElDX0xWVFRITVIpOwor
CWFwaWNfd3JpdGUoQVBJQ19MVlRUSE1SLCBsICYgfkFQSUNfTFZUX01BU0tFRCk7CisKKwltdXRl
eF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlu
dCBfX2RldmluaXQgZW5hYmxlX3RocmVzaF9zdXBwb3J0KHN0cnVjdCBjb3JldGVtcF9kYXRhICpk
YXRhKQoreworCXUzMiBlYXgsIGVkeCwgbDsKKworCS8qIE1hc2sgdGhlIHRoZXJtYWwgdmVjdG9y
IGluIHRoZSBsYXBpYyAqLworCWwgPSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlhcGljX3dy
aXRlKEFQSUNfTFZUVEhNUiwgbCB8IEFQSUNfTFZUX01BU0tFRCk7CisKKwlyZG1zcl9vbl9jcHUo
ZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQVCwgJmVheCwgJmVkeCk7CisKKwllYXgg
fD0gKFRIRVJNX0lOVF9USFJFU0hPTEQwX0VOQUJMRSB8IFRIRVJNX0lOVF9USFJFU0hPTEQxX0VO
QUJMRSk7CisKKwl3cm1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQ
VCwgZWF4LCBlZHgpOworCisJLyogVW5tYXNrIHRoZSB0aGVybWFsIHZlY3RvciAqLworCWwgPSBh
cGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKKwlhcGljX3dyaXRlKEFQSUNfTFZUVEhNUiwgbCAmIH5B
UElDX0xWVF9NQVNLRUQpOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgX19kZXZpbml0
IGNvcmV0ZW1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0
IGNvcmV0ZW1wX2RhdGEgKmRhdGE7CkBAIC0zNTMsNiArNDYyLDE1IEBAIHN0YXRpYyBpbnQgX19k
ZXZpbml0IGNvcmV0ZW1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJZGF0
YS0+dGptYXggPSBnZXRfdGptYXgoYywgZGF0YS0+aWQsICZwZGV2LT5kZXYpOwogCXBsYXRmb3Jt
X3NldF9kcnZkYXRhKHBkZXYsIGRhdGEpOwogCisJLyogRW5hYmxlIHRocmVzaG9sZCBzdXBwb3J0
ICovCisJZW5hYmxlX3RocmVzaF9zdXBwb3J0KGRhdGEpOworCisJLyogU2V0IEluaXRpYWwgQ29y
ZSB0aHJlc2hvbGRzLgorCSAqIFRoZSBsb3dlciBhbmQgdXBwZXIgdGhyZXNob2xkIHZhbHVlcyBo
ZXJlIGFyZSBhc3N1bWVkCisJICovCisJc2V0X2NvcmVfdGhyZXNob2xkKGRhdGEsIDAsIENfVFRI
UkVTSDApOworCXNldF9jb3JlX3RocmVzaG9sZChkYXRhLCA5MDAwMCwgQ19UVEhSRVNIMSk7CisK
IAkvKgogCSAqIHJlYWQgdGhlIHN0aWxsIHVuZG9jdW1lbnRlZCBJQTMyX1RFTVBFUkFUVVJFX1RB
UkdFVC4gSXQgZXhpc3RzCiAJICogb24gb2xkZXIgQ1BVcyBidXQgbm90IGluIHRoaXMgcmVnaXN0
ZXIsCkBAIC00MDUsNiArNTIzLDEwIEBAIHN0YXRpYyBpbnQgX19kZXZleGl0IGNvcmV0ZW1wX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWh3bW9uX2RldmljZV91bnJlZ2lz
dGVyKGRhdGEtPmh3bW9uX2Rldik7CiAJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5kZXYua29i
aiwgJmNvcmV0ZW1wX2dyb3VwKTsKIAlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwgJnNl
bnNvcl9kZXZfYXR0cl90ZW1wMV9tYXguZGV2X2F0dHIpOworCWRldmljZV9yZW1vdmVfZmlsZSgm
cGRldi0+ZGV2LAorCQkJCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfY29yZV90aHJlc2gwLmRldl9h
dHRyKTsKKwlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwKKwkJCQkmc2Vuc29yX2Rldl9h
dHRyX3RlbXAxX2NvcmVfdGhyZXNoMS5kZXZfYXR0cik7CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEo
cGRldiwgTlVMTCk7CiAJa2ZyZWUoZGF0YSk7CiAJcmV0dXJuIDA7Ci0tIAoxLjYuNS4yCgo=

--_002_D6D887BA8C9DFF48B5233887EF04654105C1077008bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C1077008bgsmsx502garc_--
