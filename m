From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: Detected i2c-viapro + lm75 chips display *only* CPU temerature
Message-Id: <3CF2925A.3030805@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020525032423.A5531@netswarm.net>
In-Reply-To: <20020525032423.A5531@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Whatever you have, we don't support. Sorry.
The W83518D does not appear to be a hardware monitor.
If you figure out what chip you have, you can watch our
New Drivers page for status or if it's not on there let us know.


http://www.winbond-usa.com/news/pressrel/09-17-2001.shtml





Christian Birchinger wrote:
> Hello,
> I have the following problem with my lm_sensors2 setup.
> 
> Summary: Detected i2c-viapro + lm75 chips display *only* CPU
> temerature
> 
> Details and Systeminfo:
> I'm using I2C and lm_sensors2 CVS version from 25 May 2002
> 
> I have an Asus A7V333/A/R/F Mainboard which shows voltages
> fanspeed and CPU temp in the BIOS monitor.
> 
> The sensors-detect script tells me to load:
> i2c-viapro, pcf8591 and lm75
> 
> "dmesg" shows that the "i2c-viapro" finds the device:
> i2c-viapro.o: Found Via VT8233A device
> 
> lspci reports this as well:
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
> 
> Other 2 modules just show:
> lm75.o version 2.6.3 (20020322)
> pcf8591.o version 2.6.3 (20020322)
> 
> 
> The lm75 chip *only* reports the CPU temerature:
> ~$ sensors
> pcf8591-i2c-0-48
> Adapter: SMBus Via Pro adapter at e800
> Algorithm: Non-I2C SMBus adapter
> Chan. 0:  255
> Chan. 1:  255
> Chan. 2:  255
> Chan. 3:  255
> Output:   0 (enabled)
> 
> lm75-i2c-0-49
> Adapter: SMBus Via Pro adapter at e800
> Algorithm: Non-I2C SMBus adapter
> temp:      +60.5?C  (limit = +60.0?C, hysteresis = +50.0?C)
> (The temp is correct / Don't know if that also means 'bad
> values' from the FAQ)
> 
> Loaded Modules are:
> Module                  Size  Used by    Not tainted
> lm75                    3264   0  (unused)
> i2c-viapro              3848   0  (unused)
> pcf8591                 3488   0  (unused)
> i2c-dev                 3968   0
> i2c-proc                6400   0  [lm75 pcf8591]
> i2c-core               13512   0  [lm75 i2c-viapro pcf8591
> i2c-dev i2c-proc]
> 
> sensors-detect suggests (and i use this values):
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-viapro
> # I2C chip drivers
> modprobe pcf8591
> modprobe lm75
> #----cut here----
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> options pcf8591 ignore=0,0x49
> #----cut here----
> 
> Procinfo:
> ~$ cat /proc/bus/i2c*
> i2c-0   smbus           SMBus Via Pro adapter at e800             Non-I2C SMBus adapter
> 48      PCF8591 chip                            PCF8591 sensor chip driver
> 49      LM75 chip                               LM75 sensor chip driver
> 
> Additional (failed) attempts:
> The FAQ also says that some "lm75" are in fact "W83781D" chips.
> I don't get any datas when i load the "W83781D" module.
> I could not find a chip with a known name on the mainboard (sorry).
> Only found something labled "W83L518D". Don't know if thats
> sensor related.
> There is only the "temp" output when the lm75 module is loaded
> (it also takes 1-2 sec to load the lm75 module which tells me
> it really detected something.)
> 
> If i can help in any way please send me an email.
> Thanks for your help.
> 


