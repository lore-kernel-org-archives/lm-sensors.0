From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050316195947.390b3ffa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
In-Reply-To: <20050226191142.6288b2ef.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Leon,

> I have an Asus P5P800 motherboard with the W83627EHF and would like to
> monitor the CPU temperature. I have used your patchfile
> (http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc5-i2c-w83627eh
> f-beta1.diff) to patch my linux-2.6.10 sources (no obvious problems
> there) and recompiled and installed (I'm running Fedora Core 3).
> 
> I had hoped that this would give me CPU temperature readings but I
> didn't get any values when running the sensors command (neither as
> root nor as normal user, and after running sensors -s):
> ----------------
> # sensors
> w83627ehf-isa-0290
> Adapter: ISA adapter
> 
> #
> ----------------

This is expected. The driver being preliminary, it has no user-space
support yet. Neither libsensors not sensors know about it. Our design
makes it necessary to update both whenever we want a new chip to be
supported.

> I have no idea how to debug this further or how to get sensor values
> but  I'm willing to put some time in this as a tester.  Were my
> expectations  wrong and can't I use your preliminary driver to get
> temperature  readings?

If your expectations were that you could use "sensors" out of the box,
you were indeed wrong. You can however read the raw sensors values in
/sys/bus/i2c/devices/0-0290 (or something similar), which is already
something to start with, and should at least help you make sure that the
driver itself work properly for you.

> Are there  changes in the 2.6.11-rc5 kernel w.r.t. 2.6.10 that I might
> need?

Not that I can think of. If you were able to compile the driver, chances
are good that it will work properly.

-- 
Jean Delvare
