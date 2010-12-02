From: Billy DeVincentis <billydv1@verizon.net>
Date: Thu, 02 Dec 2010 14:51:46 +0000
Subject: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <4CF7B282.10007@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I know there have been some discussions on this matter with this driver 
previously but it would seem that in this kernel version the problem if 
it had been fixed in any earlier versions, has returned. I have clearly 
pinpointed this to be the problem. No matter what else is set in the 
bios, if this module gets loaded and is turned on in the bios (Asus 
Utilities, if 3rd party utilities are chosen there is no asus Hardware 
monitoring support), the mouse and keyboard WILL freeze. Blacklisting 
the module is the simplest way to get around the freezing. Overclocking 
doesn't have anything to do with it either. I have run it both 
overclocked and normal, no difference. Icore temp sensors work perfectly 
but only give cpu temps. What if anything can I do to try to help you 
debug this?

Thank You

Billy DeVincentis

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
