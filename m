From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: w83781d hangs on i2c bus driver
Message-Id: <3EDD5C50.5030504@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Works fine on ISA.

If you modprobe an i2c bus driver after w83781d is modprobed, the bus driver modprobe hangs,
presumably while w83781d is scanning the bus.
If you modprobe w83781d after an i2c bus driver is modprobed, the w83781d modprobe hangs.

Any ideas let us know.
