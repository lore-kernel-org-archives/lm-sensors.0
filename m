From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 07:06:58 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070301080658.64316c73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<1172655111.11100.50.camel@localhost.localdomain>
In-Reply-To: <1172655111.11100.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lm-sensors@lm-sensors.org, ibm-acpi-devel@lists.sourceforge.net, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Wed, 28 Feb 2007 17:31:51 +0800, Zhang Rui wrote:
> The standard ACPI "fan" and "thermal" modules?
> I'm converting these two modules to sysfs. I think "thermal" has too
> much ACPI specific information and is not that easy to have a generic
> interface.
> Could you give some more detailed descriptions please? :)

Indeed, ACPI thermal zone may have more thermal trip points than the
hwmon interface specifies. Two of the trip points can be mapped to
temp1_max and temp1_crit, respectively. If we want to handle them all,
then probably we have to implement Henrique's suggestion and really
think in terms of thermal zones, i.e. the trip points would be mapped
to temp1_auto_point[1-*]_temp and possibly associated with a fan speed
output.

-- 
Jean Delvare

