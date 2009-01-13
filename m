From: Mark Nienberg <gmane@tippingmar.com>
Date: Tue, 13 Jan 2009 18:26:23 +0000
Subject: [lm-sensors] sensord with rrd
Message-Id: <gkimcg$46k$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have lm_sensors running and "service lm_sensors status" gives correct results.

Now if I start sensord with

INTERVAL=0
LOG_INTERVAL0m

then it works just fine and logs to syslog just like I want it to.

If I start it with

INTERVAL=0
LOG_INTERVAL0m
RRD_LOGFILE=/var/log/sensors.rrd

then i get

sensord: creating round robin database
sensord: Error creating RRD: /var/log/sensors.rrd: No sensors detected

Is there something else I have to do to get the rrd part to work?

Thanks,

Mark


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
