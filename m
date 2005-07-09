From: wagner@tik.ee.ethz.ch (Arno Wagner)
Date: Sat, 09 Jul 2005 02:07:22 +0000
Subject: [lm-sensors] sensors.conf for Asus A7V880
Message-Id: <20050709000637.GA29202@tik.ee.ethz.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This board does some things a bit different and does not monitor some 
voltages. sensors.conf block for it follows. 

Regards,
Arno

----
root /etc>sensors --version
sensors version 2.9.1 with libsensors version 2.9.1
root /etc>
----

chip "it87-*" "it8712-*"

# The values below have been tested on Asus CUSI, CUM motherboards.

# A7V880 (Asus) by Arno Wagner <arno@wagner.name>
# Comment all other entries in this section when using this
# Assumes a 1.65V CPU 

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"  
    label in4 "+12V" 
    label in5 "-12V" 
    label in6 "-5V"  
    label in7 "Stdby"
    label in8 "VBat"

    # in0 CPU core voltage VCore
    compute in0 -0.05+@ , @+0.05  # VCore is displayed 0.05V too high
    set in0_min 1.65 * 0.95       # Nominal 1.65V
    set in0_max 1.65 * 1.05       # Nominal 1.65V

    # in1  not connected to anything
    ignore in1

    # in2 +3.3V, take directly
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05

    # in3 +5V   
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    set in3_min 5 * 0.95
    set in3_max 5 * 1.05

    # in4 +12V
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05

    # in5  not connected to anything
    ignore in5

    # in6  not connected to anything
    ignore in6

    # in7  not connected to anything
    ignore in7

    # in8 Battery, measure directly, no min/max checks
      
    # CPU temperature   
    label temp1       "CPU Temp"
    set   temp1_over  45
    set   temp1_low   0

    # Mainboard temperature
    label temp2       "M/B Temp"
    set   temp2_over  40
    set   temp2_low   0

    # temp3 is unused
    ignore temp3

    set fan1_min 1200
    set fan2_min 1200
    ignore fan3

# A7V880 end






-- 
Arno Wagner, Dipl. Inform., CISSP --- CSG, ETH Zurich, wagner@tik.ee.ethz.ch 
GnuPG:  ID: 1E25338F  FP: 0C30 5782 9D93 F785 E79C  0296 797F 6B50 1E25 338F
----
Cuddly UI's are the manifestation of wishful thinking. -- Dylan Evans
Windows is the "under-3" toy of the OS world. -- Matthew D. Fuller
