From: keizerflipje@home.nl (Pascal de Bruijn)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: ASRock K7VM2 _ sensors.conf
Message-Id: <41AB8A0C.7040901@home.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've fiddled with lm_sensors and my ASRock K7VM2 motherboard, 
it works great using this (see below) configuration.

Good luck,
Pascal de Bruijn

------------------------------------------------------------------------------------

chip "w83697hf-*"

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values. no in1 on this chip.

# All values are adjusted for use with a ASRock K7VM2 motherboard!

    label in0   "   Vcore"
    label in2   "  + 3.3V"
    label in3   "  + 5.0V"
    label in4   "  +12.0V"
    label fan1  " CPU fan"
    label fan2  "Case fan"
    label temp1 "CPU temp"
    label temp2 " MB temp"
 
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# 697HF does not have VID inputs so you MUST set your core
# voltage limits below. Currently set for 1.6V core.
#               vvv

    set in0_min 1.6 * 0.95
    set in0_max 1.6 * 1.05

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
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

    set sensor1 3435 
    set sensor2 3435

    set temp1_over 80
    set temp1_hyst 75
    set temp2_over 80
    set temp2_hyst 75

    set fan1_div 4
    set fan2_div 4

    set fan1_min 1328
    set fan2_min 1328

    ignore in5
    ignore in6
    ignore in7
    ignore in8
