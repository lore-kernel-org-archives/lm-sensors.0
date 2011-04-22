From: Christian Kujau <lists@nerdbynature.de>
Date: Fri, 22 Apr 2011 00:59:50 +0000
Subject: [lm-sensors] therm_adt746x: attach_adapter method is deprecated
Message-Id: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Starting with 2.6.38+, I noticed the following messages during bootup:

i2c i2c-0: attach_adapter method is deprecated
Please use another way to instantiate your i2c_client

adt746x seems to continue to work, though. This is on a PowerBook G4.

Is this something to be worried about?

Thanks,
Christian.
-- 
BOFH excuse #40:

not enough memory, go get system upgrade

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
