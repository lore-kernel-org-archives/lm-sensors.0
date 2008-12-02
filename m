From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Dec 2008 14:15:01 +0000
Subject: [lm-sensors] Call for 2.10.8
Message-Id: <20081202151501.23d85131@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Due to a compatibility issue with the it87 driver in the upcoming
kernel 2.6.28, I would like to release lm-sensors 2.10.8 now.

There are other interesting changes in SVN which make it a good idea to
make a new release anyway. In no particular order: kernel driver fixes
backported from Linux 2.6, user-space support for the IT8720F, minor
fixes to decode-dimms, pwmconfig and sensord, and many chips added to
sensors-detect.

Proposed schedule:
* December 3rd: SVN freeze
* December 4th-6th: testing
* December 7th: release

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
