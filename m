From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: CVS tests report
Message-Id: <20030606183514.2e884183.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

I finished my tests on i2c-CVS and lm_sensors2-CVS. I tested on a first
machine with a VIA Pro this morning and already posted the results. I
tested on three other machines since (my fifth one being dead broken, I
couldn't even setup the network adapter to get the files). There are two
machines based on a PIIX4 and one based on an Intel i801.

The first problem concerns unresolved symbols. Three different issues
exist there:

depmod: *** Unresolved symbols in
/lib/modules/2.4.18/kernel/drivers/video/matrox/matroxfb_maven.o.gz
depmod:         i2c_inc_use_client
depmod:         i2c_dec_use_client

This is the same I had this morning with zoran.o. I leave the resolution
to someone else, I simply don't know what should be done.

depmod: *** Unresolved symbols in
/lib/modules/2.4.18/kernel/drivers/i2c/i2c-algo-biths.o
depmod:         cond_resched

This one is easily explained. cond_resched() was added in linux 2.4.20,
so there's no suprise it is unresolved on earlier versions. A patch
proposal is attached (borrowed the idea from diff'ing
linux/drivers/mtd/devices/doc2000.c between 2.4.20 and 2.4.21-rc1). Note
that this is guess work, I absolutely don't know how scheduling is
supposed to work. The module now loads, but I couldn't test it (I have
no device using it, as far as I know).

depmod: *** Unresolved symbols in
/lib/modules/2.4.18/kernel/drivers/i2c/i2c-proc.o
depmod:         unlikely

This third one is strange. The symbol name sounds funny, isn't it ;) The
problem seems to happen only with 2.4.18 (and probably earlier) kernels
and is a serious one (considering we hardly can do anything without
i2c-proc). What's really strange is that unlikely() actually already
exists in 2.4.18 (in linux/include/linux/compiler.h, a file that didn't
change at all between 2.4.18 and 2.4.19). I'm somewhat clueless on this
one.

The second problem I had is with the eeprom module. On two machines
(using i2c-i801 and i2c-piix4, repectively), the eeprom module returns
wrong values. More precisely, it returns the same values for all
eeproms. On the first machine (my Sony laptop) I had a memory EEPROM
showing at 0x50 and a proprietary Sony EEPROM at 0x57. Now, the Sony
EEPROM shows at both 0x50 and 0x57. Same for the other machine where I
have one 32MB memory chip at 0x50 and a 128MB memory chip at 0x52. Now,
both chips pretend to be the 128MB one. I guess the recent changes on
the module may have caused this side effect (which may have been hiding
so far because most people will actually have the same memory chip sizes
in all slots).

So, these things would need to be fixed before I can affirm i801 and
piix4 drivers have been converted successfully.

(I will of course test any fix if kindly asked to :))

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-cond-resched.patch
Type: application/octet-stream
Size: 472 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030606/6590906b/i2c-cond-resched.obj
