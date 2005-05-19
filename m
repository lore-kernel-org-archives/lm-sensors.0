From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-Id: <253818670505070621784dbd63@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Jean Delvare <khali@linux-fr.org>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

Hi,

This patch against 2.6.12-rc4 adds a void * field to the base sysfs
attribute, and updates all the derived attributes (device_attribute,
etc) to pass the void * to their sysfs callbacks. This facilitates a
number of things:

- reduce the size of much of the sysfs attribute code significantly by
allowing the replacement of the large number of macro generated
virtually identical sysfs callbacks with a single sysfs callback that
uses the void * parameter to decide what to do. For example, adapting
adm1026 to take advantage of this patch:

-------------------2.6.11.7--------------------
Module                  Size  Used by
adm1026                44692  0
--------2.6.12-rc3-devdyncallback-----
Module                  Size  Used by
adm1026                33172  0

(see http://archives.andrew.net.au/lm-sensors/msg31310.html)

- allow the creation of a non-predetermined and potentially unlimited
number of sysfs attributes, this is required by bmcsensors - a driver
I am porting from lm_sensors 2.4 to 2.6.

(see http://archives.andrew.net.au/lm-sensors/msg31225.html ,
http://bmcsensors-26.sourceforge.net/)

This first patch changes the core sysfs attribute and derived attributes.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-core.diff
Type: text/x-patch
Size: 17284 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050507/65896876/patch-linux-2.6.12-rc4-sysfsdyncallback-core.bin
