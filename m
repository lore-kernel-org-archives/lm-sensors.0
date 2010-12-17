From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 17 Dec 2010 06:08:15 +0000
Subject: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C117387Cbgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--_002_D6D887BA8C9DFF48B5233887EF04654105C117387Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am submitting a patch to enable core thermal threshold
Support to coretemp.c. There are two core thermal thresholds
available through sysfs interfaces temp1_max and temp1_min.

The expectation is that _min is lesser than the current temperature
and _max is higher than the current temperature. Whenever the current
temperature crosses these limits, an interrupt is generated.

This patch is generated against stable Linux-2.6 kernel.

As per Guenter's earlier comments the ABI names are changed to
_max and _min.

Kindly review and merge.
------------------------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Thu, 16 Dec 2010 23:09:54 +0530
Subject: [PATCH] Adding_threshold_support_to_coretemp

This patch adds the core thermal threshold support to coretemp.c.
These thresholds can be read/written using the sysfs interface
temp1_max and temp1_min. These can be used to generate interrupts,
to do dynamic power management.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 Documentation/hwmon/coretemp     |    6 ++
 arch/x86/include/asm/msr-index.h |   12 ++++
 drivers/hwmon/coretemp.c         |  118 ++++++++++++++++++++++++++++++++++=
+---
 3 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index 25568f8..096cd8b 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -29,6 +29,12 @@ the Out-Of-Spec bit. Following table summarizes the expo=
rted sysfs files:
=20
 temp1_input	 - Core temperature (in millidegrees Celsius).
 temp1_max	 - All cooling devices should be turned on (on Core2).
+		   If the IA32_TEMPERATURE_TARGET is not supported, this
+		   value indicates the higher core threshold. When the CPU
+		   temperature crosses this temperature, an interrupt is
+		   generated.
+temp1_min	 - Indicates the lower threshold of the core. An interrupt is
+		   generated when CPU temperature crosses this threshold.
 temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
 temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
 		   Correct CPU operation is no longer guaranteed.
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
index 42de98d..30d873e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,7 +39,7 @@
=20
 #define DRVNAME	"coretemp"
=20
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
+typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_TMIN, SHOW_LABEL,
 		SHOW_NAME } SHOW;
=20
 /*
@@ -59,9 +59,11 @@ struct coretemp_data {
 	int temp;
 	int tjmax;
 	int ttarget;
+	int tmin;
 	u8 alarm;
 };
=20
+static int set_core_threshold(struct coretemp_data *data, int val, int ind=
x);
 /*
  * Sysfs stuff
  */
@@ -99,17 +101,37 @@ static ssize_t show_temp(struct device *dev,
 		err =3D data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
 	else if (attr->index =3D=3D SHOW_TJMAX)
 		err =3D sprintf(buf, "%d\n", data->tjmax);
-	else
+	else if (attr->index =3D=3D SHOW_TTARGET)
 		err =3D sprintf(buf, "%d\n", data->ttarget);
+	else
+		err =3D sprintf(buf, "%d\n", data->tmin);
 	return err;
 }
=20
+static ssize_t store_temp(struct device *dev,
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
 			  SHOW_TJMAX);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
-			  SHOW_TTARGET);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
+						store_temp, SHOW_TTARGET);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp,
+						store_temp, SHOW_TMIN);
 static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABE=
L);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
@@ -120,6 +142,8 @@ static struct attribute *coretemp_attributes[] =3D {
 	&dev_attr_temp1_crit_alarm.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	NULL
 };
