From: office@systemberatung.at (Martin Irrgang)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Working config with ASUS A7V133
Message-Id: <3D3BCC4A.3BAA9E80@systemberatung.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Specialists!

I have attached a (on my standard machine) working /etc/sensors.conf for
"as99127f-*".

chip "as99127f-*"
# Same as above for w83782d except that in5 and in6 negative voltages
# are computed as in the w83781d.
# Asus won't release a datasheet so this is guesswork.
# New in5 and temp2 calculations courtesy Guntram Blohm.

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
# added MI
    label fan1 "Chassis1"
    label fan2 "CPU FAN1"
    label fan3 "Chassis2"

# added MI
    ignore in1
    ignore temp3
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

    compute temp2 (@*1.3)+25, (@-25)*1.3
# added MI
#   compute fan2 @*1.6 , @/1.6

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
#edit MI
#   set in2_max 3.3 * 1.05
    set in2_max 3.3 * 1.15
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
#edit MI
#   set in5_max -12 * 0.90
#   set in5_min -12 * 1.10
    set in5_max -12 * 1.10
    set in5_min -12 * 0.90
#edit MI
#   set in6_max -5 * 0.95
#   set in6_min -5 * 1.05
    set in6_max -5 * 1.05
    set in6_min -5 * 0.95
#added MI
    set fan1_min 3000
    set fan1_div 3
    set fan2_min 3000
    set fan2_div 3
    set fan3_min 3000
    set fan3_div 3

# examples for temperature limits
#edit MI
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47
     set temp1_over 50
     set temp1_hyst 47
     set temp2_over 62
     set temp2_hyst 57

hope it is of any help.

thanks & rgds, Martin Irrgang (office@systemberatung.at)

