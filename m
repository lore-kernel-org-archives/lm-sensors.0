From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 13 May 2012 03:03:49 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <20120513030349.GA8672@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 12, 2012 at 05:25:21PM -0400, James wrote:
> 
> I bought a new motherboard (ASRock 970 Extreme3) and it doesn't report the fans.
> 
> # sensors-detect
> Driver `adt7475':
>   * Bus `nouveau-0000:01:00.0-2'
>     Busdriver `drm', I2C address 0x2e
>     Chip `Analog Devices ADT7473' (confidence: 5)
> 
> Driver `w83627ehf':
>   * ISA bus, address 0x290
>     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> 
> Driver `fam15h_power':
>   * Chip `AMD Family 15h power sensors' (confidence: 9)
> 
> Driver `k10temp':
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)
> 
> 
> # sensors            
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:         +0.0 C  (high = +100.0 C, crit = +110.0 C)
> 
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:      101.61 W  (crit =  95.01 W)
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +15.8 C  (high = +70.0 C)
>                        (crit = +70.0 C, hyst = +67.0 C)
> 
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:        +0.86 V  (min =  +0.00 V, max =  +1.74 V)
> in1:          +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:         +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> +3.3V:        +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:          +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:          +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:         +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> Vbat:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> fan1:           0 RPM  (min =    0 RPM)  ALARM
> fan2:           0 RPM  (min =    0 RPM)  ALARM
> fan3:           0 RPM  (min =    0 RPM)  ALARM
> fan4:           0 RPM  (min =    0 RPM)  ALARM
> fan5:           0 RPM  (min =    0 RPM)  ALARM
> SYSTIN:       +38.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
> CPUTIN:       +36.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> AUXTIN:        -2.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> cpu0_vid:    +0.000 V
> intrusion0:  ALARM
> intrusion1:  ALARM
> 
> 
> The motherboard manual says it does the following hardware monitoring:
>  CPU Temperature Sensing
>  Chassis Temperature Sensing
>  CPU/Chassis/Power Fan Tachometer
>  CPU/Chassis Quiet Fan
>  CPU/Chassis Fan Multi-Speed Control
>  Voltage Monitoring: +12V, +5V, +3.3V, Vcore
> 
> The CPU fan says 3366 RPM in the BIOS.
> Case fan3 1033 RPM.
> sensors also doesn't show +12V or +5V.
> 
I think here may be your answer, found on the web. This is from Aida64 support.

"The only thing that may cause such issue would be the proprietary fan muxing feature that ASRock uses on your motherboard (and a number of other motherboards as well). It effectively muxes the RPM measurement signals of the CPU fan1 and the CPU fan2 headers into the same fan register of the Nuvoton sensor chip. When another software (for example ASRock's own monitoring software called Extreme Tuner) alters the GPIO setting for the fan mux, then the sensor chip will reflect the fan RPM for the CPU fan2 header. I'm afraid we don't have a solution for such issues :( ASRock should simply stop using that weird GPIO fan muxing on their boards."

The board in question was Asrock X79 Extreme4.

Some additional info is at
http://forums.aida64.com/index.php?/topic/594-asrock-z68-extreme7-gen3-cpu-fan-monitor-on-off-problem/.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
