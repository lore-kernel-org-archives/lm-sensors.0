From: Jon Sturm <jasturm002@aol.com>
Date: Thu, 10 Jun 2010 03:48:56 +0000
Subject: [lm-sensors] Fwd: [PATCH] drm/radeon/kms: add support for internal
Message-Id: <AANLkTinF3Td1hJjmd81NhvisRf1Jbd0svURSt_x6tVdf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Just passing this along to this list as I know a few people on this
list were waiting for the on-die sensor to be supported. A form of
this patch has been accepted into the mainline for release with
2.6.35. Any questions should be aimed at the dri-devel mailing list.


---------- Forwarded message ----------
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, Jun 2, 2010 at 11:59 AM
Subject: [PATCH] drm/radeon/kms: add support for internal thermal sensors (=
v3)
To: airlied@gmail.com, dri-devel@lists.freedesktop.org


rv6xx/rv7xx/evergreen families supported; older asics did
not have an internal thermal sensor.

Note, not all oems use the internal thermal sensor, so it's
only exposed in cases where it is used.

Note also, that most laptops use an oem specific ACPI solution for
GPU thermal information rather than using the internal thermal
sensor directly.

v2: export millidegrees celsius, use hwmon device properly.
v3: fix Kconfig

Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
---
=A0drivers/gpu/drm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
=A0drivers/gpu/drm/radeon/evergreen.c =A0 =A0 =A0 | =A0 17 ++++++
=A0drivers/gpu/drm/radeon/evergreend.h =A0 =A0 =A0| =A0 =A05 ++
=A0drivers/gpu/drm/radeon/r600.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 15 ++++++
=A0drivers/gpu/drm/radeon/r600d.h =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++
=A0drivers/gpu/drm/radeon/radeon.h =A0 =A0 =A0 =A0 =A0| =A0 13 +++++
=A0drivers/gpu/drm/radeon/radeon_atombios.c | =A0 16 ++++--
=A0drivers/gpu/drm/radeon/radeon_pm.c =A0 =A0 =A0 | =A0 82 ++++++++++++++++=
++++++++++++++
=A0drivers/gpu/drm/radeon/rv770.c =A0 =A0 =A0 =A0 =A0 | =A0 15 ++++++
=A0drivers/gpu/drm/radeon/rv770d.h =A0 =A0 =A0 =A0 =A0| =A0 =A05 ++
=A010 files changed, 170 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 88910e5..b0a1816 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -61,6 +61,7 @@ config DRM_RADEON
=A0 =A0 =A0 =A0 select DRM_KMS_HELPER
=A0 =A0 =A0 =A0 select DRM_TTM
=A0 =A0select POWER_SUPPLY
+ =A0 select HWMON
=A0 =A0help
=A0 =A0 =A0Choose this option if you have an ATI Radeon graphics card. =A0T=
here
=A0 =A0 =A0are both PCI and AGP versions. =A0You don't need to choose this =
to
diff --git a/drivers/gpu/drm/radeon/evergreen.c
b/drivers/gpu/drm/radeon/evergreen.c
index 69c4b27..0dbf490 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -39,6 +39,23 @@
=A0static void evergreen_gpu_init(struct radeon_device *rdev);
=A0void evergreen_fini(struct radeon_device *rdev);

