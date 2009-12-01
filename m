From: Wu Zhangin <wuzhangjin@gmail.com>
Date: Tue, 01 Dec 2009 11:09:58 +0000
Subject: [lm-sensors] [PATCH v6 0/8] Loongson: YeeLoong: add platform
Message-Id: <cover.1259660040.git.wuzhangjin@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mips@linux-mips.org, zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds platform specific drivers for YeeLoong netbook. including
the backlight, battery, hwmon, video output, suspend and hotkey(input) drivers.
These drivers provide standard interfaces to the user-space applications to
manage the relative devices:
	
 	 Modules			Tools

	- backlight
	  /sys/class/backlight/		kpowersave, gnome-power-manager
	- battery
	  /proc/apm			kpowersave, gnome-power-manager
	- hwmon
	  /sys/class/hwmon/		lm-sensors, sensors-applet...
	- video output
	  /sys/class/video_output	?
	- suspend
	  /sys/power/state		kpowersave, gnome-power-manager
	- hotkey
	  /sys/class/input/		gnome-settings-daemon ?

To utilize the above interfaces, you are recommended to install the latest hal,
dbus.

This v6 revision incorporates with the feedbacks from Ralf, Pavel Machek,
Rafael J. Wysocki and Dmitry Torokhov.

Changes from the old v5 revision:

	- Cleanup the "select" and "depend" of the options
	  Replace some "select"s by "depend"s to avoid potential compiling
	  errors.

	- Cleanup the hotkey(input) driver
	  Merge several functions, Cleanup the comments, Use Switch...Case
	  instead of the array.

	- Fixup of the video output driver  
	  Seems the video output subsystem doesn't handle the input value, we
	  handle it outselves via !!od->request_state.

	- Append the yl_ prefix to the file names
	  yl_ prefix is needed to distinguish it with the next patchset for
	  lynloong pc platform drivers.

All changes have been tested again.

Best Regards,
     Wu Zhangjin

Wu Zhangjin (8):
  Loongson: Lemote-2F: add platform specific submenu
  Loongson: YeeLoong: add platform specific option
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add battery driver
  Loongson: YeeLoong: add hwmon driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend driver
  Loongson: YeeLoong: add hotkey driver

 arch/mips/kernel/setup.c                           |    1 +
 arch/mips/loongson/Kconfig                         |   21 +
 arch/mips/loongson/lemote-2f/Makefile              |    7 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  130 ------
 arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  188 --------
 arch/mips/loongson/lemote-2f/pm.c                  |    4 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   65 +++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |   10 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 ++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  193 +++++++++
 .../lemote-2f/yeeloong_laptop/yl_backlight.c       |   93 ++++
 .../lemote-2f/yeeloong_laptop/yl_battery.c         |  127 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c |  452 ++++++++++++++++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c  |  239 +++++++++++
 .../lemote-2f/yeeloong_laptop/yl_suspend.c         |  135 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_vo.c     |  164 +++++++
 17 files changed, 1635 insertions(+), 322 deletions(-)
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
