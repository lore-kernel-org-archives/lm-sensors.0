From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 14 Dec 2010 12:07:35 +0000
Subject: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C1109439bgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

--_002_D6D887BA8C9DFF48B5233887EF04654105C1109439bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jean/Fenghua,

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
------------------------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Tue, 14 Dec 2010 05:10:27 +0530
Subject: [PATCH] Adding_threshold_support_to_coretemp

This patch adds the core thermal threshold support to coretemp.c.
These thresholds can be read/written using the sysfs interface
temp1_core_thresh[0/1]. These can be used to generate interrupts,
to do dynamic power management.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 arch/x86/include/asm/msr-index.h |   12 ++++
 drivers/hwmon/coretemp.c         |  133 ++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 145 insertions(+), 0 deletions(-)

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
index 42de98d..4c221b8 100644
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
@@ -298,6 +347,77 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
=20
+static void configure_apic(void *info)
+{
+	u32 l;
+	int *flag =3D (int *)info;
+
+	l =3D apic_read(APIC_LVTTHMR);
+
+	if (*flag)	/* Non-Zero flag Masks the APIC */
+		apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+	else		/* Zero flag UnMasks the APIC */
+		apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+}
+
+static int set_core_threshold(struct coretemp_data *data, int temp,
+						enum thresholds thresh)
+{
+	u32 eax, edx;
+	int diff;
+	int flag =3D 1;
+
+	if (temp > data->tjmax)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	diff =3D (data->tjmax - temp)/1000;
+
+	/* Mask the APIC */
+	smp_call_function_single(data->id, &configure_apic, &flag, 1);
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
+	/* Unmask the APIC */
+	flag =3D 0;
+	smp_call_function_single(data->id, &configure_apic, &flag, 1);
+
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int __devinit enable_thresh_support(struct coretemp_data *data)
+{
+	u32 eax, edx;
+	int flag =3D 1; /* Non-Zero Flag masks the apic */
+
+	smp_call_function_single(data->id, &configure_apic, &flag, 1);
+
+	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, &eax, &edx);
+
+	eax |=3D (THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
+
+	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
+
+	flag =3D 0; /*Flag should be zero to unmask the apic */
+	smp_call_function_single(data->id, &configure_apic, &flag, 1);
+
+	return 0;
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -353,6 +473,15 @@ static int __devinit coretemp_probe(struct platform_de=
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
@@ -405,6 +534,10 @@ static int __devexit coretemp_remove(struct platform_d=
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



--_002_D6D887BA8C9DFF48B5233887EF04654105C1109439bgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-Adding_threshold_support_to_coretemp.patch"
Content-Description: 0001-Adding_threshold_support_to_coretemp.patch
Content-Disposition: attachment;
	filename="0001-Adding_threshold_support_to_coretemp.patch"; size=7328;
	creation-date="Tue, 14 Dec 2010 17:15:04 GMT";
	modification-date="Tue, 14 Dec 2010 05:14:45 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogVHVlLCAxNCBE
ZWMgMjAxMCAwNToxMDoyNyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFkZGluZ190aHJlc2hvbGRf
c3VwcG9ydF90b19jb3JldGVtcAoKVGhpcyBwYXRjaCBhZGRzIHRoZSBjb3JlIHRoZXJtYWwgdGhy
ZXNob2xkIHN1cHBvcnQgdG8gY29yZXRlbXAuYy4KVGhlc2UgdGhyZXNob2xkcyBjYW4gYmUgcmVh
ZC93cml0dGVuIHVzaW5nIHRoZSBzeXNmcyBpbnRlcmZhY2UKdGVtcDFfY29yZV90aHJlc2hbMC8x
XS4gVGhlc2UgY2FuIGJlIHVzZWQgdG8gZ2VuZXJhdGUgaW50ZXJydXB0cywKdG8gZG8gZHluYW1p
YyBwb3dlciBtYW5hZ2VtZW50LgoKU2lnbmVkLW9mZi1ieTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9z
cy5yQGludGVsLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCB8ICAg
MTIgKysrKwogZHJpdmVycy9od21vbi9jb3JldGVtcC5jICAgICAgICAgfCAgMTMzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE0NSBpbnNl
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
aXZlcnMvaHdtb24vY29yZXRlbXAuYwppbmRleCA0MmRlOThkLi40YzIyMWI4IDEwMDY0NAotLS0g
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
LDYgKzM0Nyw3NyBAQCBzdGF0aWMgdm9pZCBfX2RldmluaXQgZ2V0X3Vjb2RlX3Jldl9vbl9jcHUo
dm9pZCAqZWR4KQogCXJkbXNyKE1TUl9JQTMyX1VDT0RFX1JFViwgZWF4LCAqKHUzMiAqKWVkeCk7
CiB9CiAKK3N0YXRpYyB2b2lkIGNvbmZpZ3VyZV9hcGljKHZvaWQgKmluZm8pCit7CisJdTMyIGw7
CisJaW50ICpmbGFnID0gKGludCAqKWluZm87CisKKwlsID0gYXBpY19yZWFkKEFQSUNfTFZUVEhN
Uik7CisKKwlpZiAoKmZsYWcpCS8qIE5vbi1aZXJvIGZsYWcgTWFza3MgdGhlIEFQSUMgKi8KKwkJ
YXBpY193cml0ZShBUElDX0xWVFRITVIsIGwgfCBBUElDX0xWVF9NQVNLRUQpOworCWVsc2UJCS8q
IFplcm8gZmxhZyBVbk1hc2tzIHRoZSBBUElDICovCisJCWFwaWNfd3JpdGUoQVBJQ19MVlRUSE1S
LCBsICYgfkFQSUNfTFZUX01BU0tFRCk7Cit9CisKK3N0YXRpYyBpbnQgc2V0X2NvcmVfdGhyZXNo
b2xkKHN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhLCBpbnQgdGVtcCwKKwkJCQkJCWVudW0gdGhy
ZXNob2xkcyB0aHJlc2gpCit7CisJdTMyIGVheCwgZWR4OworCWludCBkaWZmOworCWludCBmbGFn
ID0gMTsKKworCWlmICh0ZW1wID4gZGF0YS0+dGptYXgpCisJCXJldHVybiAtRUlOVkFMOworCisJ
bXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOworCisJZGlmZiA9IChkYXRhLT50am1heCAt
IHRlbXApLzEwMDA7CisKKwkvKiBNYXNrIHRoZSBBUElDICovCisJc21wX2NhbGxfZnVuY3Rpb25f
c2luZ2xlKGRhdGEtPmlkLCAmY29uZmlndXJlX2FwaWMsICZmbGFnLCAxKTsKKworCXJkbXNyX29u
X2NwdShkYXRhLT5pZCwgTVNSX0lBMzJfVEhFUk1fSU5URVJSVVBULCAmZWF4LCAmZWR4KTsKKwor
CWlmICh0aHJlc2ggPT0gQ19UVEhSRVNIMCkgeworCQllYXggPSAoZWF4ICYgflRIRVJNX01BU0tf
VEhSRVNIT0xEMCkgfAorCQkJCQkoZGlmZiA8PCBUSEVSTV9PRkZTRVRfVEhSRVNIT0xEMCk7CisJ
CWRhdGEtPmNfdHRocmVzaDAgPSB0ZW1wOworCX0gZWxzZSB7CisJCWVheCA9IChlYXggJiB+VEhF
Uk1fTUFTS19USFJFU0hPTEQxKSB8CisJCQkJCShkaWZmIDw8IFRIRVJNX09GRlNFVF9USFJFU0hP
TEQxKTsKKwkJZGF0YS0+Y190dGhyZXNoMSA9IHRlbXA7CisJfQorCisJd3Jtc3Jfb25fY3B1KGRh
dGEtPmlkLCBNU1JfSUEzMl9USEVSTV9JTlRFUlJVUFQsIGVheCwgZWR4KTsKKworCS8qIFVubWFz
ayB0aGUgQVBJQyAqLworCWZsYWcgPSAwOworCXNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShkYXRh
LT5pZCwgJmNvbmZpZ3VyZV9hcGljLCAmZmxhZywgMSk7CisKKwltdXRleF91bmxvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBfX2RldmluaXQgZW5h
YmxlX3RocmVzaF9zdXBwb3J0KHN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhKQoreworCXUzMiBl
YXgsIGVkeDsKKwlpbnQgZmxhZyA9IDE7IC8qIE5vbi1aZXJvIEZsYWcgbWFza3MgdGhlIGFwaWMg
Ki8KKworCXNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShkYXRhLT5pZCwgJmNvbmZpZ3VyZV9hcGlj
LCAmZmxhZywgMSk7CisKKwlyZG1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lO
VEVSUlVQVCwgJmVheCwgJmVkeCk7CisKKwllYXggfD0gKFRIRVJNX0lOVF9USFJFU0hPTEQwX0VO
QUJMRSB8IFRIRVJNX0lOVF9USFJFU0hPTEQxX0VOQUJMRSk7CisKKwl3cm1zcl9vbl9jcHUoZGF0
YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQVCwgZWF4LCBlZHgpOworCisJZmxhZyA9IDA7
IC8qRmxhZyBzaG91bGQgYmUgemVybyB0byB1bm1hc2sgdGhlIGFwaWMgKi8KKwlzbXBfY2FsbF9m
dW5jdGlvbl9zaW5nbGUoZGF0YS0+aWQsICZjb25maWd1cmVfYXBpYywgJmZsYWcsIDEpOworCisJ
cmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1wX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGE7
CkBAIC0zNTMsNiArNDczLDE1IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1wX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJZGF0YS0+dGptYXggPSBnZXRfdGptYXgo
YywgZGF0YS0+aWQsICZwZGV2LT5kZXYpOwogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRh
dGEpOwogCisJLyogRW5hYmxlIHRocmVzaG9sZCBzdXBwb3J0ICovCisJZW5hYmxlX3RocmVzaF9z
dXBwb3J0KGRhdGEpOworCisJLyogU2V0IEluaXRpYWwgQ29yZSB0aHJlc2hvbGRzLgorCSAqIFRo
ZSBsb3dlciBhbmQgdXBwZXIgdGhyZXNob2xkIHZhbHVlcyBoZXJlIGFyZSBhc3N1bWVkCisJICov
CisJc2V0X2NvcmVfdGhyZXNob2xkKGRhdGEsIDAsIENfVFRIUkVTSDApOworCXNldF9jb3JlX3Ro
cmVzaG9sZChkYXRhLCA5MDAwMCwgQ19UVEhSRVNIMSk7CisKIAkvKgogCSAqIHJlYWQgdGhlIHN0
aWxsIHVuZG9jdW1lbnRlZCBJQTMyX1RFTVBFUkFUVVJFX1RBUkdFVC4gSXQgZXhpc3RzCiAJICog
b24gb2xkZXIgQ1BVcyBidXQgbm90IGluIHRoaXMgcmVnaXN0ZXIsCkBAIC00MDUsNiArNTM0LDEw
IEBAIHN0YXRpYyBpbnQgX19kZXZleGl0IGNvcmV0ZW1wX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQogCWh3bW9uX2RldmljZV91bnJlZ2lzdGVyKGRhdGEtPmh3bW9uX2Rldik7
CiAJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5kZXYua29iaiwgJmNvcmV0ZW1wX2dyb3VwKTsK
IAlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwgJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9t
YXguZGV2X2F0dHIpOworCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2LAorCQkJCSZzZW5z
b3JfZGV2X2F0dHJfdGVtcDFfY29yZV90aHJlc2gwLmRldl9hdHRyKTsKKwlkZXZpY2VfcmVtb3Zl
X2ZpbGUoJnBkZXYtPmRldiwKKwkJCQkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2NvcmVfdGhyZXNo
MS5kZXZfYXR0cik7CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CiAJa2ZyZWUo
ZGF0YSk7CiAJcmV0dXJuIDA7Ci0tIAoxLjYuNS4yCgo=

--_002_D6D887BA8C9DFF48B5233887EF04654105C1109439bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C1109439bgsmsx502garc_--
