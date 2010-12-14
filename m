From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 14 Dec 2010 13:28:28 +0000
Subject: [lm-sensors] Patch[2/2]
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C110948C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C110948Cbgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

--_002_D6D887BA8C9DFF48B5233887EF04654105C110948Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jean/Fenghua,

This patch, the second one in the series adds the interrupt
Handling support for the thermal thresholds. When an interrupt
occurs, this is notified to the user space(so that the user space
can take some action) by a netlink event.

This patch is generated against the stable Linux-2.6 tree.

This patch depends on the "Adding notification to thermal
Framework" patch, which can be downloaded from here:
https://patchwork.kernel.org/patch/282042/


Kindly review and merge.
------------------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Tue, 14 Dec 2010 06:31:09 +0530
Subject: [PATCH 2/2] Adding_core_threshold_interrupt_handling_to_coretemp

This patch adds the interrupt handling support for the
Core thermal thresholds. When an interrupt occurs,
this is notified to the user space(so that the user space
can take some action) by a netlink event.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 arch/x86/include/asm/mce.h               |    3 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c |   56 ++++++++++++++++++++++++++
 drivers/hwmon/coretemp.c                 |   64 ++++++++++++++++++++++++++=
++++
 3 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c62c13c..eb16e94 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -223,6 +223,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c);
=20
 void mce_log_therm_throt_event(__u64 status);
=20
+/* Interrupt Handler for core thermal thresholds */
+extern int (*platform_thermal_notify)(__u64 msr_val);
+
 #ifdef CONFIG_X86_THERMAL_VECTOR
 extern void mcheck_intel_therm_init(void);
 #else
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu=
/mcheck/therm_throt.c
index 4b68326..d1148cc 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -34,6 +34,11 @@
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL		(300 * HZ)
=20
+/* Similar to CHECK_INTERVAL. But interval is reduced because
+ * these lower and upper threhsolds will be crossed frequently.
+ * Hence the reporting should be quick enough to handle the event */
+#define THRES_INTERVAL		(25 * HZ)
+
 #define THERMAL_THROTTLING_EVENT	0
 #define POWER_LIMIT_EVENT		1
=20
@@ -53,8 +58,13 @@ struct thermal_state {
 	struct _thermal_state core_power_limit;
 	struct _thermal_state package_throttle;
 	struct _thermal_state package_power_limit;
+	struct _thermal_state core_thresh0;
+	struct _thermal_state core_thresh1;
 };
=20
+/* Callback to handle core threshold interrupts */
+int (*platform_thermal_notify)(__u64 msr_val);
+
 static DEFINE_PER_CPU(struct thermal_state, thermal_state);
=20
 static atomic_t therm_throt_en	=3D ATOMIC_INIT(0);
@@ -200,6 +210,32 @@ static int therm_throt_process(bool new_event, int eve=
nt, int level)
 	return 0;
 }
