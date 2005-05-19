From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: [lm_sensors] hard lockup on modprobe w83781d with Tyan Dual K7/Thunder
Message-Id: <20011114141737.B5776@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011114180440.A8934A99@shrek.lisa.de>
In-Reply-To: <20011114180440.A8934A99@shrek.lisa.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



The alarms are set by default to the best guess of the nominal values. 
For example, your VCore min and maxes are set according to the Vid
reported.  If the Vid is correct, then your VCore1 has a low voltage,
which has set off the alarm.  Sometimes alarms can trigger even though
the voltages appear to be OK.  This happens when a quick (perhaps
noisy) voltage variation happens.  The alarm is 'sticky' until you
check the status, in which the alarm condition might have since gone
away.


Phil

On Wed, Nov 14, 2001 at 10:52:13PM +0100, Hans-Peter Jansen wrote:
> On Wednesday, 14. November 2001 19:04, Hans-Peter Jansen wrote:
> > Hello,
> >
> > I'm trying to get serveral lm_sensor versions up to CVS lm_sensors2 from
> > yesterday to run on this mb. Now, I'm at linux-2.4.15-pre4, but also tried
> > some 2.4.12(-ac?) versions, to no avail.
> 
> I finally managed to get the w83781d loading under 2.4.13-ac7. (b/c it's butt 
> kicking processor power)
> 
> But it's readings are bogus <BIOS>:
> tyrex:~# sensors
> w83782d-i2c-0-2d
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM    <1.75>
> VCore 2:   +2.83 V  (min =  +1.74 V, max =  +1.93 V)                <1.76>
> +3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)              
> +5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)                <5.11>
> +12V:      +4.67 V  (min = +10.79 V, max = +13.19 V)                <12.35>
> -12V:      -2.01 V  (min = -10.90 V, max = -13.21 V)                <-12.15>
> -5V:       +2.71 V  (min =  -4.76 V, max =  -5.26 V)              
> V5SB:      +4.32 V  (min =  +4.72 V, max =  +5.24 V)              
> VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)              
> fan1:     7180 RPM  (min = 3000 RPM, div = 2)                       <3590>
> fan2:     7105 RPM  (min = 3000 RPM, div = 2)                       <3515>
> fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
> temp1:    +77.0?C   (limit = +60?C, hysteresis = +50?C) sensor = thermistor 
> <46?C>          
> temp2:    +76.5?C   (limit = +60?C, hysteresis = +50?C) sensor = thermistor   
> <41?C>        
> temp3:    +77.0?C   (limit = +60?C, hysteresis = +50?C) sensor = thermistor   
> <46?C>        
> vid:      +1.85 V
> alarms:   Chassis intrusion detection                      ALARM  
> beep_enable:
>           Sound alarm disabled
> 
> ALARM flags seems to appear randomly and unrelated to error conditions.
> Do I need completely new formula's for that beast?
> Any further suggestions?
> 
> Cheers,
> Hans-Peter

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
