From: Paul Harper <paul.harper@arrisi.com>
Date: Wed, 18 Nov 2009 22:43:00 +0000
Subject: [lm-sensors] ipmisensors module ported to 2.6.29
Message-Id: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have ported the ipmisensors module to kernel version 2.6.29 and
corrected the issues with fatal errors on loading and swizzling of
device data.  On my IBM development platform (3650) the module now works
as expected and data from ipmitool and lm-sensors is in sync.  

I then did a test on a SuperMicro chassis and the module could not
connect to the bmc.  ipmitool works as expected on the SuperMicro.  In
examination of the ipmitool code, it appears that they have moved to
IPMB comms rather than a direct connect to the BMC.

Before I start changing ipmisensors to use IPMB comms, is there another
preferred module to use when exposing sensors to lm-sensors and the
vendor provides impi support?

Paul Harper
paul.harper@arrisi.com 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
