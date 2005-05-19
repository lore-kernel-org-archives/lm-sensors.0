From: stuart@bmsi.com (Stuart D. Gathman)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: Ticket #1196
Message-Id: <3EA1F3CA.1020600@bmsi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your instructions were to add an entry to the supported[] table in 
i2c-piix4.

This is a RedHat stock kernel (2.4.18-27.7.x).  Can I download the 
latest lm_sensors and compile the modules?  Or do I have to patch the 
kernel?  I am comfortable with compiling modules to replace RedHat 
versions - having done that to support various other hardware, but not 
with patching the kernel.

I got in a Dell 1600SC.  This has a CSB5 chipset.  Now i2c-piix4 reports:

Apr 19 21:06:39 lord kernel: i2c-piix4.o version 2.6.3 (20020322)
Apr 19 21:06:39 lord kernel: i2c-piix4.o: Found CSB5 device
Apr 19 21:06:39 lord kernel: i2c-piix4.o: Host SMBus controller not enabled!
Apr 19 21:06:39 lord kernel: i2c-piix4.o: Device not detected, module 
not inserted.

lspci -n shows:

00:0f.3 Class 0601: 1166:0225

I think I saw something about enabling SMBus controller on another 
ticket, so I'll go search.

-- 
	      Stuart D. Gathman <stuart@bmsi.com>
Business Management Systems Inc.  Phone: 703 591-0911 Fax: 703 591-6154
"Confutatis maledictis, flamis acribus addictis" - background song for
a Microsoft sponsored "Where do you want to go from here?" commercial.

