From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Wed, 06 Jul 2005 17:40:57 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <1120460286.3379.50.camel@uganda.factory.vocord.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-06-30 at 09:18 -0500, bgardner@Wabtec.com wrote:
> w1-slave-sysfs.diff
> Every slave now has at least two sysfs files:
>  - id : an 8 byte binary file that holds the 64 bit id
>    example: [23 6c dc 1c 00 00 00 43]
>  - name : the name, example: [23-0000001cdc6c]
> Family ops is now two callback functions: add_slave() and remove_slave().
> The family driver is responsible for creating any other sysfs entries.
> This patch updates w1-smem (which is pretty much empty) and w1-therm.
> 
> Signed-off-by: Ben Gardner <bgardner@wabtec.com>


I have some comments about this patch.


w1.c        |  101
+++++++++++++++++++++++++++++++++---------------------------
 w1.h        |    3 -
 w1_family.c |    3 -
 w1_family.h |    6 ++-
 w1_smem.c   |   47 ---------------------------
 w1_therm.c  |   32 +++++++++++++------
 6 files changed, 83 insertions(+), 109 deletions(-)

Index: linux-2.6.12-mm1/drivers/w1/w1.h
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1.h
+++ linux-2.6.12-mm1/drivers/w1/w1.h
@@ -77,9 +77,6 @@ struct w1_slave
        struct w1_family        *family;
        struct device           dev;
        struct completion       dev_released;
-
-       struct bin_attribute    attr_bin;
-       struct device_attribute attr_name;
 };
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
Index: linux-2.6.12-mm1/drivers/w1/w1.c
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1.c
+++ linux-2.6.12-mm1/drivers/w1/w1.c
@@ -59,19 +59,6 @@ static pid_t control_thread;
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
 
