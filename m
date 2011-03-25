From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 25 Mar 2011 13:16:29 +0000
Subject: [lm-sensors] [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF0465410951570349@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_D6D887BA8C9DFF48B5233887EF0465410951570349bgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--_002_D6D887BA8C9DFF48B5233887EF0465410951570349bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

This patch merges the pkgtemp driver with the coretemp driver.
This merged driver creates one hwmon device per physical CPU i.e
per Physical Package. Also, the sysfs interfaces per core are created
as each core comes online and removed when it goes offline.

v1 of this patch:
Basic Merging of pkgtemp with coretemp. This creates one hwmon device
per core.
v2 of this patch:
Fixed some Data structure related comments from v1. This also
creates one hwmon device per core.
v3 of this patch:
This version creates one hwmon device per physical package, but
no appropriate support for CPU hotplug.
v4 of this patch:
This creates one hwmon device per package.
Added appropriate support for CONFIG_HOTPLUG_CPU.

---
From: Durgadoss R <durgadoss.r@intel.com>

Date: Thu, 3 Mar 2011 02:37:40 +0530
Subject: [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp

This patch merges the pkgtemp driver with the coretemp driver.
This merged driver creates one hwmon device per physical CPU i.e
per Physical Package. Also, the sysfs interfaces per core are created
as each core comes online and removed when it goes offline.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 drivers/hwmon/coretemp.c |  618 ++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 455 insertions(+), 163 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 42de98d..2667828 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,119 +39,140 @@

 #define DRVNAME        "coretemp"

-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
-               SHOW_NAME } SHOW;
+#define CORES_PER_CPU          16      /* No of Real Cores per CPU */
+#define CORETEMP_NAME_LENGTH   17      /* String Length of attrs */
+#define MAX_ATTRS              5       /* Maximum no of per-core attrs */

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
+       u8 crit_alarm;
+       u8 max_alarm;
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
+ * @core_count:                Number of real cores(not HT ones) in a CPU
+ * @phys_proc_id:      The physical CPU id
  */
+struct platform_data {
+       struct device *hwmon_dev;
+       int core_count;
+       u16 phys_proc_id;
+       struct temp_data *core_data[CORES_PER_CPU];
+       struct device_attribute name_attr;
+};
+
+/* Function Declarations */
+static void remove_core(struct platform_data *data, struct device *dev, in=
t i);
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
+               return sprintf(buf, "Physical id %d\n", pdata->phys_proc_id=
);
+
+       return sprintf(buf, "Core %d\n", tdata->cpu_core_id);
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
+       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
+       tdata->crit_alarm =3D (eax >> 5) & 1;
+
+       return sprintf(buf, "%d\n", tdata->crit_alarm);
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
+static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax)
 {
-       struct coretemp_data *data =3D dev_get_drvdata(dev);
+       int err =3D -EINVAL;

-       mutex_lock(&data->update_lock);
+       mutex_lock(&tdata->update_lock);
+       /*
+        * Update the current temperature only if:
+        * 1. The time interval has elapsed _and_
+        * 2. The data is valid
+        */
+       if (time_after(jiffies, tdata->last_updated + HZ) &&
+                                               (eax & 0x80000000)) {
+               tdata->temp =3D tjmax - (((eax >> 16) & 0x7f) * 1000);
+               tdata->last_updated =3D jiffies;
+               err =3D 0;
+       }

-       if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
-               u32 eax, edx;
+       mutex_unlock(&tdata->update_lock);
+       return err;
+}

-               data->valid =3D 0;
-               rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-               data->alarm =3D (eax >> 5) & 1;
-               /* update only if data has been valid */
-               if (eax & 0x80000000) {
-                       data->temp =3D data->tjmax - (((eax >> 16)
-                                                       & 0x7f) * 1000);
-                       data->valid =3D 1;
-               } else {
-                       dev_dbg(dev, "Temperature data invalid (0x%x)\n", e=
ax);
-               }
-               data->last_updated =3D jiffies;
-       }
+static ssize_t show_temp(struct device *dev,
+                               struct device_attribute *devattr, char *buf=
)
+{
+       u32 eax, edx;
+       struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr=
);
+       struct platform_data *pdata =3D dev_get_drvdata(dev);
+       struct temp_data *tdata =3D pdata->core_data[attr->index];
+       int err;

-       mutex_unlock(&data->update_lock);
-       return data;
+       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
+       err =3D update_curr_temp(tdata, eax, tdata->tjmax);
+       if (err)
+               return err;
+
+       return sprintf(buf, "%d\n", tdata->temp);
 }

 static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct de=
vice *dev)
@@ -298,115 +319,242 @@ static void __devinit get_ucode_rev_on_cpu(void *ed=
x)
        rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }

-static int __devinit coretemp_probe(struct platform_device *pdev)
+static int get_pkg_tjmax(int cpu, struct device *dev)
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
+       dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%d\n", cpu);
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
+       /* Increment attr_no since the sysfs interfaces start with temp1_* =
*/
+       int sysfs_attr_no =3D attr_no + 1;
+
+       for (i =3D 0; i < MAX_ATTRS; i++) {
+               snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i=
],
+                       sysfs_attr_no);
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
+
+exit_free:
+       while (--i >=3D 0)
+               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+       return err;
+}
+
+static void remove_attrs(struct device *dev, struct temp_data *tdata)
+{
+       int i;

-       /* Check if we have problem with errata AE18 of Core processors:
-          Readings might stop update when processor visited too deep sleep=
,
-          fixed for stepping D0 (6EC).
-       */
+       /* Remove the sysfs attributes */
+       for (i =3D 0; i < MAX_ATTRS; i++)
+               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+}

