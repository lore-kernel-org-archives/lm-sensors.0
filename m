From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 May 2008 16:43:47 +0000
Subject: [lm-sensors] lm-sensors 3.0.2 has been released!
Message-Id: <20080518184347.7defe273@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.0.2.

Important changes compared to lm-sensors 3.0.1:
* libsensors now supports virtual hardware monitoring devices, such as
  the generic thermal zones which have been added in Linux kernel
  2.6.26.
* Support for power and energy sensors was added.
* sensors-detect was made safer, by trying to detect and skip
  1-register-only devices. It also prefers byte reads over word reads
  when possible, as not all devices like word reads. This should
  hopefully prevent the hardware issues that had been reported over the
  last few weeks.

Phil, please copy the new files to your mirror, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
