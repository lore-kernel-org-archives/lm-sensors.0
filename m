From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 20 Aug 2009 23:47:41 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] acpi_power_meter: hwmon driver for
Message-Id: <20090820164741.707b0340.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090818234757.2004.88017.stgit@elm3a70.beaverton.ibm.com>
	<20090818234810.2004.13573.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20090818234810.2004.13573.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org
Cc: djwong@us.ibm.com, lenb@kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, pavel@ucw.cz

On Tue, 18 Aug 2009 16:48:10 -0700
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> devices.  This second revision of the driver also exports the ACPI string
> info as sysfs attributes, a list of the devices that the meter measures,
> and will send ACPI notifications over the ACPI netlink socket.

This is not my favoritest ever patch.

drivers/acpi/power_meter.c:459: error: 'POWER_AVERAGE' undeclared here (not in a function)

and

drivers/acpi/power_meter.c: In function 'read_domain_devices':
drivers/acpi/power_meter.c:544: error: syntax error before 'PREFIX'
drivers/acpi/power_meter.c: In function 'read_capabilities':
drivers/acpi/power_meter.c:759: error: syntax error before 'PREFIX'
drivers/acpi/power_meter.c:776: error: syntax error before 'PREFIX'

and once I fixed those,

drivers/acpi/power_meter.c: In function 'register_ro_attrs':
drivers/acpi/power_meter.c:611: warning: 'res' may be used uninitialized in this function
drivers/acpi/power_meter.c: In function 'register_rw_attrs':
drivers/acpi/power_meter.c:639: warning: 'res' may be used uninitialized in this function


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
