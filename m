From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Some I2C chipsets are architecture-specific
Message-Id: <DvdW0MEV.1110212088.6608520.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050307153256.GG28741@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050307153256.GG28741@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Matthew,

> Some of the i2c chipsets look architecture specific, so don't trouble
> other architectures with these questions.  It's quite possible I'm
> mistaken, so please double-check.
> (...)
>  config SENSORS_ASB100
>  	tristate "Asus ASB100 Bach"
> -	depends on I2C && EXPERIMENTAL
> +	depends on I2C && X86 && EXPERIMENTAL

The ASB100 is a standalone SMBus hardware monitoring chip. It could be
found on virtually any system. That being said, the chip is made by Asus
for its own boards, and I don't think Asus makes non-x86 hardware ATM
(but this may change). So I wouldn't limit this one to x86.

> config SENSORS_VIA686A
> 	tristate "VIA686A"
>-	depends on I2C && PCI && EXPERIMENTAL
>+	depends on I2C && X86 && PCI && EXPERIMENTAL
> 	select I2C_SENSOR
> 	select I2C_ISA

Yes, I think this makes sense. This is an integrated sensor in an x86
southbridge.

On a more generic approach, SMBus/I2C clients shouldn't be limited to
x86. OTOH, some ISA hardware monitoring chips (which all have "select
I2C_ISA") are more likely to be x86-specific. In fact these chips fall
into three categories:
1* I2C/SMBus chip with an additional ISA access (not tagged "select
I2C_ISA")
2* Super-I/O chips with integrated sensors.
3* Southbridges with integrated sensors.

For category 1 we obviously cannot limit to x86 (same as I2C-only chips,
can be found on any architecture, at least in theory).

For category 2 I'm not sure, I know these Super-I/O chips are normaly
found only on PCs, but I remember of some embedded devices made by
Soekris (net4801) which were using Super-I/O chips as well. I think
these net4801 are 586-based so x86, but maybe other similar devices use
non-x86 arch?

For category 3 I guess it's safe to limit to x86. The via686a driver
falls into this category. The recently added sis5595 driver does as
well, and so will the vt1211 and vt8231 drivers once they are ported to
Linux 2.6.

I am open to discussion about this, as I only have vague ideas on what
can or cannot be found on other architectures. I admit I had never
considered limiting hardware monitoring device drivers according to
achitecture, but that sounds like a good idea to me (providing we know
what we are doing, of course).

Thanks,
--
Jean Delvare
