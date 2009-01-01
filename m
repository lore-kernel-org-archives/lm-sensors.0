From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Jan 2009 22:06:59 +0000
Subject: [lm-sensors] ACPI versus native IC drivers
Message-Id: <495D3E83.8040003@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've made a good start with reviewing the new ATK0110 driver. And I must say I 
like it. But, there is a big but.

On my Asus M2N SLI Deluxe motherboard, with this driver loaded the two hwmon 
IC's on this board (one superio, one smbus) get hit by both the ACPI and native 
driver code. This is bad, really bad!

Luckily I can fix this by:
1) Using Jean's queued patch for adding acpi resource checks to superio drivers 
from here:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-acpi-check-conflict.patch

2) Specifying: "acpi_enforce_resources=strict" on the command line

With this, the native drivers will no longer load. As we have no idea what the 
ACPI code is doing (it might be updating the readings periodically based on a 
timer for all we know). To me this (causing the native drivers to no longer 
load) seems to be the right solution.

The patch adding these checks to the super-io drivers is already queued for 
2.6.29. But that won't help as the current behaviour is to only warn when there 
is a conflict.


So I would like to suggest to change the default setting for 
acpi_enforce_resources from nag to strict. This will only impact smbus 
controllers and superio hwmon code as those are the only 2 using it.

I would personally like to take things even further and believe it would be 
correct to do an acpi resource check with warning level only in the low level 
resource alloc. code for all resource allocation. But that is a different 
discussion.

Back on topic, there is one big "but" here. If we change the default setting 
for acpi_enforce_resources to strict, then this will cause problems for people, 
and those problems will get seen as regressions. For example many asus users 
will stop having functional sensors (atleast in my asus board ACPI claims the 
relevant resources for accessing the sensors). Still I think we should make the 
default strict, as that seems the right thing to do. As this is an option 
people can always change the option as a work around if this causes too much pain.

Making this option strict by default is the only safe way I see for ever 
allowing the atk0110 driver in to the mainline kernel.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
