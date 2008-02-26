From: Matt Roberds <mattroberds@cox.net>
Date: Tue, 26 Feb 2008 22:56:46 +0000
Subject: Re: [lm-sensors] ADT7475 (resend) (WAS: First shot at Asus M2N-SLI
Message-Id: <Pine.LNX.4.64.0802261651360.11861@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080226214025.GE7456@cosmic.amd.com>
In-Reply-To: <20080226214025.GE7456@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Feb 2008, Jordan Crouse wrote:
> Okay, done, and updated the documentation too.

I tried this latest version and can confirm that it works, both with a
null sensors.conf and with my proposed Asus M2N-SLI Deluxe sensors.conf .

> It also occurred to me that I should probably send it through
> checkpatch.pl, and it was a good thing that I did, because there were
> style issues.

This seems to have caused the following compiler warnings, which weren't
there before:

drivers/hwmon/adt7475.c: In function 'adt7475_detect':
drivers/hwmon/adt7475.c:803: warning: assignment from incompatible pointer type
drivers/hwmon/adt7475.c: In function 'adt7475_detach_client':
drivers/hwmon/adt7475.c:831: warning: passing argument 1 of 'hwmon_device_unregister' from incompatible pointer type

This is with gcc 4.1.2 on Debian "Etch" AMD64; gcc --version says
gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
and uname -a says
Linux birdbird 2.6.18 #3 SMP PREEMPT Sun Jan 20 20:51:02 CST 2008 x86_64 GNU/Linux

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
