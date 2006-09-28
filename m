From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 28 Sep 2006 16:21:52 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <451BF6A0.6010905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans Edgington wrote:
> Hi,
> 
> I got the mobo up and running with FC5.
> 
> Tried the following command:
> isadump 0x295 0x296
> 
> Results:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
> 10: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
> 20: d3 af ab 83 7a 8a 76 d6 c3 ff ff ff ff ff ff ff 
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 50: ff ff ff ff ff ff ff ff ff ff 03 04 10 19 34 ff 
> 60: 00 00 00 00 ff ff 02 74 00 00 ff 06 40 24 ff 00 
> 70: ff ff 2e ff 1f ff 00 ff ff ff ff ff ff ff ff ff 
> 80: ff ff 65 64 64 55 55 46 ff ff ff ff ff ff a8 ff 
> 90: 00 0c 0c 00 15 ff 57 ff 44 22 ff aa 55 55 ff 0a 
> a0: 01 d1 00 ff 02 23 3c 32 28 1e ff d9 b2 99 80 01 
> b0: 02 1b 00 99 02 1b 3c 32 28 1e ff d9 b2 99 80 02 
> c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
> d0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> f0: 00 00 00 00 00 00 37 ff 02 ff ff 02 ff ff ff ff
> 
> The results seem to be correct systemp is around the 30C as shown in the
> results from isadump and checked with the bios. 
> I do have my doubts about the cpu temp reported in the isadump it says it's
> around 45C but when checking in the bios it shows almost 60C. Could it be
> the rebooting that is causing the temp to rise so much?
> 

Thats normal with amd cool 'n quiet processors, Linux puts the
processors in its low powerstate unless you do something which requires
all the horsepower, whereas the BIOS always has the processor in its
highest powerstate, try building a kernel with "make -j 4 bzimage" and
then do the isadump again when the kernel is building, then it should be
around 60 degrees under Linux too.

> Is it still necessary to unlock the superio and if so could to explain why?
> 

It looks like its not nescesarry as it works without it.

Regards,

Hans


