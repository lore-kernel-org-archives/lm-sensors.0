From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: sensors-detect feedback
Message-Id: <20040327182037.322275af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040324043651.1891.qmail@web80501.mail.yahoo.com>
In-Reply-To: <20040324043651.1891.qmail@web80501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Let me know if this helps add support for this system.

OK, so your system is a Netvista M42, isn't it?

For one thing, I've added support for it to vpddecode. Thanks :)

Now, as to whether lm_sensors can support your system... It's a bit
complex. The story is that some IBM systems, most notably Thinkpads,
have an RFID EEPROM inside which is accessible on the I2C bus, which
doesn't quite comply with the standards and would be damaged by us
scanning the bus. As a result, the whole system would become unusable
and would need to round-trip to the manufacturer. This is the reason why
we blacklisted IBM systems from sensors-detect.

If you want to give a try to lm_sensors, I can just tell you how to
"unlock" sensors-detect. It would be under your own responsability, I
don't assume any liability. I'm quite confident that nothing bad would
happen, because we never heard about Netvista systems with the RFID
EEPROM, and because we workaround the problem and sensors-detect
shouldn't break them anymore anyway. Still I can't promise anything not
am I liable for any damage that would occur.

If you decide to do it and it turns out to be a success, then we'll add
your model to the white list so that other owners of similar systems can
use lm_sensors too.

Let us know if you want to go on.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
