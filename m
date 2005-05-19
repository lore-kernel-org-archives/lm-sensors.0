From: m.pedersen@lancaster.ac.uk (jmp)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <1075048593.1451.0.camel@flaptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


thanks for a QUICK response!!

this is my next problem, sorry ;-) :

[root@flaptop root]# lsmod|grep i2c
i2c-proc                8400   0  [eeprom]
i2c-viapro              5008   0  (unused)
i2c-core               18916   0  [eeprom i2c-proc i2c-viapro]
[root@flaptop root]# rmmod i2c-viapro
[root@flaptop root]# rmmod i2c-core
i2c-core: Device or resource busy
[root@flaptop root]# rmmod i2c-proc
i2c-proc: Device or resource busy
[root@flaptop root]#




On Sun, 2004-01-25 at 15:34, Jean Delvare wrote:
> > My problem is related to a Fujitsu-Siemens (AMILO A 7620) laptop.
> > 
> > It seems that chipsets are supported, but I cannot successfully run
> > sensors-detect AND probe 'non-detectable'.
> > 
> > However, I have succeeded in running sensors-detect WITHOUT probing
> > 'non-detectable', but the output from sensors is only:
> > 
> > [root@flaptop root]# sensors
> > eeprom-i2c-0-51
> > Adapter: SMBus Via Pro adapter at 0400
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            DDR SDRAM DIMM
> > Memory size (MB):       512
> 
> Non-detectable devices are really rare ones, this is why probing them is
> disabled by default in sensors-detect. Maybe we should add a warning
> stating that ordinary users shouldn't try this, or maybe we should even
> remove support from sensors-detect. So far, it has caused more trouble
> than it helped.
> 
> Please provide the output of sensors-detect without the 'non-detectable'
> probes, so that I can tell you more about what you can do with our
> package. Don't forget to unload all i2c drivers before doing so, or the
> results may be unreliable.
