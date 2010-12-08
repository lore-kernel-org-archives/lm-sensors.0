From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Dec 2010 09:29:27 +0000
Subject: [lm-sensors] Patch[2/2] Adding Interrupt Handling Support to
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C0E05F61@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F61bgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Yu, Fenghua" <fenghua.yu@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Zhang, Rui" <rui.zhang@intel.com>

--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F61bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Fenghua,

This patch, the second one in the series adds the interrupt
Handling support for the thermal thresholds. When an interrupt
occurs, this is notified to the user space(so that the user space
can take some action) by a netlink event.

This patch is generated against the stable Linux-2.6 tree.

This patch depends on the "Adding notification to thermal
Framework" patch, which can be downloaded from here:
https://patchwork.kernel.org/patch/282042/

Kindly review and merge.
------------------------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Tue, 7 Dec 2010 04:10:41 +0530
Subject: [PATCH 2/2] Adding_Threshold_Interrupt_Handling_to_Coretemp

This patch adds the interrupt handling for the core/package
thermal thresholds in coretemp. The interrupts are routed to coretemp
via therm_throt.c. Whenever an interrupt occurs, a notification is sent
in the form of a netlink event to the user space.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 arch/x86/include/asm/mce.h               |    3 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c |   71 ++++++++++++++++++++++++++=
+++
 drivers/hwmon/coretemp.c                 |   72 ++++++++++++++++++++++++++=
+++-
 3 files changed, 145 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c62c13c..bbb17b9 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -223,6 +223,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c);
=20
 void mce_log_therm_throt_event(__u64 status);
=20
+/* Interrupt Handler for core/package thermal thresholds */
+extern int (*platform_thermal_notify)(__u64 msr_val, int type);
+
 #ifdef CONFIG_X86_THERMAL_VECTOR
 extern void mcheck_intel_therm_init(void);
 #else
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu=
/mcheck/therm_throt.c
index 4b68326..f4afd79 100644
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
@@ -53,8 +58,15 @@ struct thermal_state {
 	struct _thermal_state core_power_limit;
 	struct _thermal_state package_throttle;
 	struct _thermal_state package_power_limit;
+	struct _thermal_state core_thresh0;
+	struct _thermal_state core_thresh1;
+	struct _thermal_state package_thresh0;
+	struct _thermal_state package_thresh1;
 };
=20
+/* Callback to handle core/package threshold interrupts */
+int (*platform_thermal_notify)(__u64 msr_val, int type);
+
 static DEFINE_PER_CPU(struct thermal_state, thermal_state);
=20
 static atomic_t therm_throt_en	=3D ATOMIC_INIT(0);
