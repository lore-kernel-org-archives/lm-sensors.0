From: Richard F <lists@keynet-technology.com>
Date: Tue, 08 Oct 2013 18:00:22 +0000
Subject: [lm-sensors] Sensors configuration for Foxconn H67M-S
Message-Id: <52544836.9080304@keynet-technology.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Below is the configuration I developed for a Foxconn H67M-S.
There are a range of similar Foxconn boards H67M-V, H67M etc
The monitoring chip is IT8728F, which I added to the "chip" line below.
The values I'm not sure about are commented out - the PECI CPU margin is 
particularly suspect.

Hope this is useful...

chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*" "it8728-*"

# WIKI says:  0 to 3.06 V, 1 bit = 12 mV
# These are configured in the same order the BIOS lists them.
# - assumption is that this map is correct!

      label  in0 "CPU Vcore"
      # no scaling                               # BIOS measured: VCORE 
1.152
      set in0_min 0.6                            # Intel. Lower level 
could be 0.25
      set in0_max 1.52                           # Could be as high as 1.52

      label  in1 "DRAM voltage"
      # no scaling                               # BIOS measured: DRAM 1.584
      set in1_min 1.3
      set in1_max 1.7

      label  in2 "+12V"
      compute in2 @ * 4.28, @ / 4.28             # Empirical vs. BIOS 
reading 12.126
      set in2_min 11.4                           # ATX V1.3 PSU design guide
      set in2_max 12.6

      label  in3 "+5V"
      compute in3  @ * 1.80, @ / 1.80            # Empirical vs. BIOS 
reading 5.017
      set in3_min 4.75                           # ATX V1.3 PSU design guide
      set in3_max 5.25

      ignore in4                                 # unused? always 2.99
      # no scaling
      set in4_min 0                              # Mask false alarms
      set in4_max 3.06

      ignore in5                                 # unused? always 2.99
      # no scaling
      set in5_min 0                              # Mask false alarms
      set in5_max 3.06

      ignore in6                                 # unused? always 2.99
      # no scaling
      set in6_min 0                              # Mask false alarms
      set in6_max 3.06

      #3VSB                                      # label supplied by code
      set in7_min 3.14                           # ATX V1.3 PSU design guide
      set in7_max 3.47

      #Vbat                                      # BIOS measures 3.264, 
label by code

      label  fan1 "CPU fan"
      set fan1_min 500

      label  fan2 "Chassis fan"
      set fan2_min 0                   # Set to 500 if you actually 
monitor one

      ignore fan3
      set fan3_min 0                   # mask false alarms

#     See 
http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface
#     label  temp1 "PECI CPU margin"
      ignore temp1
      set temp1_max 1                  # if margin > 0 losing thermal 
control = throttling
      set temp1_min -30

      label  temp2 "System temp"
      set temp2_min 0
      set temp2_max 55

      label  temp3 "CPU package temp"      # Code supplies limits


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
