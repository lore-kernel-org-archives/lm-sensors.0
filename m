From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Apr 2008 08:58:42 +0000
Subject: Re: [lm-sensors] AMD K10 (Phenom) Sensor Module
Message-Id: <20080419105842.7866bf59@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47642FDA.6000801@cox.net>
In-Reply-To: <47642FDA.6000801@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

On Fri, 18 Apr 2008 23:44:31 -0600, Fred R. Beck wrote:
> I've been tied up and just got back to this.  Thanks much for the 
> "stripped down" version.  It looked much like my last attempt though I'd 
> missed on some of the registers...  I think you are right, this is 
> simple enough that there isn't much sense in combining the two drivers, 
> so I'll scrap that...

The main decision factor for combining support for several chips in a
single driver or not is not how simple they are but how similar they
are to each other.

> (...)
> So, running sensors now gives:
> 
>     # modprobe k8temp
>     # sensors
>     it8718-isa-0228
>     Adapter: ISA adapter
>     in0:       +1.07 V  (min =  +0.00 V, max =  +4.08 V)  
>     in1:       +1.90 V  (min =  +0.00 V, max =  +4.08 V)  
>     in2:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)  
>     in3:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
>     in4:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
>     in5:       +3.25 V  (min =  +0.00 V, max =  +4.08 V)  
>     in6:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)  
>     in7:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)  
>     in8:       +3.07 V
>     fan1:     1859 RPM  (min =   10 RPM)                  
>     fan2:        0 RPM  (min =    0 RPM)                  
>     fan3:        0 RPM  (min =    0 RPM)                  
>     fan5:        0 RPM  (min =    0 RPM)                  
>     temp1:       +39 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
>     temp2:       +41 C  (low  =  +127 C, high =   +70 C)   sensor = diode  
>     temp3:       +84 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
>     vid:      +0.000 V
> 
>     k10temp-pci-00c3
>     Adapter: PCI adapter
> 
> As you can see, I'm still figuring out how to configure lm_sensors for 
> my GA-MA790FX-DS5...  However, temp1 looks ok and matches what I'm 
> seeing in the BIOS.

Here's my guess for voltages if it helps you:
in0: Vcore
in1: Vram (although a bit high, should be 1.8)
in2: +3.3V
in3: +5V with scaling factor 1.68
in4: +12V with scaling factor 4
in5: 3VSB or 5VSB with a scaling factor of 1.68
in6: unused
in7: unused
in8: Vbat

Please check your logs after loading the it87 driver, it might give
hints about in3 and in7.

If your BIOS displays voltage values, compare with those to validate
your lm-sensors configuration settings.

As for temperature, temp2 would be the CPU temperature, and temp1 would
be the motherboard temperature. temp3 is a bit too high to be realistic
so I'd be tempted to claim that it's not wired.

If you come up with a good configuration file for this motherboard,
please send it back and we'll put it on the website.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
