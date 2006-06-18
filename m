From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 16:55:11 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060618185511.9ad76422.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

Please stop dropping Lou from the loop, he is certainly interested in
your case and may not be subscribed to the mailing list.

> Next adapter: SMBus PIIX4 adapter at 0400
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x30
> Client found at address 0x31
> Client found at address 0x4c
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> Probing for `Maxim MAX1619'... Failed!
> Probing for `National Semiconductor LM82/LM83'... Failed!
> Probing for `National Semiconductor LM90'... Failed!
> Probing for `National Semiconductor LM89/LM99'... Failed!
> Probing for `National Semiconductor LM86'... Failed!
> Probing for `Analog Devices ADM1032'... Failed!
> Probing for `Maxim MAX6657/MAX6658/MAX6659'... Failed!
> Probing for `National Semiconductor LM63'... Failed!
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Probing for `Analog Devices ADT7461'... Failed!

0x4c is a typical address for secondary temperature sensors. This
version of sensors-detect failed to identify it. Please try the latest
version:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

-- 
Jean Delvare

