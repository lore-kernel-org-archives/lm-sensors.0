From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 27 Jul 2009 06:45:55 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] acpi_power_meter: hwmon driver for
Message-Id: <1248677155.2670.132.camel@rzhang-dt>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
	 <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Darrick,

great job. :)
comments in-line.

On Sat, 2009-07-25 at 08:43 +0800, Darrick J. Wong wrote:
> +/* Handle ACPI event notifications */
> +static void acpi_power_meter_notify(struct acpi_device *device, u32 even=
t)
> +{
> +       struct acpi_power_meter_resource *resource;
> +       int res;
> +
> +       if (!device || !acpi_driver_data(device))
> +               return;
> +
> +       resource =3D acpi_driver_data(device);
> +
> +       mutex_lock(&resource->lock);
> +       switch (event) {
> +       case METER_NOTIFY_CONFIG:
> +               res =3D read_capabilities(resource);
> +               if (res)
> +                       break;
> +
> +               remove_attrs(resource);
> +               setup_attrs(resource);
> +               break;
> +       case METER_NOTIFY_TRIP:
> +               update_meter(resource);
> +               break;
> +       case METER_NOTIFY_CAP:
> +               update_cap(resource);
> +               break;
> +       case METER_NOTIFY_INTERVAL:
> +               update_avg_interval(resource);
> +               break;
> +       case METER_NOTIFY_CAPPING:
> +               dev_info(&device->dev, "Capping in progress.\n");
> +               break;
> +       default:
> +               BUG();
> +       }
> +       mutex_unlock(&resource->lock);
> +}

we should at least send a netlink event for an ACPI power meter
notification, shouldn't we?

> +
> +static int acpi_power_meter_add(struct acpi_device *device)
> +{
> +       int res;
> +       struct acpi_power_meter_resource *resource;
> +
> +       if (!device)
> +               return -EINVAL;
> +
> +       resource =3D kzalloc(sizeof(struct acpi_power_meter_resource),
> +                          GFP_KERNEL);
> +       if (!resource)
> +               return -ENOMEM;
> +
> +       resource->sensors_valid =3D 0;
> +       resource->acpi_dev =3D device;
> +       mutex_init(&resource->lock);
> +       strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
> +       strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> +       device->driver_data =3D resource;
> +
> +       res =3D read_capabilities(resource);
> +       if (res)
> +               goto exit_free;
> +
> +       resource->trip[0] =3D resource->trip[1] =3D -1;
> +
> +       res =3D setup_attrs(resource);
> +       if (res)
> +               goto exit_free;
> +
> +       resource->hwmon_dev =3D hwmon_device_register(&device->dev);
> +       if (IS_ERR(resource->hwmon_dev)) {
> +               res =3D PTR_ERR(resource->hwmon_dev);
> +               goto exit_remove;
> +       }
> +

we should create the hwmon sysfs I/F for the hwmon device,
i.e. add the hwmon attributes
under /sys/devices/LINUXSYS:00/.../ACPI000D:00/hwmon0/
rather than =EF=BB=BF/sys/devices/LINUXSYS:00/.../ACPI000D:00/

> +       res =3D 0;
> +       goto exit;
> +
> +exit_remove:
> +       remove_attrs(resource);
> +exit_free:
> +       kfree(resource);
> +exit:
> +       return res;
> +}
> +
> +
> +static int __init acpi_power_meter_init(void)
> +{
> +       int result;
> +
	  if (acpi_disable)
		return -ENODEV;

> +       result =3D acpi_bus_register_driver(&acpi_power_meter_driver);
> +       if (result < 0)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static void __exit acpi_power_meter_exit(void)
> +{
> +       acpi_bus_unregister_driver(&acpi_power_meter_driver);
> +}
> +
> +MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
> +MODULE_DESCRIPTION("ACPI 4.0 power meter driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(acpi_power_meter_init);
> +module_exit(acpi_power_meter_exit);
>=20
plus, _PMD is not supported in this driver, right?
I agree with Yakui that we can create some ACPI device sysfs attributes
besides the hwmon ones. e.g. exporting devices measured by the current
ACPI power meter device to user space.

thanks,
rui


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
