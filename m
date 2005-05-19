From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ticket# 1650 - ERROR: Can__t get TEMP1 data!
Message-Id: <1082098480.407f8330bc483@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082040645.407ea145eedf3@imp.gcu.info>
In-Reply-To: <1082040645.407ea145eedf3@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PLEASE REPLY TO THE LIST, NOT TO ME ONLY]

> i've made sure all files are the current version, i do not have any
> old libraries, or any other old files from older versions.
> 
> the only interesting fact which i've just discovered, is that i can
> read temperatures if i do this:
> 
> [root@ekolaptis it87-isa-0290]# cat temp1
> 40.0 15.0 52.0
> [root@ekolaptis it87-isa-0290]# cat temp2
> 45.0 15.0 -28.0
> [root@ekolaptis it87-isa-0290]# cat temp3
> 45.0 15.0 127.0
> 
> i found a bunch of files under /proc/sys/dev/sensors/it87-isa-0290
> which i can read without any problem.
> 
> doing 'sensors' still results in this error:
> it87-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.72 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
> VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
> +3.3V:     +6.42 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
> +5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +12.08 V  (min = +11.36 V, max = +12.60 V)
> -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:      -13.64 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
> Stdby:     +4.97 V  (min =  +4.72 V, max =  +5.24 V)
> VBat:      +4.08 V
> fan1:        0 RPM  (min =    0 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> 
> i'm out of ideas :(

A still have a few ones, don't panic ;)

First of all, please provide the output of:
sensors -v
sensors -u

Second, do you see files named "sensor1", "sensor2" and "sensor3" in the
same place you saw "temp1", "temp2" and "temp3"?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
