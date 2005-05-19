From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: done rmmod dmasound_pmac; still get error
Message-Id: <20030806181304.6c1c0505.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806180326.6fc889e1.zdavatz@ywesee.com>
In-Reply-To: <20030806180326.6fc889e1.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> > "rmmod dmasound_pmac" should do it. If you have other drivers that
> > use i2c, remove them too.
> Done that. I still get:
> 
> Next adapter: uni-n 0 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x30
> Client at address 0x48 can not be probed - unload all client drivers
> first! Client at address 0x49 can not be probed - unload all client
> drivers first! Client at address 0x50 can not be probed - unload all
> client drivers first!
> 
> Next adapter: uni-n 1 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client at address 0x48 can not be probed - unload all client drivers
> first! Client at address 0x49 can not be probed - unload all client
> drivers first! Client at address 0x50 can not be probed - unload all
> client drivers first!
> 
> Next adapter: mac-io 0 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x34
That one was used by the dmasound_pmac module, now it is free.

> Client at address 0x56 can not be probed - unload all client drivers
> first!

Other addresses are abviously used by the eeprom and lm75 modules.
Unload them (and dmasound_pmac again), and run sensors-detect again. You
should see the same things you first saw. If you could log the whole
thing, I'd like to take a look. You may use "script" to do that (run
"script sensors-detect.log", then "sensors-detect", then "exit", and you
have a nice logfile).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
