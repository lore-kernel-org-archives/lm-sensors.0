From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 25 Oct 2006 07:51:25 +0000
Subject: [lm-sensors] Determine where the thermal sensors are?
Message-Id: <20061025095125.670a17b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
In-Reply-To: <200610192118.k9JLINDa006525@et-mia-7.site.stayonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Fri, 20 Oct 2006 12:31:55 -0400, Paul Aviles wrote:
> Nice server....
> [root at srv1 /]# sensors
> adt7463-i2c-0-2e
> Adapter: SMBus I801 adapter at 1480
> ERROR: Can't get alarm mask data!
> +2.6V:     +2.617 V  (min =  +2.47 V, max =  +2.73 V)
> CPU Volt:  +1.365 V  (min =  +1.25 V, max =  +1.52 V)
> +3.3V:     +3.425 V  (min =  +3.13 V, max =  +3.47 V)
> +5V:      +5.072 V  (min =  +4.74 V, max =  +5.26 V)
> ERROR: Can't get IN4 data!
> Fan2:      5769 RPM  (min = 4800 RPM)
> Fan3:      4144 RPM  (min = 2200 RPM)
> Fan1:      5769 RPM  (min = 4800 RPM)
> CPU Temp: +47.75?C  (low  =    +5?C, high =   +68?C)
> Loc Temp: +38.00?C  (low  =    +5?C, high =   +40?C)
> Sys Temp: +40.75?C  (low  =    +5?C, high =   +50?C)
> ERROR: Can't get PWM1 data!
> ERROR: Can't get PWM2 data!
> ERROR: Can't get PWM3 data!
> 
> [root at srv1 /]# sensors -version
> sensors version 2.8.7 with libsensors version 2.8.7
> 
> Loud one..
> [root at andeya1 /]# sensors
> adt7463-i2c-0-2e
> Adapter: SMBus I801 adapter at 1480
> ERROR: Can't get alarm mask data!
> +2.6V:     +2.604 V  (min =  +2.47 V, max =  +2.73 V)
> CPU Volt:  +1.362 V  (min =  +1.25 V, max =  +1.52 V)
> +3.3V:     +3.403 V  (min =  +3.13 V, max =  +3.47 V)
> +5V:      +5.072 V  (min =  +4.74 V, max =  +5.26 V)
> ERROR: Can't get IN4 data!
> Fan2:     11157 RPM  (min = 4800 RPM)
> Fan3:     10671 RPM  (min = 2200 RPM)
> Fan1:     11180 RPM  (min = 4800 RPM)
> CPU Temp: +42.75?C  (low  =    +5?C, high =   +68?C)
> Loc Temp: +40.00?C  (low  =    +5?C, high =   +40?C)
> Sys Temp: +44.50?C  (low  =    +5?C, high =   +50?C)
> ERROR: Can't get PWM1 data!
> ERROR: Can't get PWM2 data!
> ERROR: Can't get PWM3 data!
> 
> [root at andeya1 /]# sensors -version
> sensors version 2.8.7 with libsensors version 2.8.7
> 
> I am sure the issue is not really related to sensors and more likely
> something weird in the hardware.

OK, the fan speeds reported clearly match what you hear, fans over 10k
RPM are likely to be very noisy. There aren't that many differences in
reported temperatures between the two systems, except that on the loud
server, the "Loc Temp" matches its high limit. No alarm though... I'm
not too familiar with this chip but depending on the PWM settings, it
could be that this comparison causes all fans to go to full speed. So I
suggest that you first set temp2_max a little higher, say 50 degrees C,
on the noisy server, and see if that makes it quieter.

If not, please report the PWM settings on both servers.

-- 
Jean Delvare

