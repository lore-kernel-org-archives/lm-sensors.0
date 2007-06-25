From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 08:16:48 +0000
Subject: [lm-sensors] Call for 2.10.4
Message-Id: <20070625101648.511dc9c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

We should start planning the release of lm-sensors 2.10.4. The list of
changes is getting long. We have Linux 2.4 support for the
W83627EHF/EHG, support for extra W83627EHF/EHG/DHG features (VID and
thermal sensor types), support for the dme1737 and applesmc chips, an
improved fancontrol script (needs testing!) and an updated
sensors-detect.

I propose the following schedule:
* July 8th: SVN freeze
* July 9th-15th: testing
* July 16th: release

One again, no i2c release; there's only one minor fix there, that's
just not worth it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
