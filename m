From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:00:01 +0000
Subject: [lm-sensors] [PATCH v2 0/7] sensord: Some cleanups,
Message-Id: <20090511160001.GA17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

here is the updated patch series according to your notes. Thanks for
your careful review.

There is much work left. I will go on with cleanups in further patches
(see the note in patch 1/7). I've dropped patch 2/8.

You can see the changes in the changelog of every patch under "Changes
in v2".

Thanks,
Andre
---
 args.c    |  177 +++++++++++++++++++++-----------------------------------------
 args.h    |   30 ++++++++++
 lib.c     |   74 +++++++++++++------------
 rrd.c     |  110 +++++++++++++++++++-------------------
 sense.c   |    6 +-
 sensord.c |  103 +++++++++++++++++++++---------------
 sensord.h |   18 ------
 7 files changed, 246 insertions(+), 272 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
