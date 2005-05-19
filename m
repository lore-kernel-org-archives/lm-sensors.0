From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Support of i2c-nscacb
Message-Id: <20050505155817.656bb225.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4263B107.1070703@buholzer.com>
In-Reply-To: <4263B107.1070703@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mirko,

> Do you have any hints or docu links where I can find more information
> to  extend the lm77 driver with user-space?

Checklist from lm_sensors2/doc/developers/new_drivers (which you can
read for additional information):

=* Add chip information to lib/chips.{c,h} (for chip drivers only).
  Until you have done this, the chip will be invisible for user-level
  programs which use libsensors. Use standard names in lib/chips.c;
  see also the comments in etc/sensors.conf.eg for help.
  Contact us if you need more assistance.

* Be sure that SYSCTL and ALARM definitions in the driver are bracketed
  by the special comments so that the kernel/include/sensors.h
  file, which is generated automatically, contains your definitions.
  (for chip drivers only)

* Add a procedure to prog/sensors/chips.[ch] (for chip drivers only).
  This is a function specific for your driver that
  makes the included 'sensors' program pretty-print your chip information.

* Add a call to the procedure in prog/sensors/main.c (for chip drivers only).
  Put it at the bottom of do_a_print().

* Add entries to etc/sensors.conf.eg (for chip drivers only).
  If needed, you can set defaults here.

* Add the name of the device to the README file.
=
That's for the theory. In fact, I'd invite you to grep for "lm92" in
lm_sensors2/{lib,prog/sensors,etc}, and duplicate everything as "lm77",
and start from there (the LM92 and LM77 have very similar
functionalities IIRC).

Note that SYSCTL values are only needed for Linux 2.4 drivers, 2.6
drivers don't have them, and there is no 2.4 version of the lm77 driver,
so no SYSCTL values have been defined for the lm77 driver. This means
that you can safely use NOSYSCTL instead of real SYSCTL values.

If you meet specific problems, feel free to ask questions and we'll try
to answer them.

Thanks,
-- 
Jean Delvare
