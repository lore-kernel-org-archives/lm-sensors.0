From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 08 Nov 2005 15:48:58 +0000
Subject: [lm-sensors] Problem with WINBOND_W83792D
Message-Id: <4370BAC9.8030009@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE81C2566829DC43849F0373D0CBCAA2140234@SRV-EXCHBE02.thecamelsnose.com>
In-Reply-To: <BE81C2566829DC43849F0373D0CBCAA2140234@SRV-EXCHBE02.thecamelsnose.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remy de Ruysscher wrote:

> I?ve contacted the manufacturer of the of server (Supermicro), according to them 
> they use the WINBOND_W83792D chip. Sensors-detect correctly identifies the
> chipset but still gives strange readings -78 degrees Celcius for every CPU sensor.
> 
> See also: http://secure.netroedge.com/~lm78/readticket.cgi?ticket 84

> Following up instructions:
>  
> See: http://secure.netroedge.com/~lm78/readticket.cgi?ticket 93
>  
>  
> [root@Hahn /]# sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
> VCore 2:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +4.08 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +5.07 V  (min =  +4.74 V, max =  +5.24 V)
> +12V:     +11.55 V  (min = +10.83 V, max = +13.19 V)
> -12V:      +0.82 V  (min = -13.16 V, max = -10.90 V)
> -5V:       +1.90 V  (min =  -5.26 V, max =  -4.76 V)
> V5SB:      +5.56 V  (min =  +4.74 V, max =  +5.24 V)
> VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min = 2848 RPM, div = 2)
> fan2:        0 RPM  (min = 2848 RPM, div = 2)
> fan3:        0 RPM  (min =  712 RPM, div = 8)
> temp1:       -48??C  (high =  +124??C, hyst =  +125??C)   sensor = thermistor
> temp2:     -48.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
> temp3:     -48.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
> vid:      +0.000 V  (VRM Version 8.2)
> alarms:
> beep_enable:
>           Sound alarm disabled


Hmm but this is w83627hf and not the w83792d.
What you can try to do with w83627hf is to change the sensor type.

1) edit /etc/sensors.conf
2) find the  w83627hf-*  senction

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

Try to:
 set sensor1 1

3) save it and run sensors -s
4) run sensors again

If it does not help try different numbers like 2, 3435
You can try to change other inputs too.

If this fail please try following:

1) run sensors-detect version at least 2.9.2
2) it should find w83792d, if not post here output of: i2cdump 0
2) modprobe w83792d ; sensors
  CHeck if you have correct temp, if so OK, if not
  write us the output of sensors command, and add i2cdump 0 0xcorrectvallue

I hope this helps.

Regards
Rudolf
