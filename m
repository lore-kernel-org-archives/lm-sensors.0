From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jul 2013 17:22:51 +0000
Subject: [lm-sensors] [RFC PATCH 0/5] Introduce and use device_create_groups
Message-Id: <1373131376-13293-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

This patch series introduces the new driver core API function
device_create_groups().

device_create_groups() lets callers create devices as well as associated
sysfs attributes with a single call. This avoids potential race conditions
seen if sysfs attributes on new devices are created later.

The rationale for the new API is that sysfs attributes should be created
synchronously with device creation to avoid race conditions, as outlined in
http://www.linuxfoundation.org/news-media/blogs/browse/2013/06/how-create-sysfs-file-correctly.

Unfortunately, the only API function to create a device dynamically is
device_create, which does not support the notion of adding sysfs attributes
when creating a device. The new API call is similar but lets the caller provide
a list of sysfs attribute groups.

The first patch in the series introduces the new driver core API function.

The second patch introduces hwmon_device_register_groups(), which uses the new
API call.

The remaining patches convert some hwmon drivers to use the new API to show and
test its use.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
