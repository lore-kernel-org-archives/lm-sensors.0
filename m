From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Oct 2010 19:56:31 +0000
Subject: [lm-sensors] lm-sensors 3.2.0 has been released!
Message-Id: <20101010215631.043bdf41@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.2.0 as announced earlier this week.
Additionally to the usual bug fixes and improved device detection, the
big change this time is the libsensors license change. If you missed
it, the details are at:
  http://www.lm-sensors.org/wiki/LibsensorsLicense

Most important changes are:
* The libsensors library is now released under the LGPL license.
* Minor fixes to libsensors, pwmconfig, sensors and sensord.
* New chips known by sensors-detect, as usual.

See CHANGES for the details.

Phil, please copy the new release to your mirror as your time permits.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
