From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 07:10:59 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070301081059.ebe93462.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<20070228143836.GC30168@khazad-dum.debian.net>
In-Reply-To: <20070228143836.GC30168@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 28 Feb 2007 11:38:36 -0300, Henrique de Moraes Holschuh wrote:
> Ok, I have fan*_* and temp*_input hanging directly from the device (no
> groups).  However, that device has a lot of other stuff that is not even
> remotely accounted for in hwmon, such as control of video outputs and
> hotkeys, the firmware action beeper, etc.
> 
> Does that cause problems for lm-sensors, or would it just ignore the extra
> attributes and groups?

As long as the other file names do not collide with the any of names in
Documentation/hwmon/sysfs-interface, it's OK. libsensors will ignore
the extra stuff.

> I can provide two devices, ibm-acpi.0 and ibm-acpi.1, and have the hwmon
> attributes in only one of them, and register just that one with the hwmon
> class.  Would that be better/safer?

A single device would be fine. In the long run we will probbaly have to
turn the hwmon attributes into class attributes anyway, so they will
get their own naming space.

-- 
Jean Delvare

