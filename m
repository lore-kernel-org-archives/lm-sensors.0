From: jp80@libero.it (jp80@libero.it)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: LM_Sensors 2.6.2 and QDI Kudoz 2.0
Message-Id: <001001c1a76e$f71871a0$7efd1d97@rejected>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First of all I'd like to thank you all for this really useful program.

I tested LM_Sensors 2.6.2 (with the new fixed sensors-detect script) on my
QDI Kudoz 2.0 (Via KT 266a chipset ).
I hope this settings can help somebody in trouble with this mobo.

1)My /etc/modules.conf

#----cut here----
# I2C module options
#alias char-major-89 i2c-dev

2)My /etc/rc.d/rc.local

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe it87
#----cut here----

3)I got errors while using first chip "it87" settings block so I tried the
second one and it works!
Moreover lm_sensors retrieved also my correct motherboard temp.
There is still an error with "-12v" (lm_sensors returns -0v)

chip "it87-*"

# The following is for the Inside Technologies 786LCD which uses either a
# IT8705F or a SIS950 for monitoring with the SIS630.
# You will need to load the it87 module as follows to select the correct
# temperature sensor type.
# modprobe it87 temp_type=0x31
# The sensors-detect program reports lm78 and a sis5595 and lists the it87
as
# a misdetect.  Don't do the modprobe for the lm78 or sis5595 as suggested.
#
# delete or comment out above it87 section and uncomment the following.
#chip "it87-*"
    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "3.3 Stdby"
    label in6 "-12V"
    label in7 "Stdby"
    label in8 "VBat"
    # in0 will depend on your processor VID value, set to voltage specified
in
    # bios setup screen
    set in0_min 1.7 * 0.95
    set in0_max 1.7 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    # +- 12V are very poor tolerance on this board. Verified with voltmeter
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05
    set in6_max -12 * 0.90
    set in6_min -12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    # vid not monitored by IT8705F
    ignore  vid

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
#=> #IT RETURNS -0v
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    # Temperature
    label temp1       "CPU Temp"
    label temp2       "MoBo Temp"                #=> IT WAS "ignore temp2"
    ignore temp3
    # Fans
    set fan1_min 3000
    ignore fan2
    ignore fan3

I hope you appreciate this (very) little contribution.

Bye.

Ghilardi Gian Paolo
rejected@filibusta.crema.unimi.it
