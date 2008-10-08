From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Wed, 08 Oct 2008 00:30:41 +0000
Subject: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081008003041.GA20169@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm possibly missing something here, but. I'm working on improving the 
thermal management of nvidia cards in nouveau. I've got I2C up and 
running and I can bind appropriate hwmon drivers to the chips and read 
temperatures. I've got a couple of remaining problems:

1) I know the offsets that need to be applied to the lm99 sensors. How 
do I do that in-kernel?
2) How do I read the temperature in-kernel? This only seems to be 
exported via sysfs, which is obviously not ideal (I'm not willing to 
leave the thermal management up to userspace).

Are these possible?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
