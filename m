From: Marcelo Coelho <marcelocoelho@gmail.com>
Date: Sat, 28 May 2011 10:00:28 +0000
Subject: [lm-sensors] Working configuration for intel D945GCLF
Message-Id: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I don't have a wiki account, so anyone that has one can put this in

intel/D945GCLF ?


# Configuration for Intel DG945GCLF
chip "smsc47m192-*"
    label in0 "+2.5V"
    set in0_min  2.5 * 0.95
    set in0_max  2.5 * 1.05

    label in1 "Vcore"
    set in1_min  0.9
    set in1_max  1.162

    label in2 "+3.3V"
    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10

    label in3 "+5V"
    set in3_min  5.0 * 0.90
    set in3_max  5.0 * 1.10

    label in4 "+12V"
    set in4_min 12.0 * 0.90
    set in4_max 12.0 * 1.10

    label in5 "VCC"
    set in5_min  3.3 * 0.90
    set in5_max  3.3 * 1.10

    label in6 "+1.5V"
    set in6_min  1.5 * 0.90
    set in6_max  1.5 * 1.10

    label in7 "+1.8V"
    set in7_min  1.8 * 0.90
    set in7_max  1.8 * 1.10

    label temp1 "Chipset Temp"
    set temp1_min 0
    set temp1_max 90

    label temp2 "CPU Temp"
    set temp2_min 0
    set temp2_max 85

    label temp3 "System Temp"
    set temp3_min 0
    set temp3_max 75

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
