From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <20040125163432.577458db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My problem is related to a Fujitsu-Siemens (AMILO A 7620) laptop.
> 
> It seems that chipsets are supported, but I cannot successfully run
> sensors-detect AND probe 'non-detectable'.
> 
> However, I have succeeded in running sensors-detect WITHOUT probing
> 'non-detectable', but the output from sensors is only:
> 
> [root@flaptop root]# sensors
> eeprom-i2c-0-51
> Adapter: SMBus Via Pro adapter at 0400
> Algorithm: Non-I2C SMBus adapter
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512

Non-detectable devices are really rare ones, this is why probing them is
disabled by default in sensors-detect. Maybe we should add a warning
stating that ordinary users shouldn't try this, or maybe we should even
remove support from sensors-detect. So far, it has caused more trouble
than it helped.

Please provide the output of sensors-detect without the 'non-detectable'
probes, so that I can tell you more about what you can do with our
package. Don't forget to unload all i2c drivers before doing so, or the
results may be unreliable.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
