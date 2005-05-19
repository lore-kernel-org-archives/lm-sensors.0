From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <1080217730.4062d0823171b@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

Quoting Eric <plukje@gmx.net>:

> Based on the output of sensors-detect I insmodded adm1021:
> 
> Driver `adm1021' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 0c00' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x4e
>     Chip `National Semiconductor LM84' (confidence: 5)
> 
> The module was build from a 2.6.5-rc1 kernel tree (SMP). After 
> insmodding the module the machine shut down instantly, which could
> have only been caused because the hardware detected _something_
> critical enough that it shut down the system immediatly. Initial
> tries to power up again were futile, only after unplugging
> and giving it a few minutes the machine came back up again (*phew*).

You're lucky it did come back. I think I remember we once had a report
of such a case and the system never came back :(

> I can't give you anything other helpfull information concerning what
> happened, simply because there was none given. However I put the
> details of the machine below.

I'd like the brand and model of the motherboard too.

> Whatever happened, it shouldn't have happened :-) (I'm just glad
> the machine came back on again.)

I actually think that whatever you have at 0x4e, it isn't an adm1021
compatible chip. You already have a full featured monitoring chip on
the board W83627HF, adding an old LM84 wouldn't make any sense.

That said, yes, we still should try to prevent what happened to you from
happening to others. This could include:

1* Refine sensors-detect again. I thought it was OK after my latest
changes, but obviously it isn't (providing this was sensors-detect from
lm_sensors 2.8.5). One thing that would help would be to know what the
mysterious chip is, and add detection for it in sensors-detect (even if
it's not a hardware monitoring chip). Any idea of what this could be?

2* Refine adm1021's detection procedure too.

3* Drop adm1021's limit init. This was already done in the 2.4 driver
and should have been done in 2.6 as well.

> let me know if you require any other information

I'd appreciate a dump of the faulty chip (i2cdump 0 0x2e), this could
help us find out what it is and possibly prevent it from being
recognized as an adm1021-compatible one.

Thanks and sorry for the trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