-/* stuff for the default family */
-static ssize_t w1_famdefault_read_name(struct device *dev, struct
device_attribute *attr, char *buf)
-{
-       struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-       return(sprintf(buf, "%s\n", sl->name));
-}
-static struct w1_family_ops w1_default_fops = {
-       .rname = &w1_famdefault_read_name,
-};
-static struct w1_family w1_default_family = {
-       .fops = &w1_default_fops,
-};
-
 static int w1_master_match(struct device *dev, struct device_driver
*drv)
 {
        return 1;
@@ -99,30 +86,45 @@ static void w1_slave_release(struct devi
        complete(&sl->dev_released);
 }
 
-static ssize_t w1_default_read_name(struct device *dev, struct
device_attribute *attr, char *buf)
+static ssize_t w1_slave_read_name(struct device *dev,
+                                 struct device_attribute *attr, char
*buf)
 {
-       return sprintf(buf, "No family registered.\n");
+       struct w1_slave *sl = dev_to_w1_slave(dev);
+       return sprintf(buf, "%s\n", sl->name);
 }
 
-static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf,
loff_t off,
+static ssize_t w1_slave_read_id(struct kobject *kobj, char *buf, loff_t
off,
                     size_t count)
 {
-       return sprintf(buf, "No family registered.\n");
+       struct w1_slave *sl = kobj_to_w1_slave(kobj);
+       atomic_inc(&sl->refcnt);
+       if (off > 8) {
+               count = 0;
+       } else {
+               if (off + count > 8)
+                       count = 8 - off;
+
+               memcpy(buf, (u8 *)&sl->reg_num, count);
+       }
+       atomic_dec(&sl->refcnt);
+       return count;
 }


You write here binary data, is it what you really want or 
it should be snprintf("%Lx")?

 
-static struct device_attribute w1_slave_attribute -       __ATTR(name, S_IRUGO, w1_default_read_name, NULL);
+static struct device_attribute w1_slave_attr_name +       __ATTR(name, S_IRUGO, w1_slave_read_name, NULL);
 
-static struct bin_attribute w1_slave_bin_attribute = {
+static struct bin_attribute w1_slave_attr_bin_id = {
        .attr = {
-               .name = "w1_slave",
+               .name = "id",
                .mode = S_IRUGO,
                .owner = THIS_MODULE,
        },
-       .size = W1_SLAVE_DATA_SIZE,
-       .read = &w1_default_read_bin,
+       .size = 8,
+       .read = w1_slave_read_id,
 };
 
+/* Empty family */
+static struct w1_family w1_default_family;
 
 static struct bus_type w1_bus_type = {
        .name = "w1",
@@ -356,36 +358,44 @@ static int __w1_attach_slave_device(stru
                return err;
        }
 
-       memcpy(&sl->attr_bin, &w1_slave_bin_attribute,
sizeof(sl->attr_bin));
-       memcpy(&sl->attr_name, &w1_slave_attribute,
sizeof(sl->attr_name));
-
-       sl->attr_bin.read = sl->family->fops->rbin;
-       sl->attr_name.show = sl->family->fops->rname;
+       /* Create "name" entry */
+       err = device_create_file(&sl->dev, &w1_slave_attr_name);
+       if (err < 0) {
+               dev_err(&sl->dev,
+                       "sysfs file creation for [%s] failed. err=%d\n",
+                       sl->dev.bus_id, err);
+               goto out_unreg;
+       }
 
-       err = device_create_file(&sl->dev, &sl->attr_name);
+       /* Create "id" entry */
+       err = sysfs_create_bin_file(&sl->dev.kobj,
&w1_slave_attr_bin_id);
        if (err < 0) {
                dev_err(&sl->dev,
                        "sysfs file creation for [%s] failed. err=%d\n",
                        sl->dev.bus_id, err);
-               device_unregister(&sl->dev);
-               return err;
+               goto out_rem1;
        }
 
-       if ( sl->attr_bin.read ) {
-               err = sysfs_create_bin_file(&sl->dev.kobj,
&sl->attr_bin);
-               if (err < 0) {
-                       dev_err(&sl->dev,
-                               "sysfs file creation for [%s] failed.
err=%d\n",
-                               sl->dev.bus_id, err);
-                       device_remove_file(&sl->dev, &sl->attr_name);
-                       device_unregister(&sl->dev);
-                       return err;
-               }
+       /* if the family driver needs to initialize something... */
+       if (sl->family->fops && sl->family->fops->add_slave &&
+           ((err = sl->family->fops->add_slave(sl)) < 0)) {
+               dev_err(&sl->dev,
+                       "sysfs file creation for [%s] failed. err=%d\n",
+                       sl->dev.bus_id, err);
+               goto out_rem2;
        }
 
        list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
 
        return 0;
+
+out_rem2:
+       sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
+out_rem1:
+       device_remove_file(&sl->dev, &w1_slave_attr_name);
+out_unreg:
+       device_unregister(&sl->dev);
+       return err;
 }
 
 static int w1_attach_slave_device(struct w1_master *dev, struct
w1_reg_num *rn)
@@ -460,10 +470,11 @@ static void w1_slave_detach(struct w1_sl
                        flush_signals(current);
        }
 
-       if ( sl->attr_bin.read ) {
-               sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
-       }
-       device_remove_file(&sl->dev, &sl->attr_name);
+       if (sl->family->fops && sl->family->fops->remove_slave)
+               sl->family->fops->remove_slave(sl);
+
+       sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_attr_bin_id);
+       device_remove_file(&sl->dev, &w1_slave_attr_name);
        device_unregister(&sl->dev);
        w1_family_put(sl->family);
 
Index: linux-2.6.12-mm1/drivers/w1/w1_family.h
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1_family.h
+++ linux-2.6.12-mm1/drivers/w1/w1_family.h
@@ -35,10 +35,12 @@
 
 #define MAXNAMELEN             32
 
+struct w1_slave;
+
 struct w1_family_ops
 {
-       ssize_t (* rname)(struct device *, struct device_attribute *,
char *);
-       ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
+       int  (* add_slave)(struct w1_slave *);
+       void (* remove_slave)(struct w1_slave *);
 };
 
 struct w1_family
Index: linux-2.6.12-mm1/drivers/w1/w1_smem.c
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1_smem.c
+++ linux-2.6.12-mm1/drivers/w1/w1_smem.c
@@ -36,59 +36,12 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit
memory family.");
 
-static ssize_t w1_smem_read_name(struct device *, struct
device_attribute *attr, char *);
-static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t,
size_t);
-
-static struct w1_family_ops w1_smem_fops = {
-       .rname = &w1_smem_read_name,
-       .rbin = &w1_smem_read_bin,
-};
-
-static ssize_t w1_smem_read_name(struct device *dev, struct
device_attribute *attr, char *buf)
-{
-       struct w1_slave *sl = dev_to_w1_slave(dev);
-       return sprintf(buf, "%s\n", sl->name);
-}
-
-static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t
off, size_t count)
-{
-       struct w1_slave *sl = kobj_to_w1_slave(kobj);
-       int i;
-
-       atomic_inc(&sl->refcnt);
-       if (down_interruptible(&sl->master->mutex)) {
-               count = 0;
-               goto out_dec;
-       }
-
-       if (off > W1_SLAVE_DATA_SIZE) {
-               count = 0;
-               goto out;
-       }
-       if (off + count > W1_SLAVE_DATA_SIZE) {
-               count = 0;
-               goto out;
-       }
-       for (i = 0; i < 8; ++i)
-               count += sprintf(buf + count, "%02x ", ((u8
*)&sl->reg_num)[i]);
-       count += sprintf(buf + count, "\n");
-
-out:
-       up(&sl->master->mutex);
-out_dec:
-       atomic_dec(&sl->refcnt);
-
-       return count;
-}
-
 static struct w1_family w1_smem_family_01 = {
        .fid = W1_FAMILY_SMEM_01,
-       .fops = &w1_smem_fops,
 };
 
 static struct w1_family w1_smem_family_81 = {
        .fid = W1_FAMILY_SMEM_81,
-       .fops = &w1_smem_fops,
 };
 
 static int __init w1_smem_init(void)
