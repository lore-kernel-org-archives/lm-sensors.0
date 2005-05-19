From: gh2000@earthlink.net (gh)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: W83697HF config
Message-Id: <200306091738.42584.gh2000@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors team:

Thanks for a great product.

Here are my $0.02: 

I have a MB with the Winbond W83697HF chip and everything works great.

Here is the config that I use:

chip "w83697hf-*"

    label in0 "VCore"
    label in2 "Vagp"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "Vio"
    label in6 "Vdimm"
    label in7 "V5SB"
    label in8 "VBat"
    label fan1 "CPU fan"
    label fan2 "Chassis fan"
    label temp1 "System temp"
    label temp2 "CPU temp"
    
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set in0_min 1.8 * 0.95
    set in0_max 1.8 * 1.05

    set in2_min 1.5 * 0.95
    set in2_max 1.5 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max 3.3 * 1.05
    set in5_min 3.3 * 0.95
    set in6_max 2.5 * 1.05
    set in6_min 2.5 * 0.95
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

Thanks again.

gh