=20
@@ -298,6 +322,76 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
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
+static int set_core_threshold(struct coretemp_data *data, int temp, int th=
res)
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
+	if (thres =3D=3D SHOW_TMIN) {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD0) |
+					(diff << THERM_OFFSET_THRESHOLD0);
+		data->tmin =3D temp;
+	} else {
+		eax =3D (eax & ~THERM_MASK_THRESHOLD1) |
+					(diff << THERM_OFFSET_THRESHOLD1);
+		data->ttarget =3D temp;
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
@@ -353,10 +447,21 @@ static int __devinit coretemp_probe(struct platform_d=
evice *pdev)
 	data->tjmax =3D get_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
=20
+	/* Enable threshold support */
+	enable_thresh_support(data);
+
+	/* Set Initial Core thresholds.
+	 * The lower and upper threshold values here are assumed
+	 */
+	set_core_threshold(data, 0, SHOW_TMIN);
+	set_core_threshold(data, 90000, SHOW_TTARGET);
+
 	/*
 	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
 	 * on older CPUs but not in this register,
 	 * Atoms don't have it either.
+	 * If this register is not supported, then ttarget has the value
+	 * of upper core threshold, set by set_core_threshold;
 	 */
=20
 	if ((c->x86_model > 0xe) && (c->x86_model !=3D 0x1c)) {
@@ -368,10 +473,6 @@ static int __devinit coretemp_probe(struct platform_de=
vice *pdev)
 		} else {
 			data->ttarget =3D data->tjmax -
 					(((eax >> 8) & 0xff) * 1000);
-			err =3D device_create_file(&pdev->dev,
-					&sensor_dev_attr_temp1_max.dev_attr);
-			if (err)
-				goto exit_free;
 		}
 	}
=20
@@ -404,7 +505,6 @@ static int __devexit coretemp_remove(struct platform_de=
vice *pdev)
=20
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
--=20
1.6.5.2


--_002_D6D887BA8C9DFF48B5233887EF04654105C117387Cbgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-Adding_threshold_support_to_coretemp.patch"
Content-Description: 0001-Adding_threshold_support_to_coretemp.patch
Content-Disposition: attachment;
	filename="0001-Adding_threshold_support_to_coretemp.patch"; size=8325;
	creation-date="Fri, 17 Dec 2010 11:16:13 GMT";
	modification-date="Thu, 16 Dec 2010 23:19:16 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogVGh1LCAxNiBE
