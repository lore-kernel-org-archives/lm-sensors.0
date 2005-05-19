From: haimat@lame.at (Matthias F. Brandstetter)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <200406161539.50952.haimat@lame.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just started to work with lm_sensors, so I am not 100% sure what I have 
done wrong: I installed i2c-2.8.4 and lm_sensors-2.8.7 from tarball for a 
2.4.22 Linux kernel w/o any problems, even sensors-detect worked like a 
charm for me.

I have a VIA VT82C686 chip (that was returned by sensors-detect as well), 
so lsmod gives me this output:

--<snip>--
root@debian:/usr/src/lm_sensors-2.8.7# lsmod
Module                  Size  Used by    Not tainted
eeprom                  3728   0  (unused)
i2c-dev                 3904   0
i2c-viapro              3272   0
i2c-proc                6196   0  [eeprom]
i2c-core               14116   0  [eeprom i2c-dev i2c-viapro i2c-proc]
8139too                15496   1
mii                     2560   0  [8139too]
--</snip>--

I think I have all necessary modules loaded.
But when I now use sensors, I only get this output:

--<snip>--
root@debian:/usr/src/lm_sensors-2.8.7# sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       64

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       128
--</snip>--

Aren't there any other sensors like temp., voltage and so on?
How can I access these?

Greetings and TIA, Matthias

-- 
I wore my extra loose pants for nothing.  Nothing!

       		-- Homer Simpson
		   New Kid on the Block
