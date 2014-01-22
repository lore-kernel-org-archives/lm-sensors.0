From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Jan 2014 08:26:26 +0000
Subject: [lm-sensors] lm-sensors 3.3.5 has been released!
Message-Id: <20140122092626.6be9b88e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.3.5. This is again a maintenance release
with not so much to announce.

Most important changes are:
* library: Support up to 33 sensors of the same type per monitoring
           chip (needed for recent Intel processors, coretemp driver)
* sensors-detect: Detection of new devices
* sensors-detect: Better handling of built-in drivers
* sensors-detect: Added non-interactive (automatic) mode

See CHANGES for the details.

Phil, please copy the new release to your mirror as your time permits.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
