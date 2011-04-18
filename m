From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 18 Apr 2011 13:08:34 +0000
Subject: [lm-sensors] Patch v5 Merge Pkgtemp with coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch merges the pkgtemp with coretemp driver.
It has support for CONFIG_HOTPLUG_CPU. So, the sysfs
interfaces are created when each core comes online
and are removed when it goes offline.

I have attached the logs when this driver is loaded on
a SandyBridge(for pkgtemp testing) and a Non-Sandybridge(corei5)
machine. I have tested this patch on these machines for cpu hotplug
Support. As far as I could see, it seems to work fine.
Kindly let me know if there are any crashes, with dmesg logs.
---
From: Durgadoss R <durgadoss.r@intel.com>

Date: Mon, 18 Apr 2011 22:38:57 +0530
Subject: [PATCH 1/1] hwmon:v5:Merge Pkgtemp with Coretemp

This patch merges the pkgtemp with coretemp driver.
It has support for CONFIG_HOTPLUG_CPU. So, the sysfs
interfaces are created when each core comes online
and are removed when it goes offline.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
v1:
* Basic Merging of pkgtemp with coretemp.
* Creates one hwmon device per core.
v2:
* Fixed some Data structure related comments from v1.
* Creates one hwmon device per core.
v3:
* Creates one hwmon device per physical package.
* No appropriate support for CPU hotplug.
v4:
* Creates one hwmon device per package.
* Added appropriate support for CONFIG_HOTPLUG_CPU.
v5:
* Changed naming of sysfs based on core_id
* Changed all %d to %u appropriately
* Removed unnecessary variables crit/max_alarm
* Fixed the flow of show_temp method
* Removed unwanted print messages
* Removed per-core related code from coretemp_device_add
* Corrected the error handling in get_core_online
 drivers/hwmon/coretemp.c |  602 +++++++++++++++++++++++++++++++-----------=
----
 1 files changed, 408 insertions(+), 194 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 194ca0a..bdf6bff 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,119 +41,127 @@

 #define DRVNAME        "coretemp"

-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
-               SHOW_NAME } SHOW;
+#define BASE_SYSFS_ATTR_NO     2       /* Sysfs Base attr no for coretemp =
*/
+#define NUM_REAL_CORES         16      /* Number of Real cores per cpu */
+#define CORETEMP_NAME_LENGTH   17      /* String Length of attrs */
+#define MAX_ATTRS              5       /* Maximum no of per-core attrs */
+#define MAX_CORE_DATA          (NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
+/* Macro to get sysfs attr no from cpu core id */
+#define TO_ATTR_NO(core_id)    (core_id + BASE_SYSFS_ATTR_NO)

 /*
- * Functions declaration
+ * Per-Core Temperature Data
+ * @last_updated: The time when the current temperature value was updated
+ *             earlier (in jiffies).
+ * @cpu_core_id: The CPU Core from which temperature values should be read
+ *             This value is passed as "id" field to rdmsr/wrmsr functions=
.
+ * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
+ *             from where the temperature values should be read.
+ * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
+ *             Otherwise, temp_data holds coretemp data.
  */
-
-static struct coretemp_data *coretemp_update_device(struct device *dev);
-
-struct coretemp_data {
-       struct device *hwmon_dev;
-       struct mutex update_lock;
-       const char *name;
-       u32 id;
-       u16 core_id;
-       char valid;             /* zero until following fields are valid */
-       unsigned long last_updated;     /* in jiffies */
+struct temp_data {
        int temp;
-       int tjmax;
        int ttarget;
-       u8 alarm;
+       int tjmax;
+       unsigned long last_updated;
+       unsigned int cpu;
+       u32 cpu_core_id;
+       u32 status_reg;
+       bool is_pkg_data;
+       struct sensor_device_attribute sd_attrs[MAX_ATTRS];
+       char attr_name[MAX_ATTRS][CORETEMP_NAME_LENGTH];
+       struct mutex update_lock;
 };

 /*
- * Sysfs stuff
+ * Platform Data per Physical CPU
+ * @phys_proc_id:      The physical CPU id
  */
+struct platform_data {
+       struct device *hwmon_dev;
+       u16 phys_proc_id;
+       struct temp_data *core_data[MAX_CORE_DATA];
+       struct device_attribute name_attr;
+};
+
+/* Function Declarations */
+static void coretemp_remove_core(struct platform_data *data,
+                                       struct device *dev, int i);
+
+static ssize_t show_name(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
+{
+       return sprintf(buf, "%s\n", DRVNAME);
+}

-static ssize_t show_name(struct device *dev, struct device_attribute
-                         *devattr, char *buf)
+static ssize_t show_label(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
 {
-       int ret;
        struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
-       struct coretemp_data *data =3D dev_get_drvdata(dev);
+       struct platform_data *pdata =3D dev_get_drvdata(dev);
+       struct temp_data *tdata =3D pdata->core_data[attr->index];

-       if (attr->index =3D=3D SHOW_NAME)
-               ret =3D sprintf(buf, "%s\n", data->name);
-       else    /* show label */
-               ret =3D sprintf(buf, "Core %d\n", data->core_id);
-       return ret;
+       if (tdata->is_pkg_data)
+               return sprintf(buf, "Physical id %u\n", pdata->phys_proc_id=
);
+
+       return sprintf(buf, "Core %u\n", tdata->cpu_core_id);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute
-                         *devattr, char *buf)
+static ssize_t show_crit_alarm(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
 {
-       struct coretemp_data *data =3D coretemp_update_device(dev);
-       /* read the Out-of-spec log, never clear */
-       return sprintf(buf, "%d\n", data->alarm);
+       u32 eax, edx;
+       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
+       struct platform_data *pdata =3D dev_get_drvdata(dev);
+       struct temp_data *tdata =3D pdata->core_data[attr->index];
+
+       rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
+
+       return sprintf(buf, "%d\n", ((eax >> 5) & 1));
 }

-static ssize_t show_temp(struct device *dev,
-                        struct device_attribute *devattr, char *buf)
+static ssize_t show_tjmax(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
 {
        struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
-       struct coretemp_data *data =3D coretemp_update_device(dev);
-       int err;
+       struct platform_data *pdata =3D dev_get_drvdata(dev);

-       if (attr->index =3D=3D SHOW_TEMP)
-               err =3D data->valid ? sprintf(buf, "%d\n", data->temp) : -E=
AGAIN;
-       else if (attr->index =3D=3D SHOW_TJMAX)
-               err =3D sprintf(buf, "%d\n", data->tjmax);
-       else
-               err =3D sprintf(buf, "%d\n", data->ttarget);
-       return err;
+       return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tjmax);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
-                         SHOW_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
-                         SHOW_TJMAX);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
-                         SHOW_TTARGET);
-static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABE=
L);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
-
-static struct attribute *coretemp_attributes[] =3D {
-       &sensor_dev_attr_name.dev_attr.attr,
-       &sensor_dev_attr_temp1_label.dev_attr.attr,
-       &dev_attr_temp1_crit_alarm.attr,
-       &sensor_dev_attr_temp1_input.dev_attr.attr,
-       &sensor_dev_attr_temp1_crit.dev_attr.attr,
-       NULL
-};
+static ssize_t show_ttarget(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
+{
+       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
+       struct platform_data *pdata =3D dev_get_drvdata(dev);

-static const struct attribute_group coretemp_group =3D {
-       .attrs =3D coretemp_attributes,
-};
+       return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget)=
;
+}

-static struct coretemp_data *coretemp_update_device(struct device *dev)
+static ssize_t show_temp(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
 {
-       struct coretemp_data *data =3D dev_get_drvdata(dev);
-
-       mutex_lock(&data->update_lock);
+       u32 eax, edx;
+       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
+       struct platform_data *pdata =3D dev_get_drvdata(dev);
+       struct temp_data *tdata =3D pdata->core_data[attr->index];

-       if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
-               u32 eax, edx;
+       mutex_lock(&tdata->update_lock);

-               data->valid =3D 0;
-               rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-               data->alarm =3D (eax >> 5) & 1;
-               /* update only if data has been valid */
+       /* Check whether the time interval has elapsed */
+       if (time_after(jiffies, tdata->last_updated + HZ)) {
+               rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
+               /* Check whether the data is valid */
                if (eax & 0x80000000) {
-                       data->temp =3D data->tjmax - (((eax >> 16)
-                                                       & 0x7f) * 1000);
-                       data->valid =3D 1;
-               } else {
-                       dev_dbg(dev, "Temperature data invalid (0x%x)\n", e=
ax);
+                       tdata->temp =3D tdata->tjmax -
+                                       (((eax >> 16) & 0x7f) * 1000);
                }
-               data->last_updated =3D jiffies;
+               tdata->last_updated =3D jiffies;
        }

-       mutex_unlock(&data->update_lock);
-       return data;
+       mutex_unlock(&tdata->update_lock);
+       return sprintf(buf, "%d\n", tdata->temp);
 }

 static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct de=
vice *dev)
@@ -300,115 +308,260 @@ static void __devinit get_ucode_rev_on_cpu(void *ed=
x)
        rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }

-static int __devinit coretemp_probe(struct platform_device *pdev)
+static int get_pkg_tjmax(unsigned int cpu, struct device *dev)
 {
-       struct coretemp_data *data;
-       struct cpuinfo_x86 *c =3D &cpu_data(pdev->id);
+       int default_tjmax =3D 100000;     /* 100 degree celsius */
        int err;
-       u32 eax, edx;
+       u32 eax, edx, val;

-       if (!(data =3D kzalloc(sizeof(struct coretemp_data), GFP_KERNEL))) =
{
-               err =3D -ENOMEM;
-               dev_err(&pdev->dev, "Out of memory\n");
-               goto exit;
+       err =3D rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &=
edx);
+       if (!err) {
+               val =3D (eax >> 16) & 0xff;
+               if ((val > 80) && (val < 120))
+                       return val * 1000;
        }
+       dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
+       return default_tjmax;
+}

-       data->id =3D pdev->id;
-#ifdef CONFIG_SMP
-       data->core_id =3D c->cpu_core_id;
-#endif
-       data->name =3D "coretemp";
-       mutex_init(&data->update_lock);
+static int create_name_attr(struct platform_data *pdata, struct device *de=
v)
+{
+       pdata->name_attr.attr.name =3D "name";
+       pdata->name_attr.attr.mode =3D S_IRUGO;
+       pdata->name_attr.show =3D show_name;
+       return device_create_file(dev, &pdata->name_attr);
+}

-       /* test if we can access the THERM_STATUS MSR */
-       err =3D rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &e=
dx);
-       if (err) {
-               dev_err(&pdev->dev,
-                       "Unable to access THERM_STATUS MSR, giving up\n");
-               goto exit_free;
+static int create_core_attrs(struct temp_data *tdata, struct device *dev,
+                               int attr_no)
+{
+       int err, i;
+       ssize_t (*rd_ptr[MAX_ATTRS]) (struct device *dev,
+                       struct device_attribute *devattr, char *buf) =3D {
+                       show_label, show_crit_alarm, show_ttarget,
+                       show_temp, show_tjmax };
+       const char *names[MAX_ATTRS] =3D { "temp%d_label", "temp%d_crit_ala=
rm",
+                                       "temp%d_max", "temp%d_input",
+                                       "temp%d_crit" };
+
+       for (i =3D 0; i < MAX_ATTRS; i++) {
+               snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i=
],
+                       attr_no);
+               tdata->sd_attrs[i].dev_attr.attr.name =3D tdata->attr_name[=
i];
+               tdata->sd_attrs[i].dev_attr.attr.mode =3D S_IRUGO;
+               tdata->sd_attrs[i].dev_attr.show =3D rd_ptr[i];
+               tdata->sd_attrs[i].dev_attr.store =3D NULL;
+               tdata->sd_attrs[i].index =3D attr_no;
+               err =3D device_create_file(dev, &tdata->sd_attrs[i].dev_att=
r);
+               if (err)
+                       goto exit_free;
        }
