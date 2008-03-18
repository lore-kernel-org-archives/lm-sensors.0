From: Len Brown <lenb@kernel.org>
Date: Tue, 18 Mar 2008 05:31:30 +0000
Subject: [lm-sensors] [PATCH] Re: Dependency chain of new thermal driver
Message-Id: <200803180131.30662.lenb@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080316155659.7ab2446d@hyperion.delvare>
In-Reply-To: <20080316155659.7ab2446d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

On Sunday 16 March 2008, Jean Delvare wrote:
> Hi Rui,
> 
> I am testing your new thermal driver and I am not very happy with the
> dependencies introduced by this driver. The ACPI thermal driver selects
> the generic thermal driver, which in turn selects the hwmon base
> module. As the generic thermal driver's configuration option is a
> boolean, this means that as soon as one selects the ACPI thermal driver
> (built-in or modular), the hwmon thermal driver has to be built into
> the kernel. This is a problem especially when both the ACPI_THERMAL and
> THERMAL options default to y.
> 
> I fail to see why we are using select at all. The ACPI thermal driver
> clearly works without the generic thermal driver (even though the
> generic interface is preferred now.) Likewise, the generic thermal
> interface driver doesn't need the hwmon base module to work; the hwmon
> interface is only an extension, so it should be possible to build the
> generic thermal driver without hwmon support. On top of that, I really
> would like to be able to build the generic thermal driver as a module.
> 
> One of the reasons why I would like this to change is this bug:
> https://bugzilla.redhat.com/show_bug.cgi?idC7637
> http://bugzilla.kernel.org/show_bug.cgi?id259
> (At the moment I think both reports are the exact same bug.)
> 
> We will have to fix this bug of course (not sure how...) but the fact
> that the users can't temporarily remove the generic thermal driver is a
> problem both for bug investigation and for working around the bug until
> it's fixed. I really would like to be able to tell the user "rmmod this
> module until we come up with a fix", but right now I can't.
> 
> A more modular setup would give us much more flexibility both at build
> time and when bugs are reported. Please think about it.
> 

You are absolutely right -- this is gone from 2.6.25,
lets get it right in 2.6.26.

BTW. speaking of 2.6.26....
the patch below might become helpful.  For it would
be nice if at build-time we could just have hwmon_device_register()
fail, rather than put a bunch of #ifdef HWMON in our code.

thanks,
-Len

Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..68968cc 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -16,9 +16,13 @@
 
 #include <linux/device.h>
 
+#ifdef CONFIG_HWMON
 struct device *hwmon_device_register(struct device *dev);
-
 void hwmon_device_unregister(struct device *dev);
+#else
+static struct device *hwmon_device_register(struct device *dev) { return ERR_PTR(-ENODEV); };
+static void hwmon_device_unregister(struct device *dev) { return; };
+#endif
 
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
