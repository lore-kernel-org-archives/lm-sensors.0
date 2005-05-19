From: aronayette@free.fr (aronayette)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: vt1211.c port on 2.6.6 kernel
Message-Id: <40AE08F2.7070505@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello lm_sensors team,
(please apologize for my english, i'm french)

I  tried to subscribe to some ML to ask about technical issue on vt1211 
driver port on kernel 2.6, but i didn't find.

I'm using a 2.6.6 kernel on a VIA EPIA ME6000 Motherboard and try to use 
sensors on it (http://www.viaarena.com/?PageID74).
I found a vt1211.c on your ml archive 
(http://pwp.netcabo.pt/0246517002/vt1211.c) and add it to my kernel as 
module, it works,  but sensors don't work. May be i miss something.

sensors-detect detect the vt1211 :

Driver `vt1211' (should be inserted):
  Detects correctly:
  * ISA bus address 0x6000 (Busdriver `i2c-isa')
    Chip `VT1211 Super IO Sensors' (confidence: 9)


Here are the modules i've installed :

 <http://pwp.netcabo.pt/0246517002/vt1211.c>
Module                  Size  Used by
vt1211                 13728  0 
via686a                16836  0 
eeprom                  6304  0 
i2c_viapro              6092  0 
i2c_via                 3392  0 
i2c_isa                 1888  0 
i2c_algo_bit            8520  1 i2c_via
i2c_sensor              2432  3 vt1211,via686a,eeprom
i2c_dev                 7392  0 
i2c_core               17440  8 vt1211,via686a,eeprom,i2c_viapro,i2c_isa,i2c_algo_bit,i2c_sensor,i2c_dev

And here is the sensors output

2trucmuche:~# sensors
vt1211-isa-6000
Adapter: ISA adapter
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get TEMP4 data!
ERROR: Can't get TEMP5 data!
ERROR: Can't get TEMP6 data!
ERROR: Can't get TEMP7 data!

eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512


I didn't find something about thoses errors, and i don't know how to solve it.
I'll be happy if you can help me (and if this can help you to port vt1211 on 2.6 kernel).
sensors

Thank in advance for you answer.

Nicolas




