From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Mon, 03 Jul 2006 12:48:23 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS, ...)
Message-Id: <20060703124823.GA18821@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

We have now (or we are about to have, anyway) two drivers that export
accelerometer data: IBM's HDAPS, and Apple's AMS.  More accelerometer
drivers could be coming in the future.

Both drivers export one common set of data (accelerometer output), and some
extra information that is not related to acellerometers.  Both have at least
two functionality goals in common: to export accelerometer data to
userspace, and also to allow somehow for HD head parking when the
accelerometer detects a potentially incoming impact.

User?space utilities that interface to accelerometers like hdapsd and
smackpad could benefit from a common interface, so that they work with
HDAPS, AMS, and any other future accelerometer drivers.

If any kernel-space functionality needed by HDAPS and AMS is also shared, we
would have benefits there too.  Some examples I can think of are: generic HD
queue-freeze and HD head parking, and a generic acellerometer-driven
joystick event interface.  This would also enable generic userspace
notifiers that the HD heads have been parked, etc.

I am posting this message as a head's up for the two projects (HDAPS, AMS)
to make sure that they are actively aware of each other.  I do so in hope
that we can work in a joint, generic interface and port both drivers to this
new interface in the near future, and also that we can make as much
functionality shared between the two drivers as possible.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