+/* get temperature in millidegrees */
+u32 evergreen_get_temp(struct radeon_device *rdev)
+{
+ =A0 u32 temp =3D (RREG32(CG_MULT_THERMAL_STATUS) & ASIC_T_MASK) >>
+ =A0 =A0 =A0 ASIC_T_SHIFT;
+ =A0 u32 actual_temp =3D 0;
+
+ =A0 if ((temp >> 10) & 1)
+ =A0 =A0 =A0 actual_temp =3D 0;
+ =A0 else if ((temp >> 9) & 1)
+ =A0 =A0 =A0 actual_temp =3D 255;
+ =A0 else
+ =A0 =A0 =A0 actual_temp =3D (temp >> 1) & 0xff;
+
+ =A0 return actual_temp * 1000;
+}
+
=A0void evergreen_pm_misc(struct radeon_device *rdev)
=A0{
=A0 =A0int requested_index =3D rdev->pm.requested_power_state_index;
diff --git a/drivers/gpu/drm/radeon/evergreend.h
b/drivers/gpu/drm/radeon/evergreend.h
index 79683f6..50c5e97 100644
--- a/drivers/gpu/drm/radeon/evergreend.h
+++ b/drivers/gpu/drm/radeon/evergreend.h
@@ -165,6 +165,11 @@
=A0#define =A0 =A0 =A0 =A0SE_DB_BUSY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 =
<< 30)
=A0#define =A0 =A0 =A0 =A0SE_CB_BUSY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 =
<< 31)

+#define =A0 =A0CG_MULT_THERMAL_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A00x740
+#define =A0 =A0 =A0 =A0ASIC_T(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x) =
<< 16)
+#define =A0 =A0 =A0 =A0ASIC_T_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x7FF00=
00
+#define =A0 =A0 =A0 =A0ASIC_T_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A016
+
=A0#define =A0 =A0HDP_HOST_PATH_CNTL =A0 =A0 =A0 =A0 =A0 =A0 =A00x2C00
=A0#define =A0 =A0HDP_NONSURFACE_BASE =A0 =A0 =A0 =A0 =A0 =A0 0x2C04
=A0#define =A0 =A0HDP_NONSURFACE_INFO =A0 =A0 =A0 =A0 =A0 =A0 0x2C08
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index d84d7cf..dc2a3e8 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -92,6 +92,21 @@ void r600_gpu_init(struct radeon_device *rdev);
=A0void r600_fini(struct radeon_device *rdev);
=A0void r600_irq_disable(struct radeon_device *rdev);

+/* get temperature in millidegrees */
+u32 rv6xx_get_temp(struct radeon_device *rdev)
+{
+ =A0 u32 temp =3D (RREG32(CG_THERMAL_STATUS) & ASIC_T_MASK) >>
+ =A0 =A0 =A0 ASIC_T_SHIFT;
+ =A0 u32 actual_temp =3D 0;
+
+ =A0 if ((temp >> 7) & 1)
+ =A0 =A0 =A0 actual_temp =3D 0;
+ =A0 else
+ =A0 =A0 =A0 actual_temp =3D (temp >> 1) & 0xff;
+
+ =A0 return actual_temp * 1000;
+}
+
=A0void r600_pm_get_dynpm_state(struct radeon_device *rdev)
=A0{
=A0 =A0int i;
diff --git a/drivers/gpu/drm/radeon/r600d.h b/drivers/gpu/drm/radeon/r600d.h
index 0a354b5..b7318ac 100644
--- a/drivers/gpu/drm/radeon/r600d.h
+++ b/drivers/gpu/drm/radeon/r600d.h
@@ -239,6 +239,11 @@
=A0#define =A0 =A0GRBM_SOFT_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x8020
=A0#define =A0 =A0 =A0 =A0SOFT_RESET_CP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<0)

+#define =A0 =A0CG_THERMAL_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x7F4
+#define =A0 =A0 =A0 =A0ASIC_T(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x) =
<< 0)
+#define =A0 =A0 =A0 =A0ASIC_T_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1FF
+#define =A0 =A0 =A0 =A0ASIC_T_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00
+
=A0#define =A0 =A0HDP_HOST_PATH_CNTL =A0 =A0 =A0 =A0 =A0 =A0 =A00x2C00
=A0#define =A0 =A0HDP_NONSURFACE_BASE =A0 =A0 =A0 =A0 =A0 =A0 0x2C04
=A0#define =A0 =A0HDP_NONSURFACE_INFO =A0 =A0 =A0 =A0 =A0 =A0 0x2C08
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeo=
n.h
index 084221d..487798e 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -177,6 +177,9 @@ void radeon_pm_resume(struct radeon_device *rdev);
=A0void radeon_combios_get_power_modes(struct radeon_device *rdev);
=A0void radeon_atombios_get_power_modes(struct radeon_device *rdev);
=A0void radeon_atom_set_voltage(struct radeon_device *rdev, u16 level);
+extern u32 rv6xx_get_temp(struct radeon_device *rdev);
+extern u32 rv770_get_temp(struct radeon_device *rdev);
+extern u32 evergreen_get_temp(struct radeon_device *rdev);

