From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031215210457.44c4ccc7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hm, with some close look I noticed that it is 0x2d. I have no idea
> what the output means, but does this look better somehow?

No, no. At 0x2d there is your main chipset (ASB100 "Bach"). The
W83L785TS-S is really at 0x2e.

You might provide the output of "i2cdetect 1" for a full analysis of
your I2C bus.

> just tell me if more or other dumps will help.

Please provide the output of "i2cdump 1 0x2e" anew so that I can compare
with the old values.

>  cat /proc/sys/dev/sensors/w83l785ts-i2c-1-2e/temp
> -1 40

My bad, I just chose a random register as the high limit register (well
it's a typo actually). I'll fix that. That said, the exact register to
use is unclear.

I'll let you know when I got something for you to test.

> (...)
> I consider it good practice for packages that contain shared libraries
> and binaries using them that they look for their own libraries under
> their own prefix. It helps testing a lot, especially with several
> non-distro-bundled packages or different version at the same time.
> Of course, ld.so.conf does this, but systemwide for all programs, and
> gets bloated when used this way. LD_LIBRARY_PATH is a bad hack and
> does more harm than good if you use it like you should ld.so.conf 

Well, you seem to know what you're talking about. I applied your patch
but it doesn't seem to do anything. The EXLDFLAGS variable is not used
when I compile sensors. Are there any other steps to take?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
