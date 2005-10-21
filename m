From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 21 Oct 2005 23:41:00 +0000
Subject: [lm-sensors] lm-sensors in a rollout on FC4 - Attempts fail
Message-Id: <43594CFF.8000108@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4356F706.20904@cosc.canterbury.ac.nz>
In-Reply-To: <4356F706.20904@cosc.canterbury.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> sure about the ISA/smbus question... My machines don't have an ISA bus
> unless it means some emulation just before the sensors, so saying yes to
> that
> I thought was wrong.

ISA bus connector is not there, but ISA exists in ISA LPC incarnation (low pin count)
It is used as protocol to communicate with hardware rather than to connect new devices to system.

> The other machines have
> Fedora Core 3....This particular output is from FC3 64bit
> cosc502:~$ sensors --version
> sensors version 2.8.7 with libsensors version 2.8.7
> cosc502:~$ uname -a
> Linux cosc502 2.6.9-1.667 #1 Tue Nov 2 14:50:10 EST 2004 x86_64 x86_64
> x86_64 GNU/Linux
> cosc502:~$ sensors
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.59 V  (min =  +1.93 V, max =  +1.93 V)            
> +12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)            
> +3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)            
> +5V:       +5.09 V  (min =  +4.75 V, max =  +5.25 V)            
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)            
this could be disabled in sensors.conf

> V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)            
> VBat:      +0.66 V  (min =  +2.40 V, max =  +3.60 V)            
and this too
> fan1:        0 RPM  (min = 135000 RPM, div = 2)                    CPU

this has maybe bad fan divisor try to set to 4 or 8

> Fan:  3169 RPM  (min =   -1 RPM, div = 2)
  fan3: 1985 RPM  (min = 84375 RPM, div = 4)

> M/B Temp:   +26?C  (high =    +1?C, hyst =    +0?C)   sensor = thermistor         
> CPU Temp:  +40.0?C  (high =   +80?C, hyst =   +75?C)   sensor > thermistor          temp3:     +21.0?C  (high =   +80?C, hyst =  
> +75?C)   sensor = thermistor          

ERROR: Can't get VID data!
Maybe the userspace utils X kernel module mismatch. Safe to ignore it put in conf file
ignore vid
(see config file for details)

If you have any troubles with sensors.conf let us know. (I think it well documented
just read it ;)

Regards
Rudolf
