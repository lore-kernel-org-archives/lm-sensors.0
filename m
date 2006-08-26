From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Aug 2006 21:17:05 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <20060826231705.15807a49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi J?rgen,

> Now it looks like:
> 
> snip =======
> 
> sensors
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.01 V  (min =  +0.00 V, max =  +4.08 V)
> VDDR:      +3.22 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> +5V:       +4.81 V  (min =  +0.00 V, max =  +6.85 V)
> +12V:     +11.46 V  (min =  +0.00 V, max = +16.32 V)
> -12V:     -16.97 V  (min = -16.97 V, max =  +4.01 V)   ALARM
> -5V:       -8.78 V  (min =  -8.78 V, max =  +4.05 V)   ALARM
> 5VSB:      +4.78 V  (min =  +0.00 V, max =  +6.85 V)
> VBat:      +2.93 V
> CPU_Fan:  2096 RPM  (min =    0 RPM)
> CHA_Fan1: 1264 RPM  (min =    0 RPM)
> PWR_Fan:   920 RPM  (min =    0 RPM)
> CPU Temp:    +22?C  (low  =    -1?C, high =  +127?C)   sensor = diode
> MB Temp:     +29?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
> temp3:        -5?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
> vid:       +0.30 V

Voltages look good. in2, in5 and in6 are obviously not wired so you can
add the following lines to your configuration file:

   ignore in2
   ignore in5
   ignore in6

And you can set the proper label for in1:

   label in1 "+3.3V"

It also looks like temp3 isn't wired so you can add:

   ignore temp3

Lastly, the vid reading is really strange, the value isn't even
possible for your CPU model. I think you are using a slightly older
kernel which lacks this fix:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h7d165d7c2ec424007d6241a93d0cb83d953c51

If you can apply this patch, it should fix your vid reading.

> The all fan speeds are now correct. Great work !

Thanks :)

> prog/detect/sensors-detect
> # sensors-detect revision 4112 (2006-08-25 21:59:29 +0200 (Fr, 25 Aug 2006))
> 
> This program will help you determine which I2C/SMBus modules you need to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): yes
> Probing for PCI bus adapters...
> Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4 SMBus 
> (MCP55)
> Probe successfully concluded.

OK, that's your SMBus.

> We will now try to load each adapter module in turn.
> Module `i2c-nforce2' already loaded.

And the driver is loaded, but...

>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).

... it doesn't seem to work, else sensors-detect would scan it. Support
for this SMBus master was only added recently, so maybe you need to
apply this patch as well:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h\7ae65899a4c5b05b6277f856018d1eeeb98907

> Btw.. do you have any idea, why "i2cdetect" doesnt detect anything.. like the 
> EEPROMS at the memory modules...

Because these are behind the SMBus, and it doesn't work for you yet. If
you can get it to work using the patch above, run sensors-detect gain
and it should find your EEPROMs - and maybe the additional hardware
monitoring chip I suspect you have for the additional fans.

-- 
Jean Delvare

