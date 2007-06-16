From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 16 Jun 2007 03:37:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix a potential race condition on
Message-Id: <20070616033714.GC3257@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070612135719.3f4c61a5@hyperion.delvare>
In-Reply-To: <20070612135719.3f4c61a5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-06-12 13:57:19 +0200]:
> Fix a potential race condition when some hardware monitoring platform
> drivers are being unloaded. I believe that the driver data pointer
> shouldn't be cleared before all the sysfs files are removed, otherwise
> a sysfs callback might attempt to dereference a NULL pointer. I'm not
> sure exactly what the driver core protects drivers against, so let's
> play it safe.
> 
> While we're here, clear the driver data pointer when probe fails, so
> as to not leave an invalid pointer behind us.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to testing w/ one addition for vt8231...

--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -743,6 +743,7 @@ exit_remove_files:
        sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
 
 exit_free:
+       platform_set_drvdata(pdev, NULL);
        kfree(data);
 
 exit_release:

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
