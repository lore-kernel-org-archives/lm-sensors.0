From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 25 Jun 2015 11:46:35 +0000
Subject: [lm-sensors]  lm-sensors 3.4.0 has been released!
Message-Id: <20150625134635.10080a0a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.4.0.

Most important changes are:
* library: The arbitrary limit on per-type sensor count is gone
* library: Support for temperature min and critical min hysteresis
* sensors: Support for temperature min and critical min hysteresis
* fancontrol: Deal with moving hwmon attributes
* fancontrol: Fix shell error when FCFANS is not set
* fancontrol: Reduce memory consumption
* sensors-detect: Detection of new devices
* sensors-detect: Avoid probing graphics cards by default
* sensors-detect: Skip some addresses on graphics cards

See CHANGES for the details.

Phil, please copy the new release to your mirror as your time permits.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