=20
+static int thresh_event_valid(int event)
+{
+	struct _thermal_state *state =3D NULL;
+
+	unsigned int this_cpu =3D smp_processor_id();
+	struct thermal_state *pstate =3D &per_cpu(thermal_state, this_cpu);
+	u64 now =3D get_jiffies_64();
+
+	switch (event) {
+	case 0:
+		state =3D &pstate->core_thresh0;
+		break;
+	case 1:
+		state =3D &pstate->core_thresh1;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	if (time_before64(now, state->next_check))
+		return 0;
+
+	state->next_check =3D now + THRES_INTERVAL;
+	return 1;
+}
+
 #ifdef CONFIG_SYSFS
 /* Add/Remove thermal_throttle interface for CPU device: */
 static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
@@ -313,6 +349,22 @@ device_initcall(thermal_throttle_init_device);
 #define PACKAGE_THROTTLED	((__u64)2 << 62)
 #define PACKAGE_POWER_LIMIT	((__u64)3 << 62)
=20
+static void notify_thresholds(__u64 msr_val)
+{
+	/* check whether the interrupt handler is defined;
+	 * otherwise simply return
+	 */
+	if (!platform_thermal_notify)
+		return;
+
+	/* lower threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD0) &&	thresh_event_valid(0))
+		platform_thermal_notify(msr_val);
+	/* higher threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD1) && thresh_event_valid(1))
+		platform_thermal_notify(msr_val);
+}
+
 /* Thermal transition interrupt handler */
 static void intel_thermal_interrupt(void)
 {
@@ -321,6 +373,10 @@ static void intel_thermal_interrupt(void)
=20
 	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
=20
+	/* Check for violation of core thermal thresholds
+	 * If so, send notification */
+	notify_thresholds(msr_val);
+
 	if (therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
 				THERMAL_THROTTLING_EVENT,
 				CORE_LEVEL) !=3D 0)
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 4c221b8..c53228c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -36,9 +36,17 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
+#include <asm/mce.h>
+#include <linux/thermal.h>
=20
 #define DRVNAME	"coretemp"
=20
+/* An identification number to the DTS sensor.
+ * This will help the user space to figure out which
+ * sensor caused the event
+ */
+#define DTS_ID 0
+
 typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 		SHOW_NAME } SHOW;
=20
@@ -69,6 +77,45 @@ struct coretemp_data {
=20
 static int set_core_threshold(struct coretemp_data *data, int val,
 						enum thresholds thresh);
+/* Interrupt Handlers for core/package thresholds */
+struct work_struct *t0_netlink_handlr;
+struct work_struct *t1_netlink_handlr;
+
+/* Send netlink event for DTS sensor reaching threshold0 */
+static void gen_netlink_t0(struct work_struct *work)
+{
+	generate_netlink_event(DTS_ID, THERMAL_AUX0);
+}
+
+/* Send netlink event for DTS sensor reaching threshold1 */
+static void gen_netlink_t1(struct work_struct *work)
+{
+	generate_netlink_event(DTS_ID, THERMAL_AUX1);
+}
+
+/* Platform thermal Interrupt Handler */
+static int coretemp_interrupt(__u64 msr_val)
+{
+
+	if (msr_val & THERM_LOG_THRESHOLD0) {
+		if (!(msr_val & THERM_STATUS_THRESHOLD0))
+			schedule_work(t0_netlink_handlr);
+
+		/* Reset the Threshold0 interrupt */
+		wrmsrl(MSR_IA32_THERM_STATUS, msr_val & ~THERM_LOG_THRESHOLD0);
+	}
+
+	if (msr_val & THERM_LOG_THRESHOLD1) {
+		if (msr_val & THERM_STATUS_THRESHOLD1)
+			schedule_work(t1_netlink_handlr);
+
+		/* Reset the Threshold1 interrupt */
+		wrmsrl(MSR_IA32_THERM_STATUS, msr_val & ~THERM_LOG_THRESHOLD1);
+	}
+
+	return 0;
+}
+
 /*
  * Sysfs stuff
  */
@@ -415,6 +462,9 @@ static int __devinit enable_thresh_support(struct coret=
emp_data *data)
 	flag =3D 0; /*Flag should be zero to unmask the apic */
 	smp_call_function_single(data->id, &configure_apic, &flag, 1);
=20
+	/* Enable the Interrupt Handling Support */
+	platform_thermal_notify =3D coretemp_interrupt;
+
 	return 0;
 }
=20
@@ -702,6 +752,20 @@ static int __init coretemp_init(void)
 #endif
=20
 	register_hotcpu_notifier(&coretemp_cpu_notifier);
+
+	/* Initialize the Interrupt Handlers */
+	t0_netlink_handlr =3D kzalloc(sizeof(struct work_struct), GFP_KERNEL);
+	if (!t0_netlink_handlr)
+		return -ENOMEM;
+
+	t1_netlink_handlr =3D kzalloc(sizeof(struct work_struct), GFP_KERNEL);
+	if (!t1_netlink_handlr) {
+		kfree(t0_netlink_handlr);
+		return -ENOMEM;
+	}
+	INIT_WORK(t0_netlink_handlr, (void *)gen_netlink_t0);
+	INIT_WORK(t1_netlink_handlr, (void *)gen_netlink_t1);
+
 	return 0;
=20
 #ifndef CONFIG_HOTPLUG_CPU
--=20
1.6.5.2


--_002_D6D887BA8C9DFF48B5233887EF04654105C110948Cbgsmsx502garc_
Content-Type: application/octet-stream;
	name="0002-Adding_core_threshold_interrupt_handling_to_coretemp.patch"
Content-Description: 0002-Adding_core_threshold_interrupt_handling_to_coretemp.patch
Content-Disposition: attachment;
	filename="0002-Adding_core_threshold_interrupt_handling_to_coretemp.patch";
	size=6689; creation-date="Tue, 14 Dec 2010 18:41:12 GMT";
	modification-date="Tue, 14 Dec 2010 06:34:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMzIwY2ZlM2FjMWFjYzA4OWU0MjIwOTcyM2JkODIyN2U3MmNiMTA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEdXJnYWRvc3MgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0
ZTogVHVlLCAxNCBEZWMgMjAxMCAwNjozMTowOSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBB
ZGRpbmdfY29yZV90aHJlc2hvbGRfaW50ZXJydXB0X2hhbmRsaW5nX3RvX2NvcmV0ZW1wCgpUaGlz
IHBhdGNoCgpTaWduZWQtb2ZmLWJ5OiBEdXJnYWRvc3MgUiA8ZHVyZ2Fkb3NzLnJAaW50ZWwuY29t
PgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL21jZS5oICAgICAgICAgICAgICAgfCAgICAzICsK
IGFyY2gveDg2L2tlcm5lbC9jcHUvbWNoZWNrL3RoZXJtX3Rocm90LmMgfCAgIDU2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMgICAgICAgICAgICAg
ICAgIHwgICA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMTIzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vbWNlLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaAppbmRleCBj
NjJjMTNjLi5lYjE2ZTk0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaApAQCAtMjIzLDYgKzIyMyw5IEBAIHZvaWQg
aW50ZWxfaW5pdF90aGVybWFsKHN0cnVjdCBjcHVpbmZvX3g4NiAqYyk7CiAKIHZvaWQgbWNlX2xv
Z190aGVybV90aHJvdF9ldmVudChfX3U2NCBzdGF0dXMpOwogCisvKiBJbnRlcnJ1cHQgSGFuZGxl
ciBmb3IgY29yZSB0aGVybWFsIHRocmVzaG9sZHMgKi8KK2V4dGVybiBpbnQgKCpwbGF0Zm9ybV90
aGVybWFsX25vdGlmeSkoX191NjQgbXNyX3ZhbCk7CisKICNpZmRlZiBDT05GSUdfWDg2X1RIRVJN
QUxfVkVDVE9SCiBleHRlcm4gdm9pZCBtY2hlY2tfaW50ZWxfdGhlcm1faW5pdCh2b2lkKTsKICNl
bHNlCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jaGVjay90aGVybV90aHJvdC5j
IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2hlY2svdGhlcm1fdGhyb3QuYwppbmRleCA0YjY4MzI2
Li5kMTE0OGNjIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jaGVjay90aGVybV90
aHJvdC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNoZWNrL3RoZXJtX3Rocm90LmMKQEAg
LTM0LDYgKzM0LDExIEBACiAvKiBIb3cgbG9uZyB0byB3YWl0IGJldHdlZW4gcmVwb3J0aW5nIHRo
ZXJtYWwgZXZlbnRzICovCiAjZGVmaW5lIENIRUNLX0lOVEVSVkFMCQkoMzAwICogSFopCiAKKy8q
IFNpbWlsYXIgdG8gQ0hFQ0tfSU5URVJWQUwuIEJ1dCBpbnRlcnZhbCBpcyByZWR1Y2VkIGJlY2F1
c2UKKyAqIHRoZXNlIGxvd2VyIGFuZCB1cHBlciB0aHJlaHNvbGRzIHdpbGwgYmUgY3Jvc3NlZCBm
cmVxdWVudGx5LgorICogSGVuY2UgdGhlIHJlcG9ydGluZyBzaG91bGQgYmUgcXVpY2sgZW5vdWdo
IHRvIGhhbmRsZSB0aGUgZXZlbnQgKi8KKyNkZWZpbmUgVEhSRVNfSU5URVJWQUwJCSgyNSAqIEha
KQorCiAjZGVmaW5lIFRIRVJNQUxfVEhST1RUTElOR19FVkVOVAkwCiAjZGVmaW5lIFBPV0VSX0xJ
TUlUX0VWRU5UCQkxCiAKQEAgLTUzLDggKzU4LDEzIEBAIHN0cnVjdCB0aGVybWFsX3N0YXRlIHsK
IAlzdHJ1Y3QgX3RoZXJtYWxfc3RhdGUgY29yZV9wb3dlcl9saW1pdDsKIAlzdHJ1Y3QgX3RoZXJt
YWxfc3RhdGUgcGFja2FnZV90aHJvdHRsZTsKIAlzdHJ1Y3QgX3RoZXJtYWxfc3RhdGUgcGFja2Fn
ZV9wb3dlcl9saW1pdDsKKwlzdHJ1Y3QgX3RoZXJtYWxfc3RhdGUgY29yZV90aHJlc2gwOworCXN0
cnVjdCBfdGhlcm1hbF9zdGF0ZSBjb3JlX3RocmVzaDE7CiB9OwogCisvKiBDYWxsYmFjayB0byBo
YW5kbGUgY29yZSB0aHJlc2hvbGQgaW50ZXJydXB0cyAqLworaW50ICgqcGxhdGZvcm1fdGhlcm1h
bF9ub3RpZnkpKF9fdTY0IG1zcl92YWwpOworCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0
IHRoZXJtYWxfc3RhdGUsIHRoZXJtYWxfc3RhdGUpOwogCiBzdGF0aWMgYXRvbWljX3QgdGhlcm1f
dGhyb3RfZW4JPSBBVE9NSUNfSU5JVCgwKTsKQEAgLTIwMCw2ICsyMTAsMzIgQEAgc3RhdGljIGlu
dCB0aGVybV90aHJvdF9wcm9jZXNzKGJvb2wgbmV3X2V2ZW50LCBpbnQgZXZlbnQsIGludCBsZXZl
bCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCB0aHJlc2hfZXZlbnRfdmFsaWQoaW50IGV2
ZW50KQoreworCXN0cnVjdCBfdGhlcm1hbF9zdGF0ZSAqc3RhdGUgPSBOVUxMOworCisJdW5zaWdu
ZWQgaW50IHRoaXNfY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOworCXN0cnVjdCB0aGVybWFsX3N0
YXRlICpwc3RhdGUgPSAmcGVyX2NwdSh0aGVybWFsX3N0YXRlLCB0aGlzX2NwdSk7CisJdTY0IG5v
dyA9IGdldF9qaWZmaWVzXzY0KCk7CisKKwlzd2l0Y2ggKGV2ZW50KSB7CisJY2FzZSAwOgorCQlz
dGF0ZSA9ICZwc3RhdGUtPmNvcmVfdGhyZXNoMDsKKwkJYnJlYWs7CisJY2FzZSAxOgorCQlzdGF0
ZSA9ICZwc3RhdGUtPmNvcmVfdGhyZXNoMTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJV0FSTl9P
TigxKTsKKwl9CisKKwlpZiAodGltZV9iZWZvcmU2NChub3csIHN0YXRlLT5uZXh0X2NoZWNrKSkK
KwkJcmV0dXJuIDA7CisKKwlzdGF0ZS0+bmV4dF9jaGVjayA9IG5vdyArIFRIUkVTX0lOVEVSVkFM
OworCXJldHVybiAxOworfQorCiAjaWZkZWYgQ09ORklHX1NZU0ZTCiAvKiBBZGQvUmVtb3ZlIHRo
ZXJtYWxfdGhyb3R0bGUgaW50ZXJmYWNlIGZvciBDUFUgZGV2aWNlOiAqLwogc3RhdGljIF9fY3B1
aW5pdCBpbnQgdGhlcm1hbF90aHJvdHRsZV9hZGRfZGV2KHN0cnVjdCBzeXNfZGV2aWNlICpzeXNf
ZGV2LApAQCAtMzEzLDYgKzM0OSwyMiBAQCBkZXZpY2VfaW5pdGNhbGwodGhlcm1hbF90aHJvdHRs
ZV9pbml0X2RldmljZSk7CiAjZGVmaW5lIFBBQ0tBR0VfVEhST1RUTEVECSgoX191NjQpMiA8PCA2
MikKICNkZWZpbmUgUEFDS0FHRV9QT1dFUl9MSU1JVAkoKF9fdTY0KTMgPDwgNjIpCiAKK3N0YXRp
YyB2b2lkIG5vdGlmeV90aHJlc2hvbGRzKF9fdTY0IG1zcl92YWwpCit7CisJLyogY2hlY2sgd2hl
dGhlciB0aGUgaW50ZXJydXB0IGhhbmRsZXIgaXMgZGVmaW5lZDsKKwkgKiBvdGhlcndpc2Ugc2lt
cGx5IHJldHVybgorCSAqLworCWlmICghcGxhdGZvcm1fdGhlcm1hbF9ub3RpZnkpCisJCXJldHVy
bjsKKworCS8qIGxvd2VyIHRocmVzaG9sZCByZWFjaGVkICovCisJaWYgKChtc3JfdmFsICYgVEhF
Uk1fTE9HX1RIUkVTSE9MRDApICYmCXRocmVzaF9ldmVudF92YWxpZCgwKSkKKwkJcGxhdGZvcm1f
dGhlcm1hbF9ub3RpZnkobXNyX3ZhbCk7CisJLyogaGlnaGVyIHRocmVzaG9sZCByZWFjaGVkICov
CisJaWYgKChtc3JfdmFsICYgVEhFUk1fTE9HX1RIUkVTSE9MRDEpICYmIHRocmVzaF9ldmVudF92
YWxpZCgxKSkKKwkJcGxhdGZvcm1fdGhlcm1hbF9ub3RpZnkobXNyX3ZhbCk7Cit9CisKIC8qIFRo
ZXJtYWwgdHJhbnNpdGlvbiBpbnRlcnJ1cHQgaGFuZGxlciAqLwogc3RhdGljIHZvaWQgaW50ZWxf
dGhlcm1hbF9pbnRlcnJ1cHQodm9pZCkKIHsKQEAgLTMyMSw2ICszNzMsMTAgQEAgc3RhdGljIHZv
aWQgaW50ZWxfdGhlcm1hbF9pbnRlcnJ1cHQodm9pZCkKIAogCXJkbXNybChNU1JfSUEzMl9USEVS
TV9TVEFUVVMsIG1zcl92YWwpOwogCisJLyogQ2hlY2sgZm9yIHZpb2xhdGlvbiBvZiBjb3JlIHRo
ZXJtYWwgdGhyZXNob2xkcworCSAqIElmIHNvLCBzZW5kIG5vdGlmaWNhdGlvbiAqLworCW5vdGlm
eV90aHJlc2hvbGRzKG1zcl92YWwpOworCiAJaWYgKHRoZXJtX3Rocm90X3Byb2Nlc3MobXNyX3Zh
bCAmIFRIRVJNX1NUQVRVU19QUk9DSE9ULAogCQkJCVRIRVJNQUxfVEhST1RUTElOR19FVkVOVCwK
IAkJCQlDT1JFX0xFVkVMKSAhPSAwKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9jb3JldGVt
cC5jIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5jCmluZGV4IDRjMjIxYjguLmM1MzIyOGMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYworKysgYi9kcml2ZXJzL2h3bW9uL2Nv
cmV0ZW1wLmMKQEAgLTM2LDkgKzM2LDE3IEBACiAjaW5jbHVkZSA8YXNtL21zci5oPgogI2luY2x1
ZGUgPGFzbS9wcm9jZXNzb3IuaD4KICNpbmNsdWRlIDxhc20vc21wLmg+CisjaW5jbHVkZSA8YXNt
L21jZS5oPgorI2luY2x1ZGUgPGxpbnV4L3RoZXJtYWwuaD4KIAogI2RlZmluZSBEUlZOQU1FCSJj
b3JldGVtcCIKIAorLyogQW4gaWRlbnRpZmljYXRpb24gbnVtYmVyIHRvIHRoZSBEVFMgc2Vuc29y
LgorICogVGhpcyB3aWxsIGhlbHAgdGhlIHVzZXIgc3BhY2UgdG8gZmlndXJlIG91dCB3aGljaAor
ICogc2Vuc29yIGNhdXNlZCB0aGUgZXZlbnQKKyAqLworI2RlZmluZSBEVFNfSUQgMAorCiB0eXBl
ZGVmIGVudW0geyBTSE9XX1RFTVAsIFNIT1dfVEpNQVgsIFNIT1dfVFRBUkdFVCwgU0hPV19MQUJF
TCwKIAkJU0hPV19OQU1FIH0gU0hPVzsKIApAQCAtNjksNiArNzcsNDUgQEAgc3RydWN0IGNvcmV0
ZW1wX2RhdGEgewogCiBzdGF0aWMgaW50IHNldF9jb3JlX3RocmVzaG9sZChzdHJ1Y3QgY29yZXRl
bXBfZGF0YSAqZGF0YSwgaW50IHZhbCwKIAkJCQkJCWVudW0gdGhyZXNob2xkcyB0aHJlc2gpOwor
LyogSW50ZXJydXB0IEhhbmRsZXJzIGZvciBjb3JlL3BhY2thZ2UgdGhyZXNob2xkcyAqLworc3Ry
dWN0IHdvcmtfc3RydWN0ICp0MF9uZXRsaW5rX2hhbmRscjsKK3N0cnVjdCB3b3JrX3N0cnVjdCAq
dDFfbmV0bGlua19oYW5kbHI7CisKKy8qIFNlbmQgbmV0bGluayBldmVudCBmb3IgRFRTIHNlbnNv
ciByZWFjaGluZyB0aHJlc2hvbGQwICovCitzdGF0aWMgdm9pZCBnZW5fbmV0bGlua190MChzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJZ2VuZXJhdGVfbmV0bGlua19ldmVudChEVFNfSUQs
IFRIRVJNQUxfQVVYMCk7Cit9CisKKy8qIFNlbmQgbmV0bGluayBldmVudCBmb3IgRFRTIHNlbnNv
ciByZWFjaGluZyB0aHJlc2hvbGQxICovCitzdGF0aWMgdm9pZCBnZW5fbmV0bGlua190MShzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJZ2VuZXJhdGVfbmV0bGlua19ldmVudChEVFNfSUQs
IFRIRVJNQUxfQVVYMSk7Cit9CisKKy8qIFBsYXRmb3JtIHRoZXJtYWwgSW50ZXJydXB0IEhhbmRs
ZXIgKi8KK3N0YXRpYyBpbnQgY29yZXRlbXBfaW50ZXJydXB0KF9fdTY0IG1zcl92YWwpCit7CisK
KwlpZiAobXNyX3ZhbCAmIFRIRVJNX0xPR19USFJFU0hPTEQwKSB7CisJCWlmICghKG1zcl92YWwg
JiBUSEVSTV9TVEFUVVNfVEhSRVNIT0xEMCkpCisJCQlzY2hlZHVsZV93b3JrKHQwX25ldGxpbmtf
aGFuZGxyKTsKKworCQkvKiBSZXNldCB0aGUgVGhyZXNob2xkMCBpbnRlcnJ1cHQgKi8KKwkJd3Jt
c3JsKE1TUl9JQTMyX1RIRVJNX1NUQVRVUywgbXNyX3ZhbCAmIH5USEVSTV9MT0dfVEhSRVNIT0xE
MCk7CisJfQorCisJaWYgKG1zcl92YWwgJiBUSEVSTV9MT0dfVEhSRVNIT0xEMSkgeworCQlpZiAo
bXNyX3ZhbCAmIFRIRVJNX1NUQVRVU19USFJFU0hPTEQxKQorCQkJc2NoZWR1bGVfd29yayh0MV9u
ZXRsaW5rX2hhbmRscik7CisKKwkJLyogUmVzZXQgdGhlIFRocmVzaG9sZDEgaW50ZXJydXB0ICov
CisJCXdybXNybChNU1JfSUEzMl9USEVSTV9TVEFUVVMsIG1zcl92YWwgJiB+VEhFUk1fTE9HX1RI
UkVTSE9MRDEpOworCX0KKworCXJldHVybiAwOworfQorCiAvKgogICogU3lzZnMgc3R1ZmYKICAq
LwpAQCAtNDE1LDYgKzQ2Miw5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGVuYWJsZV90aHJlc2hf
c3VwcG9ydChzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSkKIAlmbGFnID0gMDsgLypGbGFnIHNo
b3VsZCBiZSB6ZXJvIHRvIHVubWFzayB0aGUgYXBpYyAqLwogCXNtcF9jYWxsX2Z1bmN0aW9uX3Np
bmdsZShkYXRhLT5pZCwgJmNvbmZpZ3VyZV9hcGljLCAmZmxhZywgMSk7CiAKKwkvKiBFbmFibGUg
dGhlIEludGVycnVwdCBIYW5kbGluZyBTdXBwb3J0ICovCisJcGxhdGZvcm1fdGhlcm1hbF9ub3Rp
ZnkgPSBjb3JldGVtcF9pbnRlcnJ1cHQ7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtNzAyLDYgKzc1
MiwyMCBAQCBzdGF0aWMgaW50IF9faW5pdCBjb3JldGVtcF9pbml0KHZvaWQpCiAjZW5kaWYKIAog
CXJlZ2lzdGVyX2hvdGNwdV9ub3RpZmllcigmY29yZXRlbXBfY3B1X25vdGlmaWVyKTsKKworCS8q
IEluaXRpYWxpemUgdGhlIEludGVycnVwdCBIYW5kbGVycyAqLworCXQwX25ldGxpbmtfaGFuZGxy
ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHdvcmtfc3RydWN0KSwgR0ZQX0tFUk5FTCk7CisJaWYg
KCF0MF9uZXRsaW5rX2hhbmRscikKKwkJcmV0dXJuIC1FTk9NRU07CisKKwl0MV9uZXRsaW5rX2hh
bmRsciA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCB3b3JrX3N0cnVjdCksIEdGUF9LRVJORUwpOwor
CWlmICghdDFfbmV0bGlua19oYW5kbHIpIHsKKwkJa2ZyZWUodDBfbmV0bGlua19oYW5kbHIpOwor
CQlyZXR1cm4gLUVOT01FTTsKKwl9CisJSU5JVF9XT1JLKHQwX25ldGxpbmtfaGFuZGxyLCAodm9p
ZCAqKWdlbl9uZXRsaW5rX3QwKTsKKwlJTklUX1dPUksodDFfbmV0bGlua19oYW5kbHIsICh2b2lk
ICopZ2VuX25ldGxpbmtfdDEpOworCiAJcmV0dXJuIDA7CiAKICNpZm5kZWYgQ09ORklHX0hPVFBM
VUdfQ1BVCi0tIAoxLjYuNS4yCgo=

--_002_D6D887BA8C9DFF48B5233887EF04654105C110948Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C110948Cbgsmsx502garc_--
