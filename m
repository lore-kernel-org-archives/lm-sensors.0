From: jon@jonrkc.com (Jon Rutherford)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <41A52FDD.3030505@jonrkc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I installed lm_sensors 2.8.8 following instructions below, 
ran sensors-detect
and copied the lm_sensors.init file to 
/etc/rc.d/init.d/lm_sensors following that,
and the result of sensors -s, sensors, (wait >5 sec.), 
sensors is still:

[root@bodhisattva prog]# sensors
via686a-isa-6000
Adapter: ISA adapter
CPU core:  +1.69 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
+2.5V:     +2.51 V  (min =  +3.10 V, max =  +3.00 V)   ALARM
I/O:       +3.31 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
+5V:       +5.13 V  (min =  +6.44 V, max =  +6.02 V)   ALARM
+12V:     +12.06 V  (min = +15.60 V, max = +15.60 V)   ALARM
CPU Fan:  3000 RPM  (min =    0 RPM, div = 2)
P/S Fan:     0 RPM  (min =    0 RPM, div = 2)
SYS Temp:  +29.5?C  (high =   +45?C, hyst =   +40?C)
CPU Temp:  +27.2?C  (high =   +60?C, hyst =   +55?C)
SBr Temp:  +22.4?C  (high =   +65?C, hyst =   +60?C)


Jean Delvare wrote:
>>I finally figured out how to get the output of strace
>>sensors.  It is attached
>>as a text file to this email.
>>
>>Thanks for your help so far!
>>
>>Jon Rutherford
> 
> 
> The strace looks fine, the configuration file is found, and read as
> usual. I don't get it.
> 
> Could you please:
> 
> 1* Send the whole configuration file to me, unmodified, for me to try on
> my system.
> 
> 2* Try installing lm_sensors 2.8.7 or newer from our sources. Download,
> unpack, make user, make user_install and you're done. Be sure you
> actually remove Mandrake's package before you do. And see if it changes
> anything.
> 
> 3* Provide the source RPM for the Mandrake lm_sensors package, or
> preverably a pointer to that source RPM. I suspect that the Mandrake
> folks included some home made patch that would prevent me from
> understanding what's going on.
> 
> Thanks,
