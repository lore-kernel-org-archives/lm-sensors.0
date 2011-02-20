From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Feb 2011 12:19:54 +0000
Subject: [lm-sensors] [PATCH 3/4 v2] Move lis3lv02d drivers to drivers/misc
Message-Id: <20110220131954.1d5036ba@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

The lis3lv02d drivers aren't hardware monitoring drivers, so the don't
belong to drivers/hwmon. Move them to drivers/misc, short of a better
home.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
Changes since v1:
* Update file paths in MAINTAINERS.
* Move lis3lv02d documentation to Documentation/misc-devices.

Not tested due to lack of hardware.

 Documentation/hwmon/lis3lv02d          |   92 --
 Documentation/misc-devices/lis3lv02d   |   92 ++
 MAINTAINERS                            |    4=20
 drivers/hwmon/Makefile                 |    5=20
 drivers/hwmon/lis3lv02d.c              | 1000 ----------------------------=
----
 drivers/hwmon/lis3lv02d.h              |  291 ---------
 drivers/hwmon/lis3lv02d_i2c.c          |  279 --------
 drivers/hwmon/lis3lv02d_spi.c          |  144 ----
 drivers/misc/Kconfig                   |    9=20
 drivers/misc/Makefile                  |    1=20
 drivers/misc/lis3lv02d/Kconfig         |   37 +
 drivers/misc/lis3lv02d/Makefile        |    7=20
 drivers/misc/lis3lv02d/lis3lv02d.c     |  999 ++++++++++++++++++++++++++++=
+++
 drivers/misc/lis3lv02d/lis3lv02d.h     |  291 +++++++++
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |  279 ++++++++
 drivers/misc/lis3lv02d/lis3lv02d_spi.c |  144 ++++
 drivers/platform/x86/hp_accel.c        |    2=20
 17 files changed, 1862 insertions(+), 1814 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/hwmon/lis3lv02d.c	2011-02-19 16:50:32.000=