=A0/*
=A0* Fences.
@@ -665,6 +668,13 @@ struct radeon_pm_profile {
=A0 =A0int dpms_on_cm_idx;
=A0};

+enum radeon_int_thermal_type {
+ =A0 THERMAL_TYPE_NONE,
+ =A0 THERMAL_TYPE_RV6XX,
+ =A0 THERMAL_TYPE_RV770,
+ =A0 THERMAL_TYPE_EVERGREEN,
+};
+
=A0struct radeon_voltage {
=A0 =A0enum radeon_voltage_type type;
=A0 =A0/* gpio voltage */
@@ -759,6 +769,9 @@ struct radeon_pm {
=A0 =A0enum radeon_pm_profile_type profile;
=A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 profile_index;
=A0 =A0struct radeon_pm_profile profiles[PM_PROFILE_MAX];
+ =A0 /* internal thermal controller on rv6xx+ */
+ =A0 enum radeon_int_thermal_type int_thermal_type;
+ =A0 struct device =A0 =A0 =A0 =A0 =A0 *int_hwmon_dev;
=A0};


diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c
b/drivers/gpu/drm/radeon/radeon_atombios.c
index 4305cd5..821c319 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1773,14 +1773,22 @@ void radeon_atombios_get_power_modes(struct
radeon_device *rdev)
=A0 =A0 =A0 =A0 =A0 =A0}