+       return 0;

-       /* Check if we have problem with errata AE18 of Core processors:
-          Readings might stop update when processor visited too deep sleep=
,
-          fixed for stepping D0 (6EC).
-       */
+exit_free:
+       while (--i >=3D 0)
+               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+       return err;
+}
+
+static void remove_attrs(struct device *dev, struct temp_data *tdata)
+{
+       int i;
+
+       /* Remove the sysfs attributes */
+       for (i =3D 0; i < MAX_ATTRS; i++)
+               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+}
+
+static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
+                               struct device *dev)
+{
+       int err;
+       u32 eax, edx;
+
+       /*
+        * Initialize ttarget value. Eventually this will be
+        * initialized with the value from MSR_IA32_THERM_INTERRUPT
+        * register. If IA32_TEMPERATURE_TARGET is supported, this
+        * value will be over written below.
+        * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTERRUPT
+        */
+       tdata->ttarget =3D tdata->tjmax - 20000;
+
+       /*
+        * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
+        * on older CPUs but not in this register,
+        * Atoms don't have it either.
+        */
+       if ((cpu_model > 0xe) && (cpu_model !=3D 0x1c)) {
+               err =3D rdmsr_safe_on_cpu(tdata->cpu,
+                               MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+               if (err) {
+                       dev_warn(dev,
+                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
+               } else {
+                       tdata->ttarget =3D tdata->tjmax -
+                                       (((eax >> 8) & 0xff) * 1000);
+               }
+       }
+}

+static int chk_ucode_version(struct cpuinfo_x86 *c,
+                               struct platform_device *pdev)
+{
+       int err;
+       u32 edx;
+
+       /*
+        * Check if we have problem with errata AE18 of Core processors:
+        * Readings might stop update when processor visited too deep sleep=
,
+        * fixed for stepping D0 (6EC).
+        */
        if ((c->x86_model =3D=3D 0xe) && (c->x86_mask < 0xc)) {
                /* check for microcode update */
-               err =3D smp_call_function_single(data->id, get_ucode_rev_on=
_cpu,
-                                              &edx, 1);
+               err =3D smp_call_function_single(pdev->id, get_ucode_rev_on=
_cpu,
+                                                               &edx, 1);
                if (err) {
                        dev_err(&pdev->dev,
                                "Cannot determine microcode revision of "
-                               "CPU#%u (%d)!\n", data->id, err);
-                       err =3D -ENODEV;
-                       goto exit_free;
+                               "CPU#%u (%d)!\n", pdev->id, err);
+                       return -ENODEV;
                } else if (edx < 0x39) {
-                       err =3D -ENODEV;
                        dev_err(&pdev->dev,
                                "Errata AE18 not fixed, update BIOS or "
                                "microcode of the CPU!\n");
-                       goto exit_free;
+                       return -ENODEV;
                }
        }
+       return 0;
+}

-       data->tjmax =3D get_tjmax(c, data->id, &pdev->dev);
-       platform_set_drvdata(pdev, data);
+static struct temp_data *init_temp_data(unsigned int cpu, int core_id,
+                                       int pkg_flag)
+{
+       struct temp_data *tdata;
+
+       tdata =3D kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+       if (!tdata)
+               return NULL;
+
+       tdata->status_reg =3D pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
+                                                       MSR_IA32_THERM_STAT=
US;
+       tdata->is_pkg_data =3D pkg_flag;
+       tdata->cpu_core_id =3D core_id;
+       tdata->cpu =3D cpu;
+       tdata->last_updated =3D jiffies;
+       mutex_init(&tdata->update_lock);
+       return tdata;
+}
+
+static int create_core_data(struct platform_data *pdata,
+                               struct platform_device *pdev,
+                               unsigned int cpu, int pkg_flag)
+{
+       struct temp_data *tdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       u32 eax, edx;
+       int err, attr_no;

        /*
-        * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
-        * on older CPUs but not in this register,
-        * Atoms don't have it either.
+        * Find attr number for sysfs:
+        * We map the attr number to core id of the CPU
+        * The attr number is always core id + 2
+        * The Pkgtemp will always show up as temp1_*
         */
+       if (pkg_flag)
+               attr_no =3D 1;
+       else
+               attr_no =3D TO_ATTR_NO(c->cpu_core_id);

-       if ((c->x86_model > 0xe) && (c->x86_model !=3D 0x1c)) {
-               err =3D rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TA=
RGET,
-                   &eax, &edx);
-               if (err) {
-                       dev_warn(&pdev->dev, "Unable to read"
-                                       " IA32_TEMPERATURE_TARGET MSR\n");
-               } else {
-                       data->ttarget =3D data->tjmax -
-                                       (((eax >> 8) & 0xff) * 1000);
-                       err =3D device_create_file(&pdev->dev,
-                                       &sensor_dev_attr_temp1_max.dev_attr=
);
-                       if (err)
-                               goto exit_free;
-               }
-       }
+       if (attr_no > MAX_CORE_DATA - 1)
+               return -ERANGE;

-       if ((err =3D sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-               goto exit_dev;
+       /* Skip if it is a HT core, Not an error */
+       if (pdata->core_data[attr_no] !=3D NULL)
+               return 0;
+
+       tdata =3D init_temp_data(cpu, c->cpu_core_id, pkg_flag);
+       if (!tdata)
+               return -ENOMEM;

-       data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
-       if (IS_ERR(data->hwmon_dev)) {
-               err =3D PTR_ERR(data->hwmon_dev);
-               dev_err(&pdev->dev, "Class registration failed (%d)\n",
-                       err);
-               goto exit_class;
-       }
+       /* Test if we can access the status register */
+       err =3D rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
+       if (err)
+               goto exit_free;
+
+       /* Create sysfs interfaces */
+       err =3D create_core_attrs(tdata, &pdev->dev, attr_no);
+       if (err)
+               goto exit_free;
+
+       /* Get Critical Temperature */
+       if (pkg_flag)
+               tdata->tjmax =3D get_pkg_tjmax(pdev->id, &pdev->dev);
+       else
+               tdata->tjmax =3D get_tjmax(c, cpu, &pdev->dev);
+
+       update_ttarget(c->x86_model, tdata, &pdev->dev);
+
+       pdata->core_data[attr_no] =3D tdata;
+       return 0;
+exit_free:
+       kfree(tdata);
+       return err;
+}
+
+static int __devinit coretemp_probe(struct platform_device *pdev)
+{
+       struct platform_data *pdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(pdev->id);
+       int err;

+       /* Initialize the per-package data structures */
+       pdata =3D kzalloc(sizeof(struct platform_data), GFP_KERNEL);
+       if (!pdata)
+               return -ENOMEM;
+
+       pdata->phys_proc_id =3D c->phys_proc_id;
+
+       err =3D create_name_attr(pdata, &pdev->dev);
+       if (err)
+               goto exit_free;
+
+       /* Check the microcode version of the CPU */
+       err =3D chk_ucode_version(c, pdev);
+       if (err)
+               goto exit_name;
+
+       platform_set_drvdata(pdev, pdata);
+
+       pdata->hwmon_dev =3D hwmon_device_register(&pdev->dev);
+       if (IS_ERR(pdata->hwmon_dev)) {
+               err =3D PTR_ERR(pdata->hwmon_dev);
+               dev_err(&pdev->dev, "Class registration failed (%d)\n", err=
);
+               goto exit_name;
+       }
        return 0;

-exit_class:
-       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-exit_dev:
-       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr)=
;
+exit_name:
+       device_remove_file(&pdev->dev, &pdata->name_attr);
 exit_free:
-       kfree(data);
-exit:
+       kfree(pdata);
        return err;
 }

 static int __devexit coretemp_remove(struct platform_device *pdev)
 {
-       struct coretemp_data *data =3D platform_get_drvdata(pdev);
+       struct platform_data *pdata =3D platform_get_drvdata(pdev);
+       int i;
+
+       for (i =3D MAX_CORE_DATA - 1; i >=3D 0; --i)
+               coretemp_remove_core(pdata, &pdev->dev, i);

-       hwmon_device_unregister(data->hwmon_dev);
-       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr)=
;
+       device_remove_file(&pdev->dev, &pdata->name_attr);
+       hwmon_device_unregister(pdata->hwmon_dev);
        platform_set_drvdata(pdev, NULL);
-       kfree(data);
+       kfree(pdata);
        return 0;
 }

@@ -434,6 +587,52 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);

