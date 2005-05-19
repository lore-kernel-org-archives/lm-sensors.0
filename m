From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <20031126230609.5b15fd2c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I do however have another problem.  I using a dual xeon cpu Super
> X5DL8-GG motherboard and according to the "sensors"  program one of
> the CPUs is reporting back some invalid numbers as when compared to
> the BIOS.  For instance, when looking at the chip ( sensor information
> is below ) lm87-i2c-0-2d the fan1 is reporting back 0 RPMs but looking
> at the motherboard I can see that it is clearly spinning. When
> viewing the BIOS fan RPM info two values are reported, one for each
> CPU.  How do I get the lm87-i2c-0-2d report identical information as
> lm87-i2c-0-2e chip.

Frankly, I don't think this is an LM87 at 0x2d. The one at 0x2e seems to
be valid, but the data at 0x2d is just crap.

> I also notice that several of the voltage values for lm87-i2c-0-2d
> chip is different then lm87-i2c-0-2e.  The BIOS only reports only
> one set of voltage values for both CPUs( is this typical of a dual
> motherboard system?) The voltage values that are reported by the
> BIOS are almost identicle to the values reported by lm87-i2c-0-2e. 
> Can I safely assume that voltage values reported by lm87-i2c-0-2d
> can be ignored?

Apart from temp1, there's nothing valid at 0x2d. I'm not an expert in
dual-cpu systems (never owned one myself) but it doesn't make sense to
have two sets of voltage measurements on such systems. I would bet there
is a single chipset for theses (at 0x2e obviously).

> After reading the documentation for both chips it is still not
> clear to me what is the difference between the chips adm1021* and
> lm87* CPU temperatures. Any ideas?

The LM87 at 0x2e is your main monitoring chipset. Since it doesn't
provide external channels for temperature measurement, the board maker
added a temperature-only chipset for each CPU. These are the two ADM1021
chipsets.

>   1.  lsmod output.  I have loaded the adm1021 module with
>       force_adm1021=0,0x18,0,0x29

Why did you use that force parameter? Was it suggested by
sensors-detect?

I'd be interested in a full sensors-detect log (after you unloaded all
chip drivers, of course). Also, if you provide dumps for your four
chips, I will take a look into that and maybe tell you more about
what's on your motherboard exactly.

i2cdump 0 0x18
i2cdump 0 0x29
i2cdump 0 0x2d
i2cdump 0 0x2e

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
