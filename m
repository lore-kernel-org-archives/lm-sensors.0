From: psycho@albatross.co.nz (Keith Duthie)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: Hangs with w83781d
Message-Id: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In recent versions of lm_sensors, once I load the w83781d driver, apm
suspend stops working (immediately resumes), and I've experienced a number
of hangs that must be related to this.

The problem exists in 2.6.5 and 2.7.0, but does not exist in 2.6.3.

The kernel I'm using is 2.4.20 (with the ext3 and ptrace patches); the
motherboard is an abit bx6-r2 with the most recent bios.

Gcc is 2.95.3, binutils is 2.11.92.0.12.3, make is 2.79.1.


I'm currently using i2c and lm_sensors 2.7.0 with the 2.6.3 w83781d
module, and have noticed no problems so far since downgrading w83781d.
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
