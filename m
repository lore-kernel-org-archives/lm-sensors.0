From: Marc Muehlfeld <marc.muehlfeld@web.de>
Date: Tue, 19 Apr 2011 21:26:38 +0000
Subject: [lm-sensors] Config file for Gigabyte GA-EX38-DS4
Message-Id: <201104192326.38813.marc.muehlfeld@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I created a sensors3.conf for my Gigabyte GA-EX38-DS4. Maybe someone with an 
account can add this to the wiki.

Regards,
Marc



chip "it8718-*"

        # Voltages
        label   in0 "CPU Vcore"
        label   in1 "DDR"
        label   in2 "+3.3V"
        label   in3 "+5V"
        ignore  in4
        ignore  in5
        ignore  in6
        label   in7 "+12V"
        label   in8 "VBat"

        compute in3  @ * (6.8/10+1), @ / (6.8/10+1)
        compute in7  @ * 3.963,      @ / 3.963

        set in0_min  1.120 * 0.95
        set in0_max  1.120 * 1.05
        set in1_min  1.89  * 0.95
        set in1_max  1.89  * 1.05
        set in2_min  3.3   * 0.95
        set in2_max  3.3   * 1.05
        set in3_min  5     * 0.95
        set in3_max  5     * 1.05
        set in7_min 12     * 0.95
        set in7_max 12     * 1.05


        # Temperatures
        label  temp1 "CPU temp"
        label  temp2 "System temp"
        ignore temp3
        
        set temp1_min 10
        set temp1_max 65
        set temp2_min 10
        set temp2_max 55


        # Fans
        label  fan1 "CPU fan"
        label  fan2 "Chassis fan"
        label  fan3 "Sys fan 2"
        label  fan4 "Sys fan 1"

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
