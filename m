From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ne1619 (really almost solved)
Message-Id: <20030730195026.099cc797.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307292322.53518.ondrej.cecak@centrum.cz>
In-Reply-To: <200307292322.53518.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I reproduce Oops ...
> I was a normal user with runned gkrellm, xmms, kde3.1, .... After I
> runned "sensors" and it failed with SIGSEGV (after info from eeprom).
> Output in attachement. (system - 2.4.21 + old CVS XFS, Debian "Woody"
> 3.0-r1 up to date)

I think it is almost useless as is. I think I remeber you have to pass
it through ksymoops if we want valueable information.

> (Maybe it's fixed by new eeprom driver)

No chance at all.

> (I can't reboot now, I made unload/load new modules only)

No reboot is necessary. The time I asked you to reboot was very
particular (because some value set by your bios had to be preserved and
had been overwritten once).

> PC DIMM Serial Presence Detect Tester/Decoder
> By Philip Edelbrock, Christian Zuckschwerdt and others
> Version 2.6.6
> 
> Number of SDRAM DIMMs detected and decoded      0

Hm, strange. It should output values (with many bad values, but output
anyway). Are you sure the eeprom module was loaded at the time you ran
this?

> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> Memory type:            DRDRAM RIMM
> Memory size (MB):       256
> 
> eeprom-i2c-0-51
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> Memory type:            DRDRAM RIMM
> Memory size (MB):       256

That's great.

> btw: maybe one more small mistake in new driver ne1619, values of SYS
> and CPU temp looks like changed. e.g. if I run "yes > /dev/null" and
> load of CPU is 100%:
> 
> SYS Temp:  +49.0?C  (min =   +5?C, max =  +65?C)
> CPU Temp:  +43.0?C  (min =   +5?C, max =  +65?C)

This is normal, I swapped both while modifying the script (for some
coding convenience reason). You must use the new sensors.conf file in
order to get correct labels.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
