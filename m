From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 Jan 2006 07:10:12 +0000
Subject: [lm-sensors] [lm-sensors-commit] lm_sensors2 CHANGES
Message-Id: <20060119081012.084b83dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	CHANGES 
> Log Message:
> (mmh) Add note - libsensors(3) doesn't see eeprom/SPD anymore.

For now, this is true for Linux 2.6 only. With Linux 2.4, the eeprom
data is still presented.

In the long run, we will probably drop eeprom (and ddcmon) code
completely from libsensors and sensors, and then Linux 2.4 users will
be affected too. But before we can do, we need a better replacement at
least for SPD data. decode-dimms.pl is not bad, but it lacks some major
features (it doesn't display the memory module size!) and isn't exactly
user-friendly in the way it presents the data. It looks to me like it
was written with a decode-every-single-register approach rather than a
what-the-user-wants-to-know approach.

-- 
Jean Delvare

