From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: max1619
Message-Id: <20040526210051.122958a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Jean, you may kill me, but i don't have an max6650.

Definitely not a good reason to kill someone ;) (if there can be good
reasons...)

> Fan On or Off  - it show the same speed.
> and when i made "i2cset 0 0x1f 0x01 0x01" it went down to sleep...

I have to agree. Taking a look at the dump you sent [1], it definitely
doesn't look like a MAX6650/1 chip. Your chip has 2 or 4 registers,
obviously no more, while even the MAX6650 has more than that.

Your best chance is to open your computer case and physically search for
your MAX1619. The other chip might be connected directly to it.

If not, just look for any small chip made by Maxim or any other typical
manufacturer (Dallas, National Semiconductor, Analog Devices...)

From just the dump it's nearly impossible to find out what it is, it
doesn't carry enough information.

I've slighly improved the MAX6650/1 detection in sensors-detect, but I
doubt it will be enough to defeat your chip, whatever it is.

Good luck.

John, can you confirm that the change makes sense and that
sensors-detect still sees your chip? It it's OK, I'd like you to do the
same in the driver itself.

It would also be great if you could compare Alexey's mysterious chip
dump (at 0x1f) with yours and find a way to prevent the later from being
misdetected as the former.

Thanks.

[1] http://archives.andrew.net.au/lm-sensors/msg07974.html

-- 
Jean Delvare
http://khali.linux-fr.org/
