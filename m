From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Issue getting sis630 i2c smbus driver to work
Message-Id: <20040706201554.6f1ea9d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <14164-38866@sneakemail.com>
In-Reply-To: <14164-38866@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks, this did indeed work, though when running sensors-detect, i
> get: Next adapter: SMBus SIS630 adapter at 5080 (Algorithm
> unavailiable) Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x10
> 
> ..
> Sorry, no chips were detected.
> ..
> 
> I assume this means that either (a) the laptop has no sensors, or (b)
> they aren't supported by linux yet.  Is this a reasonable assertion? 
> Is there anything I can do (short of disassembling my laptop) to help?

Most probably (a). 0x08 is a typical address for SMBus 2.0 related stuff
(not a real chip), and 0x10 is certainly not a typical address for
hardware monitoring chips. You can still try dumping their contents
(using i2cdump), but I would say no chance we can do anything with them.
At the very limit they may be battery-related chips.

It's very common that laptop have no hardware monitoring chips, or at
least they are not exposed. You may get some luck with ACPI (thermal
zone & fan) in this case.

Good luck,

-- 
Jean Delvare
http://khali.linux-fr.org/
