From: mot@mediaweb.gr (Thomas Venieris)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: The correct sensors.conf for ASUS A7V600
Message-Id: <4046DEA5.9020209@mediaweb.gr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear sirs,

I managed to make lm-sensors work with my ASUS A7V600, and I thought you 
would like to know the settings in sensors.conf in case anyone else 
needs them. I could not find any other suitable place to send this 
information. Hope it helps. If not, tell me where I can post this info. 
Here goes:

I use Linux 2.6.3 compiled from source. I2C was compiled as modules.
I used lm-sensors 2.8.4, also compiled from source. As instructed, I 
installed the user-space programms only (make user). I took the 
sensors.conf from the same version (2.8.4).

The modules needed to load for the ASUS A7V600 are: i2c-isa and it87

Here goes the piece of sensors.conf that makes it work correctly:

##### sensors.conf ######
chip "it87-*" "it8705-*" "it8712-*"

# The values below have been tested on Asus A7V600.

# Voltages

    label in0 "VCore 1"
    # Put CPU VCore here, 1.65 in my setup
    set in0_min 1.65 * 0.95
    set in0_max 1.65 * 1.05
    # VCore2 not available in the A7V600 (reads 0.0)
    ignore in1
    label in2 "+3.3V"
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    label in3 "+5V"
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    label in4 "+12V"
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    # -12V and -5V not available in the A7V600
    ignore in5
    ignore in6
    label in7 "Stdby"
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    label in8 "VBat"
    #the chip does not support in8 min/max

    # vid is not monitored by IT8705F
    # and is not supported by driver at this time
    # ignore  vid

# Fans

    label fan1 "CPU Fan"
    set fan1_min 1500
    label fan2 "CHA Fan"        # Chassis fan
    ignore fan2 # Not connected, but usable (untested though)
    label fan3 "PWR Fan"        # Power fan
    set fan3 1500

# Temperatures

   # The A7V600 seems to operate with thermistors, NOT diodes.
   label temp1       "CPU Temp"
   set sensor1 2
   set   temp1_over  55
   set   temp1_low   15
   # Warning: The config example for sensors 2.8.4 suggested the 
following for the A7V600:
#   compute temp1     (@+128)/3, (3*@-128)
   # However, it did not work correctly. It was stuck at 58"C.
   # Instead the setting for A7V8X-X worked OK (same reading as the BIOS)
   compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893
   label temp2       "M/B Temp"
   set sensor2 2
   set   temp2_over  45
   set   temp2_low   15
   ignore temp3         # Not available on the A7V600

##### sensors.conf end ######

With these settings, sensors outputs the following:

it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.64 V  (min =  +1.56 V, max =  +1.72 V)  
+3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)  
+5V:       +4.86 V  (min =  +4.72 V, max =  +5.24 V)  
+12V:     +12.16 V  (min = +11.36 V, max = +12.60 V)  
Stdby:     +4.99 V  (min =  +4.72 V, max =  +5.24 V)  
VBat:      +4.08 V
CPU Fan:  3245 RPM  (min = 2657 RPM, div = 2)         
PWR Fan:  3391 RPM  (min = 3000 RPM, div = 2)         
CPU Temp:    +50?C  (low  =   +15?C, high =   +55?C)   sensor = 
thermistor  
M/B Temp:    +34?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor


Hope this information helps. Again, if you could show me some place more 
appropriate for this, let me know. Also, I am available for further 
testing and inquiries (BIOS version, board revision etc.)


Best regards,
Thomas Venieris
Athens, Greece

-- 
moT

"There's the television. It's all right there. It's all
right there. Look. Listen. Kneel. Pray. Commercials."
                                           (12 Monkeys)


