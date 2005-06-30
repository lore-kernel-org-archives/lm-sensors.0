From: salahx@coronya.com (Salah Coronya)
Date: Thu, 30 Jun 2005 08:25:11 +0000
Subject: [lm-sensors] PnP and W83627HF/W83781D IO port conflict at
Message-Id: <42C3900F.9090108@coronya.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My motherboard, an ASUS P4B-LX has a W83627HF chip on it (as detected by
sensors-detect) that has the sensor reading on it,and more importantly,
allow control of the fan via PWM.

However, the W83781D module does not work - it loads, but nothing
happens. When i2c debugging message are enabled, it print the error
message "Request of region 0x290-0x297 for w83781d failed", although it
still loads. In
/proc/ioports it shows "pnp 00:0d" at port 0x0295-0x0296 both with and
without the module loaded.

Forcing it gives the same error and results. Passing
pnp_reserve_io=0x0290,8 in the command line has no effect, and no error
message or acknowlegement about the parameter either, even with PNP
Debug output.

If PNP is disabled in the kernel, I can access the sensor, get the
sensors readings, and control the fan.

