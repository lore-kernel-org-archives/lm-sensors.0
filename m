From: Stefan Sassenberg <stefan.sassenberg@gmx.de>
Date: Tue, 04 Mar 2008 14:24:09 +0000
Subject: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <47CD5B89.1070302@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a problem making lm-sensors work on my system. It's a slightly 
old debian where I updated some packages and now use sensors and 
libsensors of version 2.9.1. I used to run a 2.6.21 kernel where sensors 
finds some chip and also shows fan speed and temperature values.

Then I upgraded the kernel to a 2.6.23 and always get the error message 
"No sensors found". The board is an MSI board and it has an 82801 ICH6 
chipset.

sensors-detect advises me to modprobe w83627hf, which I do, but the 
result is the above.

I installed a gentoo on the same machine, where it worked, and made an 
lsmod, which showed w83627hf, hwmod and hwmon_vid. I took the kernel 
config file and applied it to the kernel from kernel.org to build the 
same kernel for my debian. I modprobed the very same modules but failed. 
What can I do to find the solution?

Thank you.

Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
