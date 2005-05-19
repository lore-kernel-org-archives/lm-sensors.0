From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: make user?
Message-Id: <3D13EBBD.DB66D3EA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In preparation for sensors being in the kernel someday
we should probably work on Makefile and documentation updates
so that only the userspace parts are built and installed with,
for example, make user or make user-install or something like that.

Any volunteers?