ZWMgMjAxMCAyMzowOTo1NCArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFkZGluZ190aHJlc2hvbGRf
c3VwcG9ydF90b19jb3JldGVtcAoKVGhpcyBwYXRjaCBhZGRzIHRoZSBjb3JlIHRoZXJtYWwgdGhy
ZXNob2xkIHN1cHBvcnQgdG8gY29yZXRlbXAuYy4KVGhlc2UgdGhyZXNob2xkcyBjYW4gYmUgcmVh
ZC93cml0dGVuIHVzaW5nIHRoZSBzeXNmcyBpbnRlcmZhY2UKdGVtcDFfbWF4IGFuZCB0ZW1wMV9t
aW4uIFRoZXNlIGNhbiBiZSB1c2VkIHRvIGdlbmVyYXRlIGludGVycnVwdHMsCnRvIGRvIGR5bmFt
aWMgcG93ZXIgbWFuYWdlbWVudC4KClNpZ25lZC1vZmYtYnk6IER1cmdhZG9zcyBSIDxkdXJnYWRv
c3MuckBpbnRlbC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9od21vbi9jb3JldGVtcCAgICAgfCAg
ICA2ICsrCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCB8ICAgMTIgKysrKwogZHJp
dmVycy9od21vbi9jb3JldGVtcC5jICAgICAgICAgfCAgMTE4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vaHdtb24vY29yZXRlbXAg
Yi9Eb2N1bWVudGF0aW9uL2h3bW9uL2NvcmV0ZW1wCmluZGV4IDI1NTY4ZjguLjA5NmNkOGIgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vaHdtb24vY29yZXRlbXAKKysrIGIvRG9jdW1lbnRhdGlv
bi9od21vbi9jb3JldGVtcApAQCAtMjksNiArMjksMTIgQEAgdGhlIE91dC1PZi1TcGVjIGJpdC4g
Rm9sbG93aW5nIHRhYmxlIHN1bW1hcml6ZXMgdGhlIGV4cG9ydGVkIHN5c2ZzIGZpbGVzOgogCiB0
ZW1wMV9pbnB1dAkgLSBDb3JlIHRlbXBlcmF0dXJlIChpbiBtaWxsaWRlZ3JlZXMgQ2Vsc2l1cyku
CiB0ZW1wMV9tYXgJIC0gQWxsIGNvb2xpbmcgZGV2aWNlcyBzaG91bGQgYmUgdHVybmVkIG9uIChv
biBDb3JlMikuCisJCSAgIElmIHRoZSBJQTMyX1RFTVBFUkFUVVJFX1RBUkdFVCBpcyBub3Qgc3Vw
cG9ydGVkLCB0aGlzCisJCSAgIHZhbHVlIGluZGljYXRlcyB0aGUgaGlnaGVyIGNvcmUgdGhyZXNo
b2xkLiBXaGVuIHRoZSBDUFUKKwkJICAgdGVtcGVyYXR1cmUgY3Jvc3NlcyB0aGlzIHRlbXBlcmF0
dXJlLCBhbiBpbnRlcnJ1cHQgaXMKKwkJICAgZ2VuZXJhdGVkLgordGVtcDFfbWluCSAtIEluZGlj
YXRlcyB0aGUgbG93ZXIgdGhyZXNob2xkIG9mIHRoZSBjb3JlLiBBbiBpbnRlcnJ1cHQgaXMKKwkJ
ICAgZ2VuZXJhdGVkIHdoZW4gQ1BVIHRlbXBlcmF0dXJlIGNyb3NzZXMgdGhpcyB0aHJlc2hvbGQu
CiB0ZW1wMV9jcml0CSAtIE1heGltdW0ganVuY3Rpb24gdGVtcGVyYXR1cmUgKGluIG1pbGxpZGVn
cmVlcyBDZWxzaXVzKS4KIHRlbXAxX2NyaXRfYWxhcm0gLSBTZXQgd2hlbiBPdXQtb2Ytc3BlYyBi
aXQgaXMgc2V0LCBuZXZlciBjbGVhcnMuCiAJCSAgIENvcnJlY3QgQ1BVIG9wZXJhdGlvbiBpcyBu
byBsb25nZXIgZ3VhcmFudGVlZC4KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21z
ci1pbmRleC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKaW5kZXggM2VhM2Rj
NC4uMzFjZWZhZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKQEAgLTI1Myw2ICsyNTMsMTgg
QEAKICNkZWZpbmUgUEFDS0FHRV9USEVSTV9JTlRfTE9XX0VOQUJMRQkJKDEgPDwgMSkKICNkZWZp
bmUgUEFDS0FHRV9USEVSTV9JTlRfUExOX0VOQUJMRQkJKDEgPDwgMjQpCiAKKy8qIFRoZXJtYWwg
VGhyZXNob2xkcyBTdXBwb3J0ICovCisjZGVmaW5lIFRIRVJNX0lOVF9USFJFU0hPTEQwX0VOQUJM
RSAgICAoMSA8PCAxNSkKKyNkZWZpbmUgVEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDAgICAgICAgIDgK
KyNkZWZpbmUgVEhFUk1fTUFTS19USFJFU0hPTEQwICAgICAgICAgICgweDdmIDw8IFRIRVJNX09G
RlNFVF9USFJFU0hPTEQwKQorI2RlZmluZSBUSEVSTV9JTlRfVEhSRVNIT0xEMV9FTkFCTEUgICAg
KDEgPDwgMjMpCisjZGVmaW5lIFRIRVJNX09GRlNFVF9USFJFU0hPTEQxICAgICAgICAxNgorI2Rl
ZmluZSBUSEVSTV9NQVNLX1RIUkVTSE9MRDEgICAgICAgICAgKDB4N2YgPDwgVEhFUk1fT0ZGU0VU
X1RIUkVTSE9MRDEpCisjZGVmaW5lIFRIRVJNX1NUQVRVU19USFJFU0hPTEQwICAgICAgICAoMSA8
PCA2KQorI2RlZmluZSBUSEVSTV9MT0dfVEhSRVNIT0xEMCAgICAgICAgICAgKDEgPDwgNykKKyNk
ZWZpbmUgVEhFUk1fU1RBVFVTX1RIUkVTSE9MRDEgICAgICAgICgxIDw8IDgpCisjZGVmaW5lIFRI
RVJNX0xPR19USFJFU0hPTEQxICAgICAgICAgICAoMSA8PCA5KQorCiAvKiBNSVNDX0VOQUJMRSBi
aXRzOiBhcmNoaXRlY3R1cmFsICovCiAjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxFX0ZBU1Rf
U1RSSU5HCSgxVUxMIDw8IDApCiAjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxFX1RDQwkJKDFV
TEwgPDwgMSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyBiL2RyaXZlcnMv
aHdtb24vY29yZXRlbXAuYwppbmRleCA0MmRlOThkLi4zMGQ4NzNlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKKysrIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5jCkBAIC0z
OSw3ICszOSw3IEBACiAKICNkZWZpbmUgRFJWTkFNRQkiY29yZXRlbXAiCiAKLXR5cGVkZWYgZW51
bSB7IFNIT1dfVEVNUCwgU0hPV19USk1BWCwgU0hPV19UVEFSR0VULCBTSE9XX0xBQkVMLAordHlw
ZWRlZiBlbnVtIHsgU0hPV19URU1QLCBTSE9XX1RKTUFYLCBTSE9XX1RUQVJHRVQsIFNIT1dfVE1J
TiwgU0hPV19MQUJFTCwKIAkJU0hPV19OQU1FIH0gU0hPVzsKIAogLyoKQEAgLTU5LDkgKzU5LDEx
IEBAIHN0cnVjdCBjb3JldGVtcF9kYXRhIHsKIAlpbnQgdGVtcDsKIAlpbnQgdGptYXg7CiAJaW50
IHR0YXJnZXQ7CisJaW50IHRtaW47CiAJdTggYWxhcm07CiB9OwogCitzdGF0aWMgaW50IHNldF9j
b3JlX3RocmVzaG9sZChzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSwgaW50IHZhbCwgaW50IGlu
ZHgpOwogLyoKICAqIFN5c2ZzIHN0dWZmCiAgKi8KQEAgLTk5LDE3ICsxMDEsMzcgQEAgc3RhdGlj
IHNzaXplX3Qgc2hvd190ZW1wKHN0cnVjdCBkZXZpY2UgKmRldiwKIAkJZXJyID0gZGF0YS0+dmFs
aWQgPyBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBkYXRhLT50ZW1wKSA6IC1FQUdBSU47CiAJZWxzZSBp
ZiAoYXR0ci0+aW5kZXggPT0gU0hPV19USk1BWCkKIAkJZXJyID0gc3ByaW50ZihidWYsICIlZFxu
IiwgZGF0YS0+dGptYXgpOwotCWVsc2UKKwllbHNlIGlmIChhdHRyLT5pbmRleCA9PSBTSE9XX1RU
QVJHRVQpCiAJCWVyciA9IHNwcmludGYoYnVmLCAiJWRcbiIsIGRhdGEtPnR0YXJnZXQpOworCWVs
c2UKKwkJZXJyID0gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+dG1pbik7CiAJcmV0dXJuIGVy
cjsKIH0KIAorc3RhdGljIHNzaXplX3Qgc3RvcmVfdGVtcChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJ
CXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkKK3sKKwlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKmF0dHIgPSB0b19z
ZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7CisJc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEgPSBj
b3JldGVtcF91cGRhdGVfZGV2aWNlKGRldik7CisJdW5zaWduZWQgbG9uZyB2YWw7CisJaW50IGVy
cjsKKworCWlmIChzdHJpY3Rfc3RydG91bChidWYsIDEwLCAmdmFsKSkKKwkJcmV0dXJuIC1FSU5W
QUw7CisKKwllcnIgPSBzZXRfY29yZV90aHJlc2hvbGQoZGF0YSwgdmFsLCBhdHRyLT5pbmRleCk7
CisKKwlyZXR1cm4gKGVycikgPyAtRUlOVkFMIDogY291bnQ7Cit9CisKIHN0YXRpYyBTRU5TT1Jf
REVWSUNFX0FUVFIodGVtcDFfaW5wdXQsIFNfSVJVR08sIHNob3dfdGVtcCwgTlVMTCwKIAkJCSAg
U0hPV19URU1QKTsKIHN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIodGVtcDFfY3JpdCwgU19JUlVH
Tywgc2hvd190ZW1wLCBOVUxMLAogCQkJICBTSE9XX1RKTUFYKTsKLXN0YXRpYyBTRU5TT1JfREVW
SUNFX0FUVFIodGVtcDFfbWF4LCBTX0lSVUdPLCBzaG93X3RlbXAsIE5VTEwsCi0JCQkgIFNIT1df
VFRBUkdFVCk7CitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX21heCwgU19JV1VTUiB8
IFNfSVJVR08sIHNob3dfdGVtcCwKKwkJCQkJCXN0b3JlX3RlbXAsIFNIT1dfVFRBUkdFVCk7Citz
dGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX21pbiwgU19JV1VTUiB8IFNfSVJVR08sIHNo
b3dfdGVtcCwKKwkJCQkJCXN0b3JlX3RlbXAsIFNIT1dfVE1JTik7CiBzdGF0aWMgREVWSUNFX0FU
VFIodGVtcDFfY3JpdF9hbGFybSwgU19JUlVHTywgc2hvd19hbGFybSwgTlVMTCk7CiBzdGF0aWMg
U0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX2xhYmVsLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEws
IFNIT1dfTEFCRUwpOwogc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUihuYW1lLCBTX0lSVUdPLCBz
aG93X25hbWUsIE5VTEwsIFNIT1dfTkFNRSk7CkBAIC0xMjAsNiArMTQyLDggQEAgc3RhdGljIHN0
cnVjdCBhdHRyaWJ1dGUgKmNvcmV0ZW1wX2F0dHJpYnV0ZXNbXSA9IHsKIAkmZGV2X2F0dHJfdGVt
cDFfY3JpdF9hbGFybS5hdHRyLAogCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfaW5wdXQuZGV2X2F0
dHIuYXR0ciwKIAkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2NyaXQuZGV2X2F0dHIuYXR0ciwKKwkm
c2Vuc29yX2Rldl9hdHRyX3RlbXAxX21heC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0
dHJfdGVtcDFfbWluLmRldl9hdHRyLmF0dHIsCiAJTlVMTAogfTsKIApAQCAtMjk4LDYgKzMyMiw3
NiBAQCBzdGF0aWMgdm9pZCBfX2RldmluaXQgZ2V0X3Vjb2RlX3Jldl9vbl9jcHUodm9pZCAqZWR4
KQogCXJkbXNyKE1TUl9JQTMyX1VDT0RFX1JFViwgZWF4LCAqKHUzMiAqKWVkeCk7CiB9CiAKK3N0
YXRpYyB2b2lkIGNvbmZpZ3VyZV9hcGljKHZvaWQgKmluZm8pCit7CisJdTMyIGw7CisJaW50ICpm
bGFnID0gKGludCAqKWluZm87CisKKwlsID0gYXBpY19yZWFkKEFQSUNfTFZUVEhNUik7CisKKwlp
ZiAoKmZsYWcpCS8qIE5vbi1aZXJvIGZsYWcgTWFza3MgdGhlIEFQSUMgKi8KKwkJYXBpY193cml0
ZShBUElDX0xWVFRITVIsIGwgfCBBUElDX0xWVF9NQVNLRUQpOworCWVsc2UJCS8qIFplcm8gZmxh
ZyBVbk1hc2tzIHRoZSBBUElDICovCisJCWFwaWNfd3JpdGUoQVBJQ19MVlRUSE1SLCBsICYgfkFQ
SUNfTFZUX01BU0tFRCk7Cit9CisKK3N0YXRpYyBpbnQgc2V0X2NvcmVfdGhyZXNob2xkKHN0cnVj
dCBjb3JldGVtcF9kYXRhICpkYXRhLCBpbnQgdGVtcCwgaW50IHRocmVzKQoreworCXUzMiBlYXgs
IGVkeDsKKwlpbnQgZGlmZjsKKwlpbnQgZmxhZyA9IDE7CisKKwlpZiAodGVtcCA+IGRhdGEtPnRq
bWF4KQorCQlyZXR1cm4gLUVJTlZBTDsKKworCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2Nr
KTsKKworCWRpZmYgPSAoZGF0YS0+dGptYXggLSB0ZW1wKS8xMDAwOworCisJLyogTWFzayB0aGUg
QVBJQyAqLworCXNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShkYXRhLT5pZCwgJmNvbmZpZ3VyZV9h
cGljLCAmZmxhZywgMSk7CisKKwlyZG1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJN
X0lOVEVSUlVQVCwgJmVheCwgJmVkeCk7CisKKwlpZiAodGhyZXMgPT0gU0hPV19UTUlOKSB7CisJ
CWVheCA9IChlYXggJiB+VEhFUk1fTUFTS19USFJFU0hPTEQwKSB8CisJCQkJCShkaWZmIDw8IFRI
RVJNX09GRlNFVF9USFJFU0hPTEQwKTsKKwkJZGF0YS0+dG1pbiA9IHRlbXA7CisJfSBlbHNlIHsK
KwkJZWF4ID0gKGVheCAmIH5USEVSTV9NQVNLX1RIUkVTSE9MRDEpIHwKKwkJCQkJKGRpZmYgPDwg
VEhFUk1fT0ZGU0VUX1RIUkVTSE9MRDEpOworCQlkYXRhLT50dGFyZ2V0ID0gdGVtcDsKKwl9CisK
Kwl3cm1zcl9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJNX0lOVEVSUlVQVCwgZWF4LCBl
ZHgpOworCisJLyogVW5tYXNrIHRoZSBBUElDICovCisJZmxhZyA9IDA7CisJc21wX2NhbGxfZnVu
Y3Rpb25fc2luZ2xlKGRhdGEtPmlkLCAmY29uZmlndXJlX2FwaWMsICZmbGFnLCAxKTsKKworCW11
dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOworCXJldHVybiAwOworfQorCitzdGF0aWMg
aW50IF9fZGV2aW5pdCBlbmFibGVfdGhyZXNoX3N1cHBvcnQoc3RydWN0IGNvcmV0ZW1wX2RhdGEg
KmRhdGEpCit7CisJdTMyIGVheCwgZWR4OworCWludCBmbGFnID0gMTsgLyogTm9uLVplcm8gRmxh
ZyBtYXNrcyB0aGUgYXBpYyAqLworCisJc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlKGRhdGEtPmlk
LCAmY29uZmlndXJlX2FwaWMsICZmbGFnLCAxKTsKKworCXJkbXNyX29uX2NwdShkYXRhLT5pZCwg
TVNSX0lBMzJfVEhFUk1fSU5URVJSVVBULCAmZWF4LCAmZWR4KTsKKworCWVheCB8PSAoVEhFUk1f
SU5UX1RIUkVTSE9MRDBfRU5BQkxFIHwgVEhFUk1fSU5UX1RIUkVTSE9MRDFfRU5BQkxFKTsKKwor
CXdybXNyX29uX2NwdShkYXRhLT5pZCwgTVNSX0lBMzJfVEhFUk1fSU5URVJSVVBULCBlYXgsIGVk
eCk7CisKKwlmbGFnID0gMDsgLypGbGFnIHNob3VsZCBiZSB6ZXJvIHRvIHVubWFzayB0aGUgYXBp
YyAqLworCXNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShkYXRhLT5pZCwgJmNvbmZpZ3VyZV9hcGlj
LCAmZmxhZywgMSk7CisKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCBfX2RldmluaXQgY29y
ZXRlbXBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3QgY29y
ZXRlbXBfZGF0YSAqZGF0YTsKQEAgLTM1MywxMCArNDQ3LDIxIEBAIHN0YXRpYyBpbnQgX19kZXZp
bml0IGNvcmV0ZW1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJZGF0YS0+
dGptYXggPSBnZXRfdGptYXgoYywgZGF0YS0+aWQsICZwZGV2LT5kZXYpOwogCXBsYXRmb3JtX3Nl
dF9kcnZkYXRhKHBkZXYsIGRhdGEpOwogCisJLyogRW5hYmxlIHRocmVzaG9sZCBzdXBwb3J0ICov
CisJZW5hYmxlX3RocmVzaF9zdXBwb3J0KGRhdGEpOworCisJLyogU2V0IEluaXRpYWwgQ29yZSB0
aHJlc2hvbGRzLgorCSAqIFRoZSBsb3dlciBhbmQgdXBwZXIgdGhyZXNob2xkIHZhbHVlcyBoZXJl
IGFyZSBhc3N1bWVkCisJICovCisJc2V0X2NvcmVfdGhyZXNob2xkKGRhdGEsIDAsIFNIT1dfVE1J
Tik7CisJc2V0X2NvcmVfdGhyZXNob2xkKGRhdGEsIDkwMDAwLCBTSE9XX1RUQVJHRVQpOworCiAJ
LyoKIAkgKiByZWFkIHRoZSBzdGlsbCB1bmRvY3VtZW50ZWQgSUEzMl9URU1QRVJBVFVSRV9UQVJH
RVQuIEl0IGV4aXN0cwogCSAqIG9uIG9sZGVyIENQVXMgYnV0IG5vdCBpbiB0aGlzIHJlZ2lzdGVy
LAogCSAqIEF0b21zIGRvbid0IGhhdmUgaXQgZWl0aGVyLgorCSAqIElmIHRoaXMgcmVnaXN0ZXIg
aXMgbm90IHN1cHBvcnRlZCwgdGhlbiB0dGFyZ2V0IGhhcyB0aGUgdmFsdWUKKwkgKiBvZiB1cHBl
ciBjb3JlIHRocmVzaG9sZCwgc2V0IGJ5IHNldF9jb3JlX3RocmVzaG9sZDsKIAkgKi8KIAogCWlm
ICgoYy0+eDg2X21vZGVsID4gMHhlKSAmJiAoYy0+eDg2X21vZGVsICE9IDB4MWMpKSB7CkBAIC0z
NjgsMTAgKzQ3Myw2IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1wX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCX0gZWxzZSB7CiAJCQlkYXRhLT50dGFyZ2V0ID0g
ZGF0YS0+dGptYXggLQogCQkJCQkoKChlYXggPj4gOCkgJiAweGZmKSAqIDEwMDApOwotCQkJZXJy
ID0gZGV2aWNlX2NyZWF0ZV9maWxlKCZwZGV2LT5kZXYsCi0JCQkJCSZzZW5zb3JfZGV2X2F0dHJf
dGVtcDFfbWF4LmRldl9hdHRyKTsKLQkJCWlmIChlcnIpCi0JCQkJZ290byBleGl0X2ZyZWU7CiAJ
CX0KIAl9CiAKQEAgLTQwNCw3ICs1MDUsNiBAQCBzdGF0aWMgaW50IF9fZGV2ZXhpdCBjb3JldGVt
cF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAogCWh3bW9uX2RldmljZV91
bnJlZ2lzdGVyKGRhdGEtPmh3bW9uX2Rldik7CiAJc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5k
ZXYua29iaiwgJmNvcmV0ZW1wX2dyb3VwKTsKLQlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRl
diwgJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9tYXguZGV2X2F0dHIpOwogCXBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIE5VTEwpOwogCWtmcmVlKGRhdGEpOwogCXJldHVybiAwOwotLSAKMS42LjUu
MgoK

--_002_D6D887BA8C9DFF48B5233887EF04654105C117387Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C117387Cbgsmsx502garc_--
