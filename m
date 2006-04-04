From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Apr 2006 19:59:18 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060404215918.fdd76b30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Harald,

> "Power control" reminds me of something: Sometimes ACPI power off
> doesn't work. Do you think this is a related problem?

I don't think so. The other I2C chips we've seen which were dealing
with "power" were usually VID control chips, which can be used to
slightly alter the CPU Vcore. This can be used for power-saving
purposes or overclocking purposes, depending on the change direction.
My understanding is that these chips should not be needed for regular
users. But then again, I don't know what _this_ chip does at all, so I
can't tell.

> Creating a driver on my own sounds pretty cool. Probably it is
> allowed to use an existing driver as a template?

Not allowed. Required ;)

Not absolutely required, in fact, but strongly encouraged, as this will
make it much easier for you. Hardware monitoring drivers have many
common points, and if you choose your template(s) properly, the new
driver can be done in no time and its review will be much faster too.

I didn't look at the datasheet for your chip yet (no time for this
sorry) so I can't tell you exactly which driver to start from. But this
should be an i2c-only driver (no platform driver, and no i2c-isa
trick.) Maybe lm90 will do, as it's both simple and up-to-date with
regards to recent changes. And you can always peek at other drivers for
the features your chip has and lm90 doesn't.

-- 
Jean Delvare