000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,1000 +0,0 @@
-/*
- *  lis3lv02d.c - ST LIS3LV02DL accelerometer driver
- *
- *  Copyright (C) 2007-2008 Yan Burman
- *  Copyright (C) 2008 Eric Piel
- *  Copyright (C) 2008-2009 Pavel Machek
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/dmi.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/input-polldev.h>
-#include <linux/delay.h>
-#include <linux/wait.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
-#include <linux/freezer.h>
-#include <linux/uaccess.h>
-#include <linux/miscdevice.h>
-#include <linux/pm_runtime.h>
-#include <asm/atomic.h>
-#include "lis3lv02d.h"
-
-#define DRIVER_NAME     "lis3lv02d"
-
-/* joystick device poll interval in milliseconds */
-#define MDPS_POLL_INTERVAL 50
-#define MDPS_POLL_MIN	   0
-#define MDPS_POLL_MAX	   2000
-
-#define LIS3_SYSFS_POWERDOWN_DELAY 5000 /* In milliseconds */
-
-#define SELFTEST_OK	       0
-#define SELFTEST_FAIL	       -1
-#define SELFTEST_IRQ	       -2
-
-#define IRQ_LINE0	       0
-#define IRQ_LINE1	       1
-
-/*
- * The sensor can also generate interrupts (DRDY) but it's pretty pointless
- * because they are generated even if the data do not change. So it's bett=
er
- * to keep the interrupt for the free-fall event. The values are updated at
- * 40Hz (at the lowest frequency), but as it can be pretty time consuming =
on
- * some low processor, we poll the sensor only at 20Hz... enough for the
- * joystick.
- */
-
-#define LIS3_PWRON_DELAY_WAI_12B	(5000)
-#define LIS3_PWRON_DELAY_WAI_8B		(3000)
-
-/*
- * LIS3LV02D spec says 1024 LSBs corresponds 1 G -> 1LSB is 1000/1024 mG
- * LIS302D spec says: 18 mG / digit
- * LIS3_ACCURACY is used to increase accuracy of the intermediate
- * calculation results.
- */
-#define LIS3_ACCURACY			1024
-/* Sensitivity values for -2G +2G scale */
-#define LIS3_SENSITIVITY_12B		((LIS3_ACCURACY * 1000) / 1024)
-#define LIS3_SENSITIVITY_8B		(18 * LIS3_ACCURACY)
-
-#define LIS3_DEFAULT_FUZZ_12B		3
-#define LIS3_DEFAULT_FLAT_12B		3
-#define LIS3_DEFAULT_FUZZ_8B		1
-#define LIS3_DEFAULT_FLAT_8B		1
-
-struct lis3lv02d lis3_dev =3D {
-	.misc_wait   =3D __WAIT_QUEUE_HEAD_INITIALIZER(lis3_dev.misc_wait),
-};
-
-EXPORT_SYMBOL_GPL(lis3_dev);
-
-/* just like param_set_int() but does sanity-check so that it won't point
- * over the axis array size
- */
-static int param_set_axis(const char *val, const struct kernel_param *kp)
-{
-	int ret =3D param_set_int(val, kp);
-	if (!ret) {
-		int val =3D *(int *)kp->arg;
-		if (val < 0)
-			val =3D -val;
-		if (!val || val > 3)
-			return -EINVAL;
-	}
-	return ret;
-}
-
-static struct kernel_param_ops param_ops_axis =3D {
-	.set =3D param_set_axis,
-	.get =3D param_get_int,
-};
-
-module_param_array_named(axes, lis3_dev.ac.as_array, axis, NULL, 0644);
-MODULE_PARM_DESC(axes, "Axis-mapping for x,y,z directions");
-
-static s16 lis3lv02d_read_8(struct lis3lv02d *lis3, int reg)
-{
-	s8 lo;
-	if (lis3->read(lis3, reg, &lo) < 0)
-		return 0;
-
-	return lo;
-}
-
-static s16 lis3lv02d_read_12(struct lis3lv02d *lis3, int reg)
-{
-	u8 lo, hi;
-
-	lis3->read(lis3, reg - 1, &lo);
-	lis3->read(lis3, reg, &hi);
-	/* In "12 bit right justified" mode, bit 6, bit 7, bit 8 =3D bit 5 */
-	return (s16)((hi << 8) | lo);
-}
-
-/**
- * lis3lv02d_get_axis - For the given axis, give the value converted
- * @axis:      1,2,3 - can also be negative
- * @hw_values: raw values returned by the hardware
- *
- * Returns the converted value.
- */
-static inline int lis3lv02d_get_axis(s8 axis, int hw_values[3])
-{
-	if (axis > 0)
-		return hw_values[axis - 1];
-	else
-		return -hw_values[-axis - 1];
-}
-
-/**
- * lis3lv02d_get_xyz - Get X, Y and Z axis values from the accelerometer
- * @lis3: pointer to the device struct
- * @x:    where to store the X axis value
- * @y:    where to store the Y axis value
- * @z:    where to store the Z axis value
- *
- * Note that 40Hz input device can eat up about 10% CPU at 800MHZ
- */
-static void lis3lv02d_get_xyz(struct lis3lv02d *lis3, int *x, int *y, int =
*z)
-{
-	int position[3];
-	int i;
-
-	if (lis3->blkread) {
-		if (lis3_dev.whoami =3D WAI_12B) {
-			u16 data[3];
-			lis3->blkread(lis3, OUTX_L, 6, (u8 *)data);
-			for (i =3D 0; i < 3; i++)
-				position[i] =3D (s16)le16_to_cpu(data[i]);
-		} else {
-			u8 data[5];
-			/* Data: x, dummy, y, dummy, z */
-			lis3->blkread(lis3, OUTX, 5, data);
-			for (i =3D 0; i < 3; i++)
-				position[i] =3D (s8)data[i * 2];
-		}
-	} else {
-		position[0] =3D lis3->read_data(lis3, OUTX);
-		position[1] =3D lis3->read_data(lis3, OUTY);
-		position[2] =3D lis3->read_data(lis3, OUTZ);
-	}
-
-	for (i =3D 0; i < 3; i++)
-		position[i] =3D (position[i] * lis3->scale) / LIS3_ACCURACY;
-
-	*x =3D lis3lv02d_get_axis(lis3->ac.x, position);
-	*y =3D lis3lv02d_get_axis(lis3->ac.y, position);
-	*z =3D lis3lv02d_get_axis(lis3->ac.z, position);
-}
-
-/* conversion btw sampling rate and the register values */
-static int lis3_12_rates[4] =3D {40, 160, 640, 2560};
-static int lis3_8_rates[2] =3D {100, 400};
-static int lis3_3dc_rates[16] =3D {0, 1, 10, 25, 50, 100, 200, 400, 1600, =
5000};
-
-/* ODR is Output Data Rate */
-static int lis3lv02d_get_odr(void)
-{
-	u8 ctrl;
-	int shift;
-
-	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
-	ctrl &=3D lis3_dev.odr_mask;
-	shift =3D ffs(lis3_dev.odr_mask) - 1;
-	return lis3_dev.odrs[(ctrl >> shift)];
-}
-
-static int lis3lv02d_set_odr(int rate)
-{
-	u8 ctrl;
-	int i, len, shift;
-
-	if (!rate)
-		return -EINVAL;
-
-	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
-	ctrl &=3D ~lis3_dev.odr_mask;
-	len =3D 1 << hweight_long(lis3_dev.odr_mask); /* # of possible values */
-	shift =3D ffs(lis3_dev.odr_mask) - 1;
-
-	for (i =3D 0; i < len; i++)
-		if (lis3_dev.odrs[i] =3D rate) {
-			lis3_dev.write(&lis3_dev, CTRL_REG1,
-					ctrl | (i << shift));
-			return 0;
-		}
-	return -EINVAL;
-}
-
-static int lis3lv02d_selftest(struct lis3lv02d *lis3, s16 results[3])
-{
-	u8 ctlreg, reg;
-	s16 x, y, z;
-	u8 selftest;
-	int ret;
-	u8 ctrl_reg_data;
-	unsigned char irq_cfg;
-
-	mutex_lock(&lis3->mutex);
-
-	irq_cfg =3D lis3->irq_cfg;
-	if (lis3_dev.whoami =3D WAI_8B) {
-		lis3->data_ready_count[IRQ_LINE0] =3D 0;
-		lis3->data_ready_count[IRQ_LINE1] =3D 0;
-
-		/* Change interrupt cfg to data ready for selftest */
-		atomic_inc(&lis3_dev.wake_thread);
-		lis3->irq_cfg =3D LIS3_IRQ1_DATA_READY | LIS3_IRQ2_DATA_READY;
-		lis3->read(lis3, CTRL_REG3, &ctrl_reg_data);
-		lis3->write(lis3, CTRL_REG3, (ctrl_reg_data &
-				~(LIS3_IRQ1_MASK | LIS3_IRQ2_MASK)) |
-				(LIS3_IRQ1_DATA_READY | LIS3_IRQ2_DATA_READY));
-	}
-
-	if (lis3_dev.whoami =3D WAI_3DC) {
-		ctlreg =3D CTRL_REG4;
-		selftest =3D CTRL4_ST0;
-	} else {
-		ctlreg =3D CTRL_REG1;
-		if (lis3_dev.whoami =3D WAI_12B)
-			selftest =3D CTRL1_ST;
-		else
-			selftest =3D CTRL1_STP;
-	}
-
-	lis3->read(lis3, ctlreg, &reg);
-	lis3->write(lis3, ctlreg, (reg | selftest));
-	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
-
-	/* Read directly to avoid axis remap */
-	x =3D lis3->read_data(lis3, OUTX);
-	y =3D lis3->read_data(lis3, OUTY);
-	z =3D lis3->read_data(lis3, OUTZ);
-
-	/* back to normal settings */
-	lis3->write(lis3, ctlreg, reg);
-	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
-
-	results[0] =3D x - lis3->read_data(lis3, OUTX);
-	results[1] =3D y - lis3->read_data(lis3, OUTY);
-	results[2] =3D z - lis3->read_data(lis3, OUTZ);
-
-	ret =3D 0;
-
-	if (lis3_dev.whoami =3D WAI_8B) {
-		/* Restore original interrupt configuration */
-		atomic_dec(&lis3_dev.wake_thread);
-		lis3->write(lis3, CTRL_REG3, ctrl_reg_data);
-		lis3->irq_cfg =3D irq_cfg;
-
-		if ((irq_cfg & LIS3_IRQ1_MASK) &&
-			lis3->data_ready_count[IRQ_LINE0] < 2) {
-			ret =3D SELFTEST_IRQ;
-			goto fail;
-		}
-
-		if ((irq_cfg & LIS3_IRQ2_MASK) &&
-			lis3->data_ready_count[IRQ_LINE1] < 2) {
-			ret =3D SELFTEST_IRQ;
-			goto fail;
-		}
-	}
-
-	if (lis3->pdata) {
-		int i;
-		for (i =3D 0; i < 3; i++) {
-			/* Check against selftest acceptance limits */
-			if ((results[i] < lis3->pdata->st_min_limits[i]) ||
-			    (results[i] > lis3->pdata->st_max_limits[i])) {
-				ret =3D SELFTEST_FAIL;
-				goto fail;
-			}
-		}
-	}
-
-	/* test passed */
-fail:
-	mutex_unlock(&lis3->mutex);
-	return ret;
-}
-
-/*
- * Order of registers in the list affects to order of the restore process.
- * Perhaps it is a good idea to set interrupt enable register as a last one
- * after all other configurations
- */
-static u8 lis3_wai8_regs[] =3D { FF_WU_CFG_1, FF_WU_THS_1, FF_WU_DURATION_=
1,
-			       FF_WU_CFG_2, FF_WU_THS_2, FF_WU_DURATION_2,
-			       CLICK_CFG, CLICK_SRC, CLICK_THSY_X, CLICK_THSZ,
-			       CLICK_TIMELIMIT, CLICK_LATENCY, CLICK_WINDOW,
-			       CTRL_REG1, CTRL_REG2, CTRL_REG3};
-
-static u8 lis3_wai12_regs[] =3D {FF_WU_CFG, FF_WU_THS_L, FF_WU_THS_H,
-			       FF_WU_DURATION, DD_CFG, DD_THSI_L, DD_THSI_H,
-			       DD_THSE_L, DD_THSE_H,
-			       CTRL_REG1, CTRL_REG3, CTRL_REG2};
-
-static inline void lis3_context_save(struct lis3lv02d *lis3)
-{
-	int i;
-	for (i =3D 0; i < lis3->regs_size; i++)
-		lis3->read(lis3, lis3->regs[i], &lis3->reg_cache[i]);
-	lis3->regs_stored =3D true;
-}
-
-static inline void lis3_context_restore(struct lis3lv02d *lis3)
-{
-	int i;
-	if (lis3->regs_stored)
-		for (i =3D 0; i < lis3->regs_size; i++)
-			lis3->write(lis3, lis3->regs[i], lis3->reg_cache[i]);
-}
-
-void lis3lv02d_poweroff(struct lis3lv02d *lis3)
-{
-	if (lis3->reg_ctrl)
-		lis3_context_save(lis3);
-	/* disable X,Y,Z axis and power down */
-	lis3->write(lis3, CTRL_REG1, 0x00);
-	if (lis3->reg_ctrl)
-		lis3->reg_ctrl(lis3, LIS3_REG_OFF);
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_poweroff);
-
-void lis3lv02d_poweron(struct lis3lv02d *lis3)
-{
-	u8 reg;
-
-	lis3->init(lis3);
-
-	/*
-	 * Common configuration
-	 * BDU: (12 bits sensors only) LSB and MSB values are not updated until
-	 *      both have been read. So the value read will always be correct.
-	 * Set BOOT bit to refresh factory tuning values.
-	 */
-	lis3->read(lis3, CTRL_REG2, &reg);
-	if (lis3->whoami =3D  WAI_12B)
-		reg |=3D CTRL2_BDU | CTRL2_BOOT;
-	else
-		reg |=3D CTRL2_BOOT_8B;
-	lis3->write(lis3, CTRL_REG2, reg);
-
-	/* LIS3 power on delay is quite long */
-	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
-
-	if (lis3->reg_ctrl)
-		lis3_context_restore(lis3);
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
-
-
-static void lis3lv02d_joystick_poll(struct input_polled_dev *pidev)
-{
-	int x, y, z;
-
-	mutex_lock(&lis3_dev.mutex);
-	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
-	input_report_abs(pidev->input, ABS_X, x);
-	input_report_abs(pidev->input, ABS_Y, y);
-	input_report_abs(pidev->input, ABS_Z, z);
-	input_sync(pidev->input);
-	mutex_unlock(&lis3_dev.mutex);
-}
-
-static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
-{
-	if (lis3_dev.pm_dev)
-		pm_runtime_get_sync(lis3_dev.pm_dev);
-
-	if (lis3_dev.pdata && lis3_dev.whoami =3D WAI_8B && lis3_dev.idev)
-		atomic_set(&lis3_dev.wake_thread, 1);
-	/*
-	 * Update coordinates for the case where poll interval is 0 and
-	 * the chip in running purely under interrupt control
-	 */
-	lis3lv02d_joystick_poll(pidev);
-}
-
-static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)
-{
-	atomic_set(&lis3_dev.wake_thread, 0);
-	if (lis3_dev.pm_dev)
-		pm_runtime_put(lis3_dev.pm_dev);
-}
-
-static irqreturn_t lis302dl_interrupt(int irq, void *dummy)
-{
-	if (!test_bit(0, &lis3_dev.misc_opened))
-		goto out;
-
-	/*
-	 * Be careful: on some HP laptops the bios force DD when on battery and
-	 * the lid is closed. This leads to interrupts as soon as a little move
-	 * is done.
-	 */
-	atomic_inc(&lis3_dev.count);
-
-	wake_up_interruptible(&lis3_dev.misc_wait);
-	kill_fasync(&lis3_dev.async_queue, SIGIO, POLL_IN);
-out:
-	if (atomic_read(&lis3_dev.wake_thread))
-		return IRQ_WAKE_THREAD;
-	return IRQ_HANDLED;
-}
-
-static void lis302dl_interrupt_handle_click(struct lis3lv02d *lis3)
-{
-	struct input_dev *dev =3D lis3->idev->input;
-	u8 click_src;
-
-	mutex_lock(&lis3->mutex);
-	lis3->read(lis3, CLICK_SRC, &click_src);
-
-	if (click_src & CLICK_SINGLE_X) {
-		input_report_key(dev, lis3->mapped_btns[0], 1);
-		input_report_key(dev, lis3->mapped_btns[0], 0);
-	}
-
-	if (click_src & CLICK_SINGLE_Y) {
-		input_report_key(dev, lis3->mapped_btns[1], 1);
-		input_report_key(dev, lis3->mapped_btns[1], 0);
-	}
-
-	if (click_src & CLICK_SINGLE_Z) {
-		input_report_key(dev, lis3->mapped_btns[2], 1);
-		input_report_key(dev, lis3->mapped_btns[2], 0);
-	}
-	input_sync(dev);
-	mutex_unlock(&lis3->mutex);
-}
-
-static inline void lis302dl_data_ready(struct lis3lv02d *lis3, int index)
-{
-	int dummy;
-
-	/* Dummy read to ack interrupt */
-	lis3lv02d_get_xyz(lis3, &dummy, &dummy, &dummy);
-	lis3->data_ready_count[index]++;
-}
-
-static irqreturn_t lis302dl_interrupt_thread1_8b(int irq, void *data)
-{
-	struct lis3lv02d *lis3 =3D data;
-	u8 irq_cfg =3D lis3->irq_cfg & LIS3_IRQ1_MASK;
-
-	if (irq_cfg =3D LIS3_IRQ1_CLICK)
-		lis302dl_interrupt_handle_click(lis3);
-	else if (unlikely(irq_cfg =3D LIS3_IRQ1_DATA_READY))
-		lis302dl_data_ready(lis3, IRQ_LINE0);
-	else
-		lis3lv02d_joystick_poll(lis3->idev);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t lis302dl_interrupt_thread2_8b(int irq, void *data)
-{
-	struct lis3lv02d *lis3 =3D data;
-	u8 irq_cfg =3D lis3->irq_cfg & LIS3_IRQ2_MASK;
-
-	if (irq_cfg =3D LIS3_IRQ2_CLICK)
-		lis302dl_interrupt_handle_click(lis3);
-	else if (unlikely(irq_cfg =3D LIS3_IRQ2_DATA_READY))
-		lis302dl_data_ready(lis3, IRQ_LINE1);
-	else
-		lis3lv02d_joystick_poll(lis3->idev);
-
-	return IRQ_HANDLED;
-}
-
-static int lis3lv02d_misc_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &lis3_dev.misc_opened))
-		return -EBUSY; /* already open */
-
-	if (lis3_dev.pm_dev)
-		pm_runtime_get_sync(lis3_dev.pm_dev);
-
-	atomic_set(&lis3_dev.count, 0);
-	return 0;
-}
-
-static int lis3lv02d_misc_release(struct inode *inode, struct file *file)
-{
-	fasync_helper(-1, file, 0, &lis3_dev.async_queue);
-	clear_bit(0, &lis3_dev.misc_opened); /* release the device */
-	if (lis3_dev.pm_dev)
-		pm_runtime_put(lis3_dev.pm_dev);
-	return 0;
-}
-
-static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
-				size_t count, loff_t *pos)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	u32 data;
-	unsigned char byte_data;
-	ssize_t retval =3D 1;
-
-	if (count < 1)
-		return -EINVAL;
-
-	add_wait_queue(&lis3_dev.misc_wait, &wait);
-	while (true) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		data =3D atomic_xchg(&lis3_dev.count, 0);
-		if (data)
-			break;
-
-		if (file->f_flags & O_NONBLOCK) {
-			retval =3D -EAGAIN;
-			goto out;
-		}
-
-		if (signal_pending(current)) {
-			retval =3D -ERESTARTSYS;
-			goto out;
-		}
-
-		schedule();
-	}
-
-	if (data < 255)
-		byte_data =3D data;
-	else
-		byte_data =3D 255;
-
-	/* make sure we are not going into copy_to_user() with
-	 * TASK_INTERRUPTIBLE state */
-	set_current_state(TASK_RUNNING);
-	if (copy_to_user(buf, &byte_data, sizeof(byte_data)))
-		retval =3D -EFAULT;
-
-out:
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&lis3_dev.misc_wait, &wait);
-
-	return retval;
-}
-
-static unsigned int lis3lv02d_misc_poll(struct file *file, poll_table *wai=
t)
-{
-	poll_wait(file, &lis3_dev.misc_wait, wait);
-	if (atomic_read(&lis3_dev.count))
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
-
-static int lis3lv02d_misc_fasync(int fd, struct file *file, int on)
-{
-	return fasync_helper(fd, file, on, &lis3_dev.async_queue);
-}
-
-static const struct file_operations lis3lv02d_misc_fops =3D {
-	.owner   =3D THIS_MODULE,
-	.llseek  =3D no_llseek,
-	.read    =3D lis3lv02d_misc_read,
-	.open    =3D lis3lv02d_misc_open,
-	.release =3D lis3lv02d_misc_release,
-	.poll    =3D lis3lv02d_misc_poll,
-	.fasync  =3D lis3lv02d_misc_fasync,
-};
-
-static struct miscdevice lis3lv02d_misc_device =3D {
-	.minor   =3D MISC_DYNAMIC_MINOR,
-	.name    =3D "freefall",
-	.fops    =3D &lis3lv02d_misc_fops,
-};
-
-int lis3lv02d_joystick_enable(void)
-{
-	struct input_dev *input_dev;
-	int err;
-	int max_val, fuzz, flat;
-	int btns[] =3D {BTN_X, BTN_Y, BTN_Z};
-
-	if (lis3_dev.idev)
-		return -EINVAL;
-
-	lis3_dev.idev =3D input_allocate_polled_device();
-	if (!lis3_dev.idev)
-		return -ENOMEM;
-
-	lis3_dev.idev->poll =3D lis3lv02d_joystick_poll;
-	lis3_dev.idev->open =3D lis3lv02d_joystick_open;
-	lis3_dev.idev->close =3D lis3lv02d_joystick_close;
-	lis3_dev.idev->poll_interval =3D MDPS_POLL_INTERVAL;
-	lis3_dev.idev->poll_interval_min =3D MDPS_POLL_MIN;
-	lis3_dev.idev->poll_interval_max =3D MDPS_POLL_MAX;
-	input_dev =3D lis3_dev.idev->input;
-
-	input_dev->name       =3D "ST LIS3LV02DL Accelerometer";
-	input_dev->phys       =3D DRIVER_NAME "/input0";
-	input_dev->id.bustype =3D BUS_HOST;
-	input_dev->id.vendor  =3D 0;
-	input_dev->dev.parent =3D &lis3_dev.pdev->dev;
-
-	set_bit(EV_ABS, input_dev->evbit);
-	max_val =3D (lis3_dev.mdps_max_val * lis3_dev.scale) / LIS3_ACCURACY;
-	if (lis3_dev.whoami =3D WAI_12B) {
-		fuzz =3D LIS3_DEFAULT_FUZZ_12B;
-		flat =3D LIS3_DEFAULT_FLAT_12B;
-	} else {
-		fuzz =3D LIS3_DEFAULT_FUZZ_8B;
-		flat =3D LIS3_DEFAULT_FLAT_8B;
-	}
-	fuzz =3D (fuzz * lis3_dev.scale) / LIS3_ACCURACY;
-	flat =3D (flat * lis3_dev.scale) / LIS3_ACCURACY;
-
-	input_set_abs_params(input_dev, ABS_X, -max_val, max_val, fuzz, flat);
-	input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
-	input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
-
-	lis3_dev.mapped_btns[0] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.x), btns);
-	lis3_dev.mapped_btns[1] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.y), btns);
-	lis3_dev.mapped_btns[2] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.z), btns);
-
-	err =3D input_register_polled_device(lis3_dev.idev);
-	if (err) {
-		input_free_polled_device(lis3_dev.idev);
-		lis3_dev.idev =3D NULL;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_joystick_enable);
-
-void lis3lv02d_joystick_disable(void)
-{
-	if (lis3_dev.irq)
-		free_irq(lis3_dev.irq, &lis3_dev);
-	if (lis3_dev.pdata && lis3_dev.pdata->irq2)
-		free_irq(lis3_dev.pdata->irq2, &lis3_dev);
-
-	if (!lis3_dev.idev)
-		return;
-
-	if (lis3_dev.irq)
-		misc_deregister(&lis3lv02d_misc_device);
-	input_unregister_polled_device(lis3_dev.idev);
-	input_free_polled_device(lis3_dev.idev);
-	lis3_dev.idev =3D NULL;
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_joystick_disable);
-
-/* Sysfs stuff */
-static void lis3lv02d_sysfs_poweron(struct lis3lv02d *lis3)
-{
-	/*
-	 * SYSFS functions are fast visitors so put-call
-	 * immediately after the get-call. However, keep
-	 * chip running for a while and schedule delayed
-	 * suspend. This way periodic sysfs calls doesn't
-	 * suffer from relatively long power up time.
-	 */
-
-	if (lis3->pm_dev) {
-		pm_runtime_get_sync(lis3->pm_dev);
-		pm_runtime_put_noidle(lis3->pm_dev);
-		pm_schedule_suspend(lis3->pm_dev, LIS3_SYSFS_POWERDOWN_DELAY);
-	}
-}
-
-static ssize_t lis3lv02d_selftest_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	s16 values[3];
-
-	static const char ok[] =3D "OK";
-	static const char fail[] =3D "FAIL";
-	static const char irq[] =3D "FAIL_IRQ";
-	const char *res;
-
-	lis3lv02d_sysfs_poweron(&lis3_dev);
-	switch (lis3lv02d_selftest(&lis3_dev, values)) {
-	case SELFTEST_FAIL:
-		res =3D fail;
-		break;
-	case SELFTEST_IRQ:
-		res =3D irq;
-		break;
-	case SELFTEST_OK:
-	default:
-		res =3D ok;
-		break;
-	}
-	return sprintf(buf, "%s %d %d %d\n", res,
-		values[0], values[1], values[2]);
-}
-
-static ssize_t lis3lv02d_position_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	int x, y, z;
-
-	lis3lv02d_sysfs_poweron(&lis3_dev);
-	mutex_lock(&lis3_dev.mutex);
-	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
-	mutex_unlock(&lis3_dev.mutex);
-	return sprintf(buf, "(%d,%d,%d)\n", x, y, z);
-}
-
-static ssize_t lis3lv02d_rate_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	lis3lv02d_sysfs_poweron(&lis3_dev);
-	return sprintf(buf, "%d\n", lis3lv02d_get_odr());
-}
-
-static ssize_t lis3lv02d_rate_set(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
-{
-	unsigned long rate;
-
-	if (strict_strtoul(buf, 0, &rate))
-		return -EINVAL;
-
-	lis3lv02d_sysfs_poweron(&lis3_dev);
-	if (lis3lv02d_set_odr(rate))
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR(selftest, S_IRUSR, lis3lv02d_selftest_show, NULL);
-static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
-static DEVICE_ATTR(rate, S_IRUGO | S_IWUSR, lis3lv02d_rate_show,
-					    lis3lv02d_rate_set);
-
-static struct attribute *lis3lv02d_attributes[] =3D {
-	&dev_attr_selftest.attr,
-	&dev_attr_position.attr,
-	&dev_attr_rate.attr,
-	NULL
-};
-
-static struct attribute_group lis3lv02d_attribute_group =3D {
-	.attrs =3D lis3lv02d_attributes
-};
-
-
-static int lis3lv02d_add_fs(struct lis3lv02d *lis3)
-{
-	lis3->pdev =3D platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
-	if (IS_ERR(lis3->pdev))
-		return PTR_ERR(lis3->pdev);
-
-	return sysfs_create_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_gro=
up);
-}
-
-int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
-{
-	sysfs_remove_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
-	platform_device_unregister(lis3->pdev);
-	if (lis3->pm_dev) {
-		/* Barrier after the sysfs remove */
-		pm_runtime_barrier(lis3->pm_dev);
-
-		/* SYSFS may have left chip running. Turn off if necessary */
-		if (!pm_runtime_suspended(lis3->pm_dev))
-			lis3lv02d_poweroff(&lis3_dev);
-
-		pm_runtime_disable(lis3->pm_dev);
-		pm_runtime_set_suspended(lis3->pm_dev);
-	}
-	kfree(lis3->reg_cache);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_remove_fs);
-
-static void lis3lv02d_8b_configure(struct lis3lv02d *dev,
-				struct lis3lv02d_platform_data *p)
-{
-	int err;
-	int ctrl2 =3D p->hipass_ctrl;
-
-	if (p->click_flags) {
-		dev->write(dev, CLICK_CFG, p->click_flags);
-		dev->write(dev, CLICK_TIMELIMIT, p->click_time_limit);
-		dev->write(dev, CLICK_LATENCY, p->click_latency);
-		dev->write(dev, CLICK_WINDOW, p->click_window);
-		dev->write(dev, CLICK_THSZ, p->click_thresh_z & 0xf);
-		dev->write(dev, CLICK_THSY_X,
-			(p->click_thresh_x & 0xf) |
-			(p->click_thresh_y << 4));
-
-		if (dev->idev) {
-			struct input_dev *input_dev =3D lis3_dev.idev->input;
-			input_set_capability(input_dev, EV_KEY, BTN_X);
-			input_set_capability(input_dev, EV_KEY, BTN_Y);
-			input_set_capability(input_dev, EV_KEY, BTN_Z);
-		}
-	}
-
-	if (p->wakeup_flags) {
-		dev->write(dev, FF_WU_CFG_1, p->wakeup_flags);
-		dev->write(dev, FF_WU_THS_1, p->wakeup_thresh & 0x7f);
-		/* pdata value + 1 to keep this backward compatible*/
-		dev->write(dev, FF_WU_DURATION_1, p->duration1 + 1);
-		ctrl2 ^=3D HP_FF_WU1; /* Xor to keep compatible with old pdata*/
-	}
-
-	if (p->wakeup_flags2) {
-		dev->write(dev, FF_WU_CFG_2, p->wakeup_flags2);
-		dev->write(dev, FF_WU_THS_2, p->wakeup_thresh2 & 0x7f);
-		/* pdata value + 1 to keep this backward compatible*/
-		dev->write(dev, FF_WU_DURATION_2, p->duration2 + 1);
-		ctrl2 ^=3D HP_FF_WU2; /* Xor to keep compatible with old pdata*/
-	}
-	/* Configure hipass filters */
-	dev->write(dev, CTRL_REG2, ctrl2);
-
-	if (p->irq2) {
-		err =3D request_threaded_irq(p->irq2,
-					NULL,
-					lis302dl_interrupt_thread2_8b,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT |
-					(p->irq_flags2 & IRQF_TRIGGER_MASK),
-					DRIVER_NAME, &lis3_dev);
-		if (err < 0)
-			pr_err("No second IRQ. Limited functionality\n");
-	}
-}
-
-/*
- * Initialise the accelerometer and the various subsystems.
- * Should be rather independent of the bus system.
- */
-int lis3lv02d_init_device(struct lis3lv02d *dev)
-{
-	int err;
-	irq_handler_t thread_fn;
-	int irq_flags =3D 0;
-
-	dev->whoami =3D lis3lv02d_read_8(dev, WHO_AM_I);
-
-	switch (dev->whoami) {
-	case WAI_12B:
-		pr_info("12 bits sensor found\n");
-		dev->read_data =3D lis3lv02d_read_12;
-		dev->mdps_max_val =3D 2048;
-		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_12B;
-		dev->odrs =3D lis3_12_rates;
-		dev->odr_mask =3D CTRL1_DF0 | CTRL1_DF1;
-		dev->scale =3D LIS3_SENSITIVITY_12B;
-		dev->regs =3D lis3_wai12_regs;
-		dev->regs_size =3D ARRAY_SIZE(lis3_wai12_regs);
-		break;
-	case WAI_8B:
-		pr_info("8 bits sensor found\n");
-		dev->read_data =3D lis3lv02d_read_8;
-		dev->mdps_max_val =3D 128;
-		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_8B;
-		dev->odrs =3D lis3_8_rates;
-		dev->odr_mask =3D CTRL1_DR;
-		dev->scale =3D LIS3_SENSITIVITY_8B;
-		dev->regs =3D lis3_wai8_regs;
-		dev->regs_size =3D ARRAY_SIZE(lis3_wai8_regs);
-		break;
-	case WAI_3DC:
-		pr_info("8 bits 3DC sensor found\n");
-		dev->read_data =3D lis3lv02d_read_8;
-		dev->mdps_max_val =3D 128;
-		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_8B;
-		dev->odrs =3D lis3_3dc_rates;
-		dev->odr_mask =3D CTRL1_ODR0|CTRL1_ODR1|CTRL1_ODR2|CTRL1_ODR3;
-		dev->scale =3D LIS3_SENSITIVITY_8B;
-		break;
-	default:
-		pr_err("unknown sensor type 0x%X\n", dev->whoami);
-		return -EINVAL;
-	}
-
-	dev->reg_cache =3D kzalloc(max(sizeof(lis3_wai8_regs),
-				     sizeof(lis3_wai12_regs)), GFP_KERNEL);
-
-	if (dev->reg_cache =3D NULL) {
-		printk(KERN_ERR DRIVER_NAME "out of memory\n");
-		return -ENOMEM;
-	}
-
-	mutex_init(&dev->mutex);
-	atomic_set(&dev->wake_thread, 0);
-
-	lis3lv02d_add_fs(dev);
-	lis3lv02d_poweron(dev);
-
-	if (dev->pm_dev) {
-		pm_runtime_set_active(dev->pm_dev);
-		pm_runtime_enable(dev->pm_dev);
-	}
-
-	if (lis3lv02d_joystick_enable())
-		pr_err("joystick initialization failed\n");
-
-	/* passing in platform specific data is purely optional and only
-	 * used by the SPI transport layer at the moment */
-	if (dev->pdata) {
-		struct lis3lv02d_platform_data *p =3D dev->pdata;
-
-		if (dev->whoami =3D WAI_8B)
-			lis3lv02d_8b_configure(dev, p);
-
-		irq_flags =3D p->irq_flags1 & IRQF_TRIGGER_MASK;
-
-		dev->irq_cfg =3D p->irq_cfg;
-		if (p->irq_cfg)
-			dev->write(dev, CTRL_REG3, p->irq_cfg);
-
-		if (p->default_rate)
-			lis3lv02d_set_odr(p->default_rate);
-	}
-
-	/* bail if we did not get an IRQ from the bus layer */
-	if (!dev->irq) {
-		pr_debug("No IRQ. Disabling /dev/freefall\n");
-		goto out;
-	}
-
-	/*
-	 * The sensor can generate interrupts for free-fall and direction
-	 * detection (distinguishable with FF_WU_SRC and DD_SRC) but to keep
-	 * the things simple and _fast_ we activate it only for free-fall, so
-	 * no need to read register (very slow with ACPI). For the same reason,
-	 * we forbid shared interrupts.
-	 *
-	 * IRQF_TRIGGER_RISING seems pointless on HP laptops because the
-	 * io-apic is not configurable (and generates a warning) but I keep it
-	 * in case of support for other hardware.
-	 */
-	if (dev->pdata && dev->whoami =3D WAI_8B)
-		thread_fn =3D lis302dl_interrupt_thread1_8b;
-	else
-		thread_fn =3D NULL;
-
-	err =3D request_threaded_irq(dev->irq, lis302dl_interrupt,
-				thread_fn,
-				IRQF_TRIGGER_RISING | IRQF_ONESHOT |
-				irq_flags,
-				DRIVER_NAME, &lis3_dev);
-
-	if (err < 0) {
-		pr_err("Cannot get IRQ\n");
-		goto out;
-	}
-
-	if (misc_register(&lis3lv02d_misc_device))
-		pr_err("misc_register failed\n");
-out:
-	return 0;
-}
-EXPORT_SYMBOL_GPL(lis3lv02d_init_device);
-
-MODULE_DESCRIPTION("ST LIS3LV02Dx three-axis digital accelerometer driver"=
);
-MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
-MODULE_LICENSE("GPL");
--- linux-2.6.38-rc5.orig/drivers/hwmon/lis3lv02d.h	2011-02-19 16:50:32.000=
000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,291 +0,0 @@
-/*
- *  lis3lv02d.h - ST LIS3LV02DL accelerometer driver
- *
- *  Copyright (C) 2007-2008 Yan Burman
- *  Copyright (C) 2008-2009 Eric Piel
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
- */
-#include <linux/platform_device.h>
-#include <linux/input-polldev.h>
-#include <linux/regulator/consumer.h>
-
-/*
- * This driver tries to support the "digital" accelerometer chips from
- * STMicroelectronics such as LIS3LV02DL, LIS302DL, LIS3L02DQ, LIS331DL,
- * LIS35DE, or LIS202DL. They are very similar in terms of programming, wi=
th
- * almost the same registers. In addition to differing on physical propert=
ies,
- * they differ on the number of axes (2/3), precision (8/12 bits), and spe=
cial
- * features (freefall detection, click...). Unfortunately, not all the
- * differences can be probed via a register.
- * They can be connected either via I=B2C or SPI.
- */
-
-#include <linux/lis3lv02d.h>
-
-enum lis3_reg {
-	WHO_AM_I	=3D 0x0F,
-	OFFSET_X	=3D 0x16,
-	OFFSET_Y	=3D 0x17,
-	OFFSET_Z	=3D 0x18,
-	GAIN_X		=3D 0x19,
-	GAIN_Y		=3D 0x1A,
-	GAIN_Z		=3D 0x1B,
-	CTRL_REG1	=3D 0x20,
-	CTRL_REG2	=3D 0x21,
-	CTRL_REG3	=3D 0x22,
-	CTRL_REG4	=3D 0x23,
-	HP_FILTER_RESET	=3D 0x23,
-	STATUS_REG	=3D 0x27,
-	OUTX_L		=3D 0x28,
-	OUTX_H		=3D 0x29,
-	OUTX		=3D 0x29,
-	OUTY_L		=3D 0x2A,
-	OUTY_H		=3D 0x2B,
-	OUTY		=3D 0x2B,
-	OUTZ_L		=3D 0x2C,
-	OUTZ_H		=3D 0x2D,
-	OUTZ		=3D 0x2D,
-};
-
-enum lis302d_reg {
-	FF_WU_CFG_1	=3D 0x30,
-	FF_WU_SRC_1	=3D 0x31,
-	FF_WU_THS_1	=3D 0x32,
-	FF_WU_DURATION_1 =3D 0x33,
-	FF_WU_CFG_2	=3D 0x34,
-	FF_WU_SRC_2	=3D 0x35,
-	FF_WU_THS_2	=3D 0x36,
-	FF_WU_DURATION_2 =3D 0x37,
-	CLICK_CFG	=3D 0x38,
-	CLICK_SRC	=3D 0x39,
-	CLICK_THSY_X	=3D 0x3B,
-	CLICK_THSZ	=3D 0x3C,
-	CLICK_TIMELIMIT	=3D 0x3D,
-	CLICK_LATENCY	=3D 0x3E,
-	CLICK_WINDOW	=3D 0x3F,
-};
-
-enum lis3lv02d_reg {
-	FF_WU_CFG	=3D 0x30,
-	FF_WU_SRC	=3D 0x31,
-	FF_WU_ACK	=3D 0x32,
-	FF_WU_THS_L	=3D 0x34,
-	FF_WU_THS_H	=3D 0x35,
-	FF_WU_DURATION	=3D 0x36,
-	DD_CFG		=3D 0x38,
-	DD_SRC		=3D 0x39,
-	DD_ACK		=3D 0x3A,
-	DD_THSI_L	=3D 0x3C,
-	DD_THSI_H	=3D 0x3D,
-	DD_THSE_L	=3D 0x3E,
-	DD_THSE_H	=3D 0x3F,
-};
-
-enum lis3_who_am_i {
-	WAI_3DC		=3D 0x33,	/* 8 bits: LIS3DC, HP3DC */
-	WAI_12B		=3D 0x3A, /* 12 bits: LIS3LV02D[LQ]... */
-	WAI_8B		=3D 0x3B, /* 8 bits: LIS[23]02D[LQ]... */
-	WAI_6B		=3D 0x52, /* 6 bits: LIS331DLF - not supported */
-};
-
-enum lis3lv02d_ctrl1_12b {
-	CTRL1_Xen	=3D 0x01,
-	CTRL1_Yen	=3D 0x02,
-	CTRL1_Zen	=3D 0x04,
-	CTRL1_ST	=3D 0x08,
-	CTRL1_DF0	=3D 0x10,
-	CTRL1_DF1	=3D 0x20,
-	CTRL1_PD0	=3D 0x40,
-	CTRL1_PD1	=3D 0x80,
-};
-
-/* Delta to ctrl1_12b version */
-enum lis3lv02d_ctrl1_8b {
-	CTRL1_STM	=3D 0x08,
-	CTRL1_STP	=3D 0x10,
-	CTRL1_FS	=3D 0x20,
-	CTRL1_PD	=3D 0x40,
-	CTRL1_DR	=3D 0x80,
-};
-
-enum lis3lv02d_ctrl1_3dc {
-	CTRL1_ODR0	=3D 0x10,
-	CTRL1_ODR1	=3D 0x20,
-	CTRL1_ODR2	=3D 0x40,
-	CTRL1_ODR3	=3D 0x80,
-};
-
-enum lis3lv02d_ctrl2 {
-	CTRL2_DAS	=3D 0x01,
-	CTRL2_SIM	=3D 0x02,
-	CTRL2_DRDY	=3D 0x04,
-	CTRL2_IEN	=3D 0x08,
-	CTRL2_BOOT	=3D 0x10,
-	CTRL2_BLE	=3D 0x20,
-	CTRL2_BDU	=3D 0x40, /* Block Data Update */
-	CTRL2_FS	=3D 0x80, /* Full Scale selection */
-};
-
-enum lis3lv02d_ctrl4_3dc {
-	CTRL4_SIM	=3D 0x01,
-	CTRL4_ST0	=3D 0x02,
-	CTRL4_ST1	=3D 0x04,
-	CTRL4_FS0	=3D 0x10,
-	CTRL4_FS1	=3D 0x20,
-};
-
-enum lis302d_ctrl2 {
-	HP_FF_WU2	=3D 0x08,
-	HP_FF_WU1	=3D 0x04,
-	CTRL2_BOOT_8B   =3D 0x40,
-};
-
-enum lis3lv02d_ctrl3 {
-	CTRL3_CFS0	=3D 0x01,
-	CTRL3_CFS1	=3D 0x02,
-	CTRL3_FDS	=3D 0x10,
-	CTRL3_HPFF	=3D 0x20,
-	CTRL3_HPDD	=3D 0x40,
-	CTRL3_ECK	=3D 0x80,
-};
-
-enum lis3lv02d_status_reg {
-	STATUS_XDA	=3D 0x01,
-	STATUS_YDA	=3D 0x02,
-	STATUS_ZDA	=3D 0x04,
-	STATUS_XYZDA	=3D 0x08,
-	STATUS_XOR	=3D 0x10,
-	STATUS_YOR	=3D 0x20,
-	STATUS_ZOR	=3D 0x40,
-	STATUS_XYZOR	=3D 0x80,
-};
-
-enum lis3lv02d_ff_wu_cfg {
-	FF_WU_CFG_XLIE	=3D 0x01,
-	FF_WU_CFG_XHIE	=3D 0x02,
-	FF_WU_CFG_YLIE	=3D 0x04,
-	FF_WU_CFG_YHIE	=3D 0x08,
-	FF_WU_CFG_ZLIE	=3D 0x10,
-	FF_WU_CFG_ZHIE	=3D 0x20,
-	FF_WU_CFG_LIR	=3D 0x40,
-	FF_WU_CFG_AOI	=3D 0x80,
-};
-
-enum lis3lv02d_ff_wu_src {
-	FF_WU_SRC_XL	=3D 0x01,
-	FF_WU_SRC_XH	=3D 0x02,
-	FF_WU_SRC_YL	=3D 0x04,
-	FF_WU_SRC_YH	=3D 0x08,
-	FF_WU_SRC_ZL	=3D 0x10,
-	FF_WU_SRC_ZH	=3D 0x20,
-	FF_WU_SRC_IA	=3D 0x40,
-};
-
-enum lis3lv02d_dd_cfg {
-	DD_CFG_XLIE	=3D 0x01,
-	DD_CFG_XHIE	=3D 0x02,
-	DD_CFG_YLIE	=3D 0x04,
-	DD_CFG_YHIE	=3D 0x08,
-	DD_CFG_ZLIE	=3D 0x10,
-	DD_CFG_ZHIE	=3D 0x20,
-	DD_CFG_LIR	=3D 0x40,
-	DD_CFG_IEND	=3D 0x80,
-};
-
-enum lis3lv02d_dd_src {
-	DD_SRC_XL	=3D 0x01,
-	DD_SRC_XH	=3D 0x02,
-	DD_SRC_YL	=3D 0x04,
-	DD_SRC_YH	=3D 0x08,
-	DD_SRC_ZL	=3D 0x10,
-	DD_SRC_ZH	=3D 0x20,
-	DD_SRC_IA	=3D 0x40,
-};
-
-enum lis3lv02d_click_src_8b {
-	CLICK_SINGLE_X	=3D 0x01,
-	CLICK_DOUBLE_X	=3D 0x02,
-	CLICK_SINGLE_Y	=3D 0x04,
-	CLICK_DOUBLE_Y	=3D 0x08,
-	CLICK_SINGLE_Z	=3D 0x10,
-	CLICK_DOUBLE_Z	=3D 0x20,
-	CLICK_IA	=3D 0x40,
-};
-
-enum lis3lv02d_reg_state {
-	LIS3_REG_OFF	=3D 0x00,
-	LIS3_REG_ON	=3D 0x01,
-};
-
-union axis_conversion {
-	struct {
-		int x, y, z;
-	};
-	int as_array[3];
-
-};
-
-struct lis3lv02d {
-	void			*bus_priv; /* used by the bus layer only */
-	struct device		*pm_dev; /* for pm_runtime purposes */
-	int (*init) (struct lis3lv02d *lis3);
-	int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
-	int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
-	int (*blkread) (struct lis3lv02d *lis3, int reg, int len, u8 *ret);
-	int (*reg_ctrl) (struct lis3lv02d *lis3, bool state);
-
-	int                     *odrs;     /* Supported output data rates */
-	u8			*regs;	   /* Regs to store / restore */
-	int			regs_size;
-	u8                      *reg_cache;
-	bool			regs_stored;
-	u8                      odr_mask;  /* ODR bit mask */
-	u8			whoami;    /* indicates measurement precision */
-	s16 (*read_data) (struct lis3lv02d *lis3, int reg);
-	int			mdps_max_val;
-	int			pwron_delay;
-	int                     scale; /*
-					* relationship between 1 LBS and mG
-					* (1/1000th of earth gravity)
-					*/
-
-	struct input_polled_dev	*idev;     /* input device */
-	struct platform_device	*pdev;     /* platform device */
-	struct regulator_bulk_data regulators[2];
-	atomic_t		count;     /* interrupt count after last read */
-	union axis_conversion	ac;        /* hw -> logical axis */
-	int			mapped_btns[3];
-
-	u32			irq;       /* IRQ number */
-	struct fasync_struct	*async_queue; /* queue for the misc device */
-	wait_queue_head_t	misc_wait; /* Wait queue for the misc device */
-	unsigned long		misc_opened; /* bit0: whether the device is open */
-	int                     data_ready_count[2];
-	atomic_t		wake_thread;
-	unsigned char           irq_cfg;
-
-	struct lis3lv02d_platform_data *pdata;	/* for passing board config */
-	struct mutex		mutex;     /* Serialize poll and selftest */
-};
-
-int lis3lv02d_init_device(struct lis3lv02d *lis3);
-int lis3lv02d_joystick_enable(void);
-void lis3lv02d_joystick_disable(void);
-void lis3lv02d_poweroff(struct lis3lv02d *lis3);
-void lis3lv02d_poweron(struct lis3lv02d *lis3);
-int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
-
-extern struct lis3lv02d lis3_dev;
--- linux-2.6.38-rc5.orig/drivers/hwmon/lis3lv02d_i2c.c	2011-02-19 16:50:32=
.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,279 +0,0 @@
-/*
- * drivers/hwmon/lis3lv02d_i2c.c
- *
- * Implements I2C interface for lis3lv02d (STMicroelectronics) acceleromet=
er.
- * Driver is based on corresponding SPI driver written by Daniel Mack
- * (lis3lv02d_spi.c (C) 2009 Daniel Mack <daniel@caiaq.de> ).
- *
- * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
- *
- * Contact: Samu Onkalo <samu.p.onkalo@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include <linux/pm_runtime.h>
-#include <linux/delay.h>
-#include "lis3lv02d.h"
-
-#define DRV_NAME 	"lis3lv02d_i2c"
-
-static const char reg_vdd[]    =3D "Vdd";
-static const char reg_vdd_io[] =3D "Vdd_IO";
-
-static int lis3_reg_ctrl(struct lis3lv02d *lis3, bool state)
-{
-	int ret;
-	if (state =3D LIS3_REG_OFF) {
-		ret =3D regulator_bulk_disable(ARRAY_SIZE(lis3->regulators),
-					lis3->regulators);
-	} else {
-		ret =3D regulator_bulk_enable(ARRAY_SIZE(lis3->regulators),
-					lis3->regulators);
-		/* Chip needs time to wakeup. Not mentioned in datasheet */
-		usleep_range(10000, 20000);
-	}
-	return ret;
-}
-
-static inline s32 lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 value)
-{
-	struct i2c_client *c =3D lis3->bus_priv;
-	return i2c_smbus_write_byte_data(c, reg, value);
-}
-
-static inline s32 lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
-{
-	struct i2c_client *c =3D lis3->bus_priv;
-	*v =3D i2c_smbus_read_byte_data(c, reg);
-	return 0;
-}
-
-static inline s32 lis3_i2c_blockread(struct lis3lv02d *lis3, int reg, int =
len,
-				u8 *v)
-{
-	struct i2c_client *c =3D lis3->bus_priv;
-	reg |=3D (1 << 7); /* 7th bit enables address auto incrementation */
-	return i2c_smbus_read_i2c_block_data(c, reg, len, v);
-}
-
-static int lis3_i2c_init(struct lis3lv02d *lis3)
-{
-	u8 reg;
-	int ret;
-
-	if (lis3->reg_ctrl)
-		lis3_reg_ctrl(lis3, LIS3_REG_ON);
-
-	lis3->read(lis3, WHO_AM_I, &reg);
-	if (reg !=3D lis3->whoami)
-		printk(KERN_ERR "lis3: power on failure\n");
-
-	/* power up the device */
-	ret =3D lis3->read(lis3, CTRL_REG1, &reg);
-	if (ret < 0)
-		return ret;
-
-	reg |=3D CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
-	return lis3->write(lis3, CTRL_REG1, reg);
-}
-
-/* Default axis mapping but it can be overwritten by platform data */
-static union axis_conversion lis3lv02d_axis_map -	{ .as_array =3D { LIS3_D=
EV_X, LIS3_DEV_Y, LIS3_DEV_Z } };
-
-static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
-{
-	int ret =3D 0;
-	struct lis3lv02d_platform_data *pdata =3D client->dev.platform_data;
-
-	if (pdata) {
-		/* Regulator control is optional */
-		if (pdata->driver_features & LIS3_USE_REGULATOR_CTRL)
-			lis3_dev.reg_ctrl =3D lis3_reg_ctrl;
-
-		if ((pdata->driver_features & LIS3_USE_BLOCK_READ) &&
-			(i2c_check_functionality(client->adapter,
-						I2C_FUNC_SMBUS_I2C_BLOCK)))
-			lis3_dev.blkread  =3D lis3_i2c_blockread;
-
-		if (pdata->axis_x)
-			lis3lv02d_axis_map.x =3D pdata->axis_x;
-
-		if (pdata->axis_y)
-			lis3lv02d_axis_map.y =3D pdata->axis_y;
-
-		if (pdata->axis_z)
-			lis3lv02d_axis_map.z =3D pdata->axis_z;
-
-		if (pdata->setup_resources)
-			ret =3D pdata->setup_resources();
-
-		if (ret)
-			goto fail;
-	}
-
-	if (lis3_dev.reg_ctrl) {
-		lis3_dev.regulators[0].supply =3D reg_vdd;
-		lis3_dev.regulators[1].supply =3D reg_vdd_io;
-		ret =3D regulator_bulk_get(&client->dev,
-					ARRAY_SIZE(lis3_dev.regulators),
-					lis3_dev.regulators);
-		if (ret < 0)
-			goto fail;
-	}
-
-	lis3_dev.pdata	  =3D pdata;
-	lis3_dev.bus_priv =3D client;
-	lis3_dev.init	  =3D lis3_i2c_init;
-	lis3_dev.read	  =3D lis3_i2c_read;
-	lis3_dev.write	  =3D lis3_i2c_write;
-	lis3_dev.irq	  =3D client->irq;
-	lis3_dev.ac	  =3D lis3lv02d_axis_map;
-	lis3_dev.pm_dev	  =3D &client->dev;
-
-	i2c_set_clientdata(client, &lis3_dev);
-
-	/* Provide power over the init call */
-	if (lis3_dev.reg_ctrl)
-		lis3_reg_ctrl(&lis3_dev, LIS3_REG_ON);
-
-	ret =3D lis3lv02d_init_device(&lis3_dev);
-
-	if (lis3_dev.reg_ctrl)
-		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
-
-	if (ret =3D 0)
-		return 0;
-fail:
-	if (pdata && pdata->release_resources)
-		pdata->release_resources();
-	return ret;
-}
-
-static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
-{
-	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
-	struct lis3lv02d_platform_data *pdata =3D client->dev.platform_data;
-
-	if (pdata && pdata->release_resources)
-		pdata->release_resources();
-
-	lis3lv02d_joystick_disable();
-	lis3lv02d_remove_fs(&lis3_dev);
-
-	if (lis3_dev.reg_ctrl)
-		regulator_bulk_free(ARRAY_SIZE(lis3->regulators),
-				lis3_dev.regulators);
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int lis3lv02d_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
-	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
-
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
-		lis3lv02d_poweroff(lis3);
-	return 0;
-}
-
-static int lis3lv02d_i2c_resume(struct device *dev)
-{
-	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
-	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
-
-	/*
-	 * pm_runtime documentation says that devices should always
-	 * be powered on at resume. Pm_runtime turns them off after system
-	 * wide resume is complete.
-	 */
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
-		pm_runtime_suspended(dev))
-		lis3lv02d_poweron(lis3);
-
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_PM_RUNTIME
-static int lis3_i2c_runtime_suspend(struct device *dev)
-{
-	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
-	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
-
-	lis3lv02d_poweroff(lis3);
-	return 0;
-}
-
-static int lis3_i2c_runtime_resume(struct device *dev)
-{
-	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
-	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
-
-	lis3lv02d_poweron(lis3);
-	return 0;
-}
-#endif /* CONFIG_PM_RUNTIME */
-
-static const struct i2c_device_id lis3lv02d_id[] =3D {
-	{"lis3lv02d", 0 },
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, lis3lv02d_id);
-
-static const struct dev_pm_ops lis3_pm_ops =3D {
-	SET_SYSTEM_SLEEP_PM_OPS(lis3lv02d_i2c_suspend,
-				lis3lv02d_i2c_resume)
-	SET_RUNTIME_PM_OPS(lis3_i2c_runtime_suspend,
-			   lis3_i2c_runtime_resume,
-			   NULL)
-};
-
-static struct i2c_driver lis3lv02d_i2c_driver =3D {
-	.driver	 =3D {
-		.name   =3D DRV_NAME,
-		.owner  =3D THIS_MODULE,
-		.pm     =3D &lis3_pm_ops,
-	},
-	.probe	=3D lis3lv02d_i2c_probe,
-	.remove	=3D __devexit_p(lis3lv02d_i2c_remove),
-	.id_table =3D lis3lv02d_id,
-};
-
-static int __init lis3lv02d_init(void)
-{
-	return i2c_add_driver(&lis3lv02d_i2c_driver);
-}
-
-static void __exit lis3lv02d_exit(void)
-{
-	i2c_del_driver(&lis3lv02d_i2c_driver);
-}
-
-MODULE_AUTHOR("Nokia Corporation");
-MODULE_DESCRIPTION("lis3lv02d I2C interface");
-MODULE_LICENSE("GPL");
-
-module_init(lis3lv02d_init);
-module_exit(lis3lv02d_exit);
--- linux-2.6.38-rc5.orig/drivers/hwmon/lis3lv02d_spi.c	2011-02-19 16:50:32=
.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,144 +0,0 @@
-/*
- * lis3lv02d_spi - SPI glue layer for lis3lv02d
- *
- * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  publishhed by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
-#include <linux/spi/spi.h>
-
-#include "lis3lv02d.h"
-
-#define DRV_NAME 	"lis3lv02d_spi"
-#define LIS3_SPI_READ	0x80
-
-static int lis3_spi_read(struct lis3lv02d *lis3, int reg, u8 *v)
-{
-	struct spi_device *spi =3D lis3->bus_priv;
-	int ret =3D spi_w8r8(spi, reg | LIS3_SPI_READ);
-	if (ret < 0)
-		return -EINVAL;
-
-	*v =3D (u8) ret;
-	return 0;
-}
-
-static int lis3_spi_write(struct lis3lv02d *lis3, int reg, u8 val)
-{
-	u8 tmp[2] =3D { reg, val };
-	struct spi_device *spi =3D lis3->bus_priv;
-	return spi_write(spi, tmp, sizeof(tmp));
-}
-
-static int lis3_spi_init(struct lis3lv02d *lis3)
-{
-	u8 reg;
-	int ret;
-
-	/* power up the device */
-	ret =3D lis3->read(lis3, CTRL_REG1, &reg);
-	if (ret < 0)
-		return ret;
-
-	reg |=3D CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
-	return lis3->write(lis3, CTRL_REG1, reg);
-}
-
-static union axis_conversion lis3lv02d_axis_normal -	{ .as_array =3D { 1, =
2, 3 } };
-
-static int __devinit lis302dl_spi_probe(struct spi_device *spi)
-{
-	int ret;
-
-	spi->bits_per_word =3D 8;
-	spi->mode =3D SPI_MODE_0;
-	ret =3D spi_setup(spi);
-	if (ret < 0)
-		return ret;
-
-	lis3_dev.bus_priv	=3D spi;
-	lis3_dev.init		=3D lis3_spi_init;
-	lis3_dev.read		=3D lis3_spi_read;
-	lis3_dev.write		=3D lis3_spi_write;
-	lis3_dev.irq		=3D spi->irq;
-	lis3_dev.ac		=3D lis3lv02d_axis_normal;
-	lis3_dev.pdata		=3D spi->dev.platform_data;
-	spi_set_drvdata(spi, &lis3_dev);
-
-	return lis3lv02d_init_device(&lis3_dev);
-}
-
-static int __devexit lis302dl_spi_remove(struct spi_device *spi)
-{
-	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
-	lis3lv02d_joystick_disable();
-	lis3lv02d_poweroff(lis3);
-
-	return lis3lv02d_remove_fs(&lis3_dev);
-}
-
-#ifdef CONFIG_PM
-static int lis3lv02d_spi_suspend(struct spi_device *spi, pm_message_t mesg)
-{
-	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
-
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
-		lis3lv02d_poweroff(&lis3_dev);
-
-	return 0;
-}
-
-static int lis3lv02d_spi_resume(struct spi_device *spi)
-{
-	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
-
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
-		lis3lv02d_poweron(lis3);
-
-	return 0;
-}
-
-#else
-#define lis3lv02d_spi_suspend	NULL
-#define lis3lv02d_spi_resume	NULL
-#endif
-
-static struct spi_driver lis302dl_spi_driver =3D {
-	.driver	 =3D {
-		.name   =3D DRV_NAME,
-		.owner  =3D THIS_MODULE,
-	},
-	.probe	=3D lis302dl_spi_probe,
-	.remove	=3D __devexit_p(lis302dl_spi_remove),
-	.suspend =3D lis3lv02d_spi_suspend,
-	.resume  =3D lis3lv02d_spi_resume,
-};
-
-static int __init lis302dl_init(void)
-{
-	return spi_register_driver(&lis302dl_spi_driver);
-}
-
-static void __exit lis302dl_exit(void)
-{
-	spi_unregister_driver(&lis302dl_spi_driver);
-}
-
-module_init(lis302dl_init);
-module_exit(lis302dl_exit);
-
-MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("lis3lv02d SPI glue layer");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:" DRV_NAME);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/lis3lv02d.c	2011-02-20 13:08:00=
.000000000 +0100
@@ -0,0 +1,999 @@
+/*
+ *  lis3lv02d.c - ST LIS3LV02DL accelerometer driver
+ *
+ *  Copyright (C) 2007-2008 Yan Burman
+ *  Copyright (C) 2008 Eric Piel
+ *  Copyright (C) 2008-2009 Pavel Machek
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/dmi.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/input-polldev.h>
+#include <linux/delay.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/freezer.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/pm_runtime.h>
+#include <linux/atomic.h>
+#include "lis3lv02d.h"
+
+#define DRIVER_NAME     "lis3lv02d"
+
+/* joystick device poll interval in milliseconds */
+#define MDPS_POLL_INTERVAL 50
+#define MDPS_POLL_MIN	   0
+#define MDPS_POLL_MAX	   2000
+
+#define LIS3_SYSFS_POWERDOWN_DELAY 5000 /* In milliseconds */
+
+#define SELFTEST_OK	       0
+#define SELFTEST_FAIL	       -1
+#define SELFTEST_IRQ	       -2
+
+#define IRQ_LINE0	       0
+#define IRQ_LINE1	       1
+
+/*
+ * The sensor can also generate interrupts (DRDY) but it's pretty pointless
+ * because they are generated even if the data do not change. So it's bett=
er
+ * to keep the interrupt for the free-fall event. The values are updated at
+ * 40Hz (at the lowest frequency), but as it can be pretty time consuming =
on
+ * some low processor, we poll the sensor only at 20Hz... enough for the
+ * joystick.
+ */
+
+#define LIS3_PWRON_DELAY_WAI_12B	(5000)
+#define LIS3_PWRON_DELAY_WAI_8B		(3000)
+
+/*
+ * LIS3LV02D spec says 1024 LSBs corresponds 1 G -> 1LSB is 1000/1024 mG
+ * LIS302D spec says: 18 mG / digit
+ * LIS3_ACCURACY is used to increase accuracy of the intermediate
+ * calculation results.
+ */
+#define LIS3_ACCURACY			1024
+/* Sensitivity values for -2G +2G scale */
+#define LIS3_SENSITIVITY_12B		((LIS3_ACCURACY * 1000) / 1024)
+#define LIS3_SENSITIVITY_8B		(18 * LIS3_ACCURACY)
+
+#define LIS3_DEFAULT_FUZZ_12B		3
+#define LIS3_DEFAULT_FLAT_12B		3
+#define LIS3_DEFAULT_FUZZ_8B		1
+#define LIS3_DEFAULT_FLAT_8B		1
+
+struct lis3lv02d lis3_dev =3D {
+	.misc_wait   =3D __WAIT_QUEUE_HEAD_INITIALIZER(lis3_dev.misc_wait),
+};
+EXPORT_SYMBOL_GPL(lis3_dev);
+
+/* just like param_set_int() but does sanity-check so that it won't point
+ * over the axis array size
+ */
+static int param_set_axis(const char *val, const struct kernel_param *kp)
+{
+	int ret =3D param_set_int(val, kp);
+	if (!ret) {
+		int val =3D *(int *)kp->arg;
+		if (val < 0)
+			val =3D -val;
+		if (!val || val > 3)
+			return -EINVAL;
+	}
+	return ret;
+}
+
+static struct kernel_param_ops param_ops_axis =3D {
+	.set =3D param_set_axis,
+	.get =3D param_get_int,
+};
+
+module_param_array_named(axes, lis3_dev.ac.as_array, axis, NULL, 0644);
+MODULE_PARM_DESC(axes, "Axis-mapping for x,y,z directions");
+
+static s16 lis3lv02d_read_8(struct lis3lv02d *lis3, int reg)
+{
+	s8 lo;
+	if (lis3->read(lis3, reg, &lo) < 0)
+		return 0;
+
+	return lo;
+}
+
+static s16 lis3lv02d_read_12(struct lis3lv02d *lis3, int reg)
+{
+	u8 lo, hi;
+
+	lis3->read(lis3, reg - 1, &lo);
+	lis3->read(lis3, reg, &hi);
+	/* In "12 bit right justified" mode, bit 6, bit 7, bit 8 =3D bit 5 */
+	return (s16)((hi << 8) | lo);
+}
+
+/**
+ * lis3lv02d_get_axis - For the given axis, give the value converted
+ * @axis:      1,2,3 - can also be negative
+ * @hw_values: raw values returned by the hardware
+ *
+ * Returns the converted value.
+ */
+static inline int lis3lv02d_get_axis(s8 axis, int hw_values[3])
+{
+	if (axis > 0)
+		return hw_values[axis - 1];
+	else
+		return -hw_values[-axis - 1];
+}
+
+/**
+ * lis3lv02d_get_xyz - Get X, Y and Z axis values from the accelerometer
+ * @lis3: pointer to the device struct
+ * @x:    where to store the X axis value
+ * @y:    where to store the Y axis value
+ * @z:    where to store the Z axis value
+ *
+ * Note that 40Hz input device can eat up about 10% CPU at 800MHZ
+ */
+static void lis3lv02d_get_xyz(struct lis3lv02d *lis3, int *x, int *y, int =
*z)
+{
+	int position[3];
+	int i;
+
+	if (lis3->blkread) {
+		if (lis3_dev.whoami =3D WAI_12B) {
+			u16 data[3];
+			lis3->blkread(lis3, OUTX_L, 6, (u8 *)data);
+			for (i =3D 0; i < 3; i++)
+				position[i] =3D (s16)le16_to_cpu(data[i]);
+		} else {
+			u8 data[5];
+			/* Data: x, dummy, y, dummy, z */
+			lis3->blkread(lis3, OUTX, 5, data);
+			for (i =3D 0; i < 3; i++)
+				position[i] =3D (s8)data[i * 2];
+		}
+	} else {
+		position[0] =3D lis3->read_data(lis3, OUTX);
+		position[1] =3D lis3->read_data(lis3, OUTY);
+		position[2] =3D lis3->read_data(lis3, OUTZ);
+	}
+
+	for (i =3D 0; i < 3; i++)
+		position[i] =3D (position[i] * lis3->scale) / LIS3_ACCURACY;
+
+	*x =3D lis3lv02d_get_axis(lis3->ac.x, position);
+	*y =3D lis3lv02d_get_axis(lis3->ac.y, position);
+	*z =3D lis3lv02d_get_axis(lis3->ac.z, position);
+}
+
+/* conversion btw sampling rate and the register values */
+static int lis3_12_rates[4] =3D {40, 160, 640, 2560};
+static int lis3_8_rates[2] =3D {100, 400};
+static int lis3_3dc_rates[16] =3D {0, 1, 10, 25, 50, 100, 200, 400, 1600, =
5000};
+
+/* ODR is Output Data Rate */
+static int lis3lv02d_get_odr(void)
+{
+	u8 ctrl;
+	int shift;
+
+	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
+	ctrl &=3D lis3_dev.odr_mask;
+	shift =3D ffs(lis3_dev.odr_mask) - 1;
+	return lis3_dev.odrs[(ctrl >> shift)];
+}
+
+static int lis3lv02d_set_odr(int rate)
+{
+	u8 ctrl;
+	int i, len, shift;
+
+	if (!rate)
+		return -EINVAL;
+
+	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
+	ctrl &=3D ~lis3_dev.odr_mask;
+	len =3D 1 << hweight_long(lis3_dev.odr_mask); /* # of possible values */
+	shift =3D ffs(lis3_dev.odr_mask) - 1;
+
+	for (i =3D 0; i < len; i++)
+		if (lis3_dev.odrs[i] =3D rate) {
+			lis3_dev.write(&lis3_dev, CTRL_REG1,
+					ctrl | (i << shift));
+			return 0;
+		}
+	return -EINVAL;
+}
+
+static int lis3lv02d_selftest(struct lis3lv02d *lis3, s16 results[3])
+{
+	u8 ctlreg, reg;
+	s16 x, y, z;
+	u8 selftest;
+	int ret;
+	u8 ctrl_reg_data;
+	unsigned char irq_cfg;
+
+	mutex_lock(&lis3->mutex);
+
+	irq_cfg =3D lis3->irq_cfg;
+	if (lis3_dev.whoami =3D WAI_8B) {
+		lis3->data_ready_count[IRQ_LINE0] =3D 0;
+		lis3->data_ready_count[IRQ_LINE1] =3D 0;
+
+		/* Change interrupt cfg to data ready for selftest */
+		atomic_inc(&lis3_dev.wake_thread);
+		lis3->irq_cfg =3D LIS3_IRQ1_DATA_READY | LIS3_IRQ2_DATA_READY;
+		lis3->read(lis3, CTRL_REG3, &ctrl_reg_data);
+		lis3->write(lis3, CTRL_REG3, (ctrl_reg_data &
+				~(LIS3_IRQ1_MASK | LIS3_IRQ2_MASK)) |
+				(LIS3_IRQ1_DATA_READY | LIS3_IRQ2_DATA_READY));
+	}
+
+	if (lis3_dev.whoami =3D WAI_3DC) {
+		ctlreg =3D CTRL_REG4;
+		selftest =3D CTRL4_ST0;
+	} else {
+		ctlreg =3D CTRL_REG1;
+		if (lis3_dev.whoami =3D WAI_12B)
+			selftest =3D CTRL1_ST;
+		else
+			selftest =3D CTRL1_STP;
+	}
+
+	lis3->read(lis3, ctlreg, &reg);
+	lis3->write(lis3, ctlreg, (reg | selftest));
+	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
+
+	/* Read directly to avoid axis remap */
+	x =3D lis3->read_data(lis3, OUTX);
+	y =3D lis3->read_data(lis3, OUTY);
+	z =3D lis3->read_data(lis3, OUTZ);
+
+	/* back to normal settings */
+	lis3->write(lis3, ctlreg, reg);
+	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
+
+	results[0] =3D x - lis3->read_data(lis3, OUTX);
+	results[1] =3D y - lis3->read_data(lis3, OUTY);
+	results[2] =3D z - lis3->read_data(lis3, OUTZ);
+
+	ret =3D 0;
+
+	if (lis3_dev.whoami =3D WAI_8B) {
+		/* Restore original interrupt configuration */
+		atomic_dec(&lis3_dev.wake_thread);
+		lis3->write(lis3, CTRL_REG3, ctrl_reg_data);
+		lis3->irq_cfg =3D irq_cfg;
+
+		if ((irq_cfg & LIS3_IRQ1_MASK) &&
+			lis3->data_ready_count[IRQ_LINE0] < 2) {
+			ret =3D SELFTEST_IRQ;
+			goto fail;
+		}
+
+		if ((irq_cfg & LIS3_IRQ2_MASK) &&
+			lis3->data_ready_count[IRQ_LINE1] < 2) {
+			ret =3D SELFTEST_IRQ;
+			goto fail;
+		}
+	}
+
+	if (lis3->pdata) {
+		int i;
+		for (i =3D 0; i < 3; i++) {
+			/* Check against selftest acceptance limits */
+			if ((results[i] < lis3->pdata->st_min_limits[i]) ||
+			    (results[i] > lis3->pdata->st_max_limits[i])) {
+				ret =3D SELFTEST_FAIL;
+				goto fail;
+			}
+		}
+	}
+
+	/* test passed */
+fail:
+	mutex_unlock(&lis3->mutex);
+	return ret;
+}
+
+/*
+ * Order of registers in the list affects to order of the restore process.
+ * Perhaps it is a good idea to set interrupt enable register as a last one
+ * after all other configurations
+ */
+static u8 lis3_wai8_regs[] =3D { FF_WU_CFG_1, FF_WU_THS_1, FF_WU_DURATION_=
1,
+			       FF_WU_CFG_2, FF_WU_THS_2, FF_WU_DURATION_2,
+			       CLICK_CFG, CLICK_SRC, CLICK_THSY_X, CLICK_THSZ,
+			       CLICK_TIMELIMIT, CLICK_LATENCY, CLICK_WINDOW,
+			       CTRL_REG1, CTRL_REG2, CTRL_REG3};
+
+static u8 lis3_wai12_regs[] =3D {FF_WU_CFG, FF_WU_THS_L, FF_WU_THS_H,
+			       FF_WU_DURATION, DD_CFG, DD_THSI_L, DD_THSI_H,
+			       DD_THSE_L, DD_THSE_H,
+			       CTRL_REG1, CTRL_REG3, CTRL_REG2};
+
+static inline void lis3_context_save(struct lis3lv02d *lis3)
+{
+	int i;
+	for (i =3D 0; i < lis3->regs_size; i++)
+		lis3->read(lis3, lis3->regs[i], &lis3->reg_cache[i]);
+	lis3->regs_stored =3D true;
+}
+
+static inline void lis3_context_restore(struct lis3lv02d *lis3)
+{
+	int i;
+	if (lis3->regs_stored)
+		for (i =3D 0; i < lis3->regs_size; i++)
+			lis3->write(lis3, lis3->regs[i], lis3->reg_cache[i]);
+}
+
+void lis3lv02d_poweroff(struct lis3lv02d *lis3)
+{
+	if (lis3->reg_ctrl)
+		lis3_context_save(lis3);
+	/* disable X,Y,Z axis and power down */
+	lis3->write(lis3, CTRL_REG1, 0x00);
+	if (lis3->reg_ctrl)
+		lis3->reg_ctrl(lis3, LIS3_REG_OFF);
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_poweroff);
+
+void lis3lv02d_poweron(struct lis3lv02d *lis3)
+{
+	u8 reg;
+
+	lis3->init(lis3);
+
+	/*
+	 * Common configuration
+	 * BDU: (12 bits sensors only) LSB and MSB values are not updated until
+	 *      both have been read. So the value read will always be correct.
+	 * Set BOOT bit to refresh factory tuning values.
+	 */
+	lis3->read(lis3, CTRL_REG2, &reg);
+	if (lis3->whoami =3D  WAI_12B)
+		reg |=3D CTRL2_BDU | CTRL2_BOOT;
+	else
+		reg |=3D CTRL2_BOOT_8B;
+	lis3->write(lis3, CTRL_REG2, reg);
+
+	/* LIS3 power on delay is quite long */
+	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
+
+	if (lis3->reg_ctrl)
+		lis3_context_restore(lis3);
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
+
+
+static void lis3lv02d_joystick_poll(struct input_polled_dev *pidev)
+{
+	int x, y, z;
+
+	mutex_lock(&lis3_dev.mutex);
+	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
+	input_report_abs(pidev->input, ABS_X, x);
+	input_report_abs(pidev->input, ABS_Y, y);
+	input_report_abs(pidev->input, ABS_Z, z);
+	input_sync(pidev->input);
+	mutex_unlock(&lis3_dev.mutex);
+}
+
+static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
+{
+	if (lis3_dev.pm_dev)
+		pm_runtime_get_sync(lis3_dev.pm_dev);
+
+	if (lis3_dev.pdata && lis3_dev.whoami =3D WAI_8B && lis3_dev.idev)
+		atomic_set(&lis3_dev.wake_thread, 1);
+	/*
+	 * Update coordinates for the case where poll interval is 0 and
+	 * the chip in running purely under interrupt control
+	 */
+	lis3lv02d_joystick_poll(pidev);
+}
+
+static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)
+{
+	atomic_set(&lis3_dev.wake_thread, 0);
+	if (lis3_dev.pm_dev)
+		pm_runtime_put(lis3_dev.pm_dev);
+}
+
+static irqreturn_t lis302dl_interrupt(int irq, void *dummy)
+{
+	if (!test_bit(0, &lis3_dev.misc_opened))
+		goto out;
+
+	/*
+	 * Be careful: on some HP laptops the bios force DD when on battery and
+	 * the lid is closed. This leads to interrupts as soon as a little move
+	 * is done.
+	 */
+	atomic_inc(&lis3_dev.count);
+
+	wake_up_interruptible(&lis3_dev.misc_wait);
+	kill_fasync(&lis3_dev.async_queue, SIGIO, POLL_IN);
+out:
+	if (atomic_read(&lis3_dev.wake_thread))
+		return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
+}
+
+static void lis302dl_interrupt_handle_click(struct lis3lv02d *lis3)
+{
+	struct input_dev *dev =3D lis3->idev->input;
+	u8 click_src;
+
+	mutex_lock(&lis3->mutex);
+	lis3->read(lis3, CLICK_SRC, &click_src);
+
+	if (click_src & CLICK_SINGLE_X) {
+		input_report_key(dev, lis3->mapped_btns[0], 1);
+		input_report_key(dev, lis3->mapped_btns[0], 0);
+	}
+
+	if (click_src & CLICK_SINGLE_Y) {
+		input_report_key(dev, lis3->mapped_btns[1], 1);
+		input_report_key(dev, lis3->mapped_btns[1], 0);
+	}
+
+	if (click_src & CLICK_SINGLE_Z) {
+		input_report_key(dev, lis3->mapped_btns[2], 1);
+		input_report_key(dev, lis3->mapped_btns[2], 0);
+	}
+	input_sync(dev);
+	mutex_unlock(&lis3->mutex);
+}
+
+static inline void lis302dl_data_ready(struct lis3lv02d *lis3, int index)
+{
+	int dummy;
+
+	/* Dummy read to ack interrupt */
+	lis3lv02d_get_xyz(lis3, &dummy, &dummy, &dummy);
+	lis3->data_ready_count[index]++;
+}
+
+static irqreturn_t lis302dl_interrupt_thread1_8b(int irq, void *data)
+{
+	struct lis3lv02d *lis3 =3D data;
+	u8 irq_cfg =3D lis3->irq_cfg & LIS3_IRQ1_MASK;
+
+	if (irq_cfg =3D LIS3_IRQ1_CLICK)
+		lis302dl_interrupt_handle_click(lis3);
+	else if (unlikely(irq_cfg =3D LIS3_IRQ1_DATA_READY))
+		lis302dl_data_ready(lis3, IRQ_LINE0);
+	else
+		lis3lv02d_joystick_poll(lis3->idev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t lis302dl_interrupt_thread2_8b(int irq, void *data)
+{
+	struct lis3lv02d *lis3 =3D data;
+	u8 irq_cfg =3D lis3->irq_cfg & LIS3_IRQ2_MASK;
+
+	if (irq_cfg =3D LIS3_IRQ2_CLICK)
+		lis302dl_interrupt_handle_click(lis3);
+	else if (unlikely(irq_cfg =3D LIS3_IRQ2_DATA_READY))
+		lis302dl_data_ready(lis3, IRQ_LINE1);
+	else
+		lis3lv02d_joystick_poll(lis3->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int lis3lv02d_misc_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &lis3_dev.misc_opened))
+		return -EBUSY; /* already open */
+
+	if (lis3_dev.pm_dev)
+		pm_runtime_get_sync(lis3_dev.pm_dev);
+
+	atomic_set(&lis3_dev.count, 0);
+	return 0;
+}
+
+static int lis3lv02d_misc_release(struct inode *inode, struct file *file)
+{
+	fasync_helper(-1, file, 0, &lis3_dev.async_queue);
+	clear_bit(0, &lis3_dev.misc_opened); /* release the device */
+	if (lis3_dev.pm_dev)
+		pm_runtime_put(lis3_dev.pm_dev);
+	return 0;
+}
+
+static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
+				size_t count, loff_t *pos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	u32 data;
+	unsigned char byte_data;
+	ssize_t retval =3D 1;
+
+	if (count < 1)
+		return -EINVAL;
+
+	add_wait_queue(&lis3_dev.misc_wait, &wait);
+	while (true) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		data =3D atomic_xchg(&lis3_dev.count, 0);
+		if (data)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			retval =3D -EAGAIN;
+			goto out;
+		}
+
+		if (signal_pending(current)) {
+			retval =3D -ERESTARTSYS;
+			goto out;
+		}
+
+		schedule();
+	}
+
+	if (data < 255)
+		byte_data =3D data;
+	else
+		byte_data =3D 255;
+
+	/* make sure we are not going into copy_to_user() with
+	 * TASK_INTERRUPTIBLE state */
+	set_current_state(TASK_RUNNING);
+	if (copy_to_user(buf, &byte_data, sizeof(byte_data)))
+		retval =3D -EFAULT;
+
+out:
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&lis3_dev.misc_wait, &wait);
+
+	return retval;
+}
+
+static unsigned int lis3lv02d_misc_poll(struct file *file, poll_table *wai=
t)
+{
+	poll_wait(file, &lis3_dev.misc_wait, wait);
+	if (atomic_read(&lis3_dev.count))
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+static int lis3lv02d_misc_fasync(int fd, struct file *file, int on)
+{
+	return fasync_helper(fd, file, on, &lis3_dev.async_queue);
+}
+
+static const struct file_operations lis3lv02d_misc_fops =3D {
+	.owner   =3D THIS_MODULE,
+	.llseek  =3D no_llseek,
+	.read    =3D lis3lv02d_misc_read,
+	.open    =3D lis3lv02d_misc_open,
+	.release =3D lis3lv02d_misc_release,
+	.poll    =3D lis3lv02d_misc_poll,
+	.fasync  =3D lis3lv02d_misc_fasync,
+};
+
+static struct miscdevice lis3lv02d_misc_device =3D {
+	.minor   =3D MISC_DYNAMIC_MINOR,
+	.name    =3D "freefall",
+	.fops    =3D &lis3lv02d_misc_fops,
+};
+
+int lis3lv02d_joystick_enable(void)
+{
+	struct input_dev *input_dev;
+	int err;
+	int max_val, fuzz, flat;
+	int btns[] =3D {BTN_X, BTN_Y, BTN_Z};
+
+	if (lis3_dev.idev)
+		return -EINVAL;
+
+	lis3_dev.idev =3D input_allocate_polled_device();
+	if (!lis3_dev.idev)
+		return -ENOMEM;
+
+	lis3_dev.idev->poll =3D lis3lv02d_joystick_poll;
+	lis3_dev.idev->open =3D lis3lv02d_joystick_open;
+	lis3_dev.idev->close =3D lis3lv02d_joystick_close;
+	lis3_dev.idev->poll_interval =3D MDPS_POLL_INTERVAL;
+	lis3_dev.idev->poll_interval_min =3D MDPS_POLL_MIN;
+	lis3_dev.idev->poll_interval_max =3D MDPS_POLL_MAX;
+	input_dev =3D lis3_dev.idev->input;
+
+	input_dev->name       =3D "ST LIS3LV02DL Accelerometer";
+	input_dev->phys       =3D DRIVER_NAME "/input0";
+	input_dev->id.bustype =3D BUS_HOST;
+	input_dev->id.vendor  =3D 0;
+	input_dev->dev.parent =3D &lis3_dev.pdev->dev;
+
+	set_bit(EV_ABS, input_dev->evbit);
+	max_val =3D (lis3_dev.mdps_max_val * lis3_dev.scale) / LIS3_ACCURACY;
+	if (lis3_dev.whoami =3D WAI_12B) {
+		fuzz =3D LIS3_DEFAULT_FUZZ_12B;
+		flat =3D LIS3_DEFAULT_FLAT_12B;
+	} else {
+		fuzz =3D LIS3_DEFAULT_FUZZ_8B;
+		flat =3D LIS3_DEFAULT_FLAT_8B;
+	}
+	fuzz =3D (fuzz * lis3_dev.scale) / LIS3_ACCURACY;
+	flat =3D (flat * lis3_dev.scale) / LIS3_ACCURACY;
+
+	input_set_abs_params(input_dev, ABS_X, -max_val, max_val, fuzz, flat);
+	input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
+	input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
+
+	lis3_dev.mapped_btns[0] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.x), btns);
+	lis3_dev.mapped_btns[1] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.y), btns);
+	lis3_dev.mapped_btns[2] =3D lis3lv02d_get_axis(abs(lis3_dev.ac.z), btns);
+
+	err =3D input_register_polled_device(lis3_dev.idev);
+	if (err) {
+		input_free_polled_device(lis3_dev.idev);
+		lis3_dev.idev =3D NULL;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_joystick_enable);
+
+void lis3lv02d_joystick_disable(void)
+{
+	if (lis3_dev.irq)
+		free_irq(lis3_dev.irq, &lis3_dev);
+	if (lis3_dev.pdata && lis3_dev.pdata->irq2)
+		free_irq(lis3_dev.pdata->irq2, &lis3_dev);
+
+	if (!lis3_dev.idev)
+		return;
+
+	if (lis3_dev.irq)
+		misc_deregister(&lis3lv02d_misc_device);
+	input_unregister_polled_device(lis3_dev.idev);
+	input_free_polled_device(lis3_dev.idev);
+	lis3_dev.idev =3D NULL;
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_joystick_disable);
+
+/* Sysfs stuff */
+static void lis3lv02d_sysfs_poweron(struct lis3lv02d *lis3)
+{
+	/*
+	 * SYSFS functions are fast visitors so put-call
+	 * immediately after the get-call. However, keep
+	 * chip running for a while and schedule delayed
+	 * suspend. This way periodic sysfs calls doesn't
+	 * suffer from relatively long power up time.
+	 */
+
+	if (lis3->pm_dev) {
+		pm_runtime_get_sync(lis3->pm_dev);
+		pm_runtime_put_noidle(lis3->pm_dev);
+		pm_schedule_suspend(lis3->pm_dev, LIS3_SYSFS_POWERDOWN_DELAY);
+	}
+}
+
+static ssize_t lis3lv02d_selftest_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	s16 values[3];
+
+	static const char ok[] =3D "OK";
+	static const char fail[] =3D "FAIL";
+	static const char irq[] =3D "FAIL_IRQ";
+	const char *res;
+
+	lis3lv02d_sysfs_poweron(&lis3_dev);
+	switch (lis3lv02d_selftest(&lis3_dev, values)) {
+	case SELFTEST_FAIL:
+		res =3D fail;
+		break;
+	case SELFTEST_IRQ:
+		res =3D irq;
+		break;
+	case SELFTEST_OK:
+	default:
+		res =3D ok;
+		break;
+	}
+	return sprintf(buf, "%s %d %d %d\n", res,
+		values[0], values[1], values[2]);
+}
+
+static ssize_t lis3lv02d_position_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int x, y, z;
+
+	lis3lv02d_sysfs_poweron(&lis3_dev);
+	mutex_lock(&lis3_dev.mutex);
+	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
+	mutex_unlock(&lis3_dev.mutex);
+	return sprintf(buf, "(%d,%d,%d)\n", x, y, z);
+}
+
+static ssize_t lis3lv02d_rate_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	lis3lv02d_sysfs_poweron(&lis3_dev);
+	return sprintf(buf, "%d\n", lis3lv02d_get_odr());
+}
+
+static ssize_t lis3lv02d_rate_set(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	unsigned long rate;
+
+	if (strict_strtoul(buf, 0, &rate))
+		return -EINVAL;
+
+	lis3lv02d_sysfs_poweron(&lis3_dev);
+	if (lis3lv02d_set_odr(rate))
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR(selftest, S_IRUSR, lis3lv02d_selftest_show, NULL);
+static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
+static DEVICE_ATTR(rate, S_IRUGO | S_IWUSR, lis3lv02d_rate_show,
+					    lis3lv02d_rate_set);
+
+static struct attribute *lis3lv02d_attributes[] =3D {
+	&dev_attr_selftest.attr,
+	&dev_attr_position.attr,
+	&dev_attr_rate.attr,
+	NULL
+};
+
+static struct attribute_group lis3lv02d_attribute_group =3D {
+	.attrs =3D lis3lv02d_attributes
+};
+
+
+static int lis3lv02d_add_fs(struct lis3lv02d *lis3)
+{
+	lis3->pdev =3D platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(lis3->pdev))
+		return PTR_ERR(lis3->pdev);
+
+	return sysfs_create_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_gro=
up);
+}
+
+int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
+{
+	sysfs_remove_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
+	platform_device_unregister(lis3->pdev);
+	if (lis3->pm_dev) {
+		/* Barrier after the sysfs remove */
+		pm_runtime_barrier(lis3->pm_dev);
+
+		/* SYSFS may have left chip running. Turn off if necessary */
+		if (!pm_runtime_suspended(lis3->pm_dev))
+			lis3lv02d_poweroff(&lis3_dev);
+
+		pm_runtime_disable(lis3->pm_dev);
+		pm_runtime_set_suspended(lis3->pm_dev);
+	}
+	kfree(lis3->reg_cache);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_remove_fs);
+
+static void lis3lv02d_8b_configure(struct lis3lv02d *dev,
+				struct lis3lv02d_platform_data *p)
+{
+	int err;
+	int ctrl2 =3D p->hipass_ctrl;
+
+	if (p->click_flags) {
+		dev->write(dev, CLICK_CFG, p->click_flags);
+		dev->write(dev, CLICK_TIMELIMIT, p->click_time_limit);
+		dev->write(dev, CLICK_LATENCY, p->click_latency);
+		dev->write(dev, CLICK_WINDOW, p->click_window);
+		dev->write(dev, CLICK_THSZ, p->click_thresh_z & 0xf);
+		dev->write(dev, CLICK_THSY_X,
+			(p->click_thresh_x & 0xf) |
+			(p->click_thresh_y << 4));
+
+		if (dev->idev) {
+			struct input_dev *input_dev =3D lis3_dev.idev->input;
+			input_set_capability(input_dev, EV_KEY, BTN_X);
+			input_set_capability(input_dev, EV_KEY, BTN_Y);
+			input_set_capability(input_dev, EV_KEY, BTN_Z);
+		}
+	}
+
+	if (p->wakeup_flags) {
+		dev->write(dev, FF_WU_CFG_1, p->wakeup_flags);
+		dev->write(dev, FF_WU_THS_1, p->wakeup_thresh & 0x7f);
+		/* pdata value + 1 to keep this backward compatible*/
+		dev->write(dev, FF_WU_DURATION_1, p->duration1 + 1);
+		ctrl2 ^=3D HP_FF_WU1; /* Xor to keep compatible with old pdata*/
+	}
+
+	if (p->wakeup_flags2) {
+		dev->write(dev, FF_WU_CFG_2, p->wakeup_flags2);
+		dev->write(dev, FF_WU_THS_2, p->wakeup_thresh2 & 0x7f);
+		/* pdata value + 1 to keep this backward compatible*/
+		dev->write(dev, FF_WU_DURATION_2, p->duration2 + 1);
+		ctrl2 ^=3D HP_FF_WU2; /* Xor to keep compatible with old pdata*/
+	}
+	/* Configure hipass filters */
+	dev->write(dev, CTRL_REG2, ctrl2);
+
+	if (p->irq2) {
+		err =3D request_threaded_irq(p->irq2,
+					NULL,
+					lis302dl_interrupt_thread2_8b,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT |
+					(p->irq_flags2 & IRQF_TRIGGER_MASK),
+					DRIVER_NAME, &lis3_dev);
+		if (err < 0)
+			pr_err("No second IRQ. Limited functionality\n");
+	}
+}
+
+/*
+ * Initialise the accelerometer and the various subsystems.
+ * Should be rather independent of the bus system.
+ */
+int lis3lv02d_init_device(struct lis3lv02d *dev)
+{
+	int err;
+	irq_handler_t thread_fn;
+	int irq_flags =3D 0;
+
+	dev->whoami =3D lis3lv02d_read_8(dev, WHO_AM_I);
+
+	switch (dev->whoami) {
+	case WAI_12B:
+		pr_info("12 bits sensor found\n");
+		dev->read_data =3D lis3lv02d_read_12;
+		dev->mdps_max_val =3D 2048;
+		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_12B;
+		dev->odrs =3D lis3_12_rates;
+		dev->odr_mask =3D CTRL1_DF0 | CTRL1_DF1;
+		dev->scale =3D LIS3_SENSITIVITY_12B;
+		dev->regs =3D lis3_wai12_regs;
+		dev->regs_size =3D ARRAY_SIZE(lis3_wai12_regs);
+		break;
+	case WAI_8B:
+		pr_info("8 bits sensor found\n");
+		dev->read_data =3D lis3lv02d_read_8;
+		dev->mdps_max_val =3D 128;
+		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_8B;
+		dev->odrs =3D lis3_8_rates;
+		dev->odr_mask =3D CTRL1_DR;
+		dev->scale =3D LIS3_SENSITIVITY_8B;
+		dev->regs =3D lis3_wai8_regs;
+		dev->regs_size =3D ARRAY_SIZE(lis3_wai8_regs);
+		break;
+	case WAI_3DC:
+		pr_info("8 bits 3DC sensor found\n");
+		dev->read_data =3D lis3lv02d_read_8;
+		dev->mdps_max_val =3D 128;
+		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_8B;
+		dev->odrs =3D lis3_3dc_rates;
+		dev->odr_mask =3D CTRL1_ODR0|CTRL1_ODR1|CTRL1_ODR2|CTRL1_ODR3;
+		dev->scale =3D LIS3_SENSITIVITY_8B;
+		break;
+	default:
+		pr_err("unknown sensor type 0x%X\n", dev->whoami);
+		return -EINVAL;
+	}
+
+	dev->reg_cache =3D kzalloc(max(sizeof(lis3_wai8_regs),
+				     sizeof(lis3_wai12_regs)), GFP_KERNEL);
+
+	if (dev->reg_cache =3D NULL) {
+		printk(KERN_ERR DRIVER_NAME "out of memory\n");
+		return -ENOMEM;
+	}
+
+	mutex_init(&dev->mutex);
+	atomic_set(&dev->wake_thread, 0);
+
+	lis3lv02d_add_fs(dev);
+	lis3lv02d_poweron(dev);
+
+	if (dev->pm_dev) {
+		pm_runtime_set_active(dev->pm_dev);
+		pm_runtime_enable(dev->pm_dev);
+	}
+
+	if (lis3lv02d_joystick_enable())
+		pr_err("joystick initialization failed\n");
+
+	/* passing in platform specific data is purely optional and only
+	 * used by the SPI transport layer at the moment */
+	if (dev->pdata) {
+		struct lis3lv02d_platform_data *p =3D dev->pdata;
+
+		if (dev->whoami =3D WAI_8B)
+			lis3lv02d_8b_configure(dev, p);
+
+		irq_flags =3D p->irq_flags1 & IRQF_TRIGGER_MASK;
+
+		dev->irq_cfg =3D p->irq_cfg;
+		if (p->irq_cfg)
+			dev->write(dev, CTRL_REG3, p->irq_cfg);
+
+		if (p->default_rate)
+			lis3lv02d_set_odr(p->default_rate);
+	}
+
+	/* bail if we did not get an IRQ from the bus layer */
+	if (!dev->irq) {
+		pr_debug("No IRQ. Disabling /dev/freefall\n");
+		goto out;
+	}
+
+	/*
+	 * The sensor can generate interrupts for free-fall and direction
+	 * detection (distinguishable with FF_WU_SRC and DD_SRC) but to keep
+	 * the things simple and _fast_ we activate it only for free-fall, so
+	 * no need to read register (very slow with ACPI). For the same reason,
+	 * we forbid shared interrupts.
+	 *
+	 * IRQF_TRIGGER_RISING seems pointless on HP laptops because the
+	 * io-apic is not configurable (and generates a warning) but I keep it
+	 * in case of support for other hardware.
+	 */
+	if (dev->pdata && dev->whoami =3D WAI_8B)
+		thread_fn =3D lis302dl_interrupt_thread1_8b;
+	else
+		thread_fn =3D NULL;
+
+	err =3D request_threaded_irq(dev->irq, lis302dl_interrupt,
+				thread_fn,
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT |
+				irq_flags,
+				DRIVER_NAME, &lis3_dev);
+
+	if (err < 0) {
+		pr_err("Cannot get IRQ\n");
+		goto out;
+	}
+
+	if (misc_register(&lis3lv02d_misc_device))
+		pr_err("misc_register failed\n");
+out:
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lis3lv02d_init_device);
+
+MODULE_DESCRIPTION("ST LIS3LV02Dx three-axis digital accelerometer driver"=
);
+MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/lis3lv02d.h	2011-02-20 13:08:00=
.000000000 +0100
@@ -0,0 +1,291 @@
+/*
+ *  lis3lv02d.h - ST LIS3LV02DL accelerometer driver
+ *
+ *  Copyright (C) 2007-2008 Yan Burman
+ *  Copyright (C) 2008-2009 Eric Piel
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ */
+#include <linux/platform_device.h>
+#include <linux/input-polldev.h>
+#include <linux/regulator/consumer.h>
+
+/*
+ * This driver tries to support the "digital" accelerometer chips from
+ * STMicroelectronics such as LIS3LV02DL, LIS302DL, LIS3L02DQ, LIS331DL,
+ * LIS35DE, or LIS202DL. They are very similar in terms of programming, wi=
th
+ * almost the same registers. In addition to differing on physical propert=
ies,
+ * they differ on the number of axes (2/3), precision (8/12 bits), and spe=
cial
+ * features (freefall detection, click...). Unfortunately, not all the
+ * differences can be probed via a register.
+ * They can be connected either via I=B2C or SPI.
+ */
+
+#include <linux/lis3lv02d.h>
+
+enum lis3_reg {
+	WHO_AM_I	=3D 0x0F,
+	OFFSET_X	=3D 0x16,
+	OFFSET_Y	=3D 0x17,
+	OFFSET_Z	=3D 0x18,
+	GAIN_X		=3D 0x19,
+	GAIN_Y		=3D 0x1A,
+	GAIN_Z		=3D 0x1B,
+	CTRL_REG1	=3D 0x20,
+	CTRL_REG2	=3D 0x21,
+	CTRL_REG3	=3D 0x22,
+	CTRL_REG4	=3D 0x23,
+	HP_FILTER_RESET	=3D 0x23,
+	STATUS_REG	=3D 0x27,
+	OUTX_L		=3D 0x28,
+	OUTX_H		=3D 0x29,
+	OUTX		=3D 0x29,
+	OUTY_L		=3D 0x2A,
+	OUTY_H		=3D 0x2B,
+	OUTY		=3D 0x2B,
+	OUTZ_L		=3D 0x2C,
+	OUTZ_H		=3D 0x2D,
+	OUTZ		=3D 0x2D,
+};
+
+enum lis302d_reg {
+	FF_WU_CFG_1	=3D 0x30,
+	FF_WU_SRC_1	=3D 0x31,
+	FF_WU_THS_1	=3D 0x32,
+	FF_WU_DURATION_1 =3D 0x33,
+	FF_WU_CFG_2	=3D 0x34,
+	FF_WU_SRC_2	=3D 0x35,
+	FF_WU_THS_2	=3D 0x36,
+	FF_WU_DURATION_2 =3D 0x37,
+	CLICK_CFG	=3D 0x38,
+	CLICK_SRC	=3D 0x39,
+	CLICK_THSY_X	=3D 0x3B,
+	CLICK_THSZ	=3D 0x3C,
+	CLICK_TIMELIMIT	=3D 0x3D,
+	CLICK_LATENCY	=3D 0x3E,
+	CLICK_WINDOW	=3D 0x3F,
+};
+
+enum lis3lv02d_reg {
+	FF_WU_CFG	=3D 0x30,
+	FF_WU_SRC	=3D 0x31,
+	FF_WU_ACK	=3D 0x32,
+	FF_WU_THS_L	=3D 0x34,
+	FF_WU_THS_H	=3D 0x35,
+	FF_WU_DURATION	=3D 0x36,
+	DD_CFG		=3D 0x38,
+	DD_SRC		=3D 0x39,
+	DD_ACK		=3D 0x3A,
+	DD_THSI_L	=3D 0x3C,
+	DD_THSI_H	=3D 0x3D,
+	DD_THSE_L	=3D 0x3E,
+	DD_THSE_H	=3D 0x3F,
+};
+
+enum lis3_who_am_i {
+	WAI_3DC		=3D 0x33,	/* 8 bits: LIS3DC, HP3DC */
+	WAI_12B		=3D 0x3A, /* 12 bits: LIS3LV02D[LQ]... */
+	WAI_8B		=3D 0x3B, /* 8 bits: LIS[23]02D[LQ]... */
+	WAI_6B		=3D 0x52, /* 6 bits: LIS331DLF - not supported */
+};
+
+enum lis3lv02d_ctrl1_12b {
+	CTRL1_Xen	=3D 0x01,
+	CTRL1_Yen	=3D 0x02,
+	CTRL1_Zen	=3D 0x04,
+	CTRL1_ST	=3D 0x08,
+	CTRL1_DF0	=3D 0x10,
+	CTRL1_DF1	=3D 0x20,
+	CTRL1_PD0	=3D 0x40,
+	CTRL1_PD1	=3D 0x80,
+};
+
+/* Delta to ctrl1_12b version */
+enum lis3lv02d_ctrl1_8b {
+	CTRL1_STM	=3D 0x08,
+	CTRL1_STP	=3D 0x10,
+	CTRL1_FS	=3D 0x20,
+	CTRL1_PD	=3D 0x40,
+	CTRL1_DR	=3D 0x80,
+};
+
+enum lis3lv02d_ctrl1_3dc {
+	CTRL1_ODR0	=3D 0x10,
+	CTRL1_ODR1	=3D 0x20,
+	CTRL1_ODR2	=3D 0x40,
+	CTRL1_ODR3	=3D 0x80,
+};
+
+enum lis3lv02d_ctrl2 {
+	CTRL2_DAS	=3D 0x01,
+	CTRL2_SIM	=3D 0x02,
+	CTRL2_DRDY	=3D 0x04,
+	CTRL2_IEN	=3D 0x08,
+	CTRL2_BOOT	=3D 0x10,
+	CTRL2_BLE	=3D 0x20,
+	CTRL2_BDU	=3D 0x40, /* Block Data Update */
+	CTRL2_FS	=3D 0x80, /* Full Scale selection */
+};
+
+enum lis3lv02d_ctrl4_3dc {
+	CTRL4_SIM	=3D 0x01,
+	CTRL4_ST0	=3D 0x02,
+	CTRL4_ST1	=3D 0x04,
+	CTRL4_FS0	=3D 0x10,
+	CTRL4_FS1	=3D 0x20,
+};
+
+enum lis302d_ctrl2 {
+	HP_FF_WU2	=3D 0x08,
+	HP_FF_WU1	=3D 0x04,
+	CTRL2_BOOT_8B   =3D 0x40,
+};
+
+enum lis3lv02d_ctrl3 {
+	CTRL3_CFS0	=3D 0x01,
+	CTRL3_CFS1	=3D 0x02,
+	CTRL3_FDS	=3D 0x10,
+	CTRL3_HPFF	=3D 0x20,
+	CTRL3_HPDD	=3D 0x40,
+	CTRL3_ECK	=3D 0x80,
+};
+
+enum lis3lv02d_status_reg {
+	STATUS_XDA	=3D 0x01,
+	STATUS_YDA	=3D 0x02,
+	STATUS_ZDA	=3D 0x04,
+	STATUS_XYZDA	=3D 0x08,
+	STATUS_XOR	=3D 0x10,
+	STATUS_YOR	=3D 0x20,
+	STATUS_ZOR	=3D 0x40,
+	STATUS_XYZOR	=3D 0x80,
+};
+
+enum lis3lv02d_ff_wu_cfg {
+	FF_WU_CFG_XLIE	=3D 0x01,
+	FF_WU_CFG_XHIE	=3D 0x02,
+	FF_WU_CFG_YLIE	=3D 0x04,
+	FF_WU_CFG_YHIE	=3D 0x08,
+	FF_WU_CFG_ZLIE	=3D 0x10,
+	FF_WU_CFG_ZHIE	=3D 0x20,
+	FF_WU_CFG_LIR	=3D 0x40,
+	FF_WU_CFG_AOI	=3D 0x80,
+};
+
+enum lis3lv02d_ff_wu_src {
+	FF_WU_SRC_XL	=3D 0x01,
+	FF_WU_SRC_XH	=3D 0x02,
+	FF_WU_SRC_YL	=3D 0x04,
+	FF_WU_SRC_YH	=3D 0x08,
+	FF_WU_SRC_ZL	=3D 0x10,
+	FF_WU_SRC_ZH	=3D 0x20,
+	FF_WU_SRC_IA	=3D 0x40,
+};
+
+enum lis3lv02d_dd_cfg {
+	DD_CFG_XLIE	=3D 0x01,
+	DD_CFG_XHIE	=3D 0x02,
+	DD_CFG_YLIE	=3D 0x04,
+	DD_CFG_YHIE	=3D 0x08,
+	DD_CFG_ZLIE	=3D 0x10,
+	DD_CFG_ZHIE	=3D 0x20,
+	DD_CFG_LIR	=3D 0x40,
+	DD_CFG_IEND	=3D 0x80,
+};
+
+enum lis3lv02d_dd_src {
+	DD_SRC_XL	=3D 0x01,
+	DD_SRC_XH	=3D 0x02,
+	DD_SRC_YL	=3D 0x04,
+	DD_SRC_YH	=3D 0x08,
+	DD_SRC_ZL	=3D 0x10,
+	DD_SRC_ZH	=3D 0x20,
+	DD_SRC_IA	=3D 0x40,
+};
+
+enum lis3lv02d_click_src_8b {
+	CLICK_SINGLE_X	=3D 0x01,
+	CLICK_DOUBLE_X	=3D 0x02,
+	CLICK_SINGLE_Y	=3D 0x04,
+	CLICK_DOUBLE_Y	=3D 0x08,
+	CLICK_SINGLE_Z	=3D 0x10,
+	CLICK_DOUBLE_Z	=3D 0x20,
+	CLICK_IA	=3D 0x40,
+};
+
+enum lis3lv02d_reg_state {
+	LIS3_REG_OFF	=3D 0x00,
+	LIS3_REG_ON	=3D 0x01,
+};
+
+union axis_conversion {
+	struct {
+		int x, y, z;
+	};
+	int as_array[3];
+
+};
+
+struct lis3lv02d {
+	void			*bus_priv; /* used by the bus layer only */
+	struct device		*pm_dev; /* for pm_runtime purposes */
+	int (*init) (struct lis3lv02d *lis3);
+	int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
+	int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
+	int (*blkread) (struct lis3lv02d *lis3, int reg, int len, u8 *ret);
+	int (*reg_ctrl) (struct lis3lv02d *lis3, bool state);
+
+	int                     *odrs;     /* Supported output data rates */
+	u8			*regs;	   /* Regs to store / restore */
+	int			regs_size;
+	u8                      *reg_cache;
+	bool			regs_stored;
+	u8                      odr_mask;  /* ODR bit mask */
+	u8			whoami;    /* indicates measurement precision */
+	s16 (*read_data) (struct lis3lv02d *lis3, int reg);
+	int			mdps_max_val;
+	int			pwron_delay;
+	int                     scale; /*
+					* relationship between 1 LBS and mG
+					* (1/1000th of earth gravity)
+					*/
+
+	struct input_polled_dev	*idev;     /* input device */
+	struct platform_device	*pdev;     /* platform device */
+	struct regulator_bulk_data regulators[2];
+	atomic_t		count;     /* interrupt count after last read */
+	union axis_conversion	ac;        /* hw -> logical axis */
+	int			mapped_btns[3];
+
+	u32			irq;       /* IRQ number */
+	struct fasync_struct	*async_queue; /* queue for the misc device */
+	wait_queue_head_t	misc_wait; /* Wait queue for the misc device */
+	unsigned long		misc_opened; /* bit0: whether the device is open */
+	int                     data_ready_count[2];
+	atomic_t		wake_thread;
+	unsigned char           irq_cfg;
+
+	struct lis3lv02d_platform_data *pdata;	/* for passing board config */
+	struct mutex		mutex;     /* Serialize poll and selftest */
+};
+
+int lis3lv02d_init_device(struct lis3lv02d *lis3);
+int lis3lv02d_joystick_enable(void);
+void lis3lv02d_joystick_disable(void);
+void lis3lv02d_poweroff(struct lis3lv02d *lis3);
+void lis3lv02d_poweron(struct lis3lv02d *lis3);
+int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
+
+extern struct lis3lv02d lis3_dev;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/lis3lv02d_i2c.c	2011-02-20 13:0=
8:00.000000000 +0100
@@ -0,0 +1,279 @@
+/*
+ * drivers/hwmon/lis3lv02d_i2c.c
+ *
+ * Implements I2C interface for lis3lv02d (STMicroelectronics) acceleromet=
er.
+ * Driver is based on corresponding SPI driver written by Daniel Mack
+ * (lis3lv02d_spi.c (C) 2009 Daniel Mack <daniel@caiaq.de> ).
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * Contact: Samu Onkalo <samu.p.onkalo@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
+#include "lis3lv02d.h"
+
+#define DRV_NAME	"lis3lv02d_i2c"
+
+static const char reg_vdd[]    =3D "Vdd";
+static const char reg_vdd_io[] =3D "Vdd_IO";
+
+static int lis3_reg_ctrl(struct lis3lv02d *lis3, bool state)
+{
+	int ret;
+	if (state =3D LIS3_REG_OFF) {
+		ret =3D regulator_bulk_disable(ARRAY_SIZE(lis3->regulators),
+					lis3->regulators);
+	} else {
+		ret =3D regulator_bulk_enable(ARRAY_SIZE(lis3->regulators),
+					lis3->regulators);
+		/* Chip needs time to wakeup. Not mentioned in datasheet */
+		usleep_range(10000, 20000);
+	}
+	return ret;
+}
+
+static inline s32 lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 value)
+{
+	struct i2c_client *c =3D lis3->bus_priv;
+	return i2c_smbus_write_byte_data(c, reg, value);
+}
+
+static inline s32 lis3_i2c_read(struct lis3lv02d *lis3, int reg, u8 *v)
+{
+	struct i2c_client *c =3D lis3->bus_priv;
+	*v =3D i2c_smbus_read_byte_data(c, reg);
+	return 0;
+}
+
+static inline s32 lis3_i2c_blockread(struct lis3lv02d *lis3, int reg, int =
len,
+				u8 *v)
+{
+	struct i2c_client *c =3D lis3->bus_priv;
+	reg |=3D (1 << 7); /* 7th bit enables address auto incrementation */
+	return i2c_smbus_read_i2c_block_data(c, reg, len, v);
+}
+
+static int lis3_i2c_init(struct lis3lv02d *lis3)
+{
+	u8 reg;
+	int ret;
+
+	if (lis3->reg_ctrl)
+		lis3_reg_ctrl(lis3, LIS3_REG_ON);
+
+	lis3->read(lis3, WHO_AM_I, &reg);
+	if (reg !=3D lis3->whoami)
+		printk(KERN_ERR "lis3: power on failure\n");
+
+	/* power up the device */
+	ret =3D lis3->read(lis3, CTRL_REG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg |=3D CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
+	return lis3->write(lis3, CTRL_REG1, reg);
+}
+
+/* Default axis mapping but it can be overwritten by platform data */
+static union axis_conversion lis3lv02d_axis_map +	{ .as_array =3D { LIS3_D=
EV_X, LIS3_DEV_Y, LIS3_DEV_Z } };
+
+static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	int ret =3D 0;
+	struct lis3lv02d_platform_data *pdata =3D client->dev.platform_data;
+
+	if (pdata) {
+		/* Regulator control is optional */
+		if (pdata->driver_features & LIS3_USE_REGULATOR_CTRL)
+			lis3_dev.reg_ctrl =3D lis3_reg_ctrl;
+
+		if ((pdata->driver_features & LIS3_USE_BLOCK_READ) &&
+			(i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_I2C_BLOCK)))
+			lis3_dev.blkread  =3D lis3_i2c_blockread;
+
+		if (pdata->axis_x)
+			lis3lv02d_axis_map.x =3D pdata->axis_x;
+
+		if (pdata->axis_y)
+			lis3lv02d_axis_map.y =3D pdata->axis_y;
+
+		if (pdata->axis_z)
+			lis3lv02d_axis_map.z =3D pdata->axis_z;
+
+		if (pdata->setup_resources)
+			ret =3D pdata->setup_resources();
+
+		if (ret)
+			goto fail;
+	}
+
+	if (lis3_dev.reg_ctrl) {
+		lis3_dev.regulators[0].supply =3D reg_vdd;
+		lis3_dev.regulators[1].supply =3D reg_vdd_io;
+		ret =3D regulator_bulk_get(&client->dev,
+					ARRAY_SIZE(lis3_dev.regulators),
+					lis3_dev.regulators);
+		if (ret < 0)
+			goto fail;
+	}
+
+	lis3_dev.pdata	  =3D pdata;
+	lis3_dev.bus_priv =3D client;
+	lis3_dev.init	  =3D lis3_i2c_init;
+	lis3_dev.read	  =3D lis3_i2c_read;
+	lis3_dev.write	  =3D lis3_i2c_write;
+	lis3_dev.irq	  =3D client->irq;
+	lis3_dev.ac	  =3D lis3lv02d_axis_map;
+	lis3_dev.pm_dev	  =3D &client->dev;
+
+	i2c_set_clientdata(client, &lis3_dev);
+
+	/* Provide power over the init call */
+	if (lis3_dev.reg_ctrl)
+		lis3_reg_ctrl(&lis3_dev, LIS3_REG_ON);
+
+	ret =3D lis3lv02d_init_device(&lis3_dev);
+
+	if (lis3_dev.reg_ctrl)
+		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
+
+	if (ret =3D 0)
+		return 0;
+fail:
+	if (pdata && pdata->release_resources)
+		pdata->release_resources();
+	return ret;
+}
+
+static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
+{
+	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
+	struct lis3lv02d_platform_data *pdata =3D client->dev.platform_data;
+
+	if (pdata && pdata->release_resources)
+		pdata->release_resources();
+
+	lis3lv02d_joystick_disable();
+	lis3lv02d_remove_fs(&lis3_dev);
+
+	if (lis3_dev.reg_ctrl)
+		regulator_bulk_free(ARRAY_SIZE(lis3->regulators),
+				lis3_dev.regulators);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int lis3lv02d_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
+	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
+
+	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
+		lis3lv02d_poweroff(lis3);
+	return 0;
+}
+
+static int lis3lv02d_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
+	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
+
+	/*
+	 * pm_runtime documentation says that devices should always
+	 * be powered on at resume. Pm_runtime turns them off after system
+	 * wide resume is complete.
+	 */
+	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
+		pm_runtime_suspended(dev))
+		lis3lv02d_poweron(lis3);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+static int lis3_i2c_runtime_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
+	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
+
+	lis3lv02d_poweroff(lis3);
+	return 0;
+}
+
+static int lis3_i2c_runtime_resume(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, dev);
+	struct lis3lv02d *lis3 =3D i2c_get_clientdata(client);
+
+	lis3lv02d_poweron(lis3);
+	return 0;
+}
+#endif /* CONFIG_PM_RUNTIME */
+
+static const struct i2c_device_id lis3lv02d_id[] =3D {
+	{"lis3lv02d", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, lis3lv02d_id);
+
+static const struct dev_pm_ops lis3_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(lis3lv02d_i2c_suspend,
+				lis3lv02d_i2c_resume)
+	SET_RUNTIME_PM_OPS(lis3_i2c_runtime_suspend,
+			   lis3_i2c_runtime_resume,
+			   NULL)
+};
+
+static struct i2c_driver lis3lv02d_i2c_driver =3D {
+	.driver	 =3D {
+		.name   =3D DRV_NAME,
+		.owner  =3D THIS_MODULE,
+		.pm     =3D &lis3_pm_ops,
+	},
+	.probe	=3D lis3lv02d_i2c_probe,
+	.remove	=3D __devexit_p(lis3lv02d_i2c_remove),
+	.id_table =3D lis3lv02d_id,
+};
+
+static int __init lis3lv02d_init(void)
+{
+	return i2c_add_driver(&lis3lv02d_i2c_driver);
+}
+
+static void __exit lis3lv02d_exit(void)
+{
+	i2c_del_driver(&lis3lv02d_i2c_driver);
+}
+
+MODULE_AUTHOR("Nokia Corporation");
+MODULE_DESCRIPTION("lis3lv02d I2C interface");
+MODULE_LICENSE("GPL");
+
+module_init(lis3lv02d_init);
+module_exit(lis3lv02d_exit);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/lis3lv02d_spi.c	2011-02-20 13:0=
8:00.000000000 +0100
@@ -0,0 +1,144 @@
+/*
+ * lis3lv02d_spi - SPI glue layer for lis3lv02d
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+
+#include "lis3lv02d.h"
+
+#define DRV_NAME	"lis3lv02d_spi"
+#define LIS3_SPI_READ	0x80
+
+static int lis3_spi_read(struct lis3lv02d *lis3, int reg, u8 *v)
+{
+	struct spi_device *spi =3D lis3->bus_priv;
+	int ret =3D spi_w8r8(spi, reg | LIS3_SPI_READ);
+	if (ret < 0)
+		return -EINVAL;
+
+	*v =3D (u8) ret;
+	return 0;
+}
+
+static int lis3_spi_write(struct lis3lv02d *lis3, int reg, u8 val)
+{
+	u8 tmp[2] =3D { reg, val };
+	struct spi_device *spi =3D lis3->bus_priv;
+	return spi_write(spi, tmp, sizeof(tmp));
+}
+
+static int lis3_spi_init(struct lis3lv02d *lis3)
+{
+	u8 reg;
+	int ret;
+
+	/* power up the device */
+	ret =3D lis3->read(lis3, CTRL_REG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg |=3D CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
+	return lis3->write(lis3, CTRL_REG1, reg);
+}
+
+static union axis_conversion lis3lv02d_axis_normal +	{ .as_array =3D { 1, =
2, 3 } };
+
+static int __devinit lis302dl_spi_probe(struct spi_device *spi)
+{
+	int ret;
+
+	spi->bits_per_word =3D 8;
+	spi->mode =3D SPI_MODE_0;
+	ret =3D spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	lis3_dev.bus_priv	=3D spi;
+	lis3_dev.init		=3D lis3_spi_init;
+	lis3_dev.read		=3D lis3_spi_read;
+	lis3_dev.write		=3D lis3_spi_write;
+	lis3_dev.irq		=3D spi->irq;
+	lis3_dev.ac		=3D lis3lv02d_axis_normal;
+	lis3_dev.pdata		=3D spi->dev.platform_data;
+	spi_set_drvdata(spi, &lis3_dev);
+
+	return lis3lv02d_init_device(&lis3_dev);
+}
+
+static int __devexit lis302dl_spi_remove(struct spi_device *spi)
+{
+	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
+	lis3lv02d_joystick_disable();
+	lis3lv02d_poweroff(lis3);
+
+	return lis3lv02d_remove_fs(&lis3_dev);
+}
+
+#ifdef CONFIG_PM
+static int lis3lv02d_spi_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
+
+	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
+		lis3lv02d_poweroff(&lis3_dev);
+
+	return 0;
+}
+
+static int lis3lv02d_spi_resume(struct spi_device *spi)
+{
+	struct lis3lv02d *lis3 =3D spi_get_drvdata(spi);
+
+	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
+		lis3lv02d_poweron(lis3);
+
+	return 0;
+}
+
+#else
+#define lis3lv02d_spi_suspend	NULL
+#define lis3lv02d_spi_resume	NULL
+#endif
+
+static struct spi_driver lis302dl_spi_driver =3D {
+	.driver	 =3D {
+		.name   =3D DRV_NAME,
+		.owner  =3D THIS_MODULE,
+	},
+	.probe	=3D lis302dl_spi_probe,
+	.remove	=3D __devexit_p(lis302dl_spi_remove),
+	.suspend =3D lis3lv02d_spi_suspend,
+	.resume  =3D lis3lv02d_spi_resume,
+};
+
+static int __init lis302dl_init(void)
+{
+	return spi_register_driver(&lis302dl_spi_driver);
+}
+
+static void __exit lis302dl_exit(void)
+{
+	spi_unregister_driver(&lis302dl_spi_driver);
+}
+
+module_init(lis302dl_init);
+module_exit(lis302dl_exit);
+
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
+MODULE_DESCRIPTION("lis3lv02d SPI glue layer");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:" DRV_NAME);
--- linux-2.6.38-rc5.orig/drivers/platform/x86/hp_accel.c	2011-02-20 12:58:=
24.000000000 +0100
+++ linux-2.6.38-rc5/drivers/platform/x86/hp_accel.c	2011-02-20 13:08:00.00=
0000000 +0100
@@ -37,7 +37,7 @@
 #include <linux/leds.h>
 #include <linux/atomic.h>
 #include <acpi/acpi_drivers.h>
