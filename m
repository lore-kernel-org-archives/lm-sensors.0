From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 10:06:46 +0000
Subject: Re: [lm-sensors] Sensors on an nforce2 motherboard giving incorrect
Message-Id: <20071202110646.152cc616@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

On Mon, 19 Nov 2007 12:06:23 +0200, Chris Picton wrote:
> I have an aopen XC cube EZ18 with an nforce2 based motherboard
> 
> I am trying to get lm-sensors working, but am not getting the correct
> readings
> 
> I have attached outputs of lspci -v, lspci -n, sensors-detect, dmidecode

One of the I2C buses on your nVidia graphics adapter is hosed and added
a lot of noise to sensors-detect. Try again but say N when asked to
probe the "NVIDIA i2c adapter" buses, you'll get a much more readable
output.

> 
> smartbatt and pca9540 don't seem to exist in my kernel sources
> (linux-2.6.22-gentoo-r8)

True, but you don't actually have these chips anyway (see above.)

> 
> w83627hf and max6650 do load without errors

You don't have the latter either, only the former. Do not load the
max6650 driver.

> 
> when I run sensors, I get what I have pasted below
> 
> Note how no fan speeds are detected and temps are way too low (my
> ambient is about 28 C)
> In my bios, all speeds/temps seem to be picked up OK
> (...)
> ---------------------------------
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.55 V  (min =  +0.00 V, max =  +4.08 V)              
> VCore 2:   +1.58 V  (min =  +0.00 V, max =  +4.08 V)              
> +3.3V:     +3.31 V  (min =  +2.82 V, max =  +3.79 V)              
> +5V:       +4.97 V  (min =  +0.08 V, max =  +1.80 V)       ALARM  
> +12V:     +11.86 V  (min =  +0.79 V, max =  +8.33 V)       ALARM  
> -12V:     -11.87 V  (min =  -4.14 V, max = -13.59 V)       ALARM  
> -5V:       -5.05 V  (min =  +2.19 V, max =  -2.43 V)       ALARM  
> V5SB:      +5.46 V  (min =  +0.48 V, max =  +0.38 V)       ALARM  
> VBat:      +3.18 V  (min =  +0.13 V, max =  +3.65 V)              
> fan1:        0 RPM  (min = 42187 RPM, div = 2)              ALARM  
> fan2:        0 RPM  (min = 4856 RPM, div = 2)              ALARM  
> fan3:        0 RPM  (min = 9926 RPM, div = 2)              ALARM  
> temp1:       +17 C  (high =   +99 C, hyst =   +11 C)   sensor > thermistor           
> temp2:     +18.5 C  (high =   +70 C, hyst =   +65 C)   sensor > thermistor           
> temp3:     +19.0 C  (high =   +80 C, hyst =   +80 C)   sensor > thermistor           
> vid:      +0.000 V  (VRM Version 9.0)
> alarms:   
> beep_enable:
>           Sound alarm disabled

The important line you missed in the output of sensors-detect is:

Probing for `Fintek F75373S/SG'...                          Success!
    (confidence 7, driver `to-be-written')

This is your primary hardware monitoring chip. Your missing fan speeds
and temperatures are certainly there. By now, a driver for this chip
has been written by Riku Voipio (Cc'd). It is available in the upstream
kernel in 2.6.24-rc. You'll have to upgrade to the latest kernel, or
backport the driver to your 2.6.22 kernel.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
