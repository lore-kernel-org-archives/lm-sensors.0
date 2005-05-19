From: Manfred.Knick@T-Online.de (Manfred Knick)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: SOLVED: I2C and lm-sensors : gentoo-sources 2.4.25 and your patches
Message-Id: <200405031037.51601.Manfred.Knick@T-Online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

	RECALL	-	SOLVED

It seems that

	-->  media-video/mgavideo  <--

(which it seems I do not need, fortunately ;-))
did not properly uninstall:
after 
	emerge --unmerge  mgavideo
there were still modules left hanging around in
	/lib/modules/kernel/drivers.

After removing these manually,
/sbin/depmod was happy :-))

I could reboot to the patched kernel,
install I2C and lm-sensors,
and sensors-detect just worked fine!

	Thank you again for your work!

- Manfred

P.S.:
I'm sure you know that some people really depend upon 2.4 kernel series
and can not easily switch to 2.6 where compatibility is gained again ?

E.g. for my G400 
(which i still like for engineering - no fan, dual-head, ...),
Matrox neither released a HAL module for 2.6
nor is willing to publicate the HAL source openly
so that users could do the maintenance themselves ...

So I really appreciate the intention mentioned by Jean Delvare at the bottom 
of his helpfol tutorial  [ http://khali.linux-fr.org/devel/i2c/ ] :
"We only make these patches available to the users to fill the gap between 
i2c-2.8.0 being released and compatibility being brought back."
( I hope this is not meant to be understood as threatening with extinction ;-)


----------  Weitergeleitete Nachricht  ----------

Subject: I2C and lm-sensors : gentoo-sources 2.4.25 and your patches
Date: Monday 03 May 2004 03:19
From: Manfred Knick <Manfred.Knick@T-Online.de>
To: sensors@stimpy.netroedge.com

Kind regards from Munich. Germany !


Using Gentoo, I tried to follow Jean Delvare's instructions:

emerged a fresh clean actual production kernel (gentoo-sources-2.4.25-r2)
and renamed the tree to gentoo-sources-2.4.25-r2-sensors -

modifying Makefile -> EXTRAVERSION = -gentoo-r2-sensors accordingly.

Then I applied the provided patch for 2.4.25.

But unfortunately, after quite hopeful compilation efforts, depmod fails:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map
2.4.25-gentoo-r2-sensors; fi

with
	*** Unresolved symbols
in
	/lib/modules/kernel/drivers/mgavideo/ks0127.o
	/lib/modules/kernel/drivers/mgavideo/mga_core.o
	/lib/modules/kernel/drivers/mgavideo/maven.o
	/lib/modules/kernel/drivers/mgavideo/msp3400.o
	/lib/modules/kernel/drivers/mgavideo/tuner.o

missing
		i2c_add_adapter
		i2c_del_adapter
		i2c_add_driver
		i2c_del_driver
		i2c_attach_client
		i2c_detach_client
		i2c_get_client
		i2c_master_send
		i2c_master_recv
		i2c_transfer
		i2c_probe

_all_ of these being defined via  EXPORT_SYMBOL in

	linux/drivers/i2c/i2c-core.c

But :
	> grep I2C .config

results in :

# I2C support
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_FB_MATROX_I2C=m

And:
	> find /lib/modules/2.4.25-gentoo-r2-sensors/ -name i2c*.o -print

results in :

/lib/modules/2.4.25-gentoo-r2-sensors/kernel/drivers/i2c/i2c-core.o
/lib/modules/2.4.25-gentoo-r2-sensors/kernel/drivers/i2c/i2c-algo-bit.o
/lib/modules/2.4.25-gentoo-r2-sensors/kernel/drivers/i2c/i2c-proc.o
/lib/modules/2.4.25-gentoo-r2-sensors/kernel/drivers/i2c/i2c-dev.o
/lib/modules/2.4.25-gentoo-r2-sensors/kernel/drivers/video/matrox/i2c-matroxf
b.o

so it seems "i2c-core" _has_ been built.

Applying "emerge --ask  /usr/portage/sys-apps/lm-sensors/i2c-2.8.4.ebuild"
and trying it again led to identical results.


??? Do I have tomatoes on my eyes ???
(Yes, I do realize it's 03:16 early in the morning over here ;-)

??? Can you help me and spot it ???

Greetings and thanks in advance

- Manfred

-------------------------------------------------------

-- 
Manfred Knick  (Dipl.-Math.)
Alramstr. 31, D-81371 M?nchen
Telefon  +49 (89) 76704-300
Telefax  +49 (89) 76704-453
Mobil    +49 (171) 4180 358
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040503/5633f3ac/attachment.bin