-#include "../../hwmon/lis3lv02d.h"
+#include "../../misc/lis3lv02d/lis3lv02d.h"
=20
 #define DRIVER_NAME     "lis3lv02d"
 #define ACPI_MDPS_CLASS "accelerometer"
--- linux-2.6.38-rc5.orig/drivers/misc/Kconfig	2011-02-19 16:50:32.00000000=
0 +0100
+++ linux-2.6.38-rc5/drivers/misc/Kconfig	2011-02-20 13:08:00.000000000 +01=
00
@@ -2,6 +2,14 @@
 # Misc strange devices
 #
=20
+# This one has to live outside of the MISC_DEVICES conditional,
+# because it may be selected by drivers/platform/x86/hp_accel.
+config SENSORS_LIS3LV02D
+	tristate
+	depends on INPUT
+	select INPUT_POLLDEV
+	default n
+
 menuconfig MISC_DEVICES
 	bool "Misc devices"
 	---help---
@@ -457,5 +465,6 @@ source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
 source "drivers/misc/iwmc3200top/Kconfig"
 source "drivers/misc/ti-st/Kconfig"
+source "drivers/misc/lis3lv02d/Kconfig"
=20
 endif # MISC_DEVICES
--- linux-2.6.38-rc5.orig/drivers/misc/Makefile	2011-02-19 16:50:32.0000000=
00 +0100
+++ linux-2.6.38-rc5/drivers/misc/Makefile	2011-02-20 13:08:00.000000000 +0=
100
@@ -42,3 +42,4 @@ obj-$(CONFIG_ARM_CHARLCD)	+=3D arm-charlcd
 obj-$(CONFIG_PCH_PHUB)		+=3D pch_phub.o
 obj-y				+=3D ti-st/
 obj-$(CONFIG_AB8500_PWM)	+=3D ab8500-pwm.o
