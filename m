From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2007 13:57:06 +0000
Subject: [lm-sensors] sensord bug in lm-sensors 3.0.0
Message-Id: <20071211145706.31e52982@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Unfortunately I introduced a bug in sensord shortly before releasing
lm-sensors 3.0.0. It was reported yesterday:
http://www.lm-sensors.org/ticket/2276

I've fixed it in SVN today:
http://www.lm-sensors.org/changeset/5069

People responsible for packaging lm-sensors for a distribution will
probably want to backport this fix. Without it, the rrd feature of
sensord is essentially unusable.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
