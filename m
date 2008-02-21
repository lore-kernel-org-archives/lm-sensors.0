From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Feb 2008 07:27:44 +0000
Subject: Re: [lm-sensors] First shot at Asus M2N-SLI Deluxe config file
Message-Id: <20080221082744.10bf67a1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Wed, 20 Feb 2008 18:30:58 -0600 (CST), Matt Roberds wrote:
> Here's a first shot at a config file for an Asus M2N-SLI Deluxe
> motherboard.  It may also work for other versions of the M2N-SLI; I
> don't know.

Note, I have a configuration file for the Asus M2N32-SLI; it might have
common points with your board:
http://khali.linux-fr.org/devel/lm-sensors/sensors-Asus-M2N32-SLI.conf

Once you have a good configuration file for your board, you could add
it to the wiki:
http://www.lm-sensors.org/wiki/Configurations/Asus

Comments on your configuration file:

> # First cut at a minimal sensors3.conf for Asus M2N-SLI Deluxe motherboard
> # Matt Roberds, 20 Feb 2008
> 
> 
> chip "it8716-*"
> 
> # Voltages
> 
>     label  in0  "VCore"
>     label  in1  "VDDR"
>     ignore in2             # 3.3 V?

I would be very surprised if +3.3V wasn't monitored. Doesn't it show in
the BIOS?

>     label  in3  "+5V"      # VCC
>     label  in4  "+12V"
>     label  in5  "-12V"
>     label  in6  "-5V"
>     label  in7  "5VSB"     # VCCH
>     label  in8  "VBat"
> 
>     compute in3  ((6.8/10)+1)*@ , @/((6.8/10)+1)
>     compute in4  ((30/10)+1)*@  , @/((30/10)+1)
>     compute in7  ((6.8/10)+1)*@ , @/((6.8/10)+1)
> 
> # in5 and in6 appear to be wrong (I get around -17 V and -9 V with these
> # 'compute' lines), but I'm not sure how to adjust the 'compute' lines.
> 
>     compute in5  (1+232/56)*@ - 4.096*232/56 , (@ + 4.096*232/56)/(1+232/56)
>     compute in6  (1+120/56)*@ - 4.096*120/56 , (@ + 4.096*120/56)/(1+120/56)

Most modern motherboards do not monitor -5V, and in general they don't
monitor -12V either. Look in your BIOS, it probably doesn't display
these either. So either these voltage inputs are unused, or they are
used for something else. Try commenting out the compute statements and
see if the raw voltage value rings a bell. Comparing with what the BIOS
displays might help as well.

> 
> # Temperatures
> 
> # Not sure.  temp1 always reads close to what k8temp reports for Core0.
> # temp3 always reads approximate ambient temperature.  temp2 is between
> # temp1 and temp3.

What does the BIOS display?

> 
> # Fans
> 
>     label  fan1 "CPU Fan"
>     label  fan2 "Chassis Fan 1"
>     label  fan3 "Power Supply Fan"
> 
> 
> chip "ADT7475-*"
> 
> # For some reason, ignoring vccp, remote1, and remote2 doesn't work.  Is
> # it because they have ALARM set?

"vccp", "remote1" and "remote2" are not standard sysfs names, so I am
not surprised that libsensors doesn't recognize them. Should be in<N>
and temp<N>.

> 
> # Voltages
> 
>     ignore vccp
>     label  vcc  "+3.3V"

"vcc" isn't a standard name either, I guess that this label statement
has no effect?

> 
> # Temperatures
> 
> # Not 100% sure.  remote1 and 2 don't appear to be hooked up; local is
> # on board the adt7475 chip itself.
> 
>     ignore remote1
>     ignore remote2
> 
> # Fans
> 
>     label  fan1 "Chassis Fan 4"
>     label  fan2 "Chassis Fan 2"
>     label  fan3 "Chassis Fan 3"
>     ignore fan4
> 
> 
> chip "k8temp-*"
> 
>    label temp1 "Core0 Temp"
>    label temp3 "Core1 Temp"
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
