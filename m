From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040916123814.M40115@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The interface change for VID lines (in0_ref -> cpu0_vid) is in linux
2.6.9-rc2. This means that we should make some kind of announcement on our
main page (to point 2.6.9-rc2 users to lm_sensors CVS), and prepare to release
lm_sensors 2.8.8 before linux 2.6.9 (final) is released.

Mark (Hoffman):
I think you have a plan to revert my bogus pwmN -> fanN_pwm interface change.
I believe that it would be great if you could add support for this in
libsensors before 2.8.8 is released. That way, people will need to upgrade
only once for both changes. Since libsensors now has room for one alternative
name for each feature, you don't need to update the drivers themselves now,
only the library.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
