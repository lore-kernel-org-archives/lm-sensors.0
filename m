From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 28 Apr 2007 01:12:55 +0000
Subject: [lm-sensors] Conversion of ibm-acpi to hwmon sysfs sent to ACPI tree
Message-Id: <20070428011255.GB23519@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

FYI: I have sent a group of patches to Len Brown (ACPI tree maintainer) that
adds hwmon support to thinkpad-acpi (ibm-acpi's new name).  It exports 16
temperatures and one fan with PWM control through the hwmon interface, and
targets 2.6.22.

The patches make extensive use of ENXIO for temperature sensors that are
hotpluggable but for which we cannot detect the plug/unplug events.  Reading
a sensor that is not present at that instant returns ENXIO.

The patches are available in the ibm-acpi-devel and linux-acpi ML archives,
and also by request or through
http://repo.or.cz/w/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
