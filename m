From: "Jose M. Caballero" <caballeroguerrero@hotmail.es>
Date: Fri, 10 Dec 2010 14:32:47 +0000
Subject: [lm-sensors] weird lectures
Message-Id: <BLU0-SMTP1575A83C98D31BBDBECD18ECE2F0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

El jue, 09-12-2010 a las 08:20 -0800, Guenter Roeck escribió:
> On Thu, Dec 09, 2010 at 11:09:34AM -0500, José M. Caballero wrote:
> [ ... ]
> > 
> > Thanks a lot. Finally it works.
> > But it is very worrying lectures:
> > 
> > 
> > w83667hg-isa-0290
> > Adapter: ISA adapter
> > in0:         +0.89 V  (min =  +0.00 V, max =  +1.74 V)   
> > in1:         +1.86 V  (min =  +0.73 V, max =  +1.97 V)   
> > in2:         +3.42 V  (min =  +0.45 V, max =  +3.82 V)   
> > in3:         +3.42 V  (min =  +1.18 V, max =  +0.27 V)   ALARM
> > in4:         +0.05 V  (min =  +0.50 V, max =  +0.11 V)   ALARM
> > in5:         +1.74 V  (min =  +1.39 V, max =  +0.91 V)   ALARM
> > in7:         +3.44 V  (min =  +0.90 V, max =  +3.07 V)   ALARM
> > in8:         +3.30 V  (min =  +1.31 V, max =  +1.76 V)   ALARM
> > fan1:          0 RPM  (min =  340 RPM, div = 128)  ALARM
> > fan2:       2008 RPM  (min =  448 RPM, div = 32)
> > fan3:          0 RPM  (min =  405 RPM, div = 128)  ALARM
> > temp1:       +30.0°C  (high = -10.0°C, hyst =  -5.0°C)  ALARM  sensor > > thermistor
> > temp2:       +32.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor > > thermistor
> > temp3:      +127.5°C  (high = +80.0°C, hyst = +75.0°C)  ALARM  sensor > > thermistor
> > cpu0_vid:   +2.500 V
> > 
> > I hope the sensor doesn't work properly...
> > 
> temp3 is probably not connected, as is fan1 and fan3. The temp1 high limit seems to be 
> unset. The voltage limits look odd, with max being lower than min in some cases.
> Since ALARM is set for those voltages, I suspect that the limits are not set correctly.
> You can test that by setting more reasonable limits for one of the voltages (and temp1)
> and verify if that resets the ALARM bit.
> 
> Guenter
> 

After installing (successfully) lm-sensors and the standalone patch for
Nuvoton w83627hg-b (w83627ehf driver), I have not a /etc/sensors.conf
file just a sensors3.conf file with next relevant data:
 
chip "w83627ehf-*" "w83627dhg-*"
 
    label in0 "Vcore"
    label in2 "AVCC"
    label in3 "VCC"
    label in7 "3VSB"
    label in8 "Vbat"
 
    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10
    
(The same data as the sensors.conf.default from the
lm_sensors-3.2.0.tar.bz2)
 
Could be due to that some of my amazing readings of 'sensors'? How to
fix it?

Jose.
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
