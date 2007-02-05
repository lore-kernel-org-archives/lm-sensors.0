From: pengi.films@gmail.com (Joe Friedrichsen)
Date: Mon, 05 Feb 2007 19:27:59 +0000
Subject: [lm-sensors] [PATCH] vt1211: add probing of alternate config
Message-Id: <ecd00e6d0702051127j720f0a47va0618d188d53eed9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701301437h42a66c81lc7056ecf5ad399ba@mail.gmail.com>
In-Reply-To: <191fb4ca0701301437h42a66c81lc7056ecf5ad399ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2/4/07, Joe Friedrichsen <pengi.films at gmail.com> wrote:
> Sorry for the delay -- a friend asked me to help her move house. I
> have tomorrow/Monday off, so expect a report in a few hours.

The patched driver works. I used Juerg's patch on the vanilla 2.6.20
kernel and sensors reports:

vt1211-isa-ec00
Adapter: ISA adapter
+2.5V:     +0.00 V  (min =  +2.10 V, max =  +0.88 V)   ALARM
VCore:     +0.00 V  (min =  +0.55 V, max =  +2.39 V)   ALARM
+5V:       +0.00 V  (min =  +5.66 V, max =  +4.03 V)   ALARM
+12V:      +0.00 V  (min = +14.99 V, max = +10.65 V)   ALARM
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.46 V)
Case Fan:    0 RPM  (min = 27306 RPM, div = 2)
CPU Fan:     0 RPM  (min = 5041 RPM, div = 2)
CPU Temp: +145.0?C  (high =   +34?C, hyst =   +89?C)
Int Temp:  +64.0?C  (high =  +199?C, hyst =   +69?C)
ERROR: Can't get TEMP3 data!
vid:      +1.700 V  (VRM Version 9.0)

The chip really isn't wired to do much, as you can see. :-)

Thanks for your quick help!
Joe
