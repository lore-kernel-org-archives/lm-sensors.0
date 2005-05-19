From: javiernoval@free.fr (Javier)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: sensors.conf data for KuDoz 7E/333 motherboard
Message-Id: <1040777369.2995.228.camel@drizzt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there. First of all, I'll want to thank you for this project, it's
just great work. Well, I'm now using release 2.6.5, and to the time the
sensors.conf file which come with my Debian package is not right for my
board, so I thought it would be good to sent you the relevant section of
the corrected one. So, here it comes (notes follow the fragment):

--

# The following is for the Inside Technologies 786LCD which uses either a
# IT8705F or a SIS950 for monitoring with the SIS630.
# You will need to load the it87 module as follows to select the correct
# temperature sensor type.
# modprobe it87 temp_type=0x31
# The sensors-detect program reports lm78 and a sis5595 and lists the it87 as
# a misdetect.  Don't do the modprobe for the lm78 or sis5595 as suggested.
#
# delete or comment out above it87 section and uncomment the following.
# Section modified to work with my board (KuDoz 7E/333)
chip "it87-*"
    label in0 "VCore 1"
    label in1 "+2.5V"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "3.3 Stdby"
    label in7 "Stdby"
    ignore in8
    # in0 will depend on your processor VID value, set to voltage specified in
    # bios setup screen
    set in0_min 1.7 * 0.95
    set in0_max 1.7 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.90
    set in3_max 5.0 * 1.10
    # +- 12V are very poor tolerance on this board. Verified with voltmeter
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_min 3.3 * 0.95
    set in6_max 3.3 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    # vid not monitored by IT8705F
    ignore  vid

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in5 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    # Temperature
    label temp1       "CPU Temp"
#    ignore temp2
    label temp2       "MB Temp"
    ignore temp3
    # Fans
    set fan1_min 3000
    ignore fan2
    ignore fan3

--

As you can see if you compare it with the original one, I have changed a
few "in" lines, corrected the limits for one of the +-12V inputs (which
was 5% and should be 10% as the other one, I think), and labeled temp2.
By the way, the modprobe line is also wrong for my board, temp_type must
be 0x38 and not 0x31.

I hope this info will be helpful to you. Thanks again and keep up the
good work.

P.D. I'm Spanish, so please excuse my English :-)
-- 
Javier Noval <javiernoval@free.fr>