+obj-y				+=3D lis3lv02d/
--- linux-2.6.38-rc5.orig/drivers/hwmon/Makefile	2011-02-20 12:58:24.000000=
000 +0100
+++ linux-2.6.38-rc5/drivers/hwmon/Makefile	2011-02-20 13:08:00.000000000 +=
0100
@@ -5,9 +5,6 @@
 obj-$(CONFIG_HWMON)		+=3D hwmon.o
 obj-$(CONFIG_HWMON_VID)		+=3D hwmon-vid.o
=20
-# Helper drivers
-obj-$(CONFIG_SENSORS_LIS3LV02D) +=3D lis3lv02d.o
-
 # APCI drivers
 obj-$(CONFIG_SENSORS_ATK0110)	+=3D asus_atk0110.o
=20
@@ -65,8 +62,6 @@ obj-$(CONFIG_SENSORS_JC42)	+=3D jc42.o
 obj-$(CONFIG_SENSORS_JZ4740)	+=3D jz4740-hwmon.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+=3D k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+=3D k10temp.o
-obj-$(CONFIG_SENSORS_LIS3_SPI)	+=3D lis3lv02d_spi.o
-obj-$(CONFIG_SENSORS_LIS3_I2C)	+=3D lis3lv02d_i2c.o
 obj-$(CONFIG_SENSORS_LM63)	+=3D lm63.o
 obj-$(CONFIG_SENSORS_LM70)	+=3D lm70.o
 obj-$(CONFIG_SENSORS_LM73)	+=3D lm73.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/Kconfig	2011-02-20 13:08:00.000=
