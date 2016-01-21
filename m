From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 21 Jan 2016 09:55:11 +0000
Subject: Re: [lm-sensors] SB800 support
Message-Id: <20160121105511.261c1fbc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+-AzzLcdx6-CEJFDvt41hfa_zfWRk2y8-+i82E2FFLLBjA-2g@mail.gmail.com>
In-Reply-To: <CA+-AzzLcdx6-CEJFDvt41hfa_zfWRk2y8-+i82E2FFLLBjA-2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marcin, if you are still interested, support for the multiplexed SMBus
ports on the SB800 has just been added to the upcoming kernel v4.5.
Credits to Christian Fetzer for the code and Wolfram Sang, Andy
Shevchenko and Mika Westerberg for the review.

I have put a standalone version of the i2c-piix4 driver at:
http://jdelvare.nerim.net/devel/lm-sensors/drivers/i2c-piix4/
if you want to test it without updating your kernel. Generic build
instructions are available at:
http://jdelvare.nerim.net/devel/lm-sensors/drivers/INSTALL

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
