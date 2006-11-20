From: till@harbaum.org (Till Harbaum)
Date: Mon, 20 Nov 2006 18:07:46 +0000
Subject: [lm-sensors] New compass driver
Message-Id: <200611201907.45656.till@harbaum.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i have written a driver for the Devantech CMPS03 compass module. The
attached tgz contains a driver that i have written for and tested with
the ubuntu 2.6.17 kernel. Also included is a patch for the sensors-detect 
script from lm_sensors 2.10.1 that includes detection of the compass.

Is it ok to post this here for inclusion or do you want me to send it
somewhere else?

Regards,
  Till

-- 
Dr. Till Harbaum <Till at Harbaum.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cmps03.tgz
Type: application/x-tgz
Size: 3581 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061120/a2fba87d/attachment.bin 