000000 +0100
@@ -0,0 +1,37 @@
+#
+# STMicroelectonics LIS3LV02D and similar accelerometers
+#
+
+config SENSORS_LIS3_SPI
+	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (=
SPI)"
+	depends on !ACPI && SPI_MASTER && INPUT
+	select SENSORS_LIS3LV02D
+	default n
+	help
+	  This driver provides support for the LIS3LV02Dx accelerometer connected
+	  via SPI. The accelerometer data is readable via
+	  /sys/devices/platform/lis3lv02d.
+
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick.
+
+	  This driver can also be built as modules.  If so, the core module
+	  will be called lis3lv02d and a specific module for the SPI transport
+	  is called lis3lv02d_spi.
+
+config SENSORS_LIS3_I2C
+	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (=
I2C)"
+	depends on I2C && INPUT
+	select SENSORS_LIS3LV02D
+	default n
+	help
+	  This driver provides support for the LIS3LV02Dx accelerometer connected
+	  via I2C. The accelerometer data is readable via
+	  /sys/devices/platform/lis3lv02d.
+
+	  This driver also provides an absolute input class device, allowing
+	  the device to act as a pinball machine-esque joystick.
+
+	  This driver can also be built as modules.  If so, the core module
+	  will be called lis3lv02d and a specific module for the I2C transport
+	  is called lis3lv02d_i2c.
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/misc/lis3lv02d/Makefile	2011-02-20 13:08:00.00=
0000000 +0100
@@ -0,0 +1,7 @@
+#
+# STMicroelectonics LIS3LV02D and similar accelerometers
+#
+
+obj-$(CONFIG_SENSORS_LIS3LV02D) +=3D lis3lv02d.o
+obj-$(CONFIG_SENSORS_LIS3_SPI)	+=3D lis3lv02d_spi.o
+obj-$(CONFIG_SENSORS_LIS3_I2C)	+=3D lis3lv02d_i2c.o
--- linux-2.6.38-rc5.orig/Documentation/hwmon/lis3lv02d	2011-02-20 12:59:02=
.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,92 +0,0 @@
-Kernel driver lis3lv02d
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-
-  * STMicroelectronics LIS3LV02DL, LIS3LV02DQ (12 bits precision)
-  * STMicroelectronics LIS302DL, LIS3L02DQ, LIS331DL (8 bits)
-
-Authors:
-        Yan Burman <burman.yan@gmail.com>
-	Eric Piel <eric.piel@tremplin-utc.net>
-
-
-Description
------------
-
-This driver provides support for the accelerometer found in various HP lap=
tops
-sporting the feature officially called "HP Mobile Data Protection System 3=
D" or
-"HP 3D DriveGuard". It detects automatically laptops with this sensor. Kno=
wn
-models (full list can be found in drivers/platform/x86/hp_accel.c) will ha=
ve
-their axis automatically oriented on standard way (eg: you can directly pl=
ay
-neverball). The accelerometer data is readable via
-/sys/devices/platform/lis3lv02d. Reported values are scaled
-to mg values (1/1000th of earth gravity).
-
-Sysfs attributes under /sys/devices/platform/lis3lv02d/:
-position - 3D position that the accelerometer reports. Format: "(x,y,z)"
-rate - read reports the sampling rate of the accelerometer device in HZ.
-	write changes sampling rate of the accelerometer device.
-	Only values which are supported by HW are accepted.
-selftest - performs selftest for the chip as specified by chip manufacture=
r.
-
-This driver also provides an absolute input class device, allowing
-the laptop to act as a pinball machine-esque joystick. Joystick device can=
 be