=A0 =A0 =A0 =A0 =A0 =A0/* add the i2c bus for thermal/fan chip */
- =A0 =A0 =A0 =A0 =A0 /* no support for internal controller yet */
=A0 =A0 =A0 =A0 =A0 =A0if (controller->ucType > 0) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((controller->ucType =3D ATOM_PP_THERMALCO=
NTROLLER_RV6xx) ||
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (controller->ucType =3D ATOM_PP_THERM=
ALCONTROLLER_RV770) ||
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (controller->ucType =3D
ATOM_PP_THERMALCONTROLLER_EVERGREEN)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (controller->ucType =3D ATOM_PP_THERMALCON=
TROLLER_RV6xx) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRM_INFO("Internal thermal controlle=
r %s fan control\n",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (controller->ucFanParameter=
s &
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ATOM_PP_FANPARAMETERS_NO=
FAN) ? "without" : "with");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.int_thermal_type =3D THERMAL=
_TYPE_RV6XX;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (controller->ucType =3D
ATOM_PP_THERMALCONTROLLER_RV770) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_INFO("Internal thermal controller=
 %s fan control\n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(controller->ucFanParamete=
rs &
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATOM_PP_FANPARAMETERS_NOF=
AN) ? "without" : "with");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.int_thermal_type =3D THERMAL=
_TYPE_RV770;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (controller->ucType =3D
ATOM_PP_THERMALCONTROLLER_EVERGREEN) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_INFO("Internal thermal controller=
 %s fan control\n",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(controller->ucFanParamete=
rs &
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATOM_PP_FANPARAMETERS_NOF=
AN) ? "without" : "with");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdev->pm.int_thermal_type =3D THERMAL=
_TYPE_EVERGREEN;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if ((controller->ucType =3D
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ATOM_PP_THERMALCONTROLLER_EX=
TERNAL_GPIO) ||
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (controller->ucType =3D
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c
b/drivers/gpu/drm/radeon/radeon_pm.c
index 0228126..3f9fd92 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -27,6 +27,8 @@
=A0#include <linux/acpi.h>
=A0#endif
=A0#include <linux/power_supply.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>

=A0#define RADEON_IDLE_LOOP_MS 100
=A0#define RADEON_RECLOCK_DELAY_MS 200
@@ -373,6 +375,82 @@ fail:
=A0static DEVICE_ATTR(power_profile, S_IRUGO | S_IWUSR,
radeon_get_pm_profile, radeon_set_pm_profile);
=A0static DEVICE_ATTR(power_method, S_IRUGO | S_IWUSR,
radeon_get_pm_method, radeon_set_pm_method);

+static ssize_t radeon_hwmon_show_temp(struct device *dev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
+{
+ =A0 struct drm_device *ddev =3D pci_get_drvdata(to_pci_dev(dev));
+ =A0 struct radeon_device *rdev =3D ddev->dev_private;
+ =A0 u32 temp;
+
+ =A0 switch (rdev->pm.int_thermal_type) {
+ =A0 case THERMAL_TYPE_RV6XX:
+ =A0 =A0 =A0 temp =3D rv6xx_get_temp(rdev);
+ =A0 =A0 =A0 break;
+ =A0 case THERMAL_TYPE_RV770:
+ =A0 =A0 =A0 temp =3D rv770_get_temp(rdev);
+ =A0 =A0 =A0 break;
+ =A0 case THERMAL_TYPE_EVERGREEN:
+ =A0 =A0 =A0 temp =3D evergreen_get_temp(rdev);
+ =A0 =A0 =A0 break;
+ =A0 default:
+ =A0 =A0 =A0 temp =3D 0;
+ =A0 =A0 =A0 break;
+ =A0 }
+
+ =A0 return snprintf(buf, PAGE_SIZE, "%d\n", temp);
+}
+
+static ssize_t radeon_hwmon_show_name(struct device *dev,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
+{
+ =A0 return sprintf(buf, "radeon\n");
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
radeon_hwmon_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, radeon_hwmon_show_name, NULL, 0);
+
+static struct attribute *hwmon_attributes[] =3D {
+ =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
+ =A0 &sensor_dev_attr_name.dev_attr.attr,
+ =A0 NULL
+};
+
+static const struct attribute_group hwmon_attrgroup =3D {
+ =A0 .attrs =3D hwmon_attributes,
+};
+
+static void radeon_hwmon_init(struct radeon_device *rdev)
+{
+ =A0 int err;
+
+ =A0 rdev->pm.int_hwmon_dev =3D NULL;
+
+ =A0 switch (rdev->pm.int_thermal_type) {
+ =A0 case THERMAL_TYPE_RV6XX:
+ =A0 case THERMAL_TYPE_RV770:
+ =A0 case THERMAL_TYPE_EVERGREEN:
+ =A0 =A0 =A0 rdev->pm.int_hwmon_dev =3D hwmon_device_register(rdev->dev);
+ =A0 =A0 =A0 dev_set_drvdata(rdev->pm.int_hwmon_dev, rdev->ddev);
+ =A0 =A0 =A0 err =3D sysfs_create_group(&rdev->pm.int_hwmon_dev->kobj,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&hwmon_attrgroup);
+ =A0 =A0 =A0 if (err)
+ =A0 =A0 =A0 =A0 =A0 DRM_ERROR("Unable to create hwmon sysfs file: %d\n", =
err);
+ =A0 =A0 =A0 break;
+ =A0 default:
+ =A0 =A0 =A0 break;
+ =A0 }
+}
+
+static void radeon_hwmon_fini(struct radeon_device *rdev)
+{
+ =A0 if (rdev->pm.int_hwmon_dev) {
+ =A0 =A0 =A0 sysfs_remove_group(&rdev->pm.int_hwmon_dev->kobj, &hwmon_attr=
group);
+ =A0 =A0 =A0 hwmon_device_unregister(rdev->pm.int_hwmon_dev);
+ =A0 }
+}
+
=A0void radeon_pm_suspend(struct radeon_device *rdev)
=A0{
=A0 =A0mutex_lock(&rdev->pm.mutex);
@@ -400,6 +478,7 @@ int radeon_pm_init(struct radeon_device *rdev)
=A0 =A0rdev->pm.dynpm_can_downclock =3D true;
=A0 =A0rdev->pm.current_sclk =3D 0;
=A0 =A0rdev->pm.current_mclk =3D 0;
+ =A0 rdev->pm.int_thermal_type =3D THERMAL_TYPE_NONE;

=A0 =A0if (rdev->bios) {
=A0 =A0 =A0 =A0if (rdev->is_atom_bios)
@@ -411,6 +490,8 @@ int radeon_pm_init(struct radeon_device *rdev)
=A0 =A0 =A0 =A0rdev->pm.current_clock_mode_index =3D -1;
=A0 =A0}

+ =A0 /* set up the internal thermal sensor if applicable */
+ =A0 radeon_hwmon_init(rdev);
=A0 =A0if (rdev->pm.num_power_states > 1) {
=A0 =A0 =A0 =A0if (rdev->pm.pm_method =3D PM_METHOD_PROFILE) {
=A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&rdev->pm.mutex);
@@ -469,6 +550,7 @@ void radeon_pm_fini(struct radeon_device *rdev)
=A0#endif
=A0 =A0}

+ =A0 radeon_hwmon_fini(rdev);
=A0 =A0if (rdev->pm.i2c_bus)
=A0 =A0 =A0 =A0radeon_i2c_destroy(rdev->pm.i2c_bus);
=A0}
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 5f76938..6bae486 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -42,6 +42,21 @@
=A0static void rv770_gpu_init(struct radeon_device *rdev);
=A0void rv770_fini(struct radeon_device *rdev);

+/* get temperature in millidegrees */
+u32 rv770_get_temp(struct radeon_device *rdev)
+{
+ =A0 u32 temp =3D (RREG32(CG_MULT_THERMAL_STATUS) & ASIC_T_MASK) >>
+ =A0 =A0 =A0 ASIC_T_SHIFT;
+ =A0 u32 actual_temp =3D 0;
+
+ =A0 if ((temp >> 9) & 1)
+ =A0 =A0 =A0 actual_temp =3D 0;
+ =A0 else
+ =A0 =A0 =A0 actual_temp =3D (temp >> 1) & 0xff;
+
+ =A0 return actual_temp * 1000;
+}
+
=A0void rv770_pm_misc(struct radeon_device *rdev)
=A0{
=A0 =A0int requested_index =3D rdev->pm.requested_power_state_index;
diff --git a/drivers/gpu/drm/radeon/rv770d.h b/drivers/gpu/drm/radeon/rv770=
d.h
index 9506f8c..fd733f2 100644
--- a/drivers/gpu/drm/radeon/rv770d.h
+++ b/drivers/gpu/drm/radeon/rv770d.h
@@ -122,6 +122,11 @@
=A0#define =A0 =A0 =A0 =A0GUI_ACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<31)
=A0#define =A0 =A0GRBM_STATUS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x8014

+#define =A0 =A0CG_MULT_THERMAL_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A00x740
+#define =A0 =A0 =A0 =A0ASIC_T(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x) =
<< 16)
+#define =A0 =A0 =A0 =A0ASIC_T_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3FF00=
00
+#define =A0 =A0 =A0 =A0ASIC_T_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A016
+
=A0#define =A0 =A0HDP_HOST_PATH_CNTL =A0 =A0 =A0 =A0 =A0 =A0 =A00x2C00
=A0#define =A0 =A0HDP_NONSURFACE_BASE =A0 =A0 =A0 =A0 =A0 =A0 0x2C04
=A0#define =A0 =A0HDP_NONSURFACE_INFO =A0 =A0 =A0 =A0 =A0 =A0 0x2C08
--
1.7.0.1

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
