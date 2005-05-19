From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <20041206201245.4f6d0036.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, I am no way a hardware guy but I would like to figure out why
> it's slow using I2C bus
> then I searched the net. Accroding to the above page, the speed is
> 100Khz, well, it's indeed slow.
> No wonder we can feel human sensible delay while reading ALL
> registers.

I wish SMBus masters were really operating at this speed. That would be
fast! ;)

If you take a look at real SMBus master datasheets, you'll find that
they drive the bus at a lower speed. For example my Intel ICH3-M chip
drives the SMBus between 10 and 16 kHz according to the datasheet.
Indeed, a quick real-world measure led me to ~15 kHz. Slow as hell...

At this operating frequency, if you only use regular byte data reads,
you can't expect a read rate faster than 500 reg/s. This emphasizes the
need for SMBus chip manufacturers to implement faster read methods such
as continuous byte reads (using autoincrement) or even I2C or SMBus
block reads where possible. Continuous byte reads at the same operating
frequency would lead to maybe 700 reg/s, and block reads to 1500 reg/s
or so.

-- 
Jean Delvare
http://khali.linux-fr.org/
