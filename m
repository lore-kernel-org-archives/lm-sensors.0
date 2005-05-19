From: haimat@lame.at (Matthias F. Brandstetter)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: how to get temp. stats?
Message-Id: <200407271626.43650.haimat@lame.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I successfully installed lm_sensors onto another machine with an i801 chip. 
No problem, sensors-detect found it and suggested the right kernel 
modules.

But after loading all of these modules, I still do not get any temp. 
statistics. I only get this output:

--<snip>--
root@mx:/usr/src/lm_sensors-2.8.7# sensors
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512
--</snip>--

And I have this modules loaded:

--<snip>--
root@mx:/usr/src/lm_sensors-2.8.7# lsmod
Module                 Size  Used by    Not tainted
i2c-isa                 716   0  (unused)
eeprom                 3860   0  (unused)
i2c-proc               6548   0  [eeprom]
i2c-dev                4096   0
i2c-i801               4760   0
i2c-core              15044   0  [i2c-isa eeprom i2c-proc i2c-dev i2c-i801]
uhci                  24444   0  (unused)
usbcore               59308   1  [uhci]
ide-scsi               9328   0
eepro100              19252   1
mii                    2272   0  [eepro100]
--</snip>--

Do I need any other module loaded? Any ideas?
Greetings and TIA, Matthias

-- 
You see, boy?  The real money's in bootlegging!  Not in your childish
vandalism.

		-- Homer Simpson
		   Homer vs. the Eighteenth Amendment