-calibrated. Joystick device can be in two different modes.
-By default output values are scaled between -32768 .. 32767. In joystick r=
aw
-mode, joystick and sysfs position entry have the same scale. There can be
-small difference due to input system fuzziness feature.
-Events are also available as input event device.
-
-Selftest is meant only for hardware diagnostic purposes. It is not meant t=
o be
-used during normal operations. Position data is not corrupted during selft=
est
-but interrupt behaviour is not guaranteed to work reliably. In test mode, =
the
-sensing element is internally moved little bit. Selftest measures differen=
ce
-between normal mode and test mode. Chip specifications tell the acceptance
-limit for each type of the chip. Limits are provided via platform data
-to allow adjustment of the limits without a change to the actual driver.
-Seltest returns either "OK x y z" or "FAIL x y z" where x, y and z are
-measured difference between modes. Axes are not remapped in selftest mode.
-Measurement values are provided to help HW diagnostic applications to make
-final decision.
-
-On HP laptops, if the led infrastructure is activated, support for a led
-indicating disk protection will be provided as /sys/class/leds/hp::hddprot=
ect.
-
-Another feature of the driver is misc device called "freefall" that
-acts similar to /dev/rtc and reacts on free-fall interrupts received
-from the device. It supports blocking operations, poll/select and
-fasync operation modes. You must read 1 bytes from the device.  The
-result is number of free-fall interrupts since the last successful
-read (or 255 if number of interrupts would not fit). See the hpfall.c
-file for an example on using the device.
-
-
-Axes orientation
-----------------
-
-For better compatibility between the various laptops. The values reported =
by
-the accelerometer are converted into a "standard" organisation of the axes
-(aka "can play neverball out of the box"):
- * When the laptop is horizontal the position reported is about 0 for X an=
d Y
-	and a positive value for Z
- * If the left side is elevated, X increases (becomes positive)
- * If the front side (where the touchpad is) is elevated, Y decreases
-	(becomes negative)
- * If the laptop is put upside-down, Z becomes negative
-
-If your laptop model is not recognized (cf "dmesg"), you can send an
-email to the maintainer to add it to the database.  When reporting a new
-laptop, please include the output of "dmidecode" plus the value of
-/sys/devices/platform/lis3lv02d/position in these four cases.
-
-Q&A
----
-
-Q: How do I safely simulate freefall? I have an HP "portable
-workstation" which has about 3.5kg and a plastic case, so letting it
-fall to the ground is out of question...
-
-A: The sensor is pretty sensitive, so your hands can do it. Lift it
-into free space, follow the fall with your hands for like 10
-centimeters. That should be enough to trigger the detection.
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/Documentation/misc-devices/lis3lv02d	2011-02-20 12:59:=
02.000000000 +0100
@@ -0,0 +1,92 @@
+Kernel driver lis3lv02d
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+
+  * STMicroelectronics LIS3LV02DL, LIS3LV02DQ (12 bits precision)
+  * STMicroelectronics LIS302DL, LIS3L02DQ, LIS331DL (8 bits)
+
+Authors:
+        Yan Burman <burman.yan@gmail.com>
+	Eric Piel <eric.piel@tremplin-utc.net>
+
+
+Description
+-----------
+
+This driver provides support for the accelerometer found in various HP lap=
tops
+sporting the feature officially called "HP Mobile Data Protection System 3=
D" or
+"HP 3D DriveGuard". It detects automatically laptops with this sensor. Kno=
wn
+models (full list can be found in drivers/platform/x86/hp_accel.c) will ha=
ve
+their axis automatically oriented on standard way (eg: you can directly pl=
ay
+neverball). The accelerometer data is readable via
+/sys/devices/platform/lis3lv02d. Reported values are scaled
+to mg values (1/1000th of earth gravity).
+
+Sysfs attributes under /sys/devices/platform/lis3lv02d/:
+position - 3D position that the accelerometer reports. Format: "(x,y,z)"
+rate - read reports the sampling rate of the accelerometer device in HZ.
+	write changes sampling rate of the accelerometer device.
+	Only values which are supported by HW are accepted.
+selftest - performs selftest for the chip as specified by chip manufacture=
r.
+
+This driver also provides an absolute input class device, allowing
+the laptop to act as a pinball machine-esque joystick. Joystick device can=
 be
