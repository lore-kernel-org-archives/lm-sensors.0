From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 08:44:58 +0000
Subject: [lm-sensors] [PATCH 0/7] sensord: Coding style conversion (gnu ->
Message-Id: <20090309084458.GA4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series converts the coding style in prog/sensord/ from gnu to
kernel style. So we are consistent all over the project.

The conversion have exposed some very deep indentation levels. So it
was impossible to not break the 80-characters-per-line rule. Some of
them I already fixed, but other ones can only be fixed by
restructuring the code. I will do that in further patches.

--
 args.c    |  462 +++++++++++++++++++-------------------
 chips.c   |  547 +++++++++++++++++++++++----------------------
 lib.c     |  119 +++++----
 rrd.c     |  743
 ++++++++++++++++++++++++++++++++------------------------------
 sense.c   |  399 +++++++++++++++++----------------
 sensord.c |  382 ++++++++++++++++---------------
 sensord.h |   61 ++---
 7 files changed, 1395 insertions(+), 1318 deletions(-)

Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
