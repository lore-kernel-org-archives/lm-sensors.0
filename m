From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Via 8233 lm_sensors support
Message-Id: <3BEB16C0.996D47D5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The i2c-viapro support for the 8233 is working, now
you want to figure out what is on the bus, if anything,
besides an eeprom.
You can run sensors-detect after you modprobe the i2c-viapro driver to see
if there is anything else we can detect.
mds

Mikael Hedin wrote:
> 
> Hi, sorry for the delay, I've had a bad time (still have) with the
> 8233 chipset and DMA corruptions:(
> 
> From todays CVS: The modules load fine and find the chips:
> 
> i2c-core.o: i2c core module
> i2c-core.o: i2c core module
> i2c-core.o: i2c core module version 2.6.1 (20010830)
> i2c-viapro.o version 2.6.1 (20010830)
> i2c-viapro.o: Found Via VT8233 device
> i2c-core.o: adapter SMBus Via Pro adapter at 5000 registered as adapter 0.
> i2c-viapro.o: Via Pro SMBus detected and initialized
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-dev.o: Registered 'SMBus Via Pro adapter at 5000' as minor 0
> i2c-proc.o version 2.6.1 (20010825)
> lm87.o version 2.6.1 (20010830)
> i2c-core.o: driver LM87 sensor driver registered.
> eeprom.o version 2.6.1 (20010830)
> i2c-core.o: driver EEPROM READER registered.
> i2c-core.o: client [EEPROM chip] registered to adapter [SMBus Via Pro adapter at 5000](pos. 0).
> 
> but the sensors program doesn't have any information:
> 
> ~$sensors
> eeprom-i2c-0-52
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> 
> Is this expected?
> 
> Regards,
> 
> Micce
> 
> Mark D. Studebaker writes:
>  > Each of you has sent mail asking about 8233 support or volunteering to
>  > test.
>  > Must be a popular chip!
>  >
>  >
>  > Thanks to a patch from Martin Habbecke (which I used as a part of my
>  > cleanup
>  > of i2c-viapro detection code), I've added support for the VT8233
>  > to i2c-viapro. I don't have an 8233 so I can't test it.
>  > Use at your own risk.
>  >
>  > Martin has tested his patch but not mine. He did have success with
>  > it87 and eeprom accesses.
> --
> Mikael Hedin, MSc                   +46 (0)980 79176
> Swedish Institute of Space Physics  +46 (0)8 344979 (home)
> Box 812, S-981 28 KIRUNA, Sweden    +46 (0)70 5891533 (mobile)
> [gpg key fingerprint = 387F A8DB DC2A 50E3 FE26  30C4 5793 29D3 C01B 2A22]
> 
> Vad skall du med bil och villa
> N?r du m?r s? j?vla illa
>      Peps Persson '75
> 
> constitution Panama Craig Livingstone domestic disruption North Korea
> Roswell Rule Psix supercomputer Marxist Ruby Ridge spy Honduras SEAL
> Team 6 terrorist Paula Corbin Jones
