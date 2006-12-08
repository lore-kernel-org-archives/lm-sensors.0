From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 08 Dec 2006 14:38:17 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <20061208153817.de1c2b4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After much effort from Yuan Mu and Gong Jun from Winbond, and Rudolf
Marek and myself, the w83793 hardware monitoring driver is finally
ready to be merged upstream. I'm attaching the "final" version to this
mail, together with the patch adding the driver documentation. I will
send both patches to Linus in a few days, so the driver will make it
into 2.6.20.

Userspace support is already available in lm_sensors 2.10.1.

The Winbond W83793G/R is a complex chip with lots of features, and as a
result the driver is quite large. With 48 kB (source), it's the 6th
biggest hardware monitoring driver in the Linux tree. Thus we do expect
that some bugs are still hiding in the driver. Please help with testing
if you can.

Once again I'd like to thank Winbond for providing documentation and
drivers for their chips, it's really great.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-w83793-new-driver.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061208/2cb327a8/attachment-0002.pl 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-w83793-documentation.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061208/2cb327a8/attachment-0003.pl 
