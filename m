From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 12 Jan 2009 20:28:05 +0000
Subject: Re: [lm-sensors] [PATCH] ACPI: set acpi_enforce_resources to strict
Message-Id: <20090112202804.GA14535@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090106182012.GA6668@dreamland.darkstar.lan> <49662697.9080302@redhat.com> <68676e00901081213i4d40448y257ccbc8d4776c69@mail.gmail.com> <496A42D8.6070105@redhat.com>
In-Reply-To: <496A42D8.6070105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

Il Sun, Jan 11, 2009 at 08:04:56PM +0100, Hans de Goede ha scritto: 
> Luca Tettamanti wrote:
>> On Thu, Jan 8, 2009 at 5:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> [...]
>>> So back to the discussion about changing the default of
>>> acpi_enforce_resources to strict, Jean and I have been discussing this on
>>> IRC and we feel it will most likely cause too much pain. So we would like to
>>> suggest to make the default depend up on the motherboard. Our plan is to
>>> have the default be "auto" and that will mean "lax", unless the motherboard
>>> is atk0110 (Asus ACPI interface for reading hwmon data) capable and in that
>>> case "auto" will mean "strict"
>>
>> Hum, that would mean putting ATK specific code into ACPI subsystem.
>> It's not pretty :S
>>
>
> Agreed, an alternative Jean and I discussed was to make the default 
> strict for all Asus boards, that would be easier (simple strcmp on 
> baseboard manufacturer). I don't know how large the atk detection code 
> is.

Pretty small, 25 LoC.

>>> The plan is then to merge this acpi subsystem change and the atk0110 driver
>>> at the same time, so that people will get different hwmon capabilities, but
>>> won't loose hwmon capabilities all together. Important note: this is meant
>>> as an temporary state of affairs, the end goal is to make the checking
>>> strict.
>>>
>>> Luca do you think you could do a patch implementing the described "auto"
>>> value for acpi_enforce_resources ?
>>
>> So the logic would be:
>> - if ATK node is present and the driver is enabled -> strict
>> - otherwise -> auto
>>
>
> No the logic would be:
> if (acpi_enforce_resources = auto) {
>   if (atk0110)
>     acpi_enforce_resources = strict;
>   else
>     acpi_enforce_resources = lax;
> }

Detection is pretty easy, the only problem is that I had to hijack the
fs_initcal level, because the code shall run _after_ the interpreter has
been initialized (subsys) but before native drivers have a chance to
poke the HW. So this what I've come up with (I just wrote it - I plan to
reboot tomorrow to test it...):

---
 Documentation/kernel-parameters.txt |   19 +++++++++++++
 drivers/acpi/osl.c                  |   49 ++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

Index: linux-2.6.git/Documentation/kernel-parameters.txt
=================================--- linux-2.6.git.orig/Documentation/kernel-parameters.txt	2009-01-12 21:21:34.573074955 +0100
+++ linux-2.6.git/Documentation/kernel-parameters.txt	2009-01-12 21:22:01.164076567 +0100
@@ -251,6 +251,25 @@
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
+	acpi_enforce_resources=	[ACPI]
+			{ strict, auto, lax, no }
+			Check for resource conflicts between native drivers
+			and ACPI OperationRegions (SystemIO and System Memory
+			only). IO ports and memory declared in ACPI might be
+			used by the ACPI subsystem in arbitrary AML code and
+			can interfere with legacy drivers.
+			strict: access to resources claimed by ACPI is denied;
+			legacy drivers trying to access reserved resources
+			will fail to load.
+			auto (default): try and detect ACPI devices with known
+			ACPI drivers; escalates the setting to "strict" if such
+			a device is found, otherwise behaves like "lax".
+			lax: access to resources claimed by ACPI is allowed;
+			legacy drivers trying to access reserved resources
+			will load and a warning message is logged.
+			no: ACPI OperationRegions are not marked as reserved,
+			no further checks are performed.
+
 	agp=		[AGP]
 			{ off | try_unsupported }
 			off: disable AGP support
Index: linux-2.6.git/drivers/acpi/osl.c
=================================--- linux-2.6.git.orig/drivers/acpi/osl.c	2009-01-12 21:21:34.549076302 +0100
+++ linux-2.6.git/drivers/acpi/osl.c	2009-01-12 21:22:01.164076567 +0100
@@ -1063,6 +1063,9 @@
  * in arbitrary AML code and can interfere with legacy drivers.
  * acpi_enforce_resources= can be set to:
  *
+ *   - auto             (3)
+ *     -> detect possible conflicts with ACPI drivers and switch to
+ *     strict if needed, otherwise act like lax
  *   - strict           (2)
  *     -> further driver trying to access the resources will not load
  *   - lax (default)    (1)
@@ -1073,11 +1076,12 @@
  *     -> ACPI Operation Region resources will not be registered
  *
  */
-#define ENFORCE_RESOURCES_STRICT 2
+#define ENFORCE_RESOURCES_STRICT 3
+#define ENFORCE_RESOURCES_AUTO   2
 #define ENFORCE_RESOURCES_LAX    1
 #define ENFORCE_RESOURCES_NO     0
 
-static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_AUTO;
 
 static int __init acpi_enforce_resources_setup(char *str)
 {
@@ -1086,6 +1090,8 @@
 
 	if (!strcmp("strict", str))
 		acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
+	else if (!strcmp("auto", str))
+		acpi_enforce_resources = ENFORCE_RESOURCES_AUTO;
 	else if (!strcmp("lax", str))
 		acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
 	else if (!strcmp("no", str))
@@ -1096,6 +1102,40 @@
 
 __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
 
+static int __init acpi_detect_asus_atk(void)
+{
+	struct acpi_buffer output;
+	union acpi_object *hid;
+	acpi_status ret;
+
+	if (acpi_enforce_resources != ENFORCE_RESOURCES_AUTO)
+		return 0;
+
+	output.pointer = NULL;
+	output.length = ACPI_ALLOCATE_BUFFER;
+	ret = acpi_evaluate_object_typed(NULL, "\\_SB.PCI0.SBRG.ASOC._HID",
+			NULL, &output, ACPI_TYPE_STRING);
+	if (ret = AE_OK) {
+		hid = output.pointer;
+
+		if (!strcmp("ATK0110", hid->string.pointer)) {
+			printk(KERN_DEBUG "Asus ATK0110 interface detected: "
+					"enforcing resource checking.\n");
+
+			acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
+		} else {
+			acpi_enforce_resources =  ENFORCE_RESOURCES_LAX;
+		}
+
+		ACPI_FREE(output.pointer);
+	} else {
+		acpi_enforce_resources =  ENFORCE_RESOURCES_LAX;
+	}
+
+	return 0;
+}
+fs_initcall(acpi_detect_asus_atk);
+
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
 int acpi_check_resource_conflict(struct resource *res)


Luca
-- 
Ligabue canta: "Tutti vogliono viaggiare in primaaaa..."
Io ci ho provato e dopo un chilometro ho fuso il motore e bruciato
la frizione...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
