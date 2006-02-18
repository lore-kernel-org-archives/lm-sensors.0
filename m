From: roger@planbit.co.uk (Roger Lucas)
Date: Sat, 18 Feb 2006 15:54:22 +0000
Subject: [lm-sensors] vt8231 - epia800
Message-Id: <20060218155400.7597312EC9@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
In-Reply-To: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabe,

 

I haven't tried the VT8231 driver with an Epia 800 as I don't have one.  For
my Epia 5000 board, my current sensors.conf is below.

 

The temperature scaling was found by measuring the device heatsink with a
thermal probe whilst monitoring the VT8231 output.  The curve is very
different to anything from VIA or anyone else, but it is accurate for my
Epia 5000 boards (I have 4 of them).

 

The voltage scaling is totally dependent on the external resistors to the
VT8231.  If your board has the same external resistor combinations as mine
then the voltages are the same.  If you have different resistors then you
will have to work out which is which.  Let me know if you feel the need to
go down the same path and I'll give you some pointers..

 

FWIW, I am running the 2.6.14 kernel.

 

Regards,

 

Roger

====================

 

 

chip "vt1211-*" "vt8231-*"

#
=====================================
#           *** This file is specific to the Via EPIA 5000 ***

#
---------------------------------------------------------------------------

#

# Although other motherboards may well use the VT8251, there is NO GUARANTEE

# that they will have it wired up in the same configuration.  External

# components may differ and the device inputs may be used to sense different

# things.

#

#       CHECK THAT YOUR CONFIGURATION IS CORRECT FOR YOUR MOTHERBOARD.

#
=====================================
#

 

    label in0 "+12v"

    label in1 "+5v"

    label in2 "+2.5v"

    label in3 "Vcore1 (1.2v)"

    label in4 "NorthBridge Core"

    label in5 "+3.3V"

 

    label temp1 "CPU Temp"

#

#   Voltage scaling, as far as possible, is in the driver.  For IN0-4 the

#   voltage at the VT8231 PIN is returned in mV.  If the input is used to

#   measure a voltage that may exceed 2.5v then external scaling must be

#   provided on your motherboard.  Depending on the voltage, the appropriate

#   scaling values are below (if the motherboard manufacturer followed VIA's

#   guidelines...)

#

#       Voltage                 Scale

#       VCore                   1.0

#       2.5                     0.8333

#       3.3                     0.6296

#       3.5 (3.3V ext.)         0.5952

#       5.0                     0.4167

#       12.0                    0.1754

 

    compute in0 @/0.1754,@*0.1754

    compute in1 @/0.4167,@*0.4167

    compute in2 @/0.8333,@*0.8333

    compute in4 @/0.6296,@*0.6296

 

    set in0_min 12.0 * 0.95

    set in0_max 12.0 * 1.05

    set in1_min 5.0 * 0.95

    set in1_max 5.0 * 1.05

    set in2_min 2.5 * 0.97

    set in2_max 2.5 * 1.03

    set in3_min 1.2 * 0.95

    set in3_max 1.2 * 1.05

    set in4_min 3.3 * 0.95

    set in4_max 3.3 * 1.05

    set in5_min 3.3 * 0.95

    set in5_max 3.3 * 1.05

 

    set fan1_div 8

    set fan1_min 1000

    set fan2_div 8

    set fan2_min 1000

 

#   This temperature calibration is found by measuring a sample device.

#   You may wish to verify these values on your own platform.

 

#    compute temp0 @*317.2-57.55,(@+57.55)/317.2

    compute temp1 @*1.268-57.54,(@+57.54)/1.268

    set temp1_min 15

    set temp1_max 50

 

# End of file

 

 

 

  _____  

From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of Gabe
Sent: 18 February 2006 15:38
To: LM Sensors
Subject: Re: [lm-sensors] vt8231 - epia800

 

Hello,

2006/2/18, Jean Delvare <khali at linux-fr.org>:

Hi,

> Does anyone can tell me how to get the temperature of my system ?
>
> MB : Epia 800 (sensor vt8231)
> (...)
> output of sensors :
> vt8231-isa-6000
> Adapter: ISA adapter 
> in0:       +2.13 V  (min =  -0.03 V, max =  +2.63 V)
> +2.5V:     +2.55 V  (min =  -0.04 V, max =  +3.16 V)
> VCore:     +2.07 V  (min =  +1.56 V, max =  +1.72 V)   ALARM

What's the nominal voltage for your CPU? 


1.65 V 

 

> +5V:       +4.03 V  (min =  -0.07 V, max =  +5.23 V) 
> +12V:     +12.55 V  (min = +11.36 V, max = +12.55 V)
> +3.3V:     +3.30 V  (min =  +3.13 V, max =  +3.46 V)
> fan1:        0 RPM  (min = 2570 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min = 2570 RPM, div = 2)          ALARM 

If you don't have fans connected or they are not able to report their
speed, set the limit to 0 to get rid of the alarm. If you have slow
fans, increase the fan clock divider values to 4 or 8 to get the speed 
reading, and set the limits to lower values too.


I have no fan and set the min to 0 as you say, alarm has disappeared,
thanks.

 

> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> ERROR: Can't get TEMP4 data!
> ERROR: Can't get TEMP5 data!
> ERROR: Can't get TEMP6 data!
> ERROR: Can't get TEMP7 data!

Kernel version (uname -r)?


2.6.16-rc3
with the last vt8231 patch (given in this mailing list) 

 

Sensors version (sensors -v)?


sensors version 2.9.2 with libsensors version 2.9.2 

 

--
Jean Delvare



with the last vt8231 version I get an alarm to in0 :
in0:       +2.13 V  (min =  -0.03 V, max =  +2.63 V)   ALARM

regards,
Gabe

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060218/5ba2f49c/attachment-0001.html
