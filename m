From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <20041025222344.3085015a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried the patch with a Dell Optiplex GX110.  The module loads, finds
> a device at 0x09, but says it's "not activated".  What do you need to 
> debug this problem?

You mean, what do *you* need to work around it? ;)

Typically, disabled devices mean that the monitoring device is not wired
properly (the motherboard manufacturer didn't make use of the
functionality). Thus, the driver has not been educated to forcibly
enable the device.

You may still want to try to manually enable it, and see if the driver
then reports anything useful. The commands to do that are (in order):

isaset 0x2e 0x2f 7 9
isaset 0x2e 0x2f 0x30 1 1

Then loading the driver should work. Whether or not you will find it
useful on your board, you tell us.

Note that I updated the patch to fix a problem with fan min always being
reported as 0.
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-i2c-pc87360-beta1.diff

Please revert the old patch and apply this new one before testing again,
so that the driver at least has a chance to work ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
