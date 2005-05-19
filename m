From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: 8rdavcore GPL issue
Message-Id: <405F5173.4060905@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <405C821F.4050003@verizon.net>
In-Reply-To: <405C821F.4050003@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
 >
 > I'd have two objections:
 >
 > 1* I still see "BSD License (revised)" listed on Freshmeat (as well as
 > GPL). Is it intentional? IANAL, but I don't think you can do that kind
 > of dual licensing in this case, since the BSD License is less
 > restrictive than the BSD license, and part of the code was originally
 > under GPL.

I haven't known that they add the license if I change it under "update 
branch"...I wroted a mail to fix this.

 > 2* I would ask you to do the same for your "8RDA hardware watchdog
 > timer" project as well, since it seems to contain the same part of
 > i2cdetect the "8rdavcore" project does.

Yes, of course.

 > 1* In this document:
 >   http://www.hasw.net/8rdawdt/README
 > you suggest the w83781d driver for ISA W83627HF. The w83627hf is known
 > to work better.

Ok.

 > 2* Any reason why 8rdawdt was implemented as a user-space program
 > relying on i2c-dev, instead of as a kernel driver?

It is only a test-version. But it doesn't work on all systems like
a "real" watchdog timer (which should reboot the system). Some BIOSes
checking the watchdog timer flags and waiting for user interaction 
(press F2 to enter setup, etc.) because the Bios on my 8RDA+ uses
the timer as indication if a FSB change, etc. has failed.

Regards,
Sebastian
