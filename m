From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Aug 2007 15:02:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070819170240.28917f81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Sat, 18 Aug 2007 18:07:49 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 17 Aug 2007, Jean Delvare wrote:
> > Support more bus types (part 1 of 2). Originally libsensors was very
> > i2c-centric. Make it more neutral so that we can cleanly support
> > additional bus types such as SPI or One-Wire.
> ...
> 
> > +#define SENSORS_BUS_TYPE_ANY	(-1)
> > +#define SENSORS_BUS_TYPE_I2C	0
> > +#define SENSORS_BUS_TYPE_ISA	1
> > +#define SENSORS_BUS_TYPE_PCI	2
> > +#define SENSORS_BUS_NR_ANY	(-1)
> 
> What about BUS_HOST, for drivers doing a firmware<->hwmon bridge, like
> thinkpad-acpi, asus-acpi, sonypi... ?   They usually attach to the device
> tree through one or more platform devices, and we are now trying to export
> fan control and thermal monitoring using the hwmon class...
> 
> Or am I in the wrong track here?

Thanks for pointing this out, indeed we need to make sure that the new
libsensors will work properly with the thinkpad_acpi driver and other
similar drivers. However I do not think that we need a special bus type
for these. The thinkpad_acpi driver instantiates a platform device (as
you mentioned yourself), and platform drivers are covered by the "ISA"
bus type in libsensors (for historical reasons mainly.)

BTW, I just gave a try to the thinkpad_acpi driver (in 2.6.22.3) with
libsensors4. I had to make the following changes to the driver for
libsensors4 to recognize it:

--- linux-2.6.22.orig/drivers/misc/thinkpad_acpi.c
+++ linux-2.6.22/drivers/misc/thinkpad_acpi.c
@@ -4211,6 +4211,13 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+static ssize_t thinkpad_acpi_show_name(struct device *dev, struct
+				      device_attribute *devattr, char *buf)
+{
+	return sprintf(buf, "thinkpad\n");
+}
+static DEVICE_ATTR(name, S_IRUGO, thinkpad_acpi_show_name, NULL);
+
 static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
@@ -4248,7 +4255,7 @@ static int __init thinkpad_acpi_module_i
 
 
 	/* Device initialization */
-	tpacpi_pdev = platform_device_register_simple(IBM_DRVR_NAME, -1,
+	tpacpi_pdev = platform_device_register_simple(IBM_DRVR_NAME, 0,
 							NULL, 0);
 	if (IS_ERR(tpacpi_pdev)) {
 		ret = PTR_ERR(tpacpi_pdev);
@@ -4257,6 +4264,12 @@ static int __init thinkpad_acpi_module_i
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	ret = device_create_file(&tpacpi_pdev->dev, &dev_attr_name);
+	if (ret) {
+		printk(IBM_ERR "unable to create name attribute\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
 	tpacpi_hwmon = hwmon_device_register(&tpacpi_pdev->dev);
 	if (IS_ERR(tpacpi_hwmon)) {
 		ret = PTR_ERR(tpacpi_hwmon);

Basically, two changes: add a "name" attribute to the device, and give
the platform device an instance number.

The name attribute is needed and must be added to the thinkpad_acpi
driver now, otherwise it won't work with libsensors (neither current nor
libsensors4). This is where libsensors gets the "prefix" part of a
chip name.

The instance number is required for now, this is where libsensors gets
the "address" part of a chip name for platform devices. However, I
admit that it's not ideal that you have to declare a fake instance
number in the case of the thinkpad_acpi driver, as there can be only
one device almost by definition. Ideally libsensors should default to
address 0 for platform devices with no instance number. This should be
addressed as part of:

http://www.lm-sensors.org/ticket/2240

But I didn't plan to fix this before 3.0.1. Maybe we can have a
temporary workaround before that so that we don't have to hack the
thinkpad_acpi driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
