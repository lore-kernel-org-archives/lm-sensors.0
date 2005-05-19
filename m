From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <20041124203015.17849a9e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> root@bodhisattva jon]# sensors
> via686a-isa-6000
> Adapter: ISA adapter
> 2.0V:      +1.69 V  (min =  +0.33 V, max =  +1.51 V)   ALARM
> 2.5V:      +2.51 V  (min =  +2.33 V, max =  +3.00 V)
> 3.3V:      +3.31 V  (min =  +4.01 V, max =  +2.56 V)   ALARM
> 5.0V:      +5.13 V  (min =  +2.85 V, max =  +1.76 V)   ALARM
> 12V:      +12.06 V  (min = +15.36 V, max = +11.59 V)   ALARM
> fan1:     3000 RPM  (min = 2667 RPM, div = 2)
> fan2:        0 RPM  (min = 3260 RPM, div = 2)
> temp1:     +28.6?C  (high =   +47?C, hyst =   +21?C)
> temp2:     +26.6?C  (high =   +41?C, hyst =  +101?C)
> temp3:     +22.6?C  (high =   +48?C, hyst =   +70?C)
> ---------------------------------------------------------------------
> ---------------------- I got the above sensors data after running
> sensors -s and then running
> sensors twice separated by at least five seconds, as 
> recommended in the
> service response to another ticket with a similar problem 
> reported.
> 
> 
> And here is the via686 section of /etc/sensors.conf.
> (...)
>      label "2.0V" "CPU core"
>      label "2.5V" "+2.5V"
> (...)

Huh, this is even worse that I thought. Even the labels are ignored!
Like sensors doesn't even read the configuration file, or doesn't take
it into account.

Please provide the full output of "strace sensors".

Also, please provide the output of the following commands:
sensors -v
which sensors
ldd $(which sensors)
ls -l /usr/lib/libsensor*
ls -l /usr/local/libsensor*

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
