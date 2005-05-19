From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050208194737.1bf883c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I would be happy to run any tests and provide whatever information I
> can. Unfortunately, this is not any work that I am doing on behalf of
> my employer or any customer, so it's not so much of a "need to have"
> as much as it is a "nice to have". That being said, I am not in a
> position to contribute any hardware or financial support.

No problem.

> For right now, I can tell you that I am running Fedora Core 3 with
> kernel 2.6.10-1.760_FC3smp. My motherboard is an ASUS P5P800.

OK, so it's a different board, which means that at least two boards have
the W83627EHF chip. And the driver would need to be written for 2.6
primarily.

> I started looking to run i2cdump, but apparently there are no busses
> found in my system, or at least there are no /dev/i2c* devices.

You'd have to load some bus driver, most probably i2c-i801. The
"sensors-detect" script should tell.

> I tried isadump, but I'm not sure what you are expecting the output to
> look like, or if the output I'm getting is valid data.

Hexadecimal numbers ;) But maybe the address is different.
sensors-detect will tell too.

> I'd be happy to test any new versions you have, just let me know the
> best way to retrieve them, and how you would like me to run them, and
> what output or results you would like me to report back to you.

I've update the sensors-detect script so that it detects the W83627EHF
in the three possible ways: as an I2C client, as an ISA chip and as a
Super-I/O chip. Please give it a try:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

Download, chmod +x sensors-detect, ./sensors-detect, and send us the
full output.

David Madsen, please do too if possible! The more feedback, the better.

With the output of sensors-detect I'll tell you how to dump the chip
contents.

Thanks!
-- 
Jean Delvare
