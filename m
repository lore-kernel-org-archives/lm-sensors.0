From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks)
Message-Id: <2538186705051703394944e949@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>

Hi,

The following patches implement dynamic sysfs callbacks for
device_attribute, and provide a possible standard sensor attribute
macro for the majority of the i2c sensor chip/hwmon drivers. Finally a
patch against adm1026 shows how the patch can be used to reduce the
footprint and clean up an existing driver.

The new form of dynamic sysfs callback simply passes a reference to
the device_attribute struct, instead of a void *, along the lines of
the suggestion by Russell King (see
http://lkml.org/lkml/2005/5/14/116). Embedding the device_attribute
struct in a custom struct one can use a macro based on container_of to
access the custom attribute specific data.

Although functionally as capable as the void *, this solution I feel
is better in that it rids of some error-prone casting, and the
resulting code seems generally cleaner and easier to understand, there
is also no need for the extra void * member in the base sysfs
attribute. On the other hand a bit more work is required to implement
this on a grand scale, and in many cases a new attribute struct might
have to be defined for a driver, along with any convenience macros. My
example patch implements a new attribute struct
sensor_device_attribute that should be reusable by the majority of i2c
chip drivers (as suggested by Greg).

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