+calibrated. Joystick device can be in two different modes.
+By default output values are scaled between -32768 .. 32767. In joystick r=
aw
+mode, joystick and sysfs position entry have the same scale. There can be
+small difference due to input system fuzziness feature.
+Events are also available as input event device.
+
+Selftest is meant only for hardware diagnostic purposes. It is not meant t=
o be
+used during normal operations. Position data is not corrupted during selft=
est
+but interrupt behaviour is not guaranteed to work reliably. In test mode, =
the
+sensing element is internally moved little bit. Selftest measures differen=
ce
+between normal mode and test mode. Chip specifications tell the acceptance
+limit for each type of the chip. Limits are provided via platform data
+to allow adjustment of the limits without a change to the actual driver.
+Seltest returns either "OK x y z" or "FAIL x y z" where x, y and z are
+measured difference between modes. Axes are not remapped in selftest mode.
+Measurement values are provided to help HW diagnostic applications to make
+final decision.
+
+On HP laptops, if the led infrastructure is activated, support for a led
+indicating disk protection will be provided as /sys/class/leds/hp::hddprot=
ect.
+
+Another feature of the driver is misc device called "freefall" that
+acts similar to /dev/rtc and reacts on free-fall interrupts received
+from the device. It supports blocking operations, poll/select and
+fasync operation modes. You must read 1 bytes from the device.  The
+result is number of free-fall interrupts since the last successful
+read (or 255 if number of interrupts would not fit). See the hpfall.c
+file for an example on using the device.
+
+
+Axes orientation
+----------------
+
+For better compatibility between the various laptops. The values reported =
by
+the accelerometer are converted into a "standard" organisation of the axes
+(aka "can play neverball out of the box"):
+ * When the laptop is horizontal the position reported is about 0 for X an=
d Y
+	and a positive value for Z
+ * If the left side is elevated, X increases (becomes positive)
+ * If the front side (where the touchpad is) is elevated, Y decreases
+	(becomes negative)
+ * If the laptop is put upside-down, Z becomes negative
+
+If your laptop model is not recognized (cf "dmesg"), you can send an
+email to the maintainer to add it to the database.  When reporting a new
+laptop, please include the output of "dmidecode" plus the value of
+/sys/devices/platform/lis3lv02d/position in these four cases.
+
+Q&A
+---
+
+Q: How do I safely simulate freefall? I have an HP "portable
+workstation" which has about 3.5kg and a plastic case, so letting it
+fall to the ground is out of question...
+
+A: The sensor is pretty sensitive, so your hands can do it. Lift it
+into free space, follow the fall with your hands for like 10
+centimeters. That should be enough to trigger the detection.
--- linux-2.6.38-rc5.orig/MAINTAINERS	2011-02-17 09:08:32.000000000 +0100
+++ linux-2.6.38-rc5/MAINTAINERS	2011-02-20 13:08:52.000000000 +0100
@@ -3891,8 +3891,8 @@ F:	net/llc/
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
-F:	Documentation/hwmon/lis3lv02d
-F:	drivers/hwmon/lis3lv02d.*
+F:	Documentation/misc-devices/lis3lv02d
+F:	drivers/misc/lis3lv02d/
=20
 LM73 HARDWARE MONITOR DRIVER
 M:	Guillaume Ligneul <guillaume.ligneul@gmail.com>

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
