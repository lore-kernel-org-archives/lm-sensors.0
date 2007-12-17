From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Dec 2007 22:11:09 +0000
Subject: [lm-sensors] sensors.conf.eg bug in lm-sensors 3.0.0
Message-Id: <20071217231109.3d6d26f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Aurelien Jarno just reported to me that lm-sensors 3.0.0 prints error
messages for some chips (specifically: gl520sm, lm80 and pc87366). This
is due to missing symbol name conversions in compute statements in the
default configuration file.

I've just fixed it in SVN:
http://www.lm-sensors.org/changeset/5076

People responsible for packaging lm-sensors for a distribution will
probably want to backport this fix.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
