From: m.menges@seam.de (m menges)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: lm_sensors vt1211
Message-Id: <s10943d9.043@seam4.seam.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello! (who ever)
I'm unable to compile the vt1211.c code under Kernel 2.6 to
'module-state' - 
and do not really understand how it should works -
the 'make user user_install' do not build any chip-modules ? or
do/understand i something wrong?

I saw you are - at the moment - porting the vt1211 to the kernel 2.6
- is it right? what's the state? 
Can I do something? ( i'm not familliar in programming Kernel-Modules -
I think
this would be not very effective - ) 
but - Do you need tests?

..im still happy to test a vt1211.ko binary  

regard and thanks!

--------------------------------------------------------------------------
my system-informations:
--------------------------------------------------------------------------
lm_sensors 2.8.7
vanilla Kernel 2.6.8-rc2 based on SUSE 9.1 
Harware: VIA C3 1Ghz CLE266 all in one Board. with 4 x bt878 / vt1211 /
vt8235 /rtl8139 or intel GB

# sensors -v
sensors version 2.8.7 with libsensors version 2.8.7
#sensors-detect
..
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe vt1211
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
..

# modprobe i2c-viapro
# modprobe i2c-isa
# modprobe eeprom
- not vt1211 present -l
# sensors
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512


mfg
M.Menges
+49 531 / 24415-11
m.menges@seam.de
