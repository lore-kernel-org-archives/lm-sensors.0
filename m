From: troll@logi.net.au (Mr E_T)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: A small "generic" problem
Message-Id: <Pine.LNX.4.44.0301181204590.1115-100000@torus.loop.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

At the moment a programmer wishing to use the lm_sensors package needs to know
what chips are supported and needs to add all those chips into his package.

If you were to add a field or function to your structures to the effect of
sensor-function a programmer could use the package a lot more simply.

For values you could do something like -

enum sensor-type { volt, fan, temp, volt_min, volt_max, fan_div, fan_min,
temp_over, temp_hyst }

and I wouldn't mind betting that at some point in the future somebody decides
to put in sensors for amperage and humidity.

Anyway with this field you would not need to know what sensors belong to what
chip.

It seems that at the moment a /etc/sensors.conf file needs to have "default
labels" in it for all the user programs to work and if your chip is "none
standard" then your users have no idea of what is actually hapening.

I brought this problem up because my mortarboard (elite k7s5a) uses a sis735
driven by i2c-sis645 and does not give standard values (according to how I read
your docs).

After a lot of rebooting and comparing to my bios values i got a sensor dump of
this

eeprom-i2c-0-50
Adapter: SMBus SiS645 adapter at 0x0c00
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       256

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.50 V  (min =  +1.42 V, max =  +1.56 V)
Vcc 2.5V:  +2.48 V  (min =  +2.40 V, max =  +2.60 V)
Vcc 3.3V:  +3.29 V  (min =  +3.13 V, max =  +3.45 V)
Vcc 5V:    +4.99 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +11.36 V, max = +12.60 V)
Stdby 3V:  +3.44 V  (min =  +3.10 V, max =  +3.48 V)
- -12V:     -11.00 V  (min = -13.21 V, max = -10.90 V)
Stdby 5V:  +5.04 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.05 V
CPU fan:  4440 RPM  (min = 2657 RPM, div = 2)
SYS fan:     0 RPM  (min =    0 RPM, div = 2)
Sys Temp:    +33C  (min =  +25C, max =  +45C)
CPU Temp:    +45C  (min =  +25C, max =  +45C)

and my sensors.conf file looks like -

#Sensors for the k7s5a mainboard
#
# by D.H.McKay <troll@logi.net.au>
#
# taken from various parts of the orig sensors.conf
#
bus "i2c-0" "SMBus SiS645 adapter at 0x0c00" "Non-I2C SMBus adapter"

#chip "it87-isa-0290"
chip "it87-*"

# The values below have been tested on a Asus K7S5A motherboard

    label in0 "VCore"
    label in1 "Vcc 2.5V"
    label in2 "Vcc 3.3V"
    label in3 "Vcc 5V"
    label in4 "+12V"
    label in5 "Stdby 3V"
    label in6 "-12V"
    label in7 "Stdby 5V"
    label in8 "VBat"

    set in0_min 1.5 * 0.95
    set in0_max 1.5 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_min 3.3 * 0.94
    set in5_max 3.3 * 1.06
    set in6_max -12 * 0.90
    set in6_min -12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    #the chip does not support in8 min/max

    # vid is not monitored
    # and is not supported by driver at this time
    ignore  vid

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Temperature
#
# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type. This must be done
# with 'modprobe it87 temp_type=0xXX', you can't fix it in this file.
# See ../doc/chips/it87 for details and valid 'XX' values!!!
#
# I use temp_type=0x38 (all thermistors)
#
    label temp3       "CPU Temp"
    set   temp3_over  45
    set   temp3_hyst  25
    label temp2       "Sys Temp"
    set   temp2_over  45
    set   temp2_hyst  25
    ignore temp1

# Fans
    label fan1 "CPU fan"
    set fan1_min 2000
    label fan2 "SYS fan"
    set fan2_min 0
    ignore fan3


And an lsmod produces -

i2c-dev             4420   0  (autoclean) (unused)
it87                7560   0
eeprom              3728   0
i2c-proc            6896   0  [it87 eeprom]
i2c-isa             1196   0  (unused)
i2c-sis645          4688   0  (unused)
i2c-core           15408   0  [i2c-dev it87 eeprom i2c-proc i2c-isa i2c-sis645]

- -- 
regs MR E_T
_______________________
\                      \
  \   OOHH I hate TYPOS  \
    \                      \
      ~~~~~~~~~~~~~~~~~~~~~~~

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+KUMxPBbX35pvTSgRAkmHAJ0ae/FeHOFqO/Y8ah9GXMScqCD2ygCeLiSb
m0BlTbStRFPnjuL8nrWT6G8=wurf
-----END PGP SIGNATURE-----
