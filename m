From: jaclu@galdrion.com (Jacob Lundqvist)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: config for Asus a7v333 motherboard
Message-Id: <200208051135.17821.Jacob Lundqvist Jacob Lundqvist>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
It took me some time to get my motherboard running, thought I should share the 
config, since I didnt find anyplace on the site, I use this adr, sorry if I 
bother the wrong person...

	regards /Jacob Lundqvist

------ /etc/modules.conf ---------
alias char-major-89 i2c-dev
options w83781d force_as99127f=0,0x2d
---------------------------------------------

------ /etc/modules.conf --------
chip "as99127f-*"

#
# Configured for Asus a7v333 by Jacob Lundqvist (jaclu@galdrion.com)
# 2002-07-22
#
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

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

    label fan1 "CPU Fan"
    label fan2 "P/S Fan"

    label temp2 "CPU Temp"
    label temp1 "MB Temp"

    #compute temp2 (@*30/43)+25, (@-25)*43/30
    compute temp2 @*2, @/2
    set temp2_over 65
    set temp2_hyst 62
    set fan1_div 8
    set fan2_div 8
    set fan3_div 8

    ignore fan3 # comment if you got a third fan

    # dont know what temp3 is, so I just ignore it...
    ignore temp3

    label vid "Core cfg"

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
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
----------------------------------------------------

------- modules to load at startup --------
modprobe i2c-viapro
modprobe w83781d
----------------------------
