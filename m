From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 21:41:42 +0000
Subject: [lm-sensors] Call for 3.3.0
Message-Id: <20110316224142.0493f53b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Last release of lm-sensors (3.2.0) was in October 2010, 5 months ago.
The list of changes since then is getting large, so it's time for a new
release. The changes are important enough that I would go for 3.3.0
rather than 3.2.1 as originally planned.

This decision is motivated by the long list of new attributes and even
new sensor types handled by libsensors and sensors. Other changes worth
mentioning are Guenter's generic code to display limit values in
"sensors", the removal of some arbitrary limits in libsensors attribute
enumeration code, and the usual addition of many new devices to
sensors-detect.

The planned schedule is as follows:
* Saturday, March 19th, 2011: SVN freeze
* March 20th to 25th: Testing and bug fixing
* Saturday, March 26th, 2011: Release

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
