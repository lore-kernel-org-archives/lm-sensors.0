From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 25 Mar 2012 05:00:30 +0000
Subject: [lm-sensors] [PATCH v2 0/3] hwmon: (it87) Add support for IT8782F and IT8783E/F
Message-Id: <1332651633-23560-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Plus some cleanup

v2:
- Drop support for IT8781F
- Separate IT8782F and IT8783E/F
- Clean up documentation
- Simplify LSB calculation code
- IT8782F is similar to IT8721F and IT8728F, except it has a 6th UART.
  Move pin detection to generic pin detection code.
- Add patch to only create voltage attributes for enabled inputs
- Add patch converting driver to use devm_kzalloc().

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
