From: Iakov Karpov <sird@rkmail.ru>
Date: Tue, 07 Jul 2015 22:16:02 +0000
Subject: [lm-sensors] A config file for ASRock N68-GS UCC motherboard
Message-Id: <6652879.fnvNqCL888@stupidbox>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I am happy to announce, I made my first config file for lm_sensors!
ASRock N68-GS UCC is low-price segment motherboard for AM3/DDR3 platform,
based on nForce 630a and has Winbond W83627DHG superio. ASRock made a few
very similar motherboards, so I suppose the config would work for them too. 
Had no chance to test that theory on real hardware, but my experiments with 
BIOS say for it.
Anyway, my newly-made config is below the line, feel free to critique it.
/etc/sensors.d/ASRock-N68-GS3-UCC.conf:
---------------------------------------------------------
#libsensors3 confiuration file for ASRock N68-GS3 UCC
#Probably would work for all AM3-based ASRock N68-[VGS3|VS3|GS3|S3] UCC boards
#aswell as for their AM3+ successors (ASRock N68-[VGS3|VS3|GS3|S3] FX)

#Built-in CPU sensor

chip "k10temp-*"

    label temp1 "CPU Temp (on-chip)"

#Motherboard sensors

chip "w83627dhg-isa-*"

### Voltages

    label in0 "Vcore"
    label in2 "+3.3V"
    label in5 "+5V"
    label in6 "+12V"

    ignore in1 #not listed in BIOS, North bridge?
    ignore in3 #not listed in BIOS, looks like +3.3, but not the same voltage
               #as in BIOS
    ignore in4 #not listed in BIOS, unknown

    ignore cpu0_vid #useless value, never changes
    
    #Compute voltages
    compute in5 @ * 3  , @ / 3     #Guessed from BIOS values
    compute in6 @ * 6.6, @ / 6.6   #Guessed from BIOS values
    
    #Set limits, +/- 5%
    set in5_min  5 * 0.95
    set in5_max  5 * 1.05
    set in6_min 12 * 0.95
    set in6_max 12 * 1.05

### Temperatures

    label temp2 "CPU Temp (MB)"
    
    label temp1 "System Temp 1" #Have no idea where these two are,
    label temp3 "System Temp 2" #NB seems to be much hotter.

    set temp1_max      80 #Was set to be alike other temps,
    set temp1_max_hyst 75 #default values make no sense

### Fans

    label  fan1 "System Fan" #CHA_FAN1 on motherboard
    label  fan2 "CPU Fan"    #CPU_FAN1 on motherboard
    
    #Not present on motherboard
    ignore fan3
    ignore fan4
    ignore fan5

    set fan1_min 0   #Tweak this if you have case fan
    
    set fan2_min 500 #This value is probably to low for an average computer                     
#but I love slow and quiet fans.

### Intrusion

    ignore intrusion0 #Did not found a connector
---------------------------------------------------------
Hope this will help someone,
Thank you for your attention,
Iakov

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
