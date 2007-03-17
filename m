From: brad.beglin@gatech.edu (brad.beglin at gatech.edu)
Date: Sat, 17 Mar 2007 01:14:19 +0000
Subject: [lm-sensors] Failure to Detect VT1211 chip on Averatec 3150P
Message-Id: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM_sensors list,

I have an Averatec 3150P laptop running Gentoo that I have been unable to get to
work with LM sensors.  The laptop has the VT8375 North Bridge, VT8233 South
Bridge, and the VT1211 super IO chip (platform documentation at
http://www.via.com.tw/en/products/chipsets/legacy/km266/).  I have attempted to
detect the VT1211 using the latest version of lm_sensors with both the linux
2.6.19-r3 and 2.6.20-r1 kernels, with I2C, the via bus driver, and the VT1211
installed as both modules and built in.  On each attempt, the only thing that
detection script finds is the eeprom chip.  Is there some other kernel
configuration that I should try or another way that I can detect the super IO
chip?  If not, what else can I try?  Thanks

--
Brad Beglin