@@ -200,6 +212,38 @@ static int therm_throt_process(bool new_event, int eve=
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
+	case 2:
+		state =3D &pstate->package_thresh0;
+		break;
+	case 3:
+		state =3D &pstate->package_thresh1;
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
@@ -313,6 +357,28 @@ device_initcall(thermal_throttle_init_device);
 #define PACKAGE_THROTTLED	((__u64)2 << 62)
 #define PACKAGE_POWER_LIMIT	((__u64)3 << 62)
=20
+static void notify_thresholds(__u64 msr_val, int type)
+{
+	/* type 0 means core threshold
+	 * type 1 means package threshold
+	 */
+	int low_event =3D type * 2;
+	int high_event =3D (type * 2) + 1;
+
+	/* check whether the interrupt handler is defined;
+	 * otherwise simply return
+	 */
+	if (!platform_thermal_notify)
+		return;
+
+	/* lower threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD0) &&	thresh_event_valid(low_event))
+		platform_thermal_notify(msr_val, type);
+	/* higher threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD1) && thresh_event_valid(high_event))
+		platform_thermal_notify(msr_val, type);
+}
+
 /* Thermal transition interrupt handler */
 static void intel_thermal_interrupt(void)
 {
@@ -321,6 +387,10 @@ static void intel_thermal_interrupt(void)
=20
 	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
=20
+	/* Check for violation of core thermal thresholds
+	 * If so, send notification */
+	notify_thresholds(msr_val, 0);
+
 	if (therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
 				THERMAL_THROTTLING_EVENT,
 				CORE_LEVEL) !=3D 0)
@@ -334,6 +404,7 @@ static void intel_thermal_interrupt(void)
=20
 	if (cpu_has(c, X86_FEATURE_PTS)) {
 		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		notify_thresholds(msr_val, 1);
 		if (therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
 					THERMAL_THROTTLING_EVENT,
 					PACKAGE_LEVEL) !=3D 0)
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 7aea83e..6d8b21f 100644
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
+#define DTS_ID	0
+
 typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 		SHOW_NAME } SHOW;
 /* C indicates core thermal thresholds
@@ -75,6 +83,52 @@ static int set_core_threshold(struct coretemp_data *data=
, int val,
 						enum thresholds thresh);
 static int set_pkg_threshold(struct coretemp_data *data, int val,
 						enum thresholds thresh);
+
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
+/* Platform thermal Interrupt Handler.
+ * As of now, we handle both core/pkg threshold interrupts in the same
+ * way. If the user space is good enough to distinguish between these
+ * two and handle the events in a finer way, then we can improvise.
+ */
+static int coretemp_interrupt(__u64 msr_val, int type)
+{
+	u64 status_reg =3D (type =3D=3D 0) ? MSR_IA32_THERM_STATUS :
+					MSR_IA32_PACKAGE_THERM_STATUS;
+
+	if (msr_val & THERM_LOG_THRESHOLD0) {
+		if (!(msr_val & THERM_STATUS_THRESHOLD0))
+			schedule_work(t0_netlink_handlr);
+
+		/* Reset the Threshold0 interrupt */
+		wrmsrl(status_reg, msr_val & ~THERM_LOG_THRESHOLD0);
+	}
+
+	if (msr_val & THERM_LOG_THRESHOLD1) {
+		if (msr_val & THERM_STATUS_THRESHOLD1)
+			schedule_work(t1_netlink_handlr);
+
+		/* Reset the Threshold1 interrupt */
+		wrmsrl(status_reg, msr_val & ~THERM_LOG_THRESHOLD1);
+	}
+
+	return 0;
+}
+
 /*
  * Sysfs stuff
  */
@@ -415,7 +469,7 @@ static int set_pkg_threshold(struct coretemp_data *data=
, int temp,
 	mutex_lock(&data->update_lock);
=20
 	diff =3D (data->tjmax - temp)/1000;
-
+
 	/* Mask the thermal vector in the lapic */
 	l =3D apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
@@ -469,6 +523,8 @@ exit:
 	/* Unmask the thermal vector */
 	l =3D apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+	/* Enable the Interrupt Handling Support */
+	platform_thermal_notify =3D coretemp_interrupt;
 	return 0;
 }
=20
@@ -786,6 +842,20 @@ static int __init coretemp_init(void)
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


--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F61bgsmsx502garc_
Content-Type: application/octet-stream;
	name="0002-Adding_Threshold_Interrupt_Handling_to_Coretemp.patch"
Content-Description: 0002-Adding_Threshold_Interrupt_Handling_to_Coretemp.patch
Content-Disposition: attachment;
	filename="0002-Adding_Threshold_Interrupt_Handling_to_Coretemp.patch";
	size=8207; creation-date="Wed, 08 Dec 2010 14:29:02 GMT";
	modification-date="Wed, 08 Dec 2010 02:20:33 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogVHVlLCA3IERl
YyAyMDEwIDA0OjEwOjQxICswNTMwClN1YmplY3Q6IFtQQVRDSCAyLzJdIEFkZGluZ19UaHJlc2hv
bGRfSW50ZXJydXB0X0hhbmRsaW5nX3RvX0NvcmV0ZW1wCgpUaGlzIHBhdGNoIGFkZHMgdGhlIGlu
dGVycnVwdCBoYW5kbGluZyBmb3IgdGhlIGNvcmUvcGFja2FnZQp0aGVybWFsIHRocmVzaG9sZHMg
aW4gY29yZXRlbXAuIFRoZSBpbnRlcnJ1cHRzIGFyZSByb3V0ZWQgdG8gY29yZXRlbXAKdmlhIHRo
ZXJtX3Rocm90LmMuIFdoZW5ldmVyIGFuIGludGVycnVwdCBvY2N1cnMsIGEgbm90aWZpY2F0aW9u
IGlzIHNlbnQKaW4gdGhlIGZvcm0gb2YgYSBuZXRsaW5rIGV2ZW50IHRvIHRoZSB1c2VyIHNwYWNl
LgoKU2lnbmVkLW9mZi1ieTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KLS0t
CiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaCAgICAgICAgICAgICAgIHwgICAgMyArCiBhcmNo
L3g4Ni9rZXJuZWwvY3B1L21jaGVjay90aGVybV90aHJvdC5jIHwgICA3MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogZHJpdmVycy9od21vbi9jb3JldGVtcC5jICAgICAgICAgICAgICAg
ICB8ICAgNzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAzIGZpbGVzIGNoYW5nZWQs
IDE0NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL21jZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmgKaW5kZXggYzYy
YzEzYy4uYmJiMTdiOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmgKKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmgKQEAgLTIyMyw2ICsyMjMsOSBAQCB2b2lkIGlu
dGVsX2luaXRfdGhlcm1hbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpOwogCiB2b2lkIG1jZV9sb2df
dGhlcm1fdGhyb3RfZXZlbnQoX191NjQgc3RhdHVzKTsKIAorLyogSW50ZXJydXB0IEhhbmRsZXIg
Zm9yIGNvcmUvcGFja2FnZSB0aGVybWFsIHRocmVzaG9sZHMgKi8KK2V4dGVybiBpbnQgKCpwbGF0
Zm9ybV90aGVybWFsX25vdGlmeSkoX191NjQgbXNyX3ZhbCwgaW50IHR5cGUpOworCiAjaWZkZWYg
Q09ORklHX1g4Nl9USEVSTUFMX1ZFQ1RPUgogZXh0ZXJuIHZvaWQgbWNoZWNrX2ludGVsX3RoZXJt
X2luaXQodm9pZCk7CiAjZWxzZQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2hl
Y2svdGhlcm1fdGhyb3QuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNoZWNrL3RoZXJtX3Rocm90
LmMKaW5kZXggNGI2ODMyNi4uZjRhZmQ3OSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2hlY2svdGhlcm1fdGhyb3QuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jaGVjay90
aGVybV90aHJvdC5jCkBAIC0zNCw2ICszNCwxMSBAQAogLyogSG93IGxvbmcgdG8gd2FpdCBiZXR3
ZWVuIHJlcG9ydGluZyB0aGVybWFsIGV2ZW50cyAqLwogI2RlZmluZSBDSEVDS19JTlRFUlZBTAkJ
KDMwMCAqIEhaKQogCisvKiBTaW1pbGFyIHRvIENIRUNLX0lOVEVSVkFMLiBCdXQgaW50ZXJ2YWwg
aXMgcmVkdWNlZCBiZWNhdXNlCisgKiB0aGVzZSBsb3dlciBhbmQgdXBwZXIgdGhyZWhzb2xkcyB3
aWxsIGJlIGNyb3NzZWQgZnJlcXVlbnRseS4KKyAqIEhlbmNlIHRoZSByZXBvcnRpbmcgc2hvdWxk
IGJlIHF1aWNrIGVub3VnaCB0byBoYW5kbGUgdGhlIGV2ZW50ICovCisjZGVmaW5lIFRIUkVTX0lO
VEVSVkFMCQkoMjUgKiBIWikKKwogI2RlZmluZSBUSEVSTUFMX1RIUk9UVExJTkdfRVZFTlQJMAog
I2RlZmluZSBQT1dFUl9MSU1JVF9FVkVOVAkJMQogCkBAIC01Myw4ICs1OCwxNSBAQCBzdHJ1Y3Qg
dGhlcm1hbF9zdGF0ZSB7CiAJc3RydWN0IF90aGVybWFsX3N0YXRlIGNvcmVfcG93ZXJfbGltaXQ7
CiAJc3RydWN0IF90aGVybWFsX3N0YXRlIHBhY2thZ2VfdGhyb3R0bGU7CiAJc3RydWN0IF90aGVy
bWFsX3N0YXRlIHBhY2thZ2VfcG93ZXJfbGltaXQ7CisJc3RydWN0IF90aGVybWFsX3N0YXRlIGNv
cmVfdGhyZXNoMDsKKwlzdHJ1Y3QgX3RoZXJtYWxfc3RhdGUgY29yZV90aHJlc2gxOworCXN0cnVj
dCBfdGhlcm1hbF9zdGF0ZSBwYWNrYWdlX3RocmVzaDA7CisJc3RydWN0IF90aGVybWFsX3N0YXRl
IHBhY2thZ2VfdGhyZXNoMTsKIH07CiAKKy8qIENhbGxiYWNrIHRvIGhhbmRsZSBjb3JlL3BhY2th
Z2UgdGhyZXNob2xkIGludGVycnVwdHMgKi8KK2ludCAoKnBsYXRmb3JtX3RoZXJtYWxfbm90aWZ5
KShfX3U2NCBtc3JfdmFsLCBpbnQgdHlwZSk7CisKIHN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1
Y3QgdGhlcm1hbF9zdGF0ZSwgdGhlcm1hbF9zdGF0ZSk7CiAKIHN0YXRpYyBhdG9taWNfdCB0aGVy
bV90aHJvdF9lbgk9IEFUT01JQ19JTklUKDApOwpAQCAtMjAwLDYgKzIxMiwzOCBAQCBzdGF0aWMg
aW50IHRoZXJtX3Rocm90X3Byb2Nlc3MoYm9vbCBuZXdfZXZlbnQsIGludCBldmVudCwgaW50IGxl
dmVsKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IHRocmVzaF9ldmVudF92YWxpZChpbnQg
ZXZlbnQpCit7CisJc3RydWN0IF90aGVybWFsX3N0YXRlICpzdGF0ZSA9IE5VTEw7CisKKwl1bnNp
Z25lZCBpbnQgdGhpc19jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7CisJc3RydWN0IHRoZXJtYWxf
c3RhdGUgKnBzdGF0ZSA9ICZwZXJfY3B1KHRoZXJtYWxfc3RhdGUsIHRoaXNfY3B1KTsKKwl1NjQg
bm93ID0gZ2V0X2ppZmZpZXNfNjQoKTsKKworCXN3aXRjaCAoZXZlbnQpIHsKKwljYXNlIDA6CisJ
CXN0YXRlID0gJnBzdGF0ZS0+Y29yZV90aHJlc2gwOworCQlicmVhazsKKwljYXNlIDE6CisJCXN0
YXRlID0gJnBzdGF0ZS0+Y29yZV90aHJlc2gxOworCQlicmVhazsKKwljYXNlIDI6CisJCXN0YXRl
ID0gJnBzdGF0ZS0+cGFja2FnZV90aHJlc2gwOworCQlicmVhazsKKwljYXNlIDM6CisJCXN0YXRl
ID0gJnBzdGF0ZS0+cGFja2FnZV90aHJlc2gxOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlXQVJO
X09OKDEpOworCX0KKworCWlmICh0aW1lX2JlZm9yZTY0KG5vdywgc3RhdGUtPm5leHRfY2hlY2sp
KQorCQlyZXR1cm4gMDsKKworCXN0YXRlLT5uZXh0X2NoZWNrID0gbm93ICsgVEhSRVNfSU5URVJW
QUw7CisJcmV0dXJuIDE7Cit9CisKICNpZmRlZiBDT05GSUdfU1lTRlMKIC8qIEFkZC9SZW1vdmUg
dGhlcm1hbF90aHJvdHRsZSBpbnRlcmZhY2UgZm9yIENQVSBkZXZpY2U6ICovCiBzdGF0aWMgX19j
cHVpbml0IGludCB0aGVybWFsX3Rocm90dGxlX2FkZF9kZXYoc3RydWN0IHN5c19kZXZpY2UgKnN5
c19kZXYsCkBAIC0zMTMsNiArMzU3LDI4IEBAIGRldmljZV9pbml0Y2FsbCh0aGVybWFsX3Rocm90
dGxlX2luaXRfZGV2aWNlKTsKICNkZWZpbmUgUEFDS0FHRV9USFJPVFRMRUQJKChfX3U2NCkyIDw8
IDYyKQogI2RlZmluZSBQQUNLQUdFX1BPV0VSX0xJTUlUCSgoX191NjQpMyA8PCA2MikKIAorc3Rh
dGljIHZvaWQgbm90aWZ5X3RocmVzaG9sZHMoX191NjQgbXNyX3ZhbCwgaW50IHR5cGUpCit7CisJ
LyogdHlwZSAwIG1lYW5zIGNvcmUgdGhyZXNob2xkCisJICogdHlwZSAxIG1lYW5zIHBhY2thZ2Ug
dGhyZXNob2xkCisJICovCisJaW50IGxvd19ldmVudCA9IHR5cGUgKiAyOworCWludCBoaWdoX2V2
ZW50ID0gKHR5cGUgKiAyKSArIDE7CisKKwkvKiBjaGVjayB3aGV0aGVyIHRoZSBpbnRlcnJ1cHQg
aGFuZGxlciBpcyBkZWZpbmVkOworCSAqIG90aGVyd2lzZSBzaW1wbHkgcmV0dXJuCisJICovCisJ
aWYgKCFwbGF0Zm9ybV90aGVybWFsX25vdGlmeSkKKwkJcmV0dXJuOworCisJLyogbG93ZXIgdGhy
ZXNob2xkIHJlYWNoZWQgKi8KKwlpZiAoKG1zcl92YWwgJiBUSEVSTV9MT0dfVEhSRVNIT0xEMCkg
JiYJdGhyZXNoX2V2ZW50X3ZhbGlkKGxvd19ldmVudCkpCisJCXBsYXRmb3JtX3RoZXJtYWxfbm90
aWZ5KG1zcl92YWwsIHR5cGUpOworCS8qIGhpZ2hlciB0aHJlc2hvbGQgcmVhY2hlZCAqLworCWlm
ICgobXNyX3ZhbCAmIFRIRVJNX0xPR19USFJFU0hPTEQxKSAmJiB0aHJlc2hfZXZlbnRfdmFsaWQo
aGlnaF9ldmVudCkpCisJCXBsYXRmb3JtX3RoZXJtYWxfbm90aWZ5KG1zcl92YWwsIHR5cGUpOwor
fQorCiAvKiBUaGVybWFsIHRyYW5zaXRpb24gaW50ZXJydXB0IGhhbmRsZXIgKi8KIHN0YXRpYyB2
b2lkIGludGVsX3RoZXJtYWxfaW50ZXJydXB0KHZvaWQpCiB7CkBAIC0zMjEsNiArMzg3LDEwIEBA
IHN0YXRpYyB2b2lkIGludGVsX3RoZXJtYWxfaW50ZXJydXB0KHZvaWQpCiAKIAlyZG1zcmwoTVNS
X0lBMzJfVEhFUk1fU1RBVFVTLCBtc3JfdmFsKTsKIAorCS8qIENoZWNrIGZvciB2aW9sYXRpb24g
b2YgY29yZSB0aGVybWFsIHRocmVzaG9sZHMKKwkgKiBJZiBzbywgc2VuZCBub3RpZmljYXRpb24g
Ki8KKwlub3RpZnlfdGhyZXNob2xkcyhtc3JfdmFsLCAwKTsKKwogCWlmICh0aGVybV90aHJvdF9w
cm9jZXNzKG1zcl92YWwgJiBUSEVSTV9TVEFUVVNfUFJPQ0hPVCwKIAkJCQlUSEVSTUFMX1RIUk9U
VExJTkdfRVZFTlQsCiAJCQkJQ09SRV9MRVZFTCkgIT0gMCkKQEAgLTMzNCw2ICs0MDQsNyBAQCBz
dGF0aWMgdm9pZCBpbnRlbF90aGVybWFsX2ludGVycnVwdCh2b2lkKQogCiAJaWYgKGNwdV9oYXMo
YywgWDg2X0ZFQVRVUkVfUFRTKSkgewogCQlyZG1zcmwoTVNSX0lBMzJfUEFDS0FHRV9USEVSTV9T
VEFUVVMsIG1zcl92YWwpOworCQlub3RpZnlfdGhyZXNob2xkcyhtc3JfdmFsLCAxKTsKIAkJaWYg
KHRoZXJtX3Rocm90X3Byb2Nlc3MobXNyX3ZhbCAmIFBBQ0tBR0VfVEhFUk1fU1RBVFVTX1BST0NI
T1QsCiAJCQkJCVRIRVJNQUxfVEhST1RUTElOR19FVkVOVCwKIAkJCQkJUEFDS0FHRV9MRVZFTCkg
IT0gMCkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyBiL2RyaXZlcnMvaHdt
b24vY29yZXRlbXAuYwppbmRleCA3YWVhODNlLi42ZDhiMjFmIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2h3bW9uL2NvcmV0ZW1wLmMKKysrIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5jCkBAIC0zNiw5
ICszNiwxNyBAQAogI2luY2x1ZGUgPGFzbS9tc3IuaD4KICNpbmNsdWRlIDxhc20vcHJvY2Vzc29y
Lmg+CiAjaW5jbHVkZSA8YXNtL3NtcC5oPgorI2luY2x1ZGUgPGFzbS9tY2UuaD4KKyNpbmNsdWRl
IDxsaW51eC90aGVybWFsLmg+CiAKICNkZWZpbmUgRFJWTkFNRQkiY29yZXRlbXAiCiAKKy8qIEFu
IGlkZW50aWZpY2F0aW9uIG51bWJlciB0byB0aGUgRFRTIHNlbnNvci4KKyAqIFRoaXMgd2lsbCBo
ZWxwIHRoZSB1c2VyIHNwYWNlIHRvIGZpZ3VyZSBvdXQgd2hpY2gKKyAqIHNlbnNvciBjYXVzZWQg
dGhlIGV2ZW50CisgKi8KKyNkZWZpbmUgRFRTX0lECTAKKwogdHlwZWRlZiBlbnVtIHsgU0hPV19U
RU1QLCBTSE9XX1RKTUFYLCBTSE9XX1RUQVJHRVQsIFNIT1dfTEFCRUwsCiAJCVNIT1dfTkFNRSB9
IFNIT1c7CiAvKiBDIGluZGljYXRlcyBjb3JlIHRoZXJtYWwgdGhyZXNob2xkcwpAQCAtNzUsNiAr
ODMsNTIgQEAgc3RhdGljIGludCBzZXRfY29yZV90aHJlc2hvbGQoc3RydWN0IGNvcmV0ZW1wX2Rh
dGEgKmRhdGEsIGludCB2YWwsCiAJCQkJCQllbnVtIHRocmVzaG9sZHMgdGhyZXNoKTsKIHN0YXRp
YyBpbnQgc2V0X3BrZ190aHJlc2hvbGQoc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEsIGludCB2
YWwsCiAJCQkJCQllbnVtIHRocmVzaG9sZHMgdGhyZXNoKTsKKworLyogSW50ZXJydXB0IEhhbmRs
ZXJzIGZvciBjb3JlL3BhY2thZ2UgdGhyZXNob2xkcyAqLworc3RydWN0IHdvcmtfc3RydWN0ICp0
MF9uZXRsaW5rX2hhbmRscjsKK3N0cnVjdCB3b3JrX3N0cnVjdCAqdDFfbmV0bGlua19oYW5kbHI7
CisKKy8qIFNlbmQgbmV0bGluayBldmVudCBmb3IgRFRTIHNlbnNvciByZWFjaGluZyB0aHJlc2hv
bGQwICovCitzdGF0aWMgdm9pZCBnZW5fbmV0bGlua190MChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCit7CisJZ2VuZXJhdGVfbmV0bGlua19ldmVudChEVFNfSUQsIFRIRVJNQUxfQVVYMCk7Cit9
CisKKy8qIFNlbmQgbmV0bGluayBldmVudCBmb3IgRFRTIHNlbnNvciByZWFjaGluZyB0aHJlc2hv
bGQxICovCitzdGF0aWMgdm9pZCBnZW5fbmV0bGlua190MShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCit7CisJZ2VuZXJhdGVfbmV0bGlua19ldmVudChEVFNfSUQsIFRIRVJNQUxfQVVYMSk7Cit9
CisKKy8qIFBsYXRmb3JtIHRoZXJtYWwgSW50ZXJydXB0IEhhbmRsZXIuCisgKiBBcyBvZiBub3cs
IHdlIGhhbmRsZSBib3RoIGNvcmUvcGtnIHRocmVzaG9sZCBpbnRlcnJ1cHRzIGluIHRoZSBzYW1l
CisgKiB3YXkuIElmIHRoZSB1c2VyIHNwYWNlIGlzIGdvb2QgZW5vdWdoIHRvIGRpc3Rpbmd1aXNo
IGJldHdlZW4gdGhlc2UKKyAqIHR3byBhbmQgaGFuZGxlIHRoZSBldmVudHMgaW4gYSBmaW5lciB3
YXksIHRoZW4gd2UgY2FuIGltcHJvdmlzZS4KKyAqLworc3RhdGljIGludCBjb3JldGVtcF9pbnRl
cnJ1cHQoX191NjQgbXNyX3ZhbCwgaW50IHR5cGUpCit7CisJdTY0IHN0YXR1c19yZWcgPSAodHlw
ZSA9PSAwKSA/IE1TUl9JQTMyX1RIRVJNX1NUQVRVUyA6CisJCQkJCU1TUl9JQTMyX1BBQ0tBR0Vf
VEhFUk1fU1RBVFVTOworCisJaWYgKG1zcl92YWwgJiBUSEVSTV9MT0dfVEhSRVNIT0xEMCkgewor
CQlpZiAoIShtc3JfdmFsICYgVEhFUk1fU1RBVFVTX1RIUkVTSE9MRDApKQorCQkJc2NoZWR1bGVf
d29yayh0MF9uZXRsaW5rX2hhbmRscik7CisKKwkJLyogUmVzZXQgdGhlIFRocmVzaG9sZDAgaW50
ZXJydXB0ICovCisJCXdybXNybChzdGF0dXNfcmVnLCBtc3JfdmFsICYgflRIRVJNX0xPR19USFJF
U0hPTEQwKTsKKwl9CisKKwlpZiAobXNyX3ZhbCAmIFRIRVJNX0xPR19USFJFU0hPTEQxKSB7CisJ
CWlmIChtc3JfdmFsICYgVEhFUk1fU1RBVFVTX1RIUkVTSE9MRDEpCisJCQlzY2hlZHVsZV93b3Jr
KHQxX25ldGxpbmtfaGFuZGxyKTsKKworCQkvKiBSZXNldCB0aGUgVGhyZXNob2xkMSBpbnRlcnJ1
cHQgKi8KKwkJd3Jtc3JsKHN0YXR1c19yZWcsIG1zcl92YWwgJiB+VEhFUk1fTE9HX1RIUkVTSE9M
RDEpOworCX0KKworCXJldHVybiAwOworfQorCiAvKgogICogU3lzZnMgc3R1ZmYKICAqLwpAQCAt
NDE1LDcgKzQ2OSw3IEBAIHN0YXRpYyBpbnQgc2V0X3BrZ190aHJlc2hvbGQoc3RydWN0IGNvcmV0
ZW1wX2RhdGEgKmRhdGEsIGludCB0ZW1wLAogCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2Nr
KTsKIAogCWRpZmYgPSAoZGF0YS0+dGptYXggLSB0ZW1wKS8xMDAwOwotCisKIAkvKiBNYXNrIHRo
ZSB0aGVybWFsIHZlY3RvciBpbiB0aGUgbGFwaWMgKi8KIAlsID0gYXBpY19yZWFkKEFQSUNfTFZU
VEhNUik7CiAJYXBpY193cml0ZShBUElDX0xWVFRITVIsIGwgfCBBUElDX0xWVF9NQVNLRUQpOwpA
QCAtNDY5LDYgKzUyMyw4IEBAIGV4aXQ6CiAJLyogVW5tYXNrIHRoZSB0aGVybWFsIHZlY3RvciAq
LwogCWwgPSBhcGljX3JlYWQoQVBJQ19MVlRUSE1SKTsKIAlhcGljX3dyaXRlKEFQSUNfTFZUVEhN
UiwgbCAmIH5BUElDX0xWVF9NQVNLRUQpOworCS8qIEVuYWJsZSB0aGUgSW50ZXJydXB0IEhhbmRs
aW5nIFN1cHBvcnQgKi8KKwlwbGF0Zm9ybV90aGVybWFsX25vdGlmeSA9IGNvcmV0ZW1wX2ludGVy
cnVwdDsKIAlyZXR1cm4gMDsKIH0KIApAQCAtNzg2LDYgKzg0MiwyMCBAQCBzdGF0aWMgaW50IF9f
aW5pdCBjb3JldGVtcF9pbml0KHZvaWQpCiAjZW5kaWYKIAogCXJlZ2lzdGVyX2hvdGNwdV9ub3Rp
ZmllcigmY29yZXRlbXBfY3B1X25vdGlmaWVyKTsKKworCS8qIEluaXRpYWxpemUgdGhlIEludGVy
cnVwdCBIYW5kbGVycyAqLworCXQwX25ldGxpbmtfaGFuZGxyID0ga3phbGxvYyhzaXplb2Yoc3Ry
dWN0IHdvcmtfc3RydWN0KSwgR0ZQX0tFUk5FTCk7CisJaWYgKCF0MF9uZXRsaW5rX2hhbmRscikK
KwkJcmV0dXJuIC1FTk9NRU07CisKKwl0MV9uZXRsaW5rX2hhbmRsciA9IGt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCB3b3JrX3N0cnVjdCksIEdGUF9LRVJORUwpOworCWlmICghdDFfbmV0bGlua19oYW5k
bHIpIHsKKwkJa2ZyZWUodDBfbmV0bGlua19oYW5kbHIpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9
CisJSU5JVF9XT1JLKHQwX25ldGxpbmtfaGFuZGxyLCAodm9pZCAqKWdlbl9uZXRsaW5rX3QwKTsK
KwlJTklUX1dPUksodDFfbmV0bGlua19oYW5kbHIsICh2b2lkICopZ2VuX25ldGxpbmtfdDEpOwor
CiAJcmV0dXJuIDA7CiAKICNpZm5kZWYgQ09ORklHX0hPVFBMVUdfQ1BVCi0tIAoxLjYuNS4yCgo=

--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F61bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF04654105C0E05F61bgsmsx502garc_--