Index: linux-2.6.12-mm1/drivers/w1/w1_therm.c
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1_therm.c
+++ linux-2.6.12-mm1/drivers/w1/w1_therm.c
@@ -42,12 +42,31 @@ static u8 bad_roms[][9] = {
                                {}
                        };
 
-static ssize_t w1_therm_read_name(struct device *, struct
device_attribute *attr, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t,
size_t);
 
+static struct bin_attribute w1_therm_bin_attr = {
+       .attr = {
+               .name = "w1_slave",
+               .mode = S_IRUGO,
+               .owner = THIS_MODULE,
+       },
+       .size = W1_SLAVE_DATA_SIZE,
+       .read = w1_therm_read_bin,
+};
+
+static int w1_therm_add_slave(struct w1_slave *sl)
+{
+       return sysfs_create_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}
+
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+       sysfs_remove_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}



I would like to create this files automatically by w1 core and only
let slave drivers to create it's "private" files themselves.

 static struct w1_family_ops w1_therm_fops = {
-       .rname = &w1_therm_read_name,
-       .rbin = &w1_therm_read_bin,
+       .add_slave      = w1_therm_add_slave,
+       .remove_slave   = w1_therm_remove_slave,
 };
 
 static struct w1_family w1_therm_family_DS18S20 = {
@@ -59,6 +78,7 @@ static struct w1_family w1_therm_family_
        .fid = W1_THERM_DS18B20,
        .fops = &w1_therm_fops,
 };
+
 static struct w1_family w1_therm_family_DS1822 = {
        .fid = W1_THERM_DS1822,
        .fops = &w1_therm_fops,
@@ -90,12 +110,6 @@ static struct w1_therm_family_converter 
        },
 };
 
-static ssize_t w1_therm_read_name(struct device *dev, struct
device_attribute *attr, char *buf)
-{
-       struct w1_slave *sl = dev_to_w1_slave(dev);
-       return sprintf(buf, "%s\n", sl->name);
-}
-
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
        int t = (rom[1] << 8) | rom[0];
Index: linux-2.6.12-mm1/drivers/w1/w1_family.c
=================================--- linux-2.6.12-mm1.orig/drivers/w1/w1_family.c
+++ linux-2.6.12-mm1/drivers/w1/w1_family.c
@@ -31,9 +31,6 @@ extern void w1_reconnect_slaves(struct w
 
 static int w1_check_family(struct w1_family *f)
 {
-       if (!f->fops->rname || !f->fops->rbin)
-               return -EINVAL;
-
        return 0;
 }
 


