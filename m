From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: robustified adm1021
Message-Id: <3E173681.3050806@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Couldn't find the thread, but there was some discussion about how i2c-core returns failures as -1
and the chip drivers just take that, cast it to a u8, and that gets converted by
libsensors and reported as the value.

Also I think that adm1021 was a driver that tended to get intermittent errors.

So I took adm1021 and modified update_client to return the old value if the
read failed, as a demonstration. Comments welcome.

This behavior or something similar should be our practice going forward for
non-ISA chip drivers.

mds
