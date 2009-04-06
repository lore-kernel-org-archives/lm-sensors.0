From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 07:55:53 +0000
Subject: [lm-sensors] [PATCH 0/8] sensord: Some cleanups,
Message-Id: <20090406075553.GA4734@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

this patch series fixes some issues caused by the coding style
conversion a while ago. Most of them are deep indentation levels and
the related long lines.

Another patch removes the hidden commandline interface. You can call
sensord as an console application if you have a link (sensors)
pointing to the sensors deamon (sensord). IMO that's really
intransparent and I don't know any reason using this.

Further there is a patch introducing a new structure
(sensord_arguments). The extern struct sensord_args in args.c now is
the place for all the commandline arguments.

A last one replaces the deprecated signal() function by sigaction.

Andre
---

 args.c    |  205 +++++++++++++++++++++++++++++---------------------------------
 args.h    |   30 +++++++++
 lib.c     |   93 ++++++++++++++++------------
 rrd.c     |  108 ++++++++++++++++----------------
 sense.c   |    6 -
 sensord.c |   89 ++++++++++++++++----------
 sensord.h |   18 -----
 7 files changed, 294 insertions(+), 255 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
