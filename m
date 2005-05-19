From: jim@jg555.com (Jim Gifford)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Dell Poweredge
Message-Id: <03ea01c34991$039cd040$3400a8c0@W2RZ8L4S02>
List-Id: <lm-sensors.vger.kernel.org>
References: <022d01c348e1$8df68250$3400a8c0@W2RZ8L4S02>
In-Reply-To: <022d01c348e1$8df68250$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am having no luck in compiling the modules.

Here is what I have been selecting.

<M> I2C support
<M> I2C bit-banging interfaces (NEW)
<M> I2C PCF 8584 interfaces (NEW)
[*] I2C mainboard interfaces (NEW)
<M>   Pseudo ISA adapter (for some hardware sensors) (NEW)
<M> I2C device interface (NEW)
<M> I2C /proc interface (required for hardware sensors) (NEW)
<M>   National Semiconductor LM75 and compatibles (NEW)
<M>   National Semiconductor LM78 (NEW)
<M>   National Semiconductor LM80 (NEW)
<M>   National Semiconductor LM85, Analog Devices ADM1027 (NEW)
<M>   National Semiconductor LM87 (NEW)
<M>   National Semiconductor LM92 (NEW)
[*] Other I2C devices (NEW)
<M>   EEprom (DIMM) reader  (NEW)

Here is the last error message.
i2c-isa.c:46: error: unknown field `owner' specified in initializer
i2c-isa.c:46: warning: missing braces around initializer
i2c-isa.c:46: warning: (near initialization for `isa_adapter.name')
i2c-isa.c:46: warning: initialization makes integer from pointer without a
cast
i2c-isa.c:46: error: initializer element is not computable at load time
i2c-isa.c:46: error: (near initialization for `isa_adapter.name[0]')
i2c-isa.c:47: error: initializer element is not constant
i2c-isa.c:47: error: (near initialization for `isa_adapter.name')

Here is an output lspci
00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
00:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 15)
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
00:11.0 USB Controller: OPTi Inc. 82C861 (rev 10)
00:13.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
01:08.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15)
01:0a.0 SCSI storage controller: Adaptec AIC-7880U
01:0b.0 SCSI storage controller: Adaptec AIC-7860 (rev 01)
01:0d.0 Unknown mass storage controller: American Megatrends Inc. MegaRAID
428 Ultra RAID Controller (rev 03)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 21)
02:08.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 21)

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Jim Gifford" <jim@jg555.com>
Cc: <sensors@Stimpy.netroedge.com>
Sent: Sunday, July 13, 2003 9:41 AM
Subject: Re: Dell Poweredge


>
> > Dead as in needing a bios flash, which means it can be made to work.
>
> OK, it's only wounded then, not dead ;)
>
> > I send a link, that I found, that says that sensors don't work
> >
http://lists.us.dell.com/pipermail/linux-aacraid-devel/2001-February/000019.html
>
> Well, the message is 25 months old. We would need recent information.
> What I would suggest is that you give a try to i2c and lm_sensors CVS
> and tell us how it works. We can't do anything before you do so and
> report how it went.
>
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
