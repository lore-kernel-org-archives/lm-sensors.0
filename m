From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jun 2007 20:48:39 +0000
Subject: Re: [lm-sensors] Converting vt8231 to a platform driver
Message-Id: <20070610224839.7cdeeb94@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603135804.3aa2b7fb@hyperion.delvare>
In-Reply-To: <20070603135804.3aa2b7fb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

On Sat, 9 Jun 2007 11:58:32 +0100, Roger Lucas wrote:
> I have converted the vt8231 driver to a platform driver as you requested and
> it seems to be working OK except for a "Trying to free nonexistent resource"
> error message when I rmmod the driver.
> 
> I am running with a 2.6.16.20 kernel and my "remove/exit" functions in the
> revised vt8231 driver are:
> 
> static int vt8231_remove(struct platform_device *pdev)
> {
> 	struct vt8231_data *data = platform_get_drvdata(pdev);
> 	int i;
> 
> 	hwmon_device_unregister(data->class_dev);
> 
> 	for(i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
> 		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_volts[i]);
> 
> 	for(i = 0; i < ARRAY_SIZE(vt8231_group_temps); i++)
> 		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_temps[i]);
> 
> 	sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
> 
> 	release_region(data->addr, VT8231_EXTENT);
> 	platform_set_drvdata(pdev,NULL);
> 	kfree(data);
> 	return 0;
> }
> 
> static void __exit sm_vt8231_exit(void)
> {
> 	pci_unregister_driver(&vt8231_pci_driver);
> 	if (s_bridge != NULL) {
> 		platform_device_unregister(pdev);
> 		platform_driver_unregister(&vt8231_driver);
> 		pci_dev_put(s_bridge);
> 		s_bridge = NULL;
> 	}
> }

Looks alright.

> This seems to be correct compared to the patch that you put in for the
> via686a driver as referenced in your e-mail below.  I believe that I am
> correctly requesting the region in the vt8231_probe() function and the only
> other place it is released is in the vt8231_probe() error cleanup code.
> 
> I have seen some comments from you about this error along with a kernel
> patch to change the re-ordering in platform_device_del().  
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018937.html
> 
> I think they are relevant here because I suspect that with the above code
> and your patch, the vt8231_remove() function would be called _before_ the
> platform_device_del() function automatically frees any allocated resources
> and therefore should work without error.  With the above code but without
> your patch, platform_device_del() has already automatically freed the region
> before the vt8231_remove() function is called and so the region gets
> released twice.

Totally correct.

> Given that the cleanup code in platform_device_del() releases the region
> automatically (although the exact ordering depends on the patch), isn't the
> call to release_region() in vt8231_remove() unnecessary?

Yes and no. With our current driver driver architecture, and with the
way the driver core handles resources at the moment, it is unnecessary.
However, ideally our drivers would _not_ control the device lifetime,
only the driver lifetime. In which case, it really matters to release
the resource in vt8231_remove(), otherwise you can't reload the driver.
And I am also not sure that this is correct that the driver core
accepts to silently remove a device those I/O region is still marked as
busy. I'd expect at least a warning, so let's anticipate the day the
driver core is changed to do this.

If your patch is ready, can you please just sign it and send it over?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
