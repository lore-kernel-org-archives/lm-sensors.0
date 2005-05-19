From: mdixon@operamail.com (mike dixon)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: lm75 question
Message-Id: <20050219175106.F1FC523CFA@ws5-3.us4.outblaze.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi - 

I'm emailing because I'm starting to fear my trouble with lm75 is that my computer is getting long in the tooth.  My problem seems to be specifically with lm75 (CPU temp).  I use lm75/78 to get CPU temp/fan speed and mb temp/fan speed.  

I have an Asus a7m266 mb and Athlon 1900+ (both almost five years old).  With kernel 2.4 I'm almost positive I never had trouble with lm75/78.  I moved to 2.6.3 quite awhile back and am fairly sure I also had no/little trouble.  

I moved to 2.6.7 many months ago and had a lot of trouble with lm75 'not responding' when I'd boot (no problems with lm78).  About 10-15% of the time lm75 would be reporting after boot.  The rest of the time, nothing.  But I discovered that after booting, if I rmmod all i2c mods and reloaded them, about the second or third or fourth try rmmod/insmod'ing them lm75 would start reporting (I use i2c-viapro over via686a).  This technique never failed.  

The other day I built 2.6.10 and there doesn't seem to be a thing I can do to get lm75 to report.  (I used "make oldconfig" and my 2.6.7 cfg).  sensors-detect still reports "Success"  but now even my reloading technique won't work.  So it *seems* that kernels and lm75 are orthogonally related (for me at least) - the newer the kernel the less likely lm75 will work.

Which leads to my question: Is this because lm75/my computer are getting a little aged and maybe the mod I need gets less attention now because of it?  Would you know if there's anything I can 'bring over' from 2.6.7 kernel source into 2.6.10 that would improve my chances of getting lm75 to work again?  Most recently I've used sensor utils 2.8.6 and 2.8.7.

Thanks...

Mike
-- 
_____________________________________________________________
Web-based SMS services available at http://www.operamail.com.
From your mailbox to local or overseas cell phones.

Powered by Outblaze