+static struct platform_device *coretemp_get_pdev(u16 phys_proc_id)
+{
+       struct pdev_entry *p;
+
+       mutex_lock(&pdev_list_mutex);
+
+       list_for_each_entry(p, &pdev_list, list)
+               if (p->phys_proc_id =3D=3D phys_proc_id) {
+                       mutex_unlock(&pdev_list_mutex);
+                       return p->pdev;
+               }
+
+       mutex_unlock(&pdev_list_mutex);
+       return NULL;
+}
+
+static void coretemp_add_core(unsigned int cpu, int pkg_flag)
+{
+       int err;
+       struct platform_data *pdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D coretemp_get_pdev(c->phys_proc_id)=
;
+
+       if (!pdev)
+               return;
+
+       pdata =3D platform_get_drvdata(pdev);
+
+       err =3D create_core_data(pdata, pdev, cpu, pkg_flag);
+       if (err) {
+               dev_err(&pdev->dev, "Adding Core %u on Pkg %u failed\n",
+                       cpu, c->phys_proc_id);
+       }
+}
+
+static void coretemp_remove_core(struct platform_data *pdata,
+                                       struct device *dev, int indx)
+{
+       if (pdata->core_data[indx] =3D=3D NULL)
+               return;
+
+       remove_attrs(dev, pdata->core_data[indx]);
+       kfree(pdata->core_data[indx]);
+       pdata->core_data[indx] =3D NULL;
+}
+
 static int __cpuinit coretemp_device_add(unsigned int cpu)
 {
        int err;
@@ -441,30 +640,8 @@ static int __cpuinit coretemp_device_add(unsigned int =
cpu)
        struct pdev_entry *pdev_entry;
        struct cpuinfo_x86 *c =3D &cpu_data(cpu);

-       /*
-        * CPUID.06H.EAX[0] indicates whether the CPU has thermal
-        * sensors. We check this bit only, all the early CPUs
-        * without thermal sensors will be filtered out.
-        */
-       if (!cpu_has(c, X86_FEATURE_DTS)) {
-               pr_info("CPU (model=3D0x%x) has no thermal sensor\n",
-                       c->x86_model);
-               return 0;
-       }
-
        mutex_lock(&pdev_list_mutex);

-#ifdef CONFIG_SMP
-       /* Skip second HT entry of each core */
-       list_for_each_entry(pdev_entry, &pdev_list, list) {
-               if (c->phys_proc_id =3D=3D pdev_entry->phys_proc_id &&
-                   c->cpu_core_id =3D=3D pdev_entry->cpu_core_id) {
-                       err =3D 0;        /* Not an error */
-                       goto exit;
-               }
-       }
-#endif
-
        pdev =3D platform_device_alloc(DRVNAME, cpu);
        if (!pdev) {
                err =3D -ENOMEM;
@@ -504,26 +681,62 @@ exit:
        return err;
 }

-static void __cpuinit coretemp_device_remove(unsigned int cpu)
+static void get_core_online(unsigned int cpu)
 {
-       struct pdev_entry *p;
-       unsigned int i;
-
-       mutex_lock(&pdev_list_mutex);
-       list_for_each_entry(p, &pdev_list, list) {
-               if (p->cpu !=3D cpu)
-                       continue;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D coretemp_get_pdev(c->phys_proc_id)=
;
+       int err;

-               platform_device_unregister(p->pdev);
-               list_del(&p->list);
-               mutex_unlock(&pdev_list_mutex);
-               kfree(p);
-               for_each_cpu(i, cpu_sibling_mask(cpu))
-                       if (i !=3D cpu && !coretemp_device_add(i))
-                               break;
+       /*
+        * CPUID.06H.EAX[0] indicates whether the CPU has thermal
+        * sensors. We check this bit only, all the early CPUs
+        * without thermal sensors will be filtered out.
+        */
+       if (!cpu_has(c, X86_FEATURE_DTS))
                return;
+
+       if (!pdev) {
+               /*
+                * Alright, we have DTS support.
+                * We are bringing the _first_ core in this pkg
+                * online. So, initialize per-pkg data structures and
+                * then bring this core online.
+                */
+               err =3D coretemp_device_add(cpu);
+               if (err)
+                       return;
+               /*
+                * Check whether pkgtemp support is available.
+                * If so, add interfaces for pkgtemp.
+                */
+               if (cpu_has(c, X86_FEATURE_PTS))
+                       coretemp_add_core(cpu, 1);
        }
-       mutex_unlock(&pdev_list_mutex);
+
+       /*
+        * Physical CPU device already exists.
+        * So, just add interfaces for this core.
+        */
+       coretemp_add_core(cpu, 0);
+}
+
+static void put_core_offline(unsigned int cpu)
+{
+       int indx;
+       struct platform_data *pdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D coretemp_get_pdev(c->phys_proc_id)=
;
+
+       /* If the physical CPU device does not exist, just return */
+       if (!pdev)
+               return;
+
+       pdata =3D platform_get_drvdata(pdev);
+
+       indx =3D TO_ATTR_NO(c->cpu_core_id);
+
+       if (pdata->core_data[indx] && pdata->core_data[indx]->cpu =3D=3D cp=
u)
+               coretemp_remove_core(pdata, &pdev->dev, indx);
 }

 static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
@@ -534,10 +747,10 @@ static int __cpuinit coretemp_cpu_callback(struct not=
ifier_block *nfb,
        switch (action) {
        case CPU_ONLINE:
        case CPU_DOWN_FAILED:
-               coretemp_device_add(cpu);
+               get_core_online(cpu);
                break;
        case CPU_DOWN_PREPARE:
-               coretemp_device_remove(cpu);
+               put_core_offline(cpu);
                break;
        }
        return NOTIFY_OK;
@@ -547,10 +760,11 @@ static struct notifier_block coretemp_cpu_notifier __=
refdata =3D {
        .notifier_call =3D coretemp_cpu_callback,
 };

+
 static int __init coretemp_init(void)
 {
        int i, err =3D -ENODEV;
-
+
        /* quick check if we run Intel */
        if (cpu_data(0).x86_vendor !=3D X86_VENDOR_INTEL)
                goto exit;
@@ -560,7 +774,7 @@ static int __init coretemp_init(void)
                goto exit;

        for_each_online_cpu(i)
-               coretemp_device_add(i);
+               get_core_online(i);

 #ifndef CONFIG_HOTPLUG_CPU
        if (list_empty(&pdev_list)) {
--
1.6.1


--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-hwmon-v5-Merge-Pkgtemp-with-Coretemp.patch"
Content-Description: 0001-hwmon-v5-Merge-Pkgtemp-with-Coretemp.patch
Content-Disposition: attachment;
	filename="0001-hwmon-v5-Merge-Pkgtemp-with-Coretemp.patch"; size=22857;
	creation-date="Mon, 18 Apr 2011 18:15:09 GMT";
	modification-date="Mon, 18 Apr 2011 22:54:30 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogTW9uLCAxOCBB
cHIgMjAxMSAyMjozODo1NyArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBod21vbjp2NTpNZXJn
ZSBQa2d0ZW1wIHdpdGggQ29yZXRlbXAKClRoaXMgcGF0Y2ggbWVyZ2VzIHRoZSBwa2d0ZW1wIHdp
dGggY29yZXRlbXAgZHJpdmVyLgpJdCBoYXMgc3VwcG9ydCBmb3IgQ09ORklHX0hPVFBMVUdfQ1BV
LiBTbywgdGhlIHN5c2ZzCmludGVyZmFjZXMgYXJlIGNyZWF0ZWQgd2hlbiBlYWNoIGNvcmUgY29t
ZXMgb25saW5lCmFuZCBhcmUgcmVtb3ZlZCB3aGVuIGl0IGdvZXMgb2ZmbGluZS4KClNpZ25lZC1v
ZmYtYnk6IER1cmdhZG9zcyBSIDxkdXJnYWRvc3MuckBpbnRlbC5jb20+Ci0tLQp2MToKKiBCYXNp
YyBNZXJnaW5nIG9mIHBrZ3RlbXAgd2l0aCBjb3JldGVtcC4KKiBDcmVhdGVzIG9uZSBod21vbiBk
ZXZpY2UgcGVyIGNvcmUuCnYyOgoqIEZpeGVkIHNvbWUgRGF0YSBzdHJ1Y3R1cmUgcmVsYXRlZCBj
b21tZW50cyBmcm9tIHYxLgoqIENyZWF0ZXMgb25lIGh3bW9uIGRldmljZSBwZXIgY29yZS4KdjM6
CiogQ3JlYXRlcyBvbmUgaHdtb24gZGV2aWNlIHBlciBwaHlzaWNhbCBwYWNrYWdlLgoqIE5vIGFw
cHJvcHJpYXRlIHN1cHBvcnQgZm9yIENQVSBob3RwbHVnLgp2NDoKKiBDcmVhdGVzIG9uZSBod21v
biBkZXZpY2UgcGVyIHBhY2thZ2UuCiogQWRkZWQgYXBwcm9wcmlhdGUgc3VwcG9ydCBmb3IgQ09O
RklHX0hPVFBMVUdfQ1BVLgp2NToKKiBDaGFuZ2VkIG5hbWluZyBvZiBzeXNmcyBiYXNlZCBvbiBj
b3JlX2lkCiogQ2hhbmdlZCBhbGwgJWQgdG8gJXUgYXBwcm9wcmlhdGVseQoqIFJlbW92ZWQgdW5u
ZWNlc3NhcnkgdmFyaWFibGVzIGNyaXQvbWF4X2FsYXJtCiogRml4ZWQgdGhlIGZsb3cgb2Ygc2hv
d190ZW1wIG1ldGhvZAoqIFJlbW92ZWQgdW53YW50ZWQgcHJpbnQgbWVzc2FnZXMKKiBSZW1vdmVk
IHBlci1jb3JlIHJlbGF0ZWQgY29kZSBmcm9tIGNvcmV0ZW1wX2RldmljZV9hZGQKKiBDb3JyZWN0
ZWQgdGhlIGVycm9yIGhhbmRsaW5nIGluIGdldF9jb3JlX29ubGluZQogZHJpdmVycy9od21vbi9j
b3JldGVtcC5jIHwgIDYwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQwOCBpbnNlcnRpb25zKCspLCAxOTQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9jb3JldGVtcC5jIGIvZHJpdmVycy9od21v
bi9jb3JldGVtcC5jCmluZGV4IDE5NGNhMGEuLmJkZjZiZmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
aHdtb24vY29yZXRlbXAuYworKysgYi9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMKQEAgLTQxLDEx
OSArNDEsMTI3IEBACiAKICNkZWZpbmUgRFJWTkFNRQkiY29yZXRlbXAiCiAKLXR5cGVkZWYgZW51
bSB7IFNIT1dfVEVNUCwgU0hPV19USk1BWCwgU0hPV19UVEFSR0VULCBTSE9XX0xBQkVMLAotCQlT
SE9XX05BTUUgfSBTSE9XOworI2RlZmluZSBCQVNFX1NZU0ZTX0FUVFJfTk8JMgkvKiBTeXNmcyBC
YXNlIGF0dHIgbm8gZm9yIGNvcmV0ZW1wICovCisjZGVmaW5lIE5VTV9SRUFMX0NPUkVTCQkxNgkv
KiBOdW1iZXIgb2YgUmVhbCBjb3JlcyBwZXIgY3B1ICovCisjZGVmaW5lIENPUkVURU1QX05BTUVf
TEVOR1RICTE3CS8qIFN0cmluZyBMZW5ndGggb2YgYXR0cnMgKi8KKyNkZWZpbmUgTUFYX0FUVFJT
CQk1CS8qIE1heGltdW0gbm8gb2YgcGVyLWNvcmUgYXR0cnMgKi8KKyNkZWZpbmUgTUFYX0NPUkVf
REFUQQkJKE5VTV9SRUFMX0NPUkVTICsgQkFTRV9TWVNGU19BVFRSX05PKQorLyogTWFjcm8gdG8g
Z2V0IHN5c2ZzIGF0dHIgbm8gZnJvbSBjcHUgY29yZSBpZCAqLworI2RlZmluZSBUT19BVFRSX05P
KGNvcmVfaWQpCShjb3JlX2lkICsgQkFTRV9TWVNGU19BVFRSX05PKQogCiAvKgotICogRnVuY3Rp
b25zIGRlY2xhcmF0aW9uCisgKiBQZXItQ29yZSBUZW1wZXJhdHVyZSBEYXRhCisgKiBAbGFzdF91
cGRhdGVkOiBUaGUgdGltZSB3aGVuIHRoZSBjdXJyZW50IHRlbXBlcmF0dXJlIHZhbHVlIHdhcyB1
cGRhdGVkCisgKgkJZWFybGllciAoaW4gamlmZmllcykuCisgKiBAY3B1X2NvcmVfaWQ6IFRoZSBD
UFUgQ29yZSBmcm9tIHdoaWNoIHRlbXBlcmF0dXJlIHZhbHVlcyBzaG91bGQgYmUgcmVhZAorICoJ
CVRoaXMgdmFsdWUgaXMgcGFzc2VkIGFzICJpZCIgZmllbGQgdG8gcmRtc3Ivd3Jtc3IgZnVuY3Rp
b25zLgorICogQHN0YXR1c19yZWc6IE9uZSBvZiBJQTMyX1RIRVJNX1NUQVRVUyBvciBJQTMyX1BB
Q0tBR0VfVEhFUk1fU1RBVFVTLAorICoJCWZyb20gd2hlcmUgdGhlIHRlbXBlcmF0dXJlIHZhbHVl
cyBzaG91bGQgYmUgcmVhZC4KKyAqIEBpc19wa2dfZGF0YTogSWYgdGhpcyBpcyAxLCB0aGUgdGVt
cF9kYXRhIGhvbGRzIHBrZ3RlbXAgZGF0YS4KKyAqCQlPdGhlcndpc2UsIHRlbXBfZGF0YSBob2xk
cyBjb3JldGVtcCBkYXRhLgogICovCi0KLXN0YXRpYyBzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqY29y
ZXRlbXBfdXBkYXRlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwotCi1zdHJ1Y3QgY29yZXRl
bXBfZGF0YSB7Ci0Jc3RydWN0IGRldmljZSAqaHdtb25fZGV2OwotCXN0cnVjdCBtdXRleCB1cGRh
dGVfbG9jazsKLQljb25zdCBjaGFyICpuYW1lOwotCXUzMiBpZDsKLQl1MTYgY29yZV9pZDsKLQlj
aGFyIHZhbGlkOwkJLyogemVybyB1bnRpbCBmb2xsb3dpbmcgZmllbGRzIGFyZSB2YWxpZCAqLwot
CXVuc2lnbmVkIGxvbmcgbGFzdF91cGRhdGVkOwkvKiBpbiBqaWZmaWVzICovCitzdHJ1Y3QgdGVt
cF9kYXRhIHsKIAlpbnQgdGVtcDsKLQlpbnQgdGptYXg7CiAJaW50IHR0YXJnZXQ7Ci0JdTggYWxh
cm07CisJaW50IHRqbWF4OworCXVuc2lnbmVkIGxvbmcgbGFzdF91cGRhdGVkOworCXVuc2lnbmVk
IGludCBjcHU7CisJdTMyIGNwdV9jb3JlX2lkOworCXUzMiBzdGF0dXNfcmVnOworCWJvb2wgaXNf
cGtnX2RhdGE7CisJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlIHNkX2F0dHJzW01BWF9B
VFRSU107CisJY2hhciBhdHRyX25hbWVbTUFYX0FUVFJTXVtDT1JFVEVNUF9OQU1FX0xFTkdUSF07
CisJc3RydWN0IG11dGV4IHVwZGF0ZV9sb2NrOwogfTsKIAogLyoKLSAqIFN5c2ZzIHN0dWZmCisg
KiBQbGF0Zm9ybSBEYXRhIHBlciBQaHlzaWNhbCBDUFUKKyAqIEBwaHlzX3Byb2NfaWQ6CVRoZSBw
aHlzaWNhbCBDUFUgaWQKICAqLworc3RydWN0IHBsYXRmb3JtX2RhdGEgeworCXN0cnVjdCBkZXZp
Y2UgKmh3bW9uX2RldjsKKwl1MTYgcGh5c19wcm9jX2lkOworCXN0cnVjdCB0ZW1wX2RhdGEgKmNv
cmVfZGF0YVtNQVhfQ09SRV9EQVRBXTsKKwlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBuYW1lX2F0
dHI7Cit9OworCisvKiBGdW5jdGlvbiBEZWNsYXJhdGlvbnMgKi8KK3N0YXRpYyB2b2lkIGNvcmV0
ZW1wX3JlbW92ZV9jb3JlKHN0cnVjdCBwbGF0Zm9ybV9kYXRhICpkYXRhLAorCQkJCQlzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGludCBpKTsKKworc3RhdGljIHNzaXplX3Qgc2hvd19uYW1lKHN0cnVjdCBk
ZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwgY2hhciAq
YnVmKQoreworCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBEUlZOQU1FKTsKK30KIAotc3Rh
dGljIHNzaXplX3Qgc2hvd19uYW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9h
dHRyaWJ1dGUKLQkJCSAgKmRldmF0dHIsIGNoYXIgKmJ1ZikKK3N0YXRpYyBzc2l6ZV90IHNob3df
bGFiZWwoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpk
ZXZhdHRyLCBjaGFyICpidWYpCiB7Ci0JaW50IHJldDsKIAlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9h
dHRyaWJ1dGUgKmF0dHIgPSB0b19zZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7Ci0Jc3RydWN0IGNv
cmV0ZW1wX2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgcGxhdGZv
cm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgdGVtcF9kYXRh
ICp0ZGF0YSA9IHBkYXRhLT5jb3JlX2RhdGFbYXR0ci0+aW5kZXhdOwogCi0JaWYgKGF0dHItPmlu
ZGV4ID09IFNIT1dfTkFNRSkKLQkJcmV0ID0gc3ByaW50ZihidWYsICIlc1xuIiwgZGF0YS0+bmFt
ZSk7Ci0JZWxzZQkvKiBzaG93IGxhYmVsICovCi0JCXJldCA9IHNwcmludGYoYnVmLCAiQ29yZSAl
ZFxuIiwgZGF0YS0+Y29yZV9pZCk7Ci0JcmV0dXJuIHJldDsKKwlpZiAodGRhdGEtPmlzX3BrZ19k
YXRhKQorCQlyZXR1cm4gc3ByaW50ZihidWYsICJQaHlzaWNhbCBpZCAldVxuIiwgcGRhdGEtPnBo
eXNfcHJvY19pZCk7CisKKwlyZXR1cm4gc3ByaW50ZihidWYsICJDb3JlICV1XG4iLCB0ZGF0YS0+
Y3B1X2NvcmVfaWQpOwogfQogCi1zdGF0aWMgc3NpemVfdCBzaG93X2FsYXJtKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUKLQkJCSAgKmRldmF0dHIsIGNoYXIgKmJ1
ZikKK3N0YXRpYyBzc2l6ZV90IHNob3dfY3JpdF9hbGFybShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJ
CQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldmF0dHIsIGNoYXIgKmJ1ZikKIHsKLQlzdHJ1
Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSA9IGNvcmV0ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2KTsKLQkv
KiByZWFkIHRoZSBPdXQtb2Ytc3BlYyBsb2csIG5ldmVyIGNsZWFyICovCi0JcmV0dXJuIHNwcmlu
dGYoYnVmLCAiJWRcbiIsIGRhdGEtPmFsYXJtKTsKKwl1MzIgZWF4LCBlZHg7CisJc3RydWN0IHNl
bnNvcl9kZXZpY2VfYXR0cmlidXRlICphdHRyID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRldmF0dHIp
OworCXN0cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwor
CXN0cnVjdCB0ZW1wX2RhdGEgKnRkYXRhID0gcGRhdGEtPmNvcmVfZGF0YVthdHRyLT5pbmRleF07
CisKKwlyZG1zcl9vbl9jcHUodGRhdGEtPmNwdSwgdGRhdGEtPnN0YXR1c19yZWcsICZlYXgsICZl
ZHgpOworCisJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsICgoZWF4ID4+IDUpICYgMSkpOwog
fQogCi1zdGF0aWMgc3NpemVfdCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LAotCQkJIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYpCitzdGF0aWMgc3NpemVf
dCBzaG93X3RqbWF4KHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqZGV2YXR0ciwgY2hhciAqYnVmKQogewogCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciA9IHRvX3NlbnNvcl9kZXZfYXR0cihkZXZhdHRyKTsKLQlzdHJ1Y3QgY29yZXRl
bXBfZGF0YSAqZGF0YSA9IGNvcmV0ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2KTsKLQlpbnQgZXJyOwor
CXN0cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwogCi0J
aWYgKGF0dHItPmluZGV4ID09IFNIT1dfVEVNUCkKLQkJZXJyID0gZGF0YS0+dmFsaWQgPyBzcHJp
bnRmKGJ1ZiwgIiVkXG4iLCBkYXRhLT50ZW1wKSA6IC1FQUdBSU47Ci0JZWxzZSBpZiAoYXR0ci0+
aW5kZXggPT0gU0hPV19USk1BWCkKLQkJZXJyID0gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+
dGptYXgpOwotCWVsc2UKLQkJZXJyID0gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+dHRhcmdl
dCk7Ci0JcmV0dXJuIGVycjsKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgcGRhdGEtPmNv
cmVfZGF0YVthdHRyLT5pbmRleF0tPnRqbWF4KTsKIH0KIAotc3RhdGljIFNFTlNPUl9ERVZJQ0Vf
QVRUUih0ZW1wMV9pbnB1dCwgU19JUlVHTywgc2hvd190ZW1wLCBOVUxMLAotCQkJICBTSE9XX1RF
TVApOwotc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9jcml0LCBTX0lSVUdPLCBzaG93
X3RlbXAsIE5VTEwsCi0JCQkgIFNIT1dfVEpNQVgpOwotc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRU
Uih0ZW1wMV9tYXgsIFNfSVJVR08sIHNob3dfdGVtcCwgTlVMTCwKLQkJCSAgU0hPV19UVEFSR0VU
KTsKLXN0YXRpYyBERVZJQ0VfQVRUUih0ZW1wMV9jcml0X2FsYXJtLCBTX0lSVUdPLCBzaG93X2Fs
YXJtLCBOVUxMKTsKLXN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIodGVtcDFfbGFiZWwsIFNfSVJV
R08sIHNob3dfbmFtZSwgTlVMTCwgU0hPV19MQUJFTCk7Ci1zdGF0aWMgU0VOU09SX0RFVklDRV9B
VFRSKG5hbWUsIFNfSVJVR08sIHNob3dfbmFtZSwgTlVMTCwgU0hPV19OQU1FKTsKLQotc3RhdGlj
IHN0cnVjdCBhdHRyaWJ1dGUgKmNvcmV0ZW1wX2F0dHJpYnV0ZXNbXSA9IHsKLQkmc2Vuc29yX2Rl
dl9hdHRyX25hbWUuZGV2X2F0dHIuYXR0ciwKLQkmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2xhYmVs
LmRldl9hdHRyLmF0dHIsCi0JJmRldl9hdHRyX3RlbXAxX2NyaXRfYWxhcm0uYXR0ciwKLQkmc2Vu
c29yX2Rldl9hdHRyX3RlbXAxX2lucHV0LmRldl9hdHRyLmF0dHIsCi0JJnNlbnNvcl9kZXZfYXR0
cl90ZW1wMV9jcml0LmRldl9hdHRyLmF0dHIsCi0JTlVMTAotfTsKK3N0YXRpYyBzc2l6ZV90IHNo
b3dfdHRhcmdldChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmRldmF0dHIsIGNoYXIgKmJ1ZikKK3sKKwlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1
dGUgKmF0dHIgPSB0b19zZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7CisJc3RydWN0IHBsYXRmb3Jt
X2RhdGEgKnBkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7CiAKLXN0YXRpYyBjb25zdCBzdHJ1
Y3QgYXR0cmlidXRlX2dyb3VwIGNvcmV0ZW1wX2dyb3VwID0gewotCS5hdHRycyA9IGNvcmV0ZW1w
X2F0dHJpYnV0ZXMsCi19OworCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBwZGF0YS0+Y29y
ZV9kYXRhW2F0dHItPmluZGV4XS0+dHRhcmdldCk7Cit9CiAKLXN0YXRpYyBzdHJ1Y3QgY29yZXRl
bXBfZGF0YSAqY29yZXRlbXBfdXBkYXRlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0
aWMgc3NpemVfdCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYpCiB7Ci0Jc3RydWN0IGNvcmV0ZW1wX2Rh
dGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKLQotCW11dGV4X2xvY2soJmRhdGEtPnVw
ZGF0ZV9sb2NrKTsKKwl1MzIgZWF4LCBlZHg7CisJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmli
dXRlICphdHRyID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRldmF0dHIpOworCXN0cnVjdCBwbGF0Zm9y
bV9kYXRhICpwZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCXN0cnVjdCB0ZW1wX2RhdGEg
KnRkYXRhID0gcGRhdGEtPmNvcmVfZGF0YVthdHRyLT5pbmRleF07CiAKLQlpZiAoIWRhdGEtPnZh
bGlkIHx8IHRpbWVfYWZ0ZXIoamlmZmllcywgZGF0YS0+bGFzdF91cGRhdGVkICsgSFopKSB7Ci0J
CXUzMiBlYXgsIGVkeDsKKwltdXRleF9sb2NrKCZ0ZGF0YS0+dXBkYXRlX2xvY2spOwogCi0JCWRh
dGEtPnZhbGlkID0gMDsKLQkJcmRtc3Jfb25fY3B1KGRhdGEtPmlkLCBNU1JfSUEzMl9USEVSTV9T
VEFUVVMsICZlYXgsICZlZHgpOwotCQlkYXRhLT5hbGFybSA9IChlYXggPj4gNSkgJiAxOwotCQkv
KiB1cGRhdGUgb25seSBpZiBkYXRhIGhhcyBiZWVuIHZhbGlkICovCisJLyogQ2hlY2sgd2hldGhl
ciB0aGUgdGltZSBpbnRlcnZhbCBoYXMgZWxhcHNlZCAqLworCWlmICh0aW1lX2FmdGVyKGppZmZp
ZXMsIHRkYXRhLT5sYXN0X3VwZGF0ZWQgKyBIWikpIHsKKwkJcmRtc3Jfb25fY3B1KHRkYXRhLT5j
cHUsIHRkYXRhLT5zdGF0dXNfcmVnLCAmZWF4LCAmZWR4KTsKKwkJLyogQ2hlY2sgd2hldGhlciB0
aGUgZGF0YSBpcyB2YWxpZCAqLwogCQlpZiAoZWF4ICYgMHg4MDAwMDAwMCkgewotCQkJZGF0YS0+
dGVtcCA9IGRhdGEtPnRqbWF4IC0gKCgoZWF4ID4+IDE2KQotCQkJCQkJCSYgMHg3ZikgKiAxMDAw
KTsKLQkJCWRhdGEtPnZhbGlkID0gMTsKLQkJfSBlbHNlIHsKLQkJCWRldl9kYmcoZGV2LCAiVGVt
cGVyYXR1cmUgZGF0YSBpbnZhbGlkICgweCV4KVxuIiwgZWF4KTsKKwkJCXRkYXRhLT50ZW1wID0g
dGRhdGEtPnRqbWF4IC0KKwkJCQkJKCgoZWF4ID4+IDE2KSAmIDB4N2YpICogMTAwMCk7CiAJCX0K
LQkJZGF0YS0+bGFzdF91cGRhdGVkID0gamlmZmllczsKKwkJdGRhdGEtPmxhc3RfdXBkYXRlZCA9
IGppZmZpZXM7CiAJfQogCi0JbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Ci0JcmV0
dXJuIGRhdGE7CisJbXV0ZXhfdW5sb2NrKCZ0ZGF0YS0+dXBkYXRlX2xvY2spOworCXJldHVybiBz
cHJpbnRmKGJ1ZiwgIiVkXG4iLCB0ZGF0YS0+dGVtcCk7CiB9CiAKIHN0YXRpYyBpbnQgX19kZXZp
bml0IGFkanVzdF90am1heChzdHJ1Y3QgY3B1aW5mb194ODYgKmMsIHUzMiBpZCwgc3RydWN0IGRl
dmljZSAqZGV2KQpAQCAtMzAwLDExNSArMzA4LDI2MCBAQCBzdGF0aWMgdm9pZCBfX2RldmluaXQg
Z2V0X3Vjb2RlX3Jldl9vbl9jcHUodm9pZCAqZWR4KQogCXJkbXNyKE1TUl9JQTMyX1VDT0RFX1JF
ViwgZWF4LCAqKHUzMiAqKWVkeCk7CiB9CiAKLXN0YXRpYyBpbnQgX19kZXZpbml0IGNvcmV0ZW1w
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCitzdGF0aWMgaW50IGdldF9wa2df
dGptYXgodW5zaWduZWQgaW50IGNwdSwgc3RydWN0IGRldmljZSAqZGV2KQogewotCXN0cnVjdCBj
b3JldGVtcF9kYXRhICpkYXRhOwotCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YShw
ZGV2LT5pZCk7CisJaW50IGRlZmF1bHRfdGptYXggPSAxMDAwMDA7CS8qIDEwMCBkZWdyZWUgY2Vs
c2l1cyAqLwogCWludCBlcnI7Ci0JdTMyIGVheCwgZWR4OworCXUzMiBlYXgsIGVkeCwgdmFsOwog
Ci0JaWYgKCEoZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBjb3JldGVtcF9kYXRhKSwgR0ZQ
X0tFUk5FTCkpKSB7Ci0JCWVyciA9IC1FTk9NRU07Ci0JCWRldl9lcnIoJnBkZXYtPmRldiwgIk91
dCBvZiBtZW1vcnlcbiIpOwotCQlnb3RvIGV4aXQ7CisJZXJyID0gcmRtc3Jfc2FmZV9vbl9jcHUo
Y3B1LCBNU1JfSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQsICZlYXgsICZlZHgpOworCWlmICghZXJy
KSB7CisJCXZhbCA9IChlYXggPj4gMTYpICYgMHhmZjsKKwkJaWYgKCh2YWwgPiA4MCkgJiYgKHZh
bCA8IDEyMCkpCisJCQlyZXR1cm4gdmFsICogMTAwMDsKIAl9CisJZGV2X3dhcm4oZGV2LCAiVW5h
YmxlIHRvIHJlYWQgUGtnLVRqTWF4IGZyb20gQ1BVOiV1XG4iLCBjcHUpOworCXJldHVybiBkZWZh
dWx0X3RqbWF4OworfQogCi0JZGF0YS0+aWQgPSBwZGV2LT5pZDsKLSNpZmRlZiBDT05GSUdfU01Q
Ci0JZGF0YS0+Y29yZV9pZCA9IGMtPmNwdV9jb3JlX2lkOwotI2VuZGlmCi0JZGF0YS0+bmFtZSA9
ICJjb3JldGVtcCI7Ci0JbXV0ZXhfaW5pdCgmZGF0YS0+dXBkYXRlX2xvY2spOworc3RhdGljIGlu
dCBjcmVhdGVfbmFtZV9hdHRyKHN0cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YSwgc3RydWN0IGRl
dmljZSAqZGV2KQoreworCXBkYXRhLT5uYW1lX2F0dHIuYXR0ci5uYW1lID0gIm5hbWUiOworCXBk
YXRhLT5uYW1lX2F0dHIuYXR0ci5tb2RlID0gU19JUlVHTzsKKwlwZGF0YS0+bmFtZV9hdHRyLnNo
b3cgPSBzaG93X25hbWU7CisJcmV0dXJuIGRldmljZV9jcmVhdGVfZmlsZShkZXYsICZwZGF0YS0+
bmFtZV9hdHRyKTsKK30KIAotCS8qIHRlc3QgaWYgd2UgY2FuIGFjY2VzcyB0aGUgVEhFUk1fU1RB
VFVTIE1TUiAqLwotCWVyciA9IHJkbXNyX3NhZmVfb25fY3B1KGRhdGEtPmlkLCBNU1JfSUEzMl9U
SEVSTV9TVEFUVVMsICZlYXgsICZlZHgpOwotCWlmIChlcnIpIHsKLQkJZGV2X2VycigmcGRldi0+
ZGV2LAotCQkJIlVuYWJsZSB0byBhY2Nlc3MgVEhFUk1fU1RBVFVTIE1TUiwgZ2l2aW5nIHVwXG4i
KTsKLQkJZ290byBleGl0X2ZyZWU7CitzdGF0aWMgaW50IGNyZWF0ZV9jb3JlX2F0dHJzKHN0cnVj
dCB0ZW1wX2RhdGEgKnRkYXRhLCBzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJaW50IGF0dHJfbm8p
Cit7CisJaW50IGVyciwgaTsKKwlzc2l6ZV90ICgqcmRfcHRyW01BWF9BVFRSU10pIChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCisJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwgY2hhciAq
YnVmKSA9IHsKKwkJCXNob3dfbGFiZWwsIHNob3dfY3JpdF9hbGFybSwgc2hvd190dGFyZ2V0LAor
CQkJc2hvd190ZW1wLCBzaG93X3RqbWF4IH07CisJY29uc3QgY2hhciAqbmFtZXNbTUFYX0FUVFJT
XSA9IHsgInRlbXAlZF9sYWJlbCIsICJ0ZW1wJWRfY3JpdF9hbGFybSIsCisJCQkJCSJ0ZW1wJWRf
bWF4IiwgInRlbXAlZF9pbnB1dCIsCisJCQkJCSJ0ZW1wJWRfY3JpdCIgfTsKKworCWZvciAoaSA9
IDA7IGkgPCBNQVhfQVRUUlM7IGkrKykgeworCQlzbnByaW50Zih0ZGF0YS0+YXR0cl9uYW1lW2ld
LCBDT1JFVEVNUF9OQU1FX0xFTkdUSCwgbmFtZXNbaV0sCisJCQlhdHRyX25vKTsKKwkJdGRhdGEt
PnNkX2F0dHJzW2ldLmRldl9hdHRyLmF0dHIubmFtZSA9IHRkYXRhLT5hdHRyX25hbWVbaV07CisJ
CXRkYXRhLT5zZF9hdHRyc1tpXS5kZXZfYXR0ci5hdHRyLm1vZGUgPSBTX0lSVUdPOworCQl0ZGF0
YS0+c2RfYXR0cnNbaV0uZGV2X2F0dHIuc2hvdyA9IHJkX3B0cltpXTsKKwkJdGRhdGEtPnNkX2F0
dHJzW2ldLmRldl9hdHRyLnN0b3JlID0gTlVMTDsKKwkJdGRhdGEtPnNkX2F0dHJzW2ldLmluZGV4
ID0gYXR0cl9ubzsKKwkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJnRkYXRhLT5zZF9h
dHRyc1tpXS5kZXZfYXR0cik7CisJCWlmIChlcnIpCisJCQlnb3RvIGV4aXRfZnJlZTsKIAl9CisJ
cmV0dXJuIDA7CiAKLQkvKiBDaGVjayBpZiB3ZSBoYXZlIHByb2JsZW0gd2l0aCBlcnJhdGEgQUUx
OCBvZiBDb3JlIHByb2Nlc3NvcnM6Ci0JICAgUmVhZGluZ3MgbWlnaHQgc3RvcCB1cGRhdGUgd2hl
biBwcm9jZXNzb3IgdmlzaXRlZCB0b28gZGVlcCBzbGVlcCwKLQkgICBmaXhlZCBmb3Igc3RlcHBp
bmcgRDAgKDZFQykuCi0JKi8KK2V4aXRfZnJlZToKKwl3aGlsZSAoLS1pID49IDApCisJCWRldmlj
ZV9yZW1vdmVfZmlsZShkZXYsICZ0ZGF0YS0+c2RfYXR0cnNbaV0uZGV2X2F0dHIpOworCXJldHVy
biBlcnI7Cit9CisKK3N0YXRpYyB2b2lkIHJlbW92ZV9hdHRycyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCB0ZW1wX2RhdGEgKnRkYXRhKQoreworCWludCBpOworCisJLyogUmVtb3ZlIHRoZSBz
eXNmcyBhdHRyaWJ1dGVzICovCisJZm9yIChpID0gMDsgaSA8IE1BWF9BVFRSUzsgaSsrKQorCQlk
ZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmdGRhdGEtPnNkX2F0dHJzW2ldLmRldl9hdHRyKTsKK30K
Kworc3RhdGljIHZvaWQgdXBkYXRlX3R0YXJnZXQoX191OCBjcHVfbW9kZWwsIHN0cnVjdCB0ZW1w
X2RhdGEgKnRkYXRhLAorCQkJCXN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlpbnQgZXJyOworCXUz
MiBlYXgsIGVkeDsKKworCS8qCisJICogSW5pdGlhbGl6ZSB0dGFyZ2V0IHZhbHVlLiBFdmVudHVh
bGx5IHRoaXMgd2lsbCBiZQorCSAqIGluaXRpYWxpemVkIHdpdGggdGhlIHZhbHVlIGZyb20gTVNS
X0lBMzJfVEhFUk1fSU5URVJSVVBUCisJICogcmVnaXN0ZXIuIElmIElBMzJfVEVNUEVSQVRVUkVf
VEFSR0VUIGlzIHN1cHBvcnRlZCwgdGhpcworCSAqIHZhbHVlIHdpbGwgYmUgb3ZlciB3cml0dGVu
IGJlbG93LgorCSAqIFRvIERvOiBQYXRjaCB0byBpbml0aWFsaXplIHR0YXJnZXQgZnJvbSBNU1Jf
SUEzMl9USEVSTV9JTlRFUlJVUFQKKwkgKi8KKwl0ZGF0YS0+dHRhcmdldCA9IHRkYXRhLT50am1h
eCAtIDIwMDAwOworCisJLyoKKwkgKiBSZWFkIHRoZSBzdGlsbCB1bmRvY3VtZW50ZWQgSUEzMl9U
RU1QRVJBVFVSRV9UQVJHRVQuIEl0IGV4aXN0cworCSAqIG9uIG9sZGVyIENQVXMgYnV0IG5vdCBp
biB0aGlzIHJlZ2lzdGVyLAorCSAqIEF0b21zIGRvbid0IGhhdmUgaXQgZWl0aGVyLgorCSAqLwor
CWlmICgoY3B1X21vZGVsID4gMHhlKSAmJiAoY3B1X21vZGVsICE9IDB4MWMpKSB7CisJCWVyciA9
IHJkbXNyX3NhZmVfb25fY3B1KHRkYXRhLT5jcHUsCisJCQkJTVNSX0lBMzJfVEVNUEVSQVRVUkVf
VEFSR0VULCAmZWF4LCAmZWR4KTsKKwkJaWYgKGVycikgeworCQkJZGV2X3dhcm4oZGV2LAorCQkJ
IlVuYWJsZSB0byByZWFkIElBMzJfVEVNUEVSQVRVUkVfVEFSR0VUIE1TUlxuIik7CisJCX0gZWxz
ZSB7CisJCQl0ZGF0YS0+dHRhcmdldCA9IHRkYXRhLT50am1heCAtCisJCQkJCSgoKGVheCA+PiA4
KSAmIDB4ZmYpICogMTAwMCk7CisJCX0KKwl9Cit9CiAKK3N0YXRpYyBpbnQgY2hrX3Vjb2RlX3Zl
cnNpb24oc3RydWN0IGNwdWluZm9feDg2ICpjLAorCQkJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCit7CisJaW50IGVycjsKKwl1MzIgZWR4OworCisJLyoKKwkgKiBDaGVjayBpZiB3ZSBo
YXZlIHByb2JsZW0gd2l0aCBlcnJhdGEgQUUxOCBvZiBDb3JlIHByb2Nlc3NvcnM6CisJICogUmVh
ZGluZ3MgbWlnaHQgc3RvcCB1cGRhdGUgd2hlbiBwcm9jZXNzb3IgdmlzaXRlZCB0b28gZGVlcCBz
bGVlcCwKKwkgKiBmaXhlZCBmb3Igc3RlcHBpbmcgRDAgKDZFQykuCisJICovCiAJaWYgKChjLT54
ODZfbW9kZWwgPT0gMHhlKSAmJiAoYy0+eDg2X21hc2sgPCAweGMpKSB7CiAJCS8qIGNoZWNrIGZv
ciBtaWNyb2NvZGUgdXBkYXRlICovCi0JCWVyciA9IHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShk
YXRhLT5pZCwgZ2V0X3Vjb2RlX3Jldl9vbl9jcHUsCi0JCQkJCSAgICAgICAmZWR4LCAxKTsKKwkJ
ZXJyID0gc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlKHBkZXYtPmlkLCBnZXRfdWNvZGVfcmV2X29u
X2NwdSwKKwkJCQkJCQkJJmVkeCwgMSk7CiAJCWlmIChlcnIpIHsKIAkJCWRldl9lcnIoJnBkZXYt
PmRldiwKIAkJCQkiQ2Fubm90IGRldGVybWluZSBtaWNyb2NvZGUgcmV2aXNpb24gb2YgIgotCQkJ
CSJDUFUjJXUgKCVkKSFcbiIsIGRhdGEtPmlkLCBlcnIpOwotCQkJZXJyID0gLUVOT0RFVjsKLQkJ
CWdvdG8gZXhpdF9mcmVlOworCQkJCSJDUFUjJXUgKCVkKSFcbiIsIHBkZXYtPmlkLCBlcnIpOwor
CQkJcmV0dXJuIC1FTk9ERVY7CiAJCX0gZWxzZSBpZiAoZWR4IDwgMHgzOSkgewotCQkJZXJyID0g
LUVOT0RFVjsKIAkJCWRldl9lcnIoJnBkZXYtPmRldiwKIAkJCQkiRXJyYXRhIEFFMTggbm90IGZp
eGVkLCB1cGRhdGUgQklPUyBvciAiCiAJCQkJIm1pY3JvY29kZSBvZiB0aGUgQ1BVIVxuIik7Ci0J
CQlnb3RvIGV4aXRfZnJlZTsKKwkJCXJldHVybiAtRU5PREVWOwogCQl9CiAJfQorCXJldHVybiAw
OworfQogCi0JZGF0YS0+dGptYXggPSBnZXRfdGptYXgoYywgZGF0YS0+aWQsICZwZGV2LT5kZXYp
OwotCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRhdGEpOworc3RhdGljIHN0cnVjdCB0ZW1w
X2RhdGEgKmluaXRfdGVtcF9kYXRhKHVuc2lnbmVkIGludCBjcHUsIGludCBjb3JlX2lkLAorCQkJ
CQlpbnQgcGtnX2ZsYWcpCit7CisJc3RydWN0IHRlbXBfZGF0YSAqdGRhdGE7CisKKwl0ZGF0YSA9
IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCB0ZW1wX2RhdGEpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXRk
YXRhKQorCQlyZXR1cm4gTlVMTDsKKworCXRkYXRhLT5zdGF0dXNfcmVnID0gcGtnX2ZsYWcgPyBN
U1JfSUEzMl9QQUNLQUdFX1RIRVJNX1NUQVRVUyA6CisJCQkJCQkJTVNSX0lBMzJfVEhFUk1fU1RB
VFVTOworCXRkYXRhLT5pc19wa2dfZGF0YSA9IHBrZ19mbGFnOworCXRkYXRhLT5jcHVfY29yZV9p
ZCA9IGNvcmVfaWQ7CisJdGRhdGEtPmNwdSA9IGNwdTsKKwl0ZGF0YS0+bGFzdF91cGRhdGVkID0g
amlmZmllczsKKwltdXRleF9pbml0KCZ0ZGF0YS0+dXBkYXRlX2xvY2spOworCXJldHVybiB0ZGF0
YTsKK30KKworc3RhdGljIGludCBjcmVhdGVfY29yZV9kYXRhKHN0cnVjdCBwbGF0Zm9ybV9kYXRh
ICpwZGF0YSwKKwkJCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAorCQkJCXVuc2lnbmVk
IGludCBjcHUsIGludCBwa2dfZmxhZykKK3sKKwlzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YTsKKwlz
dHJ1Y3QgY3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEoY3B1KTsKKwl1MzIgZWF4LCBlZHg7CisJ
aW50IGVyciwgYXR0cl9ubzsKIAogCS8qCi0JICogcmVhZCB0aGUgc3RpbGwgdW5kb2N1bWVudGVk
IElBMzJfVEVNUEVSQVRVUkVfVEFSR0VULiBJdCBleGlzdHMKLQkgKiBvbiBvbGRlciBDUFVzIGJ1
dCBub3QgaW4gdGhpcyByZWdpc3RlciwKLQkgKiBBdG9tcyBkb24ndCBoYXZlIGl0IGVpdGhlci4K
KwkgKiBGaW5kIGF0dHIgbnVtYmVyIGZvciBzeXNmczoKKwkgKiBXZSBtYXAgdGhlIGF0dHIgbnVt
YmVyIHRvIGNvcmUgaWQgb2YgdGhlIENQVQorCSAqIFRoZSBhdHRyIG51bWJlciBpcyBhbHdheXMg
Y29yZSBpZCArIDIKKwkgKiBUaGUgUGtndGVtcCB3aWxsIGFsd2F5cyBzaG93IHVwIGFzIHRlbXAx
XyoKIAkgKi8KKwlpZiAocGtnX2ZsYWcpCisJCWF0dHJfbm8gPSAxOworCWVsc2UKKwkJYXR0cl9u
byA9IFRPX0FUVFJfTk8oYy0+Y3B1X2NvcmVfaWQpOwogCi0JaWYgKChjLT54ODZfbW9kZWwgPiAw
eGUpICYmIChjLT54ODZfbW9kZWwgIT0gMHgxYykpIHsKLQkJZXJyID0gcmRtc3Jfc2FmZV9vbl9j
cHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RFTVBFUkFUVVJFX1RBUkdFVCwKLQkJICAgICZlYXgsICZl
ZHgpOwotCQlpZiAoZXJyKSB7Ci0JCQlkZXZfd2FybigmcGRldi0+ZGV2LCAiVW5hYmxlIHRvIHJl
YWQiCi0JCQkJCSIgSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQgTVNSXG4iKTsKLQkJfSBlbHNlIHsK
LQkJCWRhdGEtPnR0YXJnZXQgPSBkYXRhLT50am1heCAtCi0JCQkJCSgoKGVheCA+PiA4KSAmIDB4
ZmYpICogMTAwMCk7Ci0JCQllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoJnBkZXYtPmRldiwKLQkJ
CQkJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9tYXguZGV2X2F0dHIpOwotCQkJaWYgKGVycikKLQkJ
CQlnb3RvIGV4aXRfZnJlZTsKLQkJfQotCX0KKwlpZiAoYXR0cl9ubyA+IE1BWF9DT1JFX0RBVEEg
LSAxKQorCQlyZXR1cm4gLUVSQU5HRTsKIAotCWlmICgoZXJyID0gc3lzZnNfY3JlYXRlX2dyb3Vw
KCZwZGV2LT5kZXYua29iaiwgJmNvcmV0ZW1wX2dyb3VwKSkpCi0JCWdvdG8gZXhpdF9kZXY7CisJ
LyogU2tpcCBpZiBpdCBpcyBhIEhUIGNvcmUsIE5vdCBhbiBlcnJvciAqLworCWlmIChwZGF0YS0+
Y29yZV9kYXRhW2F0dHJfbm9dICE9IE5VTEwpCisJCXJldHVybiAwOworCisJdGRhdGEgPSBpbml0
X3RlbXBfZGF0YShjcHUsIGMtPmNwdV9jb3JlX2lkLCBwa2dfZmxhZyk7CisJaWYgKCF0ZGF0YSkK
KwkJcmV0dXJuIC1FTk9NRU07CiAKLQlkYXRhLT5od21vbl9kZXYgPSBod21vbl9kZXZpY2VfcmVn
aXN0ZXIoJnBkZXYtPmRldik7Ci0JaWYgKElTX0VSUihkYXRhLT5od21vbl9kZXYpKSB7Ci0JCWVy
ciA9IFBUUl9FUlIoZGF0YS0+aHdtb25fZGV2KTsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2xh
c3MgcmVnaXN0cmF0aW9uIGZhaWxlZCAoJWQpXG4iLAotCQkJZXJyKTsKLQkJZ290byBleGl0X2Ns
YXNzOwotCX0KKwkvKiBUZXN0IGlmIHdlIGNhbiBhY2Nlc3MgdGhlIHN0YXR1cyByZWdpc3RlciAq
LworCWVyciA9IHJkbXNyX3NhZmVfb25fY3B1KGNwdSwgdGRhdGEtPnN0YXR1c19yZWcsICZlYXgs
ICZlZHgpOworCWlmIChlcnIpCisJCWdvdG8gZXhpdF9mcmVlOworCisJLyogQ3JlYXRlIHN5c2Zz
IGludGVyZmFjZXMgKi8KKwllcnIgPSBjcmVhdGVfY29yZV9hdHRycyh0ZGF0YSwgJnBkZXYtPmRl
diwgYXR0cl9ubyk7CisJaWYgKGVycikKKwkJZ290byBleGl0X2ZyZWU7CisKKwkvKiBHZXQgQ3Jp
dGljYWwgVGVtcGVyYXR1cmUgKi8KKwlpZiAocGtnX2ZsYWcpCisJCXRkYXRhLT50am1heCA9IGdl
dF9wa2dfdGptYXgocGRldi0+aWQsICZwZGV2LT5kZXYpOworCWVsc2UKKwkJdGRhdGEtPnRqbWF4
ID0gZ2V0X3RqbWF4KGMsIGNwdSwgJnBkZXYtPmRldik7CisKKwl1cGRhdGVfdHRhcmdldChjLT54
ODZfbW9kZWwsIHRkYXRhLCAmcGRldi0+ZGV2KTsKKworCXBkYXRhLT5jb3JlX2RhdGFbYXR0cl9u
b10gPSB0ZGF0YTsKKwlyZXR1cm4gMDsKK2V4aXRfZnJlZToKKwlrZnJlZSh0ZGF0YSk7CisJcmV0
dXJuIGVycjsKK30KKworc3RhdGljIGludCBfX2RldmluaXQgY29yZXRlbXBfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGE7
CisJc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNwdV9kYXRhKHBkZXYtPmlkKTsKKwlpbnQgZXJy
OwogCisJLyogSW5pdGlhbGl6ZSB0aGUgcGVyLXBhY2thZ2UgZGF0YSBzdHJ1Y3R1cmVzICovCisJ
cGRhdGEgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcGxhdGZvcm1fZGF0YSksIEdGUF9LRVJORUwp
OworCWlmICghcGRhdGEpCisJCXJldHVybiAtRU5PTUVNOworCisJcGRhdGEtPnBoeXNfcHJvY19p
ZCA9IGMtPnBoeXNfcHJvY19pZDsKKworCWVyciA9IGNyZWF0ZV9uYW1lX2F0dHIocGRhdGEsICZw
ZGV2LT5kZXYpOworCWlmIChlcnIpCisJCWdvdG8gZXhpdF9mcmVlOworCisJLyogQ2hlY2sgdGhl
IG1pY3JvY29kZSB2ZXJzaW9uIG9mIHRoZSBDUFUgKi8KKwllcnIgPSBjaGtfdWNvZGVfdmVyc2lv
bihjLCBwZGV2KTsKKwlpZiAoZXJyKQorCQlnb3RvIGV4aXRfbmFtZTsKKworCXBsYXRmb3JtX3Nl
dF9kcnZkYXRhKHBkZXYsIHBkYXRhKTsKKworCXBkYXRhLT5od21vbl9kZXYgPSBod21vbl9kZXZp
Y2VfcmVnaXN0ZXIoJnBkZXYtPmRldik7CisJaWYgKElTX0VSUihwZGF0YS0+aHdtb25fZGV2KSkg
eworCQllcnIgPSBQVFJfRVJSKHBkYXRhLT5od21vbl9kZXYpOworCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJDbGFzcyByZWdpc3RyYXRpb24gZmFpbGVkICglZClcbiIsIGVycik7CisJCWdvdG8gZXhp
dF9uYW1lOworCX0KIAlyZXR1cm4gMDsKIAotZXhpdF9jbGFzczoKLQlzeXNmc19yZW1vdmVfZ3Jv
dXAoJnBkZXYtPmRldi5rb2JqLCAmY29yZXRlbXBfZ3JvdXApOwotZXhpdF9kZXY6Ci0JZGV2aWNl
X3JlbW92ZV9maWxlKCZwZGV2LT5kZXYsICZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfbWF4LmRldl9h
dHRyKTsKK2V4aXRfbmFtZToKKwlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwgJnBkYXRh
LT5uYW1lX2F0dHIpOwogZXhpdF9mcmVlOgotCWtmcmVlKGRhdGEpOwotZXhpdDoKKwlrZnJlZShw
ZGF0YSk7CiAJcmV0dXJuIGVycjsKIH0KIAogc3RhdGljIGludCBfX2RldmV4aXQgY29yZXRlbXBf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7Ci0Jc3RydWN0IGNvcmV0ZW1w
X2RhdGEgKmRhdGEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlzdHJ1Y3QgcGxhdGZv
cm1fZGF0YSAqcGRhdGEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlpbnQgaTsKKwor
CWZvciAoaSA9IE1BWF9DT1JFX0RBVEEgLSAxOyBpID49IDA7IC0taSkKKwkJY29yZXRlbXBfcmVt
b3ZlX2NvcmUocGRhdGEsICZwZGV2LT5kZXYsIGkpOwogCi0JaHdtb25fZGV2aWNlX3VucmVnaXN0
ZXIoZGF0YS0+aHdtb25fZGV2KTsKLQlzeXNmc19yZW1vdmVfZ3JvdXAoJnBkZXYtPmRldi5rb2Jq
LCAmY29yZXRlbXBfZ3JvdXApOwotCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2LCAmc2Vu
c29yX2Rldl9hdHRyX3RlbXAxX21heC5kZXZfYXR0cik7CisJZGV2aWNlX3JlbW92ZV9maWxlKCZw
ZGV2LT5kZXYsICZwZGF0YS0+bmFtZV9hdHRyKTsKKwlod21vbl9kZXZpY2VfdW5yZWdpc3Rlcihw
ZGF0YS0+aHdtb25fZGV2KTsKIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKLQlr
ZnJlZShkYXRhKTsKKwlrZnJlZShwZGF0YSk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTQzNCw2ICs1
ODcsNTIgQEAgc3RydWN0IHBkZXZfZW50cnkgewogc3RhdGljIExJU1RfSEVBRChwZGV2X2xpc3Qp
Owogc3RhdGljIERFRklORV9NVVRFWChwZGV2X2xpc3RfbXV0ZXgpOwogCitzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqY29yZXRlbXBfZ2V0X3BkZXYodTE2IHBoeXNfcHJvY19pZCkKK3sK
KwlzdHJ1Y3QgcGRldl9lbnRyeSAqcDsKKworCW11dGV4X2xvY2soJnBkZXZfbGlzdF9tdXRleCk7
CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHAsICZwZGV2X2xpc3QsIGxpc3QpCisJCWlmIChwLT5w
aHlzX3Byb2NfaWQgPT0gcGh5c19wcm9jX2lkKSB7CisJCQltdXRleF91bmxvY2soJnBkZXZfbGlz
dF9tdXRleCk7CisJCQlyZXR1cm4gcC0+cGRldjsKKwkJfQorCisJbXV0ZXhfdW5sb2NrKCZwZGV2
X2xpc3RfbXV0ZXgpOworCXJldHVybiBOVUxMOworfQorCitzdGF0aWMgdm9pZCBjb3JldGVtcF9h
ZGRfY29yZSh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgcGtnX2ZsYWcpCit7CisJaW50IGVycjsKKwlz
dHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGE7CisJc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNw
dV9kYXRhKGNwdSk7CisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IGNvcmV0ZW1wX2dl
dF9wZGV2KGMtPnBoeXNfcHJvY19pZCk7CisKKwlpZiAoIXBkZXYpCisJCXJldHVybjsKKworCXBk
YXRhID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisKKwllcnIgPSBjcmVhdGVfY29yZV9k
YXRhKHBkYXRhLCBwZGV2LCBjcHUsIHBrZ19mbGFnKTsKKwlpZiAoZXJyKSB7CisJCWRldl9lcnIo
JnBkZXYtPmRldiwgIkFkZGluZyBDb3JlICV1IG9uIFBrZyAldSBmYWlsZWRcbiIsCisJCQljcHUs
IGMtPnBoeXNfcHJvY19pZCk7CisJfQorfQorCitzdGF0aWMgdm9pZCBjb3JldGVtcF9yZW1vdmVf
Y29yZShzdHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGEsCisJCQkJCXN0cnVjdCBkZXZpY2UgKmRl
diwgaW50IGluZHgpCit7CisJaWYgKHBkYXRhLT5jb3JlX2RhdGFbaW5keF0gPT0gTlVMTCkKKwkJ
cmV0dXJuOworCisJcmVtb3ZlX2F0dHJzKGRldiwgcGRhdGEtPmNvcmVfZGF0YVtpbmR4XSk7CisJ
a2ZyZWUocGRhdGEtPmNvcmVfZGF0YVtpbmR4XSk7CisJcGRhdGEtPmNvcmVfZGF0YVtpbmR4XSA9
IE5VTEw7Cit9CisKIHN0YXRpYyBpbnQgX19jcHVpbml0IGNvcmV0ZW1wX2RldmljZV9hZGQodW5z
aWduZWQgaW50IGNwdSkKIHsKIAlpbnQgZXJyOwpAQCAtNDQxLDMwICs2NDAsOCBAQCBzdGF0aWMg
aW50IF9fY3B1aW5pdCBjb3JldGVtcF9kZXZpY2VfYWRkKHVuc2lnbmVkIGludCBjcHUpCiAJc3Ry
dWN0IHBkZXZfZW50cnkgKnBkZXZfZW50cnk7CiAJc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNw
dV9kYXRhKGNwdSk7CiAKLQkvKgotCSAqIENQVUlELjA2SC5FQVhbMF0gaW5kaWNhdGVzIHdoZXRo
ZXIgdGhlIENQVSBoYXMgdGhlcm1hbAotCSAqIHNlbnNvcnMuIFdlIGNoZWNrIHRoaXMgYml0IG9u
bHksIGFsbCB0aGUgZWFybHkgQ1BVcwotCSAqIHdpdGhvdXQgdGhlcm1hbCBzZW5zb3JzIHdpbGwg
YmUgZmlsdGVyZWQgb3V0LgotCSAqLwotCWlmICghY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9EVFMp
KSB7Ci0JCXByX2luZm8oIkNQVSAobW9kZWw9MHgleCkgaGFzIG5vIHRoZXJtYWwgc2Vuc29yXG4i
LAotCQkJYy0+eDg2X21vZGVsKTsKLQkJcmV0dXJuIDA7Ci0JfQotCiAJbXV0ZXhfbG9jaygmcGRl
dl9saXN0X211dGV4KTsKIAotI2lmZGVmIENPTkZJR19TTVAKLQkvKiBTa2lwIHNlY29uZCBIVCBl
bnRyeSBvZiBlYWNoIGNvcmUgKi8KLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBkZXZfZW50cnksICZw
ZGV2X2xpc3QsIGxpc3QpIHsKLQkJaWYgKGMtPnBoeXNfcHJvY19pZCA9PSBwZGV2X2VudHJ5LT5w
aHlzX3Byb2NfaWQgJiYKLQkJICAgIGMtPmNwdV9jb3JlX2lkID09IHBkZXZfZW50cnktPmNwdV9j
b3JlX2lkKSB7Ci0JCQllcnIgPSAwOwkvKiBOb3QgYW4gZXJyb3IgKi8KLQkJCWdvdG8gZXhpdDsK
LQkJfQotCX0KLSNlbmRpZgotCiAJcGRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYyhEUlZOQU1F
LCBjcHUpOwogCWlmICghcGRldikgewogCQllcnIgPSAtRU5PTUVNOwpAQCAtNTA0LDI2ICs2ODEs
NjIgQEAgZXhpdDoKIAlyZXR1cm4gZXJyOwogfQogCi1zdGF0aWMgdm9pZCBfX2NwdWluaXQgY29y
ZXRlbXBfZGV2aWNlX3JlbW92ZSh1bnNpZ25lZCBpbnQgY3B1KQorc3RhdGljIHZvaWQgZ2V0X2Nv
cmVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpCiB7Ci0Jc3RydWN0IHBkZXZfZW50cnkgKnA7Ci0J
dW5zaWduZWQgaW50IGk7Ci0KLQltdXRleF9sb2NrKCZwZGV2X2xpc3RfbXV0ZXgpOwotCWxpc3Rf
Zm9yX2VhY2hfZW50cnkocCwgJnBkZXZfbGlzdCwgbGlzdCkgewotCQlpZiAocC0+Y3B1ICE9IGNw
dSkKLQkJCWNvbnRpbnVlOworCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YShjcHUp
OworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBjb3JldGVtcF9nZXRfcGRldihjLT5w
aHlzX3Byb2NfaWQpOworCWludCBlcnI7CiAKLQkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIo
cC0+cGRldik7Ci0JCWxpc3RfZGVsKCZwLT5saXN0KTsKLQkJbXV0ZXhfdW5sb2NrKCZwZGV2X2xp
c3RfbXV0ZXgpOwotCQlrZnJlZShwKTsKLQkJZm9yX2VhY2hfY3B1KGksIGNwdV9zaWJsaW5nX21h
c2soY3B1KSkKLQkJCWlmIChpICE9IGNwdSAmJiAhY29yZXRlbXBfZGV2aWNlX2FkZChpKSkKLQkJ
CQlicmVhazsKKwkvKgorCSAqIENQVUlELjA2SC5FQVhbMF0gaW5kaWNhdGVzIHdoZXRoZXIgdGhl
IENQVSBoYXMgdGhlcm1hbAorCSAqIHNlbnNvcnMuIFdlIGNoZWNrIHRoaXMgYml0IG9ubHksIGFs
bCB0aGUgZWFybHkgQ1BVcworCSAqIHdpdGhvdXQgdGhlcm1hbCBzZW5zb3JzIHdpbGwgYmUgZmls
dGVyZWQgb3V0LgorCSAqLworCWlmICghY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9EVFMpKQogCQly
ZXR1cm47CisKKwlpZiAoIXBkZXYpIHsKKwkJLyoKKwkJICogQWxyaWdodCwgd2UgaGF2ZSBEVFMg
c3VwcG9ydC4KKwkJICogV2UgYXJlIGJyaW5naW5nIHRoZSBfZmlyc3RfIGNvcmUgaW4gdGhpcyBw
a2cKKwkJICogb25saW5lLiBTbywgaW5pdGlhbGl6ZSBwZXItcGtnIGRhdGEgc3RydWN0dXJlcyBh
bmQKKwkJICogdGhlbiBicmluZyB0aGlzIGNvcmUgb25saW5lLgorCQkgKi8KKwkJZXJyID0gY29y
ZXRlbXBfZGV2aWNlX2FkZChjcHUpOworCQlpZiAoZXJyKQorCQkJcmV0dXJuOworCQkvKgorCQkg
KiBDaGVjayB3aGV0aGVyIHBrZ3RlbXAgc3VwcG9ydCBpcyBhdmFpbGFibGUuCisJCSAqIElmIHNv
LCBhZGQgaW50ZXJmYWNlcyBmb3IgcGtndGVtcC4KKwkJICovCisJCWlmIChjcHVfaGFzKGMsIFg4
Nl9GRUFUVVJFX1BUUykpCisJCQljb3JldGVtcF9hZGRfY29yZShjcHUsIDEpOwogCX0KLQltdXRl
eF91bmxvY2soJnBkZXZfbGlzdF9tdXRleCk7CisKKwkvKgorCSAqIFBoeXNpY2FsIENQVSBkZXZp
Y2UgYWxyZWFkeSBleGlzdHMuCisJICogU28sIGp1c3QgYWRkIGludGVyZmFjZXMgZm9yIHRoaXMg
Y29yZS4KKwkgKi8KKwljb3JldGVtcF9hZGRfY29yZShjcHUsIDApOworfQorCitzdGF0aWMgdm9p
ZCBwdXRfY29yZV9vZmZsaW5lKHVuc2lnbmVkIGludCBjcHUpCit7CisJaW50IGluZHg7CisJc3Ry
dWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhOworCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVf
ZGF0YShjcHUpOworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBjb3JldGVtcF9nZXRf
cGRldihjLT5waHlzX3Byb2NfaWQpOworCisJLyogSWYgdGhlIHBoeXNpY2FsIENQVSBkZXZpY2Ug
ZG9lcyBub3QgZXhpc3QsIGp1c3QgcmV0dXJuICovCisJaWYgKCFwZGV2KQorCQlyZXR1cm47CisK
KwlwZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCisJaW5keCA9IFRPX0FUVFJf
Tk8oYy0+Y3B1X2NvcmVfaWQpOworCisJaWYgKHBkYXRhLT5jb3JlX2RhdGFbaW5keF0gJiYgcGRh
dGEtPmNvcmVfZGF0YVtpbmR4XS0+Y3B1ID09IGNwdSkKKwkJY29yZXRlbXBfcmVtb3ZlX2NvcmUo
cGRhdGEsICZwZGV2LT5kZXYsIGluZHgpOwogfQogCiBzdGF0aWMgaW50IF9fY3B1aW5pdCBjb3Jl
dGVtcF9jcHVfY2FsbGJhY2soc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuZmIsCkBAIC01MzQsMTAg
Kzc0NywxMCBAQCBzdGF0aWMgaW50IF9fY3B1aW5pdCBjb3JldGVtcF9jcHVfY2FsbGJhY2soc3Ry
dWN0IG5vdGlmaWVyX2Jsb2NrICpuZmIsCiAJc3dpdGNoIChhY3Rpb24pIHsKIAljYXNlIENQVV9P
TkxJTkU6CiAJY2FzZSBDUFVfRE9XTl9GQUlMRUQ6Ci0JCWNvcmV0ZW1wX2RldmljZV9hZGQoY3B1
KTsKKwkJZ2V0X2NvcmVfb25saW5lKGNwdSk7CiAJCWJyZWFrOwogCWNhc2UgQ1BVX0RPV05fUFJF
UEFSRToKLQkJY29yZXRlbXBfZGV2aWNlX3JlbW92ZShjcHUpOworCQlwdXRfY29yZV9vZmZsaW5l
KGNwdSk7CiAJCWJyZWFrOwogCX0KIAlyZXR1cm4gTk9USUZZX09LOwpAQCAtNTQ3LDEwICs3NjAs
MTEgQEAgc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBjb3JldGVtcF9jcHVfbm90aWZpZXIg
X19yZWZkYXRhID0gewogCS5ub3RpZmllcl9jYWxsID0gY29yZXRlbXBfY3B1X2NhbGxiYWNrLAog
fTsKIAorCiBzdGF0aWMgaW50IF9faW5pdCBjb3JldGVtcF9pbml0KHZvaWQpCiB7CiAJaW50IGks
IGVyciA9IC1FTk9ERVY7Ci0KKwogCS8qIHF1aWNrIGNoZWNrIGlmIHdlIHJ1biBJbnRlbCAqLwog
CWlmIChjcHVfZGF0YSgwKS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwpCiAJCWdvdG8g
ZXhpdDsKQEAgLTU2MCw3ICs3NzQsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjb3JldGVtcF9pbml0
KHZvaWQpCiAJCWdvdG8gZXhpdDsKIAogCWZvcl9lYWNoX29ubGluZV9jcHUoaSkKLQkJY29yZXRl
bXBfZGV2aWNlX2FkZChpKTsKKwkJZ2V0X2NvcmVfb25saW5lKGkpOwogCiAjaWZuZGVmIENPTkZJ
R19IT1RQTFVHX0NQVQogCWlmIChsaXN0X2VtcHR5KCZwZGV2X2xpc3QpKSB7Ci0tIAoxLjYuMQoK

--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_
Content-Type: application/octet-stream; name="corei5.log"
Content-Description: corei5.log
Content-Disposition: attachment; filename="corei5.log"; size=278;
	creation-date="Mon, 18 Apr 2011 18:22:57 GMT";
	modification-date="Mon, 18 Apr 2011 22:09:05 GMT"
Content-Transfer-Encoding: base64

bW9kYWxpYXM6cGxhdGZvcm06Y29yZXRlbXAKbmFtZTpjb3JldGVtcAp0ZW1wMl9jcml0OjEwNTAw
MAp0ZW1wMl9jcml0X2FsYXJtOjAKdGVtcDJfaW5wdXQ6MjQwMDAKdGVtcDJfbGFiZWw6Q29yZSAw
CnRlbXAyX21heDo4OTAwMAp0ZW1wNF9jcml0OjEwNTAwMAp0ZW1wNF9jcml0X2FsYXJtOjAKdGVt
cDRfaW5wdXQ6MjUwMDAKdGVtcDRfbGFiZWw6Q29yZSAyCnRlbXA0X21heDo4OTAwMAp1ZXZlbnQ6
RFJJVkVSPWNvcmV0ZW1wCnVldmVudDpNT0RBTElBUz1wbGF0Zm9ybTpjb3JldGVtcAo=

--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_
Content-Type: application/octet-stream; name="snb.log"
Content-Description: snb.log
Content-Disposition: attachment; filename="snb.log"; size=555;
	creation-date="Mon, 18 Apr 2011 18:23:55 GMT";
	modification-date="Sun, 09 Jan 2011 12:57:54 GMT"
Content-Transfer-Encoding: base64

bW9kYWxpYXM6cGxhdGZvcm06Y29yZXRlbXAKbmFtZTpjb3JldGVtcAp0ZW1wMV9jcml0OjEwMDAw
MAp0ZW1wMV9jcml0X2FsYXJtOjAKdGVtcDFfaW5wdXQ6MzUwMDAKdGVtcDFfbGFiZWw6UGh5c2lj
YWwgaWQgMAp0ZW1wMV9tYXg6ODYwMDAKdGVtcDJfY3JpdDoxMDAwMDAKdGVtcDJfY3JpdF9hbGFy
bTowCnRlbXAyX2lucHV0OjI5MDAwCnRlbXAyX2xhYmVsOkNvcmUgMAp0ZW1wMl9tYXg6ODYwMDAK
dGVtcDNfY3JpdDoxMDAwMDAKdGVtcDNfY3JpdF9hbGFybTowCnRlbXAzX2lucHV0OjM1MDAwCnRl
bXAzX2xhYmVsOkNvcmUgMQp0ZW1wM19tYXg6ODYwMDAKdGVtcDRfY3JpdDoxMDAwMDAKdGVtcDRf
Y3JpdF9hbGFybTowCnRlbXA0X2lucHV0OjI5MDAwCnRlbXA0X2xhYmVsOkNvcmUgMgp0ZW1wNF9t
YXg6ODYwMDAKdGVtcDVfY3JpdDoxMDAwMDAKdGVtcDVfY3JpdF9hbGFybTowCnRlbXA1X2lucHV0
OjM1MDAwCnRlbXA1X2xhYmVsOkNvcmUgMwp0ZW1wNV9tYXg6ODYwMDAKdWV2ZW50OkRSSVZFUj1j
b3JldGVtcAp1ZXZlbnQ6TU9EQUxJQVM9cGxhdGZvcm06Y29yZXRlbXAK

--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_004_D6D887BA8C9DFF48B5233887EF046541095182D2CCbgsmsx502garc_--
