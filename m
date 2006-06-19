From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Jun 2006 10:01:09 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060619120109.31d996b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lou,

> I ran the commands to load the ic2-nforce2 module as per your instructions
> and then ran sensors-detects again.  
> 
> Several new sensors were detected and the result of sensors-detect was put
> into /etc/sysconfig/lm_sensors but no new sensors were found when I ran the
> sensors command line.  Output was the same as previous and behavior of
> temperature values was unchanged.

> Next adapter: SMBus nForce2 adapter at 4c40

Good news is that the "new_id" trick worked. Note that it needs to be
done every time you load the i2c-nforce2 driver, so in particular it
won't survive a reboot unless you add the commands in a boot script.

> Do you want to scan it? (YES/no/selectively): YES
> Client found at address 0x08
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

These were probed, but NOT detected. You have a chip here but your
version of sensors-detect doesn't know what it is. Please try the
latest version of sensors-detect, as Brian did:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

I wouldn't be surprised if you have the same chip as Brian.

> I tried to look in the docs but is there something more I need to do for
> these new sensors to be reported to output?  

The only new chips which were detected here are SPD EEPROMs, you can
get information from them using the decode-dimms.pl script. These are
not sensors so they won't show in "sensors".

-- 
Jean Delvare

