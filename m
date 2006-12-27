From: a@gaydenko.com (Andrew Gaydenko)
Date: Wed, 27 Dec 2006 16:42:59 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200612271943.00165@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I'm absolutely new with lm_sensors. After digging in the mail list and the
site, I suppose, steps to use W83627DHG with Core 2 Duo look like shown
below. Is this list correct?


Thanks in advance!
Andrew

_______

Step 1. adding 'coretemp' kernel module

Apply kernel patch referenced at this message:

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018420.html

It seems like this is last 'coretemp' module version. I have begun from the
http://www.lm-sensors.org/wiki/Devices list, have found coretemp ref here
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018100.html
and followed 'coretemp' subjects at the mailing list till '2006-December'


Step 2. patching 'w83627ehf' kernel module

Apply this

http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-add-w83627dhg-support.patch

kernel patch which is referenced also here http://www.lm-sensors.org/wiki/Devices


Step 3. getting and building last lm_sensors from SVN tree (self-explaned).

Step 4. play with lm_sensors.conf file and frontends (self-explaned).

