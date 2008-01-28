From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Jan 2008 18:25:37 +0000
Subject: [lm-sensors] lm-sensors 3.0.1 has been released!
Message-Id: <20080128192537.70a0c288@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.0.1.

Important changes compared to lm-sensors 3.0.0:
* libsensors no longer depends on libsysfs. This change makes libsensors
  much faster, in particular at initialization time. Memory consumption
  was also significantly reduced.
* Many fixes to pwmconfig.
* RRD support in sensord is working again.
* Improved sysconfig and modprobe.d integration in sensors-detect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
