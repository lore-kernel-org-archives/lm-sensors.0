From: schopen@medienlabor.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU Fan on ASUS P4P800VM
Message-Id: <200501272214.14608.schopen@medienlabor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

are there any known problems with the CPU Fan output and ASUS P4P800VM 
motherboards? I don't get any output (0 RPM). MB Temp and CPU Temp is fine. 
I'm using kernel 2.6.2 on Debian/sarge. The following kernel modules are 
loaded: i2c-i801, i2c-isa, eeprom, w83627hf init=0. lmsensors.conf:

chip "w83627thf-*" "w83637hf-*"

    label in0 "VCore"
    label in1 "+12V"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "-12V"
    label in7 "V5SB"
    label in8 "VBat"

    compute in1 ((28/10)+1)*@, @/((28/10)+1)
    compute in3 ((34/51)+1)*@, @/((34/51)+1)
    compute in4 (5.14*@)-14.91, (@+14.91)/5.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set in0_min vid * 0.95
    set in0_max vid * 1.05
    set in1_min 12 * 0.90
    set in1_max 12 * 1.10
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min -12 * 0.90
    set in4_max -12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

    label temp1 "M/B Temp"
    label temp2 "CPU Temp"
    ignore temp3

    # ignore fan1
    label fan2 "CPU Fan"
    # ignore fan3

Thanks,
Marcus
-- 
Marcus Schopen - schopen@medienlabor.de
Medienlabor. - Paulusstr.1 (im Victoria Geb?ude) - 33602 Bielefeld
tel. +49 521 9824771 - fax. +49 521 9824772 - mob. +49 171 6433903
InterNet, GNU/Linux, ZOPE, Netzwerke, Security, Consulting&Support

visit Deutsche Zope User Group - www.dzug.org