+static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
+                               struct device *dev)
+{
+       int err;
+       u32 eax, edx;
+
+       /*
+        * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
+        * on older CPUs but not in this register,
+        * Atoms don't have it either.
+        */
+       if ((cpu_model > 0xe) && (cpu_model !=3D 0x1c)) {
+               err =3D rdmsr_safe_on_cpu(tdata->cpu_core_id,
+                               MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+               if (err) {
+                       dev_warn(dev,
+                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
+
+               } else {
+                       tdata->ttarget =3D tdata->tjmax -
+                                       (((eax >> 8) & 0xff) * 1000);
+               }
+       }
+}
+
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
+static struct temp_data *init_temp_data(int cpu, int core_id, int pkg_flag=
)
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
+       mutex_init(&tdata->update_lock);
+       return tdata;
+}

-       /*
-        * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
-        * on older CPUs but not in this register,
-        * Atoms don't have it either.
-        */
+static int create_core_data(struct platform_data *pdata,
+                               struct platform_device *pdev,
+                               unsigned int cpu, int pkg_flag)
+{
+       struct temp_data *tdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       u32 eax, edx;
+       int err;
+       int core_id =3D c->cpu_core_id;

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
+       tdata =3D init_temp_data(cpu, core_id, pkg_flag);
+       if (!tdata)
+               return -ENOMEM;
+
+       /* Test if we can access the status register */
+       err =3D rdmsr_safe_on_cpu(core_id, tdata->status_reg, &eax, &edx);
+       if (err)
+               goto exit_free;
+
+       /* Create sysfs interfaces */
+       err =3D create_core_attrs(tdata, &pdev->dev, pdata->core_count);
+       if (err)
+               goto exit_free;
+
+       /* Get Critical Temperature */
+       if (pkg_flag)
+               tdata->tjmax =3D get_pkg_tjmax(pdev->id, &pdev->dev);
+       else
+               tdata->tjmax =3D get_tjmax(c, core_id, &pdev->dev);
+
+       update_ttarget(c->x86_model, tdata, &pdev->dev);
+
+       pdata->core_data[pdata->core_count] =3D tdata;
+       pdata->core_count++;
+
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
+
+       /* Initialize the per-package data structures */
+       pdata =3D kzalloc(sizeof(struct platform_data), GFP_KERNEL);
+       if (!pdata) {
+               dev_err(&pdev->dev, "Out of memory\n");
+               return -ENOMEM;
        }

-       if ((err =3D sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-               goto exit_dev;
+       pdata->core_count =3D 0;
+       pdata->phys_proc_id =3D c->phys_proc_id;

-       data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
-       if (IS_ERR(data->hwmon_dev)) {
-               err =3D PTR_ERR(data->hwmon_dev);
-               dev_err(&pdev->dev, "Class registration failed (%d)\n",
-                       err);
-               goto exit_class;
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
        }

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

-       hwmon_device_unregister(data->hwmon_dev);
-       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr)=
;
+       for (i =3D pdata->core_count - 1; i >=3D 0; --i)
+               remove_core(pdata, &pdev->dev, i);
+
+       device_remove_file(&pdev->dev, &pdata->name_attr);
+       hwmon_device_unregister(pdata->hwmon_dev);
        platform_set_drvdata(pdev, NULL);
-       kfree(data);
+       kfree(pdata);
        return 0;
 }

@@ -432,6 +580,96 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);

+static struct platform_device *get_pdev(int phys_proc_id)
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
+static int get_core_indx(struct platform_data *pdata, int core_id)
+{
+       int i;
+
+       for (i =3D 0; i < pdata->core_count; i++) {
+               if (pdata->core_data[i]->cpu_core_id =3D=3D core_id &&
+                       !pdata->core_data[i]->is_pkg_data)
+                       return i;
+       }
+       return -ENODEV;
+}
+
+static void add_core(unsigned int cpu, int pkg_flag)
+{
+       int indx, err;
+       struct platform_data *pdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D get_pdev(c->phys_proc_id);
+
+       if (!pdev)
+               return;
+
+       pdata =3D platform_get_drvdata(pdev);
+
+       /* If this core is a HT one, do not create any interfaces */
+       indx =3D get_core_indx(pdata, c->cpu_core_id);
+       if (indx >=3D 0) {
+               dev_info(&pdev->dev, "A HT core (%u) is onlined\n", cpu);
+               return;
+       }
+
+       err =3D create_core_data(pdata, pdev, cpu, pkg_flag);
+       if (err) {
+               dev_err(&pdev->dev, "Onlining Core %u on Pkg %d failed\n",
+                       cpu, c->phys_proc_id);
+       }
+}
+
+static void remove_core(struct platform_data *pdata, struct device *dev,
+                       int indx)
+{
+       int i;
+       int max =3D pdata->core_count - 1;
+
+       /* Remove all sysfs attrs for this core */
+       remove_attrs(dev, pdata->core_data[indx]);
+
+       /* Shift the core_data elements */
+       for (i =3D indx; i < max; i++)
+               pdata->core_data[i] =3D pdata->core_data[i + 1];
+
+       /* Free the _last_ element */
+       kfree(pdata->core_data[max]);
+       pdata->core_data[max] =3D NULL;
+
+       pdata->core_count--;
+
+       /*
+        * If count is _only_ one and the device is pkg temp
+        * remove those interfaces and get rid off this 'pdev' entry
+        * in the pdev_entry list.
+        *
+        * The pkg temp is alive as long as atleast one of the
+        * cores inside the pkg is online. And it is removed
+        * when all cores in a pkg go offline.
+        */
+       if (pdata->core_count =3D=3D 1 && pdata->core_data[0]->is_pkg_data)=
 {
+               remove_attrs(dev, pdata->core_data[0]);
+               kfree(pdata->core_data[0]);
+               pdata->core_data[0] =3D NULL;
+               pdata->core_count--;
+       }
+}
+
 static int __cpuinit coretemp_device_add(unsigned int cpu)
 {
        int err;
@@ -503,28 +741,81 @@ exit:
        return err;
 }

-static void __cpuinit coretemp_device_remove(unsigned int cpu)
+static void __cpuinit coretemp_device_remove(int phys_proc_id)
 {
        struct pdev_entry *p;
-       unsigned int i;

        mutex_lock(&pdev_list_mutex);
        list_for_each_entry(p, &pdev_list, list) {
-               if (p->cpu !=3D cpu)
+               if (p->phys_proc_id !=3D phys_proc_id)
                        continue;

                platform_device_unregister(p->pdev);
                list_del(&p->list);
                mutex_unlock(&pdev_list_mutex);
                kfree(p);
-               for_each_cpu(i, cpu_sibling_mask(cpu))
-                       if (i !=3D cpu && !coretemp_device_add(i))
-                               break;
                return;
        }
        mutex_unlock(&pdev_list_mutex);
 }

+static void get_core_online(unsigned int cpu)
+{
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D get_pdev(c->phys_proc_id);
+
+       if (!pdev) {
+               /*
+                * We are bringing the _first_ core in this pkg
+                * online. So initialize per-pkg data structures and
+                * then bring this core online.
+                */
+               coretemp_device_add(cpu);
+               if (cpu_has(c, X86_FEATURE_PTS))
+                       add_core(cpu, 1);
+       }
+       /*
+        * Physical CPU device already exists.
+        * So, just bring this core online.
+        */
+       add_core(cpu, 0);
+}
+
+
+static void put_core_offline(unsigned int cpu)
+{
+       int indx;
+       struct platform_data *pdata;
+       struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+       struct platform_device *pdev =3D get_pdev(c->phys_proc_id);
+
+       /* If the physical CPU device does not exist, just return */
+       if (!pdev)
+               return;
+
+       pdata =3D platform_get_drvdata(pdev);
+
+       indx =3D get_core_indx(pdata, c->cpu_core_id);
+       if (indx < 0) {
+               dev_info(&pdev->dev, "Core %d does not exist\n",
+                       c->cpu_core_id);
+               return;
+       }
+
+       if (pdata->core_data[indx]->cpu =3D=3D cpu)
+               remove_core(pdata, &pdev->dev, indx);
+       else
+               dev_info(&pdev->dev, "A HT CPU (%u) is offlined\n", cpu);
+
+       /*
+        * If all cores in this pkg are offline,
+        * remove this device from the pdev_entry list and
+        * do pkg level clean ups
+        */
+       if (pdata->core_count =3D=3D 0)
+               coretemp_device_remove(c->phys_proc_id);
+}
+
 static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
                                 unsigned long action, void *hcpu)
 {
@@ -533,10 +824,10 @@ static int __cpuinit coretemp_cpu_callback(struct not=
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
@@ -546,6 +837,7 @@ static struct notifier_block coretemp_cpu_notifier __re=
fdata =3D {
        .notifier_call =3D coretemp_cpu_callback,
 };

+
 static int __init coretemp_init(void)
 {
        int i, err =3D -ENODEV;
@@ -559,7 +851,7 @@ static int __init coretemp_init(void)
                goto exit;

        for_each_online_cpu(i)
-               coretemp_device_add(i);
+               get_core_online(i);

 #ifndef CONFIG_HOTPLUG_CPU
        if (list_empty(&pdev_list)) {
--
1.7.4


--_002_D6D887BA8C9DFF48B5233887EF0465410951570349bgsmsx502garc_
Content-Type: application/octet-stream;
	name="0001-v4-Merging_pkgtemp_with_coretemp.patch"
Content-Description: 0001-v4-Merging_pkgtemp_with_coretemp.patch
Content-Disposition: attachment;
	filename="0001-v4-Merging_pkgtemp_with_coretemp.patch"; size=22587;
	creation-date="Fri, 25 Mar 2011 18:28:13 GMT";
	modification-date="Fri, 25 Mar 2011 06:25:17 GMT"
Content-Transfer-Encoding: base64

RnJvbTogRHVyZ2Fkb3NzIFIgPGR1cmdhZG9zcy5yQGludGVsLmNvbT4KRGF0ZTogVGh1LCAzIE1h
ciAyMDExIDAyOjM3OjQwICswNTMwClN1YmplY3Q6IFtQQVRDSDpod21vbjp2NDpdTWVyZ2luZ19w
a2d0ZW1wX3dpdGhfY29yZXRlbXAKClRoaXMgcGF0Y2ggbWVyZ2VzIHRoZSBwa2d0ZW1wIGRyaXZl
ciB3aXRoIHRoZSBjb3JldGVtcCBkcml2ZXIuClRoaXMgbWVyZ2VkIGRyaXZlciBjcmVhdGVzIG9u
ZSBod21vbiBkZXZpY2UgcGVyIHBoeXNpY2FsIENQVSBpLmUKcGVyIFBoeXNpY2FsIFBhY2thZ2Uu
IEFsc28sIHRoZSBzeXNmcyBpbnRlcmZhY2VzIHBlciBjb3JlIGFyZSBjcmVhdGVkCmFzIGVhY2gg
Y29yZSBjb21lcyBvbmxpbmUgYW5kIHJlbW92ZWQgd2hlbiBpdCBnb2VzIG9mZmxpbmUuCgp2MSBv
ZiB0aGlzIHBhdGNoOgpCYXNpYyBNZXJnaW5nIG9mIHBrZ3RlbXAgd2l0aCBjb3JldGVtcC4gVGhp
cyBjcmVhdGVzIG9uZSBod21vbiBkZXZpY2UKcGVyIGNvcmUuCnYyIG9mIHRoaXMgcGF0Y2g6CkZp
eGVkIHNvbWUgRGF0YSBzdHJ1Y3R1cmUgcmVsYXRlZCBjb21tZW50cyBmcm9tIHYxLiBUaGlzIGFs
c28KY3JlYXRlcyBvbmUgaHdtb24gZGV2aWNlIHBlciBjb3JlLgp2MyBvZiB0aGlzIHBhdGNoOgpU
aGlzIHZlcnNpb24gY3JlYXRlcyBvbmUgaHdtb24gZGV2aWNlIHBlciBwaHlzaWNhbCBwYWNrYWdl
LCBidXQKbm8gYXBwcm9wcmlhdGUgc3VwcG9ydCBmb3IgQ1BVIGhvdHBsdWcuCnY0IG9mIHRoaXMg
cGF0Y2g6ClRoaXMgY3JlYXRlcyBvbmUgaHdtb24gZGV2aWNlIHBlciBwYWNrYWdlLgpBZGRlZCBh
cHByb3ByaWF0ZSBzdXBwb3J0IGZvciBDT05GSUdfSE9UUExVR19DUFUuCgpTaWduZWQtb2ZmLWJ5
OiBEdXJnYWRvc3MgUiA8ZHVyZ2Fkb3NzLnJAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvaHdtb24v
Y29yZXRlbXAuYyB8ICA2MTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0NTUgaW5zZXJ0aW9ucygrKSwgMTYzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyBiL2RyaXZlcnMvaHdt
b24vY29yZXRlbXAuYwppbmRleCA0MmRlOThkLi4yNjY3ODI4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2h3bW9uL2NvcmV0ZW1wLmMKKysrIGIvZHJpdmVycy9od21vbi9jb3JldGVtcC5jCkBAIC0zOSwx
MTkgKzM5LDE0MCBAQAogCiAjZGVmaW5lIERSVk5BTUUJImNvcmV0ZW1wIgogCi10eXBlZGVmIGVu
dW0geyBTSE9XX1RFTVAsIFNIT1dfVEpNQVgsIFNIT1dfVFRBUkdFVCwgU0hPV19MQUJFTCwKLQkJ
U0hPV19OQU1FIH0gU0hPVzsKKyNkZWZpbmUgQ09SRVNfUEVSX0NQVQkJMTYJLyogTm8gb2YgUmVh
bCBDb3JlcyBwZXIgQ1BVICovCisjZGVmaW5lIENPUkVURU1QX05BTUVfTEVOR1RICTE3CS8qIFN0
cmluZyBMZW5ndGggb2YgYXR0cnMgKi8KKyNkZWZpbmUgTUFYX0FUVFJTCQk1CS8qIE1heGltdW0g
bm8gb2YgcGVyLWNvcmUgYXR0cnMgKi8KIAogLyoKLSAqIEZ1bmN0aW9ucyBkZWNsYXJhdGlvbgor
ICogUGVyLUNvcmUgVGVtcGVyYXR1cmUgRGF0YQorICogQGxhc3RfdXBkYXRlZDogVGhlIHRpbWUg
d2hlbiB0aGUgY3VycmVudCB0ZW1wZXJhdHVyZSB2YWx1ZSB3YXMgdXBkYXRlZAorICoJCWVhcmxp
ZXIgKGluIGppZmZpZXMpLgorICogQGNwdV9jb3JlX2lkOiBUaGUgQ1BVIENvcmUgZnJvbSB3aGlj
aCB0ZW1wZXJhdHVyZSB2YWx1ZXMgc2hvdWxkIGJlIHJlYWQKKyAqCQlUaGlzIHZhbHVlIGlzIHBh
c3NlZCBhcyAiaWQiIGZpZWxkIHRvIHJkbXNyL3dybXNyIGZ1bmN0aW9ucy4KKyAqIEBzdGF0dXNf
cmVnOiBPbmUgb2YgSUEzMl9USEVSTV9TVEFUVVMgb3IgSUEzMl9QQUNLQUdFX1RIRVJNX1NUQVRV
UywKKyAqCQlmcm9tIHdoZXJlIHRoZSB0ZW1wZXJhdHVyZSB2YWx1ZXMgc2hvdWxkIGJlIHJlYWQu
CisgKiBAaXNfcGtnX2RhdGE6IElmIHRoaXMgaXMgMSwgdGhlIHRlbXBfZGF0YSBob2xkcyBwa2d0
ZW1wIGRhdGEuCisgKgkJT3RoZXJ3aXNlLCB0ZW1wX2RhdGEgaG9sZHMgY29yZXRlbXAgZGF0YS4K
ICAqLwotCi1zdGF0aWMgc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmNvcmV0ZW1wX3VwZGF0ZV9kZXZp
Y2Uoc3RydWN0IGRldmljZSAqZGV2KTsKLQotc3RydWN0IGNvcmV0ZW1wX2RhdGEgewotCXN0cnVj
dCBkZXZpY2UgKmh3bW9uX2RldjsKLQlzdHJ1Y3QgbXV0ZXggdXBkYXRlX2xvY2s7Ci0JY29uc3Qg
Y2hhciAqbmFtZTsKLQl1MzIgaWQ7Ci0JdTE2IGNvcmVfaWQ7Ci0JY2hhciB2YWxpZDsJCS8qIHpl
cm8gdW50aWwgZm9sbG93aW5nIGZpZWxkcyBhcmUgdmFsaWQgKi8KLQl1bnNpZ25lZCBsb25nIGxh
c3RfdXBkYXRlZDsJLyogaW4gamlmZmllcyAqLworc3RydWN0IHRlbXBfZGF0YSB7CiAJaW50IHRl
bXA7Ci0JaW50IHRqbWF4OwogCWludCB0dGFyZ2V0OwotCXU4IGFsYXJtOworCWludCB0am1heDsK
Kwl1OCBjcml0X2FsYXJtOworCXU4IG1heF9hbGFybTsKKwl1bnNpZ25lZCBsb25nIGxhc3RfdXBk
YXRlZDsKKwl1bnNpZ25lZCBpbnQgY3B1OworCXUzMiBjcHVfY29yZV9pZDsKKwl1MzIgc3RhdHVz
X3JlZzsKKwlib29sIGlzX3BrZ19kYXRhOworCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0
ZSBzZF9hdHRyc1tNQVhfQVRUUlNdOworCWNoYXIgYXR0cl9uYW1lW01BWF9BVFRSU11bQ09SRVRF
TVBfTkFNRV9MRU5HVEhdOworCXN0cnVjdCBtdXRleCB1cGRhdGVfbG9jazsKIH07CiAKIC8qCi0g
KiBTeXNmcyBzdHVmZgorICogUGxhdGZvcm0gRGF0YSBwZXIgUGh5c2ljYWwgQ1BVCisgKiBAY29y
ZV9jb3VudDoJCU51bWJlciBvZiByZWFsIGNvcmVzKG5vdCBIVCBvbmVzKSBpbiBhIENQVQorICog
QHBoeXNfcHJvY19pZDoJVGhlIHBoeXNpY2FsIENQVSBpZAogICovCitzdHJ1Y3QgcGxhdGZvcm1f
ZGF0YSB7CisJc3RydWN0IGRldmljZSAqaHdtb25fZGV2OworCWludCBjb3JlX2NvdW50OworCXUx
NiBwaHlzX3Byb2NfaWQ7CisJc3RydWN0IHRlbXBfZGF0YSAqY29yZV9kYXRhW0NPUkVTX1BFUl9D
UFVdOworCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlIG5hbWVfYXR0cjsKK307CisKKy8qIEZ1bmN0
aW9uIERlY2xhcmF0aW9ucyAqLworc3RhdGljIHZvaWQgcmVtb3ZlX2NvcmUoc3RydWN0IHBsYXRm
b3JtX2RhdGEgKmRhdGEsIHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGkpOworCitzdGF0aWMgc3Np
emVfdCBzaG93X25hbWUoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYpCit7CisJcmV0dXJuIHNwcmludGYoYnVmLCAiJXNc
biIsIERSVk5BTUUpOworfQogCi1zdGF0aWMgc3NpemVfdCBzaG93X25hbWUoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQotCQkJICAqZGV2YXR0ciwgY2hhciAqYnVm
KQorc3RhdGljIHNzaXplX3Qgc2hvd19sYWJlbChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldmF0dHIsIGNoYXIgKmJ1ZikKIHsKLQlpbnQgcmV0Owog
CXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciA9IHRvX3NlbnNvcl9kZXZfYXR0
cihkZXZhdHRyKTsKLQlzdHJ1Y3QgY29yZXRlbXBfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOworCXN0cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOworCXN0cnVjdCB0ZW1wX2RhdGEgKnRkYXRhID0gcGRhdGEtPmNvcmVfZGF0YVthdHRyLT5p
bmRleF07CiAKLQlpZiAoYXR0ci0+aW5kZXggPT0gU0hPV19OQU1FKQotCQlyZXQgPSBzcHJpbnRm
KGJ1ZiwgIiVzXG4iLCBkYXRhLT5uYW1lKTsKLQllbHNlCS8qIHNob3cgbGFiZWwgKi8KLQkJcmV0
ID0gc3ByaW50ZihidWYsICJDb3JlICVkXG4iLCBkYXRhLT5jb3JlX2lkKTsKLQlyZXR1cm4gcmV0
OworCWlmICh0ZGF0YS0+aXNfcGtnX2RhdGEpCisJCXJldHVybiBzcHJpbnRmKGJ1ZiwgIlBoeXNp
Y2FsIGlkICVkXG4iLCBwZGF0YS0+cGh5c19wcm9jX2lkKTsKKworCXJldHVybiBzcHJpbnRmKGJ1
ZiwgIkNvcmUgJWRcbiIsIHRkYXRhLT5jcHVfY29yZV9pZCk7CiB9CiAKLXN0YXRpYyBzc2l6ZV90
IHNob3dfYWxhcm0oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQot
CQkJICAqZGV2YXR0ciwgY2hhciAqYnVmKQorc3RhdGljIHNzaXplX3Qgc2hvd19jcml0X2FsYXJt
KHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0
ciwgY2hhciAqYnVmKQogewotCXN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhID0gY29yZXRlbXBf
dXBkYXRlX2RldmljZShkZXYpOwotCS8qIHJlYWQgdGhlIE91dC1vZi1zcGVjIGxvZywgbmV2ZXIg
Y2xlYXIgKi8KLQlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+YWxhcm0pOworCXUz
MiBlYXgsIGVkeDsKKwlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKmF0dHIgPSB0b19z
ZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7CisJc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IHRlbXBfZGF0YSAqdGRhdGEgPSBwZGF0YS0+
Y29yZV9kYXRhW2F0dHItPmluZGV4XTsKKworCXJkbXNyX29uX2NwdSh0ZGF0YS0+Y3B1X2NvcmVf
aWQsIHRkYXRhLT5zdGF0dXNfcmVnLCAmZWF4LCAmZWR4KTsKKwl0ZGF0YS0+Y3JpdF9hbGFybSA9
IChlYXggPj4gNSkgJiAxOworCisJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIHRkYXRhLT5j
cml0X2FsYXJtKTsKIH0KIAotc3RhdGljIHNzaXplX3Qgc2hvd190ZW1wKHN0cnVjdCBkZXZpY2Ug
KmRldiwKLQkJCSBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwgY2hhciAqYnVmKQor
c3RhdGljIHNzaXplX3Qgc2hvd190am1heChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmRldmF0dHIsIGNoYXIgKmJ1ZikKIHsKIAlzdHJ1Y3Qgc2Vuc29y
X2RldmljZV9hdHRyaWJ1dGUgKmF0dHIgPSB0b19zZW5zb3JfZGV2X2F0dHIoZGV2YXR0cik7Ci0J
c3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEgPSBjb3JldGVtcF91cGRhdGVfZGV2aWNlKGRldik7
Ci0JaW50IGVycjsKKwlzdHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsKIAotCWlmIChhdHRyLT5pbmRleCA9PSBTSE9XX1RFTVApCi0JCWVyciA9IGRhdGEt
PnZhbGlkID8gc3ByaW50ZihidWYsICIlZFxuIiwgZGF0YS0+dGVtcCkgOiAtRUFHQUlOOwotCWVs
c2UgaWYgKGF0dHItPmluZGV4ID09IFNIT1dfVEpNQVgpCi0JCWVyciA9IHNwcmludGYoYnVmLCAi
JWRcbiIsIGRhdGEtPnRqbWF4KTsKLQllbHNlCi0JCWVyciA9IHNwcmludGYoYnVmLCAiJWRcbiIs
IGRhdGEtPnR0YXJnZXQpOwotCXJldHVybiBlcnI7CisJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRc
biIsIHBkYXRhLT5jb3JlX2RhdGFbYXR0ci0+aW5kZXhdLT50am1heCk7CiB9CiAKLXN0YXRpYyBT
RU5TT1JfREVWSUNFX0FUVFIodGVtcDFfaW5wdXQsIFNfSVJVR08sIHNob3dfdGVtcCwgTlVMTCwK
LQkJCSAgU0hPV19URU1QKTsKLXN0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIodGVtcDFfY3JpdCwg
U19JUlVHTywgc2hvd190ZW1wLCBOVUxMLAotCQkJICBTSE9XX1RKTUFYKTsKLXN0YXRpYyBTRU5T
T1JfREVWSUNFX0FUVFIodGVtcDFfbWF4LCBTX0lSVUdPLCBzaG93X3RlbXAsIE5VTEwsCi0JCQkg
IFNIT1dfVFRBUkdFVCk7Ci1zdGF0aWMgREVWSUNFX0FUVFIodGVtcDFfY3JpdF9hbGFybSwgU19J
UlVHTywgc2hvd19hbGFybSwgTlVMTCk7Ci1zdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAx
X2xhYmVsLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwsIFNIT1dfTEFCRUwpOwotc3RhdGljIFNF
TlNPUl9ERVZJQ0VfQVRUUihuYW1lLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwsIFNIT1dfTkFN
RSk7Ci0KLXN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpjb3JldGVtcF9hdHRyaWJ1dGVzW10gPSB7
Ci0JJnNlbnNvcl9kZXZfYXR0cl9uYW1lLmRldl9hdHRyLmF0dHIsCi0JJnNlbnNvcl9kZXZfYXR0
cl90ZW1wMV9sYWJlbC5kZXZfYXR0ci5hdHRyLAotCSZkZXZfYXR0cl90ZW1wMV9jcml0X2FsYXJt
LmF0dHIsCi0JJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9pbnB1dC5kZXZfYXR0ci5hdHRyLAotCSZz
ZW5zb3JfZGV2X2F0dHJfdGVtcDFfY3JpdC5kZXZfYXR0ci5hdHRyLAotCU5VTEwKLX07CitzdGF0
aWMgc3NpemVfdCBzaG93X3R0YXJnZXQoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBk
ZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYpCit7CisJc3RydWN0IHNlbnNvcl9k
ZXZpY2VfYXR0cmlidXRlICphdHRyID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRldmF0dHIpOworCXN0
cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwogCi1zdGF0
aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBjb3JldGVtcF9ncm91cCA9IHsKLQkuYXR0
cnMgPSBjb3JldGVtcF9hdHRyaWJ1dGVzLAotfTsKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxu
IiwgcGRhdGEtPmNvcmVfZGF0YVthdHRyLT5pbmRleF0tPnR0YXJnZXQpOworfQogCi1zdGF0aWMg
c3RydWN0IGNvcmV0ZW1wX2RhdGEgKmNvcmV0ZW1wX3VwZGF0ZV9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2KQorc3RhdGljIGludCB1cGRhdGVfY3Vycl90ZW1wKHN0cnVjdCB0ZW1wX2RhdGEgKnRk
YXRhLCB1MzIgZWF4LCBpbnQgdGptYXgpCiB7Ci0Jc3RydWN0IGNvcmV0ZW1wX2RhdGEgKmRhdGEg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlpbnQgZXJyID0gLUVJTlZBTDsKIAotCW11dGV4X2xv
Y2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsKKwltdXRleF9sb2NrKCZ0ZGF0YS0+dXBkYXRlX2xvY2sp
OworCS8qCisJICogVXBkYXRlIHRoZSBjdXJyZW50IHRlbXBlcmF0dXJlIG9ubHkgaWY6CisJICog
MS4gVGhlIHRpbWUgaW50ZXJ2YWwgaGFzIGVsYXBzZWQgX2FuZF8KKwkgKiAyLiBUaGUgZGF0YSBp
cyB2YWxpZAorCSAqLworCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIHRkYXRhLT5sYXN0X3VwZGF0
ZWQgKyBIWikgJiYKKwkJCQkJCShlYXggJiAweDgwMDAwMDAwKSkgeworCQl0ZGF0YS0+dGVtcCA9
IHRqbWF4IC0gKCgoZWF4ID4+IDE2KSAmIDB4N2YpICogMTAwMCk7CisJCXRkYXRhLT5sYXN0X3Vw
ZGF0ZWQgPSBqaWZmaWVzOworCQllcnIgPSAwOworCX0KIAotCWlmICghZGF0YS0+dmFsaWQgfHwg
dGltZV9hZnRlcihqaWZmaWVzLCBkYXRhLT5sYXN0X3VwZGF0ZWQgKyBIWikpIHsKLQkJdTMyIGVh
eCwgZWR4OworCW11dGV4X3VubG9jaygmdGRhdGEtPnVwZGF0ZV9sb2NrKTsKKwlyZXR1cm4gZXJy
OworfQogCi0JCWRhdGEtPnZhbGlkID0gMDsKLQkJcmRtc3Jfb25fY3B1KGRhdGEtPmlkLCBNU1Jf
SUEzMl9USEVSTV9TVEFUVVMsICZlYXgsICZlZHgpOwotCQlkYXRhLT5hbGFybSA9IChlYXggPj4g
NSkgJiAxOwotCQkvKiB1cGRhdGUgb25seSBpZiBkYXRhIGhhcyBiZWVuIHZhbGlkICovCi0JCWlm
IChlYXggJiAweDgwMDAwMDAwKSB7Ci0JCQlkYXRhLT50ZW1wID0gZGF0YS0+dGptYXggLSAoKChl
YXggPj4gMTYpCi0JCQkJCQkJJiAweDdmKSAqIDEwMDApOwotCQkJZGF0YS0+dmFsaWQgPSAxOwot
CQl9IGVsc2UgewotCQkJZGV2X2RiZyhkZXYsICJUZW1wZXJhdHVyZSBkYXRhIGludmFsaWQgKDB4
JXgpXG4iLCBlYXgpOwotCQl9Ci0JCWRhdGEtPmxhc3RfdXBkYXRlZCA9IGppZmZpZXM7Ci0JfQor
c3RhdGljIHNzaXplX3Qgc2hvd190ZW1wKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQlzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwgY2hhciAqYnVmKQoreworCXUzMiBlYXgsIGVkeDsK
KwlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKmF0dHIgPSB0b19zZW5zb3JfZGV2X2F0
dHIoZGV2YXR0cik7CisJc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhID0gZGV2X2dldF9kcnZk
YXRhKGRldik7CisJc3RydWN0IHRlbXBfZGF0YSAqdGRhdGEgPSBwZGF0YS0+Y29yZV9kYXRhW2F0
dHItPmluZGV4XTsKKwlpbnQgZXJyOwogCi0JbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9j
ayk7Ci0JcmV0dXJuIGRhdGE7CisJcmRtc3Jfb25fY3B1KHRkYXRhLT5jcHVfY29yZV9pZCwgdGRh
dGEtPnN0YXR1c19yZWcsICZlYXgsICZlZHgpOworCWVyciA9IHVwZGF0ZV9jdXJyX3RlbXAodGRh
dGEsIGVheCwgdGRhdGEtPnRqbWF4KTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gZXJyOworCisJcmV0
dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIHRkYXRhLT50ZW1wKTsKIH0KIAogc3RhdGljIGludCBf
X2RldmluaXQgYWRqdXN0X3RqbWF4KHN0cnVjdCBjcHVpbmZvX3g4NiAqYywgdTMyIGlkLCBzdHJ1
Y3QgZGV2aWNlICpkZXYpCkBAIC0yOTgsMTE1ICszMTksMjQyIEBAIHN0YXRpYyB2b2lkIF9fZGV2
aW5pdCBnZXRfdWNvZGVfcmV2X29uX2NwdSh2b2lkICplZHgpCiAJcmRtc3IoTVNSX0lBMzJfVUNP
REVfUkVWLCBlYXgsICoodTMyICopZWR4KTsKIH0KIAotc3RhdGljIGludCBfX2RldmluaXQgY29y
ZXRlbXBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3N0YXRpYyBpbnQgZ2V0
X3BrZ190am1heChpbnQgY3B1LCBzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7Ci0Jc3RydWN0IGNvcmV0
ZW1wX2RhdGEgKmRhdGE7Ci0Jc3RydWN0IGNwdWluZm9feDg2ICpjID0gJmNwdV9kYXRhKHBkZXYt
PmlkKTsKKwlpbnQgZGVmYXVsdF90am1heCA9IDEwMDAwMDsJLyogMTAwIGRlZ3JlZSBjZWxzaXVz
ICovCiAJaW50IGVycjsKLQl1MzIgZWF4LCBlZHg7CisJdTMyIGVheCwgZWR4LCB2YWw7CiAKLQlp
ZiAoIShkYXRhID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGNvcmV0ZW1wX2RhdGEpLCBHRlBfS0VS
TkVMKSkpIHsKLQkJZXJyID0gLUVOT01FTTsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiT3V0IG9m
IG1lbW9yeVxuIik7Ci0JCWdvdG8gZXhpdDsKKwllcnIgPSByZG1zcl9zYWZlX29uX2NwdShjcHUs
IE1TUl9JQTMyX1RFTVBFUkFUVVJFX1RBUkdFVCwgJmVheCwgJmVkeCk7CisJaWYgKCFlcnIpIHsK
KwkJdmFsID0gKGVheCA+PiAxNikgJiAweGZmOworCQlpZiAoKHZhbCA+IDgwKSAmJiAodmFsIDwg
MTIwKSkKKwkJCXJldHVybiB2YWwgKiAxMDAwOwogCX0KKwlkZXZfd2FybihkZXYsICJVbmFibGUg
dG8gcmVhZCBQa2ctVGpNYXggZnJvbSBDUFU6JWRcbiIsIGNwdSk7CisJcmV0dXJuIGRlZmF1bHRf
dGptYXg7Cit9CiAKLQlkYXRhLT5pZCA9IHBkZXYtPmlkOwotI2lmZGVmIENPTkZJR19TTVAKLQlk
YXRhLT5jb3JlX2lkID0gYy0+Y3B1X2NvcmVfaWQ7Ci0jZW5kaWYKLQlkYXRhLT5uYW1lID0gImNv
cmV0ZW1wIjsKLQltdXRleF9pbml0KCZkYXRhLT51cGRhdGVfbG9jayk7CitzdGF0aWMgaW50IGNy
ZWF0ZV9uYW1lX2F0dHIoc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhLCBzdHJ1Y3QgZGV2aWNl
ICpkZXYpCit7CisJcGRhdGEtPm5hbWVfYXR0ci5hdHRyLm5hbWUgPSAibmFtZSI7CisJcGRhdGEt
Pm5hbWVfYXR0ci5hdHRyLm1vZGUgPSBTX0lSVUdPOworCXBkYXRhLT5uYW1lX2F0dHIuc2hvdyA9
IHNob3dfbmFtZTsKKwlyZXR1cm4gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJnBkYXRhLT5uYW1l
X2F0dHIpOworfQogCi0JLyogdGVzdCBpZiB3ZSBjYW4gYWNjZXNzIHRoZSBUSEVSTV9TVEFUVVMg
TVNSICovCi0JZXJyID0gcmRtc3Jfc2FmZV9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RIRVJN
X1NUQVRVUywgJmVheCwgJmVkeCk7Ci0JaWYgKGVycikgewotCQlkZXZfZXJyKCZwZGV2LT5kZXYs
Ci0JCQkiVW5hYmxlIHRvIGFjY2VzcyBUSEVSTV9TVEFUVVMgTVNSLCBnaXZpbmcgdXBcbiIpOwot
CQlnb3RvIGV4aXRfZnJlZTsKK3N0YXRpYyBpbnQgY3JlYXRlX2NvcmVfYXR0cnMoc3RydWN0IHRl
bXBfZGF0YSAqdGRhdGEsIHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQlpbnQgYXR0cl9ubykKK3sK
KwlpbnQgZXJyLCBpOworCXNzaXplX3QgKCpyZF9wdHJbTUFYX0FUVFJTXSkgKHN0cnVjdCBkZXZp
Y2UgKmRldiwKKwkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRyLCBjaGFyICpidWYp
ID0geworCQkJc2hvd19sYWJlbCwgc2hvd19jcml0X2FsYXJtLCBzaG93X3R0YXJnZXQsCisJCQlz
aG93X3RlbXAsIHNob3dfdGptYXggfTsKKwljb25zdCBjaGFyICpuYW1lc1tNQVhfQVRUUlNdID0g
eyAidGVtcCVkX2xhYmVsIiwgInRlbXAlZF9jcml0X2FsYXJtIiwKKwkJCQkJInRlbXAlZF9tYXgi
LCAidGVtcCVkX2lucHV0IiwKKwkJCQkJInRlbXAlZF9jcml0IiB9OworCisJLyogSW5jcmVtZW50
IGF0dHJfbm8gc2luY2UgdGhlIHN5c2ZzIGludGVyZmFjZXMgc3RhcnQgd2l0aCB0ZW1wMV8qICov
CisJaW50IHN5c2ZzX2F0dHJfbm8gPSBhdHRyX25vICsgMTsKKworCWZvciAoaSA9IDA7IGkgPCBN
QVhfQVRUUlM7IGkrKykgeworCQlzbnByaW50Zih0ZGF0YS0+YXR0cl9uYW1lW2ldLCBDT1JFVEVN
UF9OQU1FX0xFTkdUSCwgbmFtZXNbaV0sCisJCQlzeXNmc19hdHRyX25vKTsKKwkJdGRhdGEtPnNk
X2F0dHJzW2ldLmRldl9hdHRyLmF0dHIubmFtZSA9IHRkYXRhLT5hdHRyX25hbWVbaV07CisJCXRk
YXRhLT5zZF9hdHRyc1tpXS5kZXZfYXR0ci5hdHRyLm1vZGUgPSBTX0lSVUdPOworCQl0ZGF0YS0+
c2RfYXR0cnNbaV0uZGV2X2F0dHIuc2hvdyA9IHJkX3B0cltpXTsKKwkJdGRhdGEtPnNkX2F0dHJz
W2ldLmRldl9hdHRyLnN0b3JlID0gTlVMTDsKKwkJdGRhdGEtPnNkX2F0dHJzW2ldLmluZGV4ID0g
YXR0cl9ubzsKKwkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJnRkYXRhLT5zZF9hdHRy
c1tpXS5kZXZfYXR0cik7CisJCWlmIChlcnIpCisJCQlnb3RvIGV4aXRfZnJlZTsKIAl9CisJcmV0
dXJuIDA7CisKK2V4aXRfZnJlZToKKwl3aGlsZSAoLS1pID49IDApCisJCWRldmljZV9yZW1vdmVf
ZmlsZShkZXYsICZ0ZGF0YS0+c2RfYXR0cnNbaV0uZGV2X2F0dHIpOworCXJldHVybiBlcnI7Cit9
CisKK3N0YXRpYyB2b2lkIHJlbW92ZV9hdHRycyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0
ZW1wX2RhdGEgKnRkYXRhKQoreworCWludCBpOwogCi0JLyogQ2hlY2sgaWYgd2UgaGF2ZSBwcm9i
bGVtIHdpdGggZXJyYXRhIEFFMTggb2YgQ29yZSBwcm9jZXNzb3JzOgotCSAgIFJlYWRpbmdzIG1p
Z2h0IHN0b3AgdXBkYXRlIHdoZW4gcHJvY2Vzc29yIHZpc2l0ZWQgdG9vIGRlZXAgc2xlZXAsCi0J
ICAgZml4ZWQgZm9yIHN0ZXBwaW5nIEQwICg2RUMpLgotCSovCisJLyogUmVtb3ZlIHRoZSBzeXNm
cyBhdHRyaWJ1dGVzICovCisJZm9yIChpID0gMDsgaSA8IE1BWF9BVFRSUzsgaSsrKQorCQlkZXZp
Y2VfcmVtb3ZlX2ZpbGUoZGV2LCAmdGRhdGEtPnNkX2F0dHJzW2ldLmRldl9hdHRyKTsKK30KIAor
c3RhdGljIHZvaWQgdXBkYXRlX3R0YXJnZXQoX191OCBjcHVfbW9kZWwsIHN0cnVjdCB0ZW1wX2Rh
dGEgKnRkYXRhLAorCQkJCXN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlpbnQgZXJyOworCXUzMiBl
YXgsIGVkeDsKKworCS8qCisJICogUmVhZCB0aGUgc3RpbGwgdW5kb2N1bWVudGVkIElBMzJfVEVN
UEVSQVRVUkVfVEFSR0VULiBJdCBleGlzdHMKKwkgKiBvbiBvbGRlciBDUFVzIGJ1dCBub3QgaW4g
dGhpcyByZWdpc3RlciwKKwkgKiBBdG9tcyBkb24ndCBoYXZlIGl0IGVpdGhlci4KKwkgKi8KKwlp
ZiAoKGNwdV9tb2RlbCA+IDB4ZSkgJiYgKGNwdV9tb2RlbCAhPSAweDFjKSkgeworCQllcnIgPSBy
ZG1zcl9zYWZlX29uX2NwdSh0ZGF0YS0+Y3B1X2NvcmVfaWQsCisJCQkJTVNSX0lBMzJfVEVNUEVS
QVRVUkVfVEFSR0VULCAmZWF4LCAmZWR4KTsKKwkJaWYgKGVycikgeworCQkJZGV2X3dhcm4oZGV2
LAorCQkJIlVuYWJsZSB0byByZWFkIElBMzJfVEVNUEVSQVRVUkVfVEFSR0VUIE1TUlxuIik7CisK
KwkJfSBlbHNlIHsKKwkJCXRkYXRhLT50dGFyZ2V0ID0gdGRhdGEtPnRqbWF4IC0KKwkJCQkJKCgo
ZWF4ID4+IDgpICYgMHhmZikgKiAxMDAwKTsKKwkJfQorCX0KK30KKworc3RhdGljIGludCBjaGtf
dWNvZGVfdmVyc2lvbihzdHJ1Y3QgY3B1aW5mb194ODYgKmMsCisJCQkJc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKK3sKKwlpbnQgZXJyOworCXUzMiBlZHg7CisKKwkvKgorCSAqIENoZWNr
IGlmIHdlIGhhdmUgcHJvYmxlbSB3aXRoIGVycmF0YSBBRTE4IG9mIENvcmUgcHJvY2Vzc29yczoK
KwkgKiBSZWFkaW5ncyBtaWdodCBzdG9wIHVwZGF0ZSB3aGVuIHByb2Nlc3NvciB2aXNpdGVkIHRv
byBkZWVwIHNsZWVwLAorCSAqIGZpeGVkIGZvciBzdGVwcGluZyBEMCAoNkVDKS4KKwkgKi8KIAlp
ZiAoKGMtPng4Nl9tb2RlbCA9PSAweGUpICYmIChjLT54ODZfbWFzayA8IDB4YykpIHsKIAkJLyog
Y2hlY2sgZm9yIG1pY3JvY29kZSB1cGRhdGUgKi8KLQkJZXJyID0gc21wX2NhbGxfZnVuY3Rpb25f
c2luZ2xlKGRhdGEtPmlkLCBnZXRfdWNvZGVfcmV2X29uX2NwdSwKLQkJCQkJICAgICAgICZlZHgs
IDEpOworCQllcnIgPSBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUocGRldi0+aWQsIGdldF91Y29k
ZV9yZXZfb25fY3B1LAorCQkJCQkJCQkmZWR4LCAxKTsKIAkJaWYgKGVycikgewogCQkJZGV2X2Vy
cigmcGRldi0+ZGV2LAogCQkJCSJDYW5ub3QgZGV0ZXJtaW5lIG1pY3JvY29kZSByZXZpc2lvbiBv
ZiAiCi0JCQkJIkNQVSMldSAoJWQpIVxuIiwgZGF0YS0+aWQsIGVycik7Ci0JCQllcnIgPSAtRU5P
REVWOwotCQkJZ290byBleGl0X2ZyZWU7CisJCQkJIkNQVSMldSAoJWQpIVxuIiwgcGRldi0+aWQs
IGVycik7CisJCQlyZXR1cm4gLUVOT0RFVjsKIAkJfSBlbHNlIGlmIChlZHggPCAweDM5KSB7Ci0J
CQllcnIgPSAtRU5PREVWOwogCQkJZGV2X2VycigmcGRldi0+ZGV2LAogCQkJCSJFcnJhdGEgQUUx
OCBub3QgZml4ZWQsIHVwZGF0ZSBCSU9TIG9yICIKIAkJCQkibWljcm9jb2RlIG9mIHRoZSBDUFUh
XG4iKTsKLQkJCWdvdG8gZXhpdF9mcmVlOworCQkJcmV0dXJuIC1FTk9ERVY7CiAJCX0KIAl9CisJ
cmV0dXJuIDA7Cit9CiAKLQlkYXRhLT50am1heCA9IGdldF90am1heChjLCBkYXRhLT5pZCwgJnBk
ZXYtPmRldik7Ci0JcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7CitzdGF0aWMgc3Ry
dWN0IHRlbXBfZGF0YSAqaW5pdF90ZW1wX2RhdGEoaW50IGNwdSwgaW50IGNvcmVfaWQsIGludCBw
a2dfZmxhZykKK3sKKwlzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YTsKKworCXRkYXRhID0ga3phbGxv
YyhzaXplb2Yoc3RydWN0IHRlbXBfZGF0YSksIEdGUF9LRVJORUwpOworCWlmICghdGRhdGEpCisJ
CXJldHVybiBOVUxMOworCisJdGRhdGEtPnN0YXR1c19yZWcgPSBwa2dfZmxhZyA/IE1TUl9JQTMy
X1BBQ0tBR0VfVEhFUk1fU1RBVFVTIDoKKwkJCQkJCQlNU1JfSUEzMl9USEVSTV9TVEFUVVM7CisJ
dGRhdGEtPmlzX3BrZ19kYXRhID0gcGtnX2ZsYWc7CisJdGRhdGEtPmNwdV9jb3JlX2lkID0gY29y
ZV9pZDsKKwl0ZGF0YS0+Y3B1ID0gY3B1OworCW11dGV4X2luaXQoJnRkYXRhLT51cGRhdGVfbG9j
ayk7CisJcmV0dXJuIHRkYXRhOworfQogCi0JLyoKLQkgKiByZWFkIHRoZSBzdGlsbCB1bmRvY3Vt
ZW50ZWQgSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQuIEl0IGV4aXN0cwotCSAqIG9uIG9sZGVyIENQ
VXMgYnV0IG5vdCBpbiB0aGlzIHJlZ2lzdGVyLAotCSAqIEF0b21zIGRvbid0IGhhdmUgaXQgZWl0
aGVyLgotCSAqLworc3RhdGljIGludCBjcmVhdGVfY29yZV9kYXRhKHN0cnVjdCBwbGF0Zm9ybV9k
YXRhICpwZGF0YSwKKwkJCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAorCQkJCXVuc2ln
bmVkIGludCBjcHUsIGludCBwa2dfZmxhZykKK3sKKwlzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YTsK
KwlzdHJ1Y3QgY3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEoY3B1KTsKKwl1MzIgZWF4LCBlZHg7
CisJaW50IGVycjsKKwlpbnQgY29yZV9pZCA9IGMtPmNwdV9jb3JlX2lkOwogCi0JaWYgKChjLT54
ODZfbW9kZWwgPiAweGUpICYmIChjLT54ODZfbW9kZWwgIT0gMHgxYykpIHsKLQkJZXJyID0gcmRt
c3Jfc2FmZV9vbl9jcHUoZGF0YS0+aWQsIE1TUl9JQTMyX1RFTVBFUkFUVVJFX1RBUkdFVCwKLQkJ
ICAgICZlYXgsICZlZHgpOwotCQlpZiAoZXJyKSB7Ci0JCQlkZXZfd2FybigmcGRldi0+ZGV2LCAi
VW5hYmxlIHRvIHJlYWQiCi0JCQkJCSIgSUEzMl9URU1QRVJBVFVSRV9UQVJHRVQgTVNSXG4iKTsK
LQkJfSBlbHNlIHsKLQkJCWRhdGEtPnR0YXJnZXQgPSBkYXRhLT50am1heCAtCi0JCQkJCSgoKGVh
eCA+PiA4KSAmIDB4ZmYpICogMTAwMCk7Ci0JCQllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoJnBk
ZXYtPmRldiwKLQkJCQkJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9tYXguZGV2X2F0dHIpOwotCQkJ
aWYgKGVycikKLQkJCQlnb3RvIGV4aXRfZnJlZTsKLQkJfQorCXRkYXRhID0gaW5pdF90ZW1wX2Rh
dGEoY3B1LCBjb3JlX2lkLCBwa2dfZmxhZyk7CisJaWYgKCF0ZGF0YSkKKwkJcmV0dXJuIC1FTk9N
RU07CisKKwkvKiBUZXN0IGlmIHdlIGNhbiBhY2Nlc3MgdGhlIHN0YXR1cyByZWdpc3RlciAqLwor
CWVyciA9IHJkbXNyX3NhZmVfb25fY3B1KGNvcmVfaWQsIHRkYXRhLT5zdGF0dXNfcmVnLCAmZWF4
LCAmZWR4KTsKKwlpZiAoZXJyKQorCQlnb3RvIGV4aXRfZnJlZTsKKworCS8qIENyZWF0ZSBzeXNm
cyBpbnRlcmZhY2VzICovCisJZXJyID0gY3JlYXRlX2NvcmVfYXR0cnModGRhdGEsICZwZGV2LT5k
ZXYsIHBkYXRhLT5jb3JlX2NvdW50KTsKKwlpZiAoZXJyKQorCQlnb3RvIGV4aXRfZnJlZTsKKwor
CS8qIEdldCBDcml0aWNhbCBUZW1wZXJhdHVyZSAqLworCWlmIChwa2dfZmxhZykKKwkJdGRhdGEt
PnRqbWF4ID0gZ2V0X3BrZ190am1heChwZGV2LT5pZCwgJnBkZXYtPmRldik7CisJZWxzZQorCQl0
ZGF0YS0+dGptYXggPSBnZXRfdGptYXgoYywgY29yZV9pZCwgJnBkZXYtPmRldik7CisKKwl1cGRh
dGVfdHRhcmdldChjLT54ODZfbW9kZWwsIHRkYXRhLCAmcGRldi0+ZGV2KTsKKworCXBkYXRhLT5j
b3JlX2RhdGFbcGRhdGEtPmNvcmVfY291bnRdID0gdGRhdGE7CisJcGRhdGEtPmNvcmVfY291bnQr
KzsKKworCXJldHVybiAwOworZXhpdF9mcmVlOgorCWtmcmVlKHRkYXRhKTsKKwlyZXR1cm4gZXJy
OworfQorCitzdGF0aWMgaW50IF9fZGV2aW5pdCBjb3JldGVtcF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBwbGF0Zm9ybV9kYXRhICpwZGF0YTsKKwlzdHJ1
Y3QgY3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEocGRldi0+aWQpOworCWludCBlcnI7CisKKwkv
KiBJbml0aWFsaXplIHRoZSBwZXItcGFja2FnZSBkYXRhIHN0cnVjdHVyZXMgKi8KKwlwZGF0YSA9
IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwbGF0Zm9ybV9kYXRhKSwgR0ZQX0tFUk5FTCk7CisJaWYg
KCFwZGF0YSkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJPdXQgb2YgbWVtb3J5XG4iKTsKKwkJ
cmV0dXJuIC1FTk9NRU07CiAJfQogCi0JaWYgKChlcnIgPSBzeXNmc19jcmVhdGVfZ3JvdXAoJnBk
ZXYtPmRldi5rb2JqLCAmY29yZXRlbXBfZ3JvdXApKSkKLQkJZ290byBleGl0X2RldjsKKwlwZGF0
YS0+Y29yZV9jb3VudCA9IDA7CisJcGRhdGEtPnBoeXNfcHJvY19pZCA9IGMtPnBoeXNfcHJvY19p
ZDsKIAotCWRhdGEtPmh3bW9uX2RldiA9IGh3bW9uX2RldmljZV9yZWdpc3RlcigmcGRldi0+ZGV2
KTsKLQlpZiAoSVNfRVJSKGRhdGEtPmh3bW9uX2RldikpIHsKLQkJZXJyID0gUFRSX0VSUihkYXRh
LT5od21vbl9kZXYpOwotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDbGFzcyByZWdpc3RyYXRpb24g
ZmFpbGVkICglZClcbiIsCi0JCQllcnIpOwotCQlnb3RvIGV4aXRfY2xhc3M7CisJZXJyID0gY3Jl
YXRlX25hbWVfYXR0cihwZGF0YSwgJnBkZXYtPmRldik7CisJaWYgKGVycikKKwkJZ290byBleGl0
X2ZyZWU7CisKKwkvKiBDaGVjayB0aGUgbWljcm9jb2RlIHZlcnNpb24gb2YgdGhlIENQVSAqLwor
CWVyciA9IGNoa191Y29kZV92ZXJzaW9uKGMsIHBkZXYpOworCWlmIChlcnIpCisJCWdvdG8gZXhp
dF9uYW1lOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcGRhdGEpOworCisJcGRhdGEt
Pmh3bW9uX2RldiA9IGh3bW9uX2RldmljZV9yZWdpc3RlcigmcGRldi0+ZGV2KTsKKwlpZiAoSVNf
RVJSKHBkYXRhLT5od21vbl9kZXYpKSB7CisJCWVyciA9IFBUUl9FUlIocGRhdGEtPmh3bW9uX2Rl
dik7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNsYXNzIHJlZ2lzdHJhdGlvbiBmYWlsZWQgKCVk
KVxuIiwgZXJyKTsKKwkJZ290byBleGl0X25hbWU7CiAJfQogCiAJcmV0dXJuIDA7CiAKLWV4aXRf
Y2xhc3M6Ci0Jc3lzZnNfcmVtb3ZlX2dyb3VwKCZwZGV2LT5kZXYua29iaiwgJmNvcmV0ZW1wX2dy
b3VwKTsKLWV4aXRfZGV2OgotCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2LCAmc2Vuc29y
X2Rldl9hdHRyX3RlbXAxX21heC5kZXZfYXR0cik7CitleGl0X25hbWU6CisJZGV2aWNlX3JlbW92
ZV9maWxlKCZwZGV2LT5kZXYsICZwZGF0YS0+bmFtZV9hdHRyKTsKIGV4aXRfZnJlZToKLQlrZnJl
ZShkYXRhKTsKLWV4aXQ6CisJa2ZyZWUocGRhdGEpOwogCXJldHVybiBlcnI7CiB9CiAKIHN0YXRp
YyBpbnQgX19kZXZleGl0IGNvcmV0ZW1wX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogewotCXN0cnVjdCBjb3JldGVtcF9kYXRhICpkYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRh
dGEocGRldik7CisJc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEocGRldik7CisJaW50IGk7CiAKLQlod21vbl9kZXZpY2VfdW5yZWdpc3RlcihkYXRhLT5o
d21vbl9kZXYpOwotCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRldi0+ZGV2LmtvYmosICZjb3JldGVt
cF9ncm91cCk7Ci0JZGV2aWNlX3JlbW92ZV9maWxlKCZwZGV2LT5kZXYsICZzZW5zb3JfZGV2X2F0
dHJfdGVtcDFfbWF4LmRldl9hdHRyKTsKKwlmb3IgKGkgPSBwZGF0YS0+Y29yZV9jb3VudCAtIDE7
IGkgPj0gMDsgLS1pKQorCQlyZW1vdmVfY29yZShwZGF0YSwgJnBkZXYtPmRldiwgaSk7CisKKwlk
ZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwgJnBkYXRhLT5uYW1lX2F0dHIpOworCWh3bW9u
X2RldmljZV91bnJlZ2lzdGVyKHBkYXRhLT5od21vbl9kZXYpOwogCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIE5VTEwpOwotCWtmcmVlKGRhdGEpOworCWtmcmVlKHBkYXRhKTsKIAlyZXR1cm4g
MDsKIH0KIApAQCAtNDMyLDYgKzU4MCw5NiBAQCBzdHJ1Y3QgcGRldl9lbnRyeSB7CiBzdGF0aWMg
TElTVF9IRUFEKHBkZXZfbGlzdCk7CiBzdGF0aWMgREVGSU5FX01VVEVYKHBkZXZfbGlzdF9tdXRl
eCk7CiAKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpnZXRfcGRldihpbnQgcGh5c19w
cm9jX2lkKQoreworCXN0cnVjdCBwZGV2X2VudHJ5ICpwOworCisJbXV0ZXhfbG9jaygmcGRldl9s
aXN0X211dGV4KTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnkocCwgJnBkZXZfbGlzdCwgbGlzdCkK
KwkJaWYgKHAtPnBoeXNfcHJvY19pZCA9PSBwaHlzX3Byb2NfaWQpIHsKKwkJCW11dGV4X3VubG9j
aygmcGRldl9saXN0X211dGV4KTsKKwkJCXJldHVybiBwLT5wZGV2OworCQl9CisKKwltdXRleF91
bmxvY2soJnBkZXZfbGlzdF9tdXRleCk7CisJcmV0dXJuIE5VTEw7Cit9CisKK3N0YXRpYyBpbnQg
Z2V0X2NvcmVfaW5keChzdHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGEsIGludCBjb3JlX2lkKQor
eworCWludCBpOworCisJZm9yIChpID0gMDsgaSA8IHBkYXRhLT5jb3JlX2NvdW50OyBpKyspIHsK
KwkJaWYgKHBkYXRhLT5jb3JlX2RhdGFbaV0tPmNwdV9jb3JlX2lkID09IGNvcmVfaWQgJiYKKwkJ
CSFwZGF0YS0+Y29yZV9kYXRhW2ldLT5pc19wa2dfZGF0YSkKKwkJCXJldHVybiBpOworCX0KKwly
ZXR1cm4gLUVOT0RFVjsKK30KKworc3RhdGljIHZvaWQgYWRkX2NvcmUodW5zaWduZWQgaW50IGNw
dSwgaW50IHBrZ19mbGFnKQoreworCWludCBpbmR4LCBlcnI7CisJc3RydWN0IHBsYXRmb3JtX2Rh
dGEgKnBkYXRhOworCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YShjcHUpOworCXN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBnZXRfcGRldihjLT5waHlzX3Byb2NfaWQpOwor
CisJaWYgKCFwZGV2KQorCQlyZXR1cm47CisKKwlwZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOworCisJLyogSWYgdGhpcyBjb3JlIGlzIGEgSFQgb25lLCBkbyBub3QgY3JlYXRlIGFu
eSBpbnRlcmZhY2VzICovCisJaW5keCA9IGdldF9jb3JlX2luZHgocGRhdGEsIGMtPmNwdV9jb3Jl
X2lkKTsKKwlpZiAoaW5keCA+PSAwKSB7CisJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJBIEhUIGNv
cmUgKCV1KSBpcyBvbmxpbmVkXG4iLCBjcHUpOworCQlyZXR1cm47CisJfQorCisJZXJyID0gY3Jl
YXRlX2NvcmVfZGF0YShwZGF0YSwgcGRldiwgY3B1LCBwa2dfZmxhZyk7CisJaWYgKGVycikgewor
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJPbmxpbmluZyBDb3JlICV1IG9uIFBrZyAlZCBmYWlsZWRc
biIsCisJCQljcHUsIGMtPnBoeXNfcHJvY19pZCk7CisJfQorfQorCitzdGF0aWMgdm9pZCByZW1v
dmVfY29yZShzdHJ1Y3QgcGxhdGZvcm1fZGF0YSAqcGRhdGEsIHN0cnVjdCBkZXZpY2UgKmRldiwK
KwkJCWludCBpbmR4KQoreworCWludCBpOworCWludCBtYXggPSBwZGF0YS0+Y29yZV9jb3VudCAt
IDE7CisKKwkvKiBSZW1vdmUgYWxsIHN5c2ZzIGF0dHJzIGZvciB0aGlzIGNvcmUgKi8KKwlyZW1v
dmVfYXR0cnMoZGV2LCBwZGF0YS0+Y29yZV9kYXRhW2luZHhdKTsKKworCS8qIFNoaWZ0IHRoZSBj
b3JlX2RhdGEgZWxlbWVudHMgKi8KKwlmb3IgKGkgPSBpbmR4OyBpIDwgbWF4OyBpKyspCisJCXBk
YXRhLT5jb3JlX2RhdGFbaV0gPSBwZGF0YS0+Y29yZV9kYXRhW2kgKyAxXTsKKworCS8qIEZyZWUg
dGhlIF9sYXN0XyBlbGVtZW50ICovCisJa2ZyZWUocGRhdGEtPmNvcmVfZGF0YVttYXhdKTsKKwlw
ZGF0YS0+Y29yZV9kYXRhW21heF0gPSBOVUxMOworCisJcGRhdGEtPmNvcmVfY291bnQtLTsKKwor
CS8qCisJICogSWYgY291bnQgaXMgX29ubHlfIG9uZSBhbmQgdGhlIGRldmljZSBpcyBwa2cgdGVt
cAorCSAqIHJlbW92ZSB0aG9zZSBpbnRlcmZhY2VzIGFuZCBnZXQgcmlkIG9mZiB0aGlzICdwZGV2
JyBlbnRyeQorCSAqIGluIHRoZSBwZGV2X2VudHJ5IGxpc3QuCisJICoKKwkgKiBUaGUgcGtnIHRl
bXAgaXMgYWxpdmUgYXMgbG9uZyBhcyBhdGxlYXN0IG9uZSBvZiB0aGUKKwkgKiBjb3JlcyBpbnNp
ZGUgdGhlIHBrZyBpcyBvbmxpbmUuIEFuZCBpdCBpcyByZW1vdmVkCisJICogd2hlbiBhbGwgY29y
ZXMgaW4gYSBwa2cgZ28gb2ZmbGluZS4KKwkgKi8KKwlpZiAocGRhdGEtPmNvcmVfY291bnQgPT0g
MSAmJiBwZGF0YS0+Y29yZV9kYXRhWzBdLT5pc19wa2dfZGF0YSkgeworCQlyZW1vdmVfYXR0cnMo
ZGV2LCBwZGF0YS0+Y29yZV9kYXRhWzBdKTsKKwkJa2ZyZWUocGRhdGEtPmNvcmVfZGF0YVswXSk7
CisJCXBkYXRhLT5jb3JlX2RhdGFbMF0gPSBOVUxMOworCQlwZGF0YS0+Y29yZV9jb3VudC0tOwor
CX0KK30KKwogc3RhdGljIGludCBfX2NwdWluaXQgY29yZXRlbXBfZGV2aWNlX2FkZCh1bnNpZ25l
ZCBpbnQgY3B1KQogewogCWludCBlcnI7CkBAIC01MDMsMjggKzc0MSw4MSBAQCBleGl0OgogCXJl
dHVybiBlcnI7CiB9CiAKLXN0YXRpYyB2b2lkIF9fY3B1aW5pdCBjb3JldGVtcF9kZXZpY2VfcmVt
b3ZlKHVuc2lnbmVkIGludCBjcHUpCitzdGF0aWMgdm9pZCBfX2NwdWluaXQgY29yZXRlbXBfZGV2
aWNlX3JlbW92ZShpbnQgcGh5c19wcm9jX2lkKQogewogCXN0cnVjdCBwZGV2X2VudHJ5ICpwOwot
CXVuc2lnbmVkIGludCBpOwogCiAJbXV0ZXhfbG9jaygmcGRldl9saXN0X211dGV4KTsKIAlsaXN0
X2Zvcl9lYWNoX2VudHJ5KHAsICZwZGV2X2xpc3QsIGxpc3QpIHsKLQkJaWYgKHAtPmNwdSAhPSBj
cHUpCisJCWlmIChwLT5waHlzX3Byb2NfaWQgIT0gcGh5c19wcm9jX2lkKQogCQkJY29udGludWU7
CiAKIAkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIocC0+cGRldik7CiAJCWxpc3RfZGVsKCZw
LT5saXN0KTsKIAkJbXV0ZXhfdW5sb2NrKCZwZGV2X2xpc3RfbXV0ZXgpOwogCQlrZnJlZShwKTsK
LQkJZm9yX2VhY2hfY3B1KGksIGNwdV9zaWJsaW5nX21hc2soY3B1KSkKLQkJCWlmIChpICE9IGNw
dSAmJiAhY29yZXRlbXBfZGV2aWNlX2FkZChpKSkKLQkJCQlicmVhazsKIAkJcmV0dXJuOwogCX0K
IAltdXRleF91bmxvY2soJnBkZXZfbGlzdF9tdXRleCk7CiB9CiAKK3N0YXRpYyB2b2lkIGdldF9j
b3JlX29ubGluZSh1bnNpZ25lZCBpbnQgY3B1KQoreworCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9
ICZjcHVfZGF0YShjcHUpOworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBnZXRfcGRl
dihjLT5waHlzX3Byb2NfaWQpOworCisJaWYgKCFwZGV2KSB7CisJCS8qCisJCSAqIFdlIGFyZSBi
cmluZ2luZyB0aGUgX2ZpcnN0XyBjb3JlIGluIHRoaXMgcGtnCisJCSAqIG9ubGluZS4gU28gaW5p
dGlhbGl6ZSBwZXItcGtnIGRhdGEgc3RydWN0dXJlcyBhbmQKKwkJICogdGhlbiBicmluZyB0aGlz
IGNvcmUgb25saW5lLgorCQkgKi8KKwkJY29yZXRlbXBfZGV2aWNlX2FkZChjcHUpOworCQlpZiAo
Y3B1X2hhcyhjLCBYODZfRkVBVFVSRV9QVFMpKQorCQkJYWRkX2NvcmUoY3B1LCAxKTsKKwl9CisJ
LyoKKwkgKiBQaHlzaWNhbCBDUFUgZGV2aWNlIGFscmVhZHkgZXhpc3RzLgorCSAqIFNvLCBqdXN0
IGJyaW5nIHRoaXMgY29yZSBvbmxpbmUuCisJICovCisJYWRkX2NvcmUoY3B1LCAwKTsKK30KKwor
CitzdGF0aWMgdm9pZCBwdXRfY29yZV9vZmZsaW5lKHVuc2lnbmVkIGludCBjcHUpCit7CisJaW50
IGluZHg7CisJc3RydWN0IHBsYXRmb3JtX2RhdGEgKnBkYXRhOworCXN0cnVjdCBjcHVpbmZvX3g4
NiAqYyA9ICZjcHVfZGF0YShjcHUpOworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBn
ZXRfcGRldihjLT5waHlzX3Byb2NfaWQpOworCisJLyogSWYgdGhlIHBoeXNpY2FsIENQVSBkZXZp
Y2UgZG9lcyBub3QgZXhpc3QsIGp1c3QgcmV0dXJuICovCisJaWYgKCFwZGV2KQorCQlyZXR1cm47
CisKKwlwZGF0YSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCisJaW5keCA9IGdldF9j
b3JlX2luZHgocGRhdGEsIGMtPmNwdV9jb3JlX2lkKTsKKwlpZiAoaW5keCA8IDApIHsKKwkJZGV2
X2luZm8oJnBkZXYtPmRldiwgIkNvcmUgJWQgZG9lcyBub3QgZXhpc3RcbiIsCisJCQljLT5jcHVf
Y29yZV9pZCk7CisJCXJldHVybjsKKwl9CisKKwlpZiAocGRhdGEtPmNvcmVfZGF0YVtpbmR4XS0+
Y3B1ID09IGNwdSkKKwkJcmVtb3ZlX2NvcmUocGRhdGEsICZwZGV2LT5kZXYsIGluZHgpOworCWVs
c2UKKwkJZGV2X2luZm8oJnBkZXYtPmRldiwgIkEgSFQgQ1BVICgldSkgaXMgb2ZmbGluZWRcbiIs
IGNwdSk7CisKKwkvKgorCSAqIElmIGFsbCBjb3JlcyBpbiB0aGlzIHBrZyBhcmUgb2ZmbGluZSwK
KwkgKiByZW1vdmUgdGhpcyBkZXZpY2UgZnJvbSB0aGUgcGRldl9lbnRyeSBsaXN0IGFuZAorCSAq
IGRvIHBrZyBsZXZlbCBjbGVhbiB1cHMKKwkgKi8KKwlpZiAocGRhdGEtPmNvcmVfY291bnQgPT0g
MCkKKwkJY29yZXRlbXBfZGV2aWNlX3JlbW92ZShjLT5waHlzX3Byb2NfaWQpOworfQorCiBzdGF0
aWMgaW50IF9fY3B1aW5pdCBjb3JldGVtcF9jcHVfY2FsbGJhY2soc3RydWN0IG5vdGlmaWVyX2Js
b2NrICpuZmIsCiAJCQkJIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpoY3B1KQogewpAQCAt
NTMzLDEwICs4MjQsMTAgQEAgc3RhdGljIGludCBfX2NwdWluaXQgY29yZXRlbXBfY3B1X2NhbGxi
YWNrKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmZiLAogCXN3aXRjaCAoYWN0aW9uKSB7CiAJY2Fz
ZSBDUFVfT05MSU5FOgogCWNhc2UgQ1BVX0RPV05fRkFJTEVEOgotCQljb3JldGVtcF9kZXZpY2Vf
YWRkKGNwdSk7CisJCWdldF9jb3JlX29ubGluZShjcHUpOwogCQlicmVhazsKIAljYXNlIENQVV9E
T1dOX1BSRVBBUkU6Ci0JCWNvcmV0ZW1wX2RldmljZV9yZW1vdmUoY3B1KTsKKwkJcHV0X2NvcmVf
b2ZmbGluZShjcHUpOwogCQlicmVhazsKIAl9CiAJcmV0dXJuIE5PVElGWV9PSzsKQEAgLTU0Niw2
ICs4MzcsNyBAQCBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGNvcmV0ZW1wX2NwdV9ub3Rp
ZmllciBfX3JlZmRhdGEgPSB7CiAJLm5vdGlmaWVyX2NhbGwgPSBjb3JldGVtcF9jcHVfY2FsbGJh
Y2ssCiB9OwogCisKIHN0YXRpYyBpbnQgX19pbml0IGNvcmV0ZW1wX2luaXQodm9pZCkKIHsKIAlp
bnQgaSwgZXJyID0gLUVOT0RFVjsKQEAgLTU1OSw3ICs4NTEsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBjb3JldGVtcF9pbml0KHZvaWQpCiAJCWdvdG8gZXhpdDsKIAogCWZvcl9lYWNoX29ubGluZV9j
cHUoaSkKLQkJY29yZXRlbXBfZGV2aWNlX2FkZChpKTsKKwkJZ2V0X2NvcmVfb25saW5lKGkpOwog
CiAjaWZuZGVmIENPTkZJR19IT1RQTFVHX0NQVQogCWlmIChsaXN0X2VtcHR5KCZwZGV2X2xpc3Qp
KSB7Ci0tIAoxLjcuNAoK

--_002_D6D887BA8C9DFF48B5233887EF0465410951570349bgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_002_D6D887BA8C9DFF48B5233887EF0465410951570349bgsmsx502garc_--
