From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Wed, 28 Feb 2007 14:38:36 +0000
Subject: [lm-sensors] RFC: conversion of ibm-acpi to hwmon sysfs
Message-Id: <20070228143836.GC30168@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
In-Reply-To: <20070226172716.b2e956b7.khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 26 Feb 2007, Jean Delvare wrote:
> > I was going to place all fan attributes in a sysfs group (subdirectory)
> > named "fan", and all thermal attributes in a sysfs group named "thermal". Is
> > that acceptable?
> 
> No, it's not, as it wouldn't be compatible with what all the other
> drivers do and what libsensors expects.

Ok, I have fan*_* and temp*_input hanging directly from the device (no
groups).  However, that device has a lot of other stuff that is not even
remotely accounted for in hwmon, such as control of video outputs and
hotkeys, the firmware action beeper, etc.

Does that cause problems for lm-sensors, or would it just ignore the extra
attributes and groups?

I can provide two devices, ibm-acpi.0 and ibm-acpi.1, and have the hwmon
attributes in only one of them, and register just that one with the hwmon
class.  Would that be better/safer?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

