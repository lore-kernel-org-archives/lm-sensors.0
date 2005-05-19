From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Troubles making sensors work with ASUS motherboard
Message-Id: <3CBC7813.334795A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CB6C091.1040109@berg.dk>
In-Reply-To: <3CB6C091.1040109@berg.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most of the voltages probably aren't hooked up to the via686.
I think this board has a w83782d or as99127f at 0x2d on the i2c bus,
and that sensor has all the voltages hooked up.
mds

Martin Berg wrote:
> 
> Mark Studebaker wrote:
> 
> >> via686a.o version 2.6.2 (20011118)
> >> via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
> >> via686a.o: No Via 686A sensors found.
> >> via686a.o version 2.6.3 (20020322)
> >> via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
> >> via686a.o: No Via 686A sensors found.
> >>
> > Hopefully this is you trying two separate versions and not two different
> > modules being loaded at once. Otherwise you have a problem.
> >
> Hmm, I only issued one modprobe via686a.
> There does though exist two (different) via686a.o 's - one under
> ./misc/via686a.o and one under ./kernel/drivers/sensors/via686a.o.
> The first originates from the installation of lm_sensors and the second
> originates from a complete module rebuild for the kernel (make modules;
>  make modules_install).
> 
> Just as a test I removed the one not belonging to lm_sensors (that is:
> removed the one from the SuSE installation).
> After modprobe via686a force_addr=0x0d00 there is (just as before)
> one sensor in /proc/sys/dev/sensors/chips:
>    256     via686a-isa-0d00
> 
> After sensors -s, sensors produce the before seen rubbish data.
> Now, I am aware of the possible need to ajust sensors.conf, but all the
> values except "SBr Temp" are static - and by using the hardware monitor
> in the BIOS it seems that all voltages and temperatures change back and
> forth over time (not to mention the permanent0 for fan speed).
> 
> Example output from sensors:
> via686a-isa-0d00
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> CPU core:  +3.03 V  (min =  +1.98 V, max =  +2.49 V)   ALARM
> +2.5V:     +3.03 V  (min =  +2.24 V, max =  +2.74 V)   ALARM
> I/O:       +3.44 V  (min =  +2.95 V, max =  +3.62 V)
> +5V:       +6.28 V  (min =  +4.47 V, max =  +5.49 V)   ALARM
> +12V:     +15.22 V  (min = +10.79 V, max = +13.18 V)   ALARM
> CPU Fan:     0 RPM  (min = 3000 RPM, div = 2)
> P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)
> SYS Temp:  -68.3?C  (limit =  +45?C, hysteresis =  +40?C)
> CPU Temp:  -68.3?C  (limit =  +60?C, hysteresis =  +55?C)
> SBr Temp:  +28.0?C  (limit =  +65?C, hysteresis =  +60?C)
> 
> Is this just a matter of tweaking the sensors.conf ?
> 
> Thanks for your help
> 
> Martin Berg
