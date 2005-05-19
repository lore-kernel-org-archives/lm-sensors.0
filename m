From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Regardding Ticket #: 1791
Message-Id: <20041008200147.74e388a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
In-Reply-To: <000001c4ad5f$6d5d83c0$843f4853@jonathan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I did not quite understand the part about ACPI

Among other things, ACPI can handle fans speeds and temperatures, so it
may be seen as an alternative to lm_sensors. Once ACPI is enabled in
your kernel, go and take a look in /proc/acpi/*. Maybe you'll find
something.

> Here is the output of sensors-detect I hope it reveals something for
> you.
> (...)
> Client found at address 0x42
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

Maybe there's something interesting there. Please provide the output of
"i2cdump 0 0x42" and "i2cdump 0 0x44". (I assume that your i801 SMBus is
i2c bus 0; you can check by using "i2cdetect -l").

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
