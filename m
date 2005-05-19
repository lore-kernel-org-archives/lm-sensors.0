From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: problem with lm_sensors
Message-Id: <3E95D265.5080106@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E9496EA.3020302@t-online.de>
In-Reply-To: <3E9496EA.3020302@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Well it looks like everything is working except for 'sensors -s'.  Does 
simply 'sensors' give output?  'sensors -s' tries to look in 
/etc/sensors.conf for the limits you've specified and then sets those 
limits on your chip.  If the config file isn't setup for that, it could 
give the output you are getting.  You could try running sensors with a 
debugging tool, like strace to see what errors it is getting.  If memory 
serves me right, there was a period of time when the kernel had a broken 
sysctl implementation.  I wonder if you are using such a kernel 
(probably not)?


Phil

Stephan Zerhau wrote:

> Philip,
> thank You very much for your very quick reply. I?ve got  in my 
> /proc/sys/dev/sensors/:
> server:/proc/sys/dev/sensors # ll
> total 0
> dr-xr-xr-x    3 root     root            0 Apr 10 14:54 .
> dr-xr-xr-x    6 root     root            0 Apr 10 14:54 ..
> dr-xr-xr-x    2 root     root            0 Apr 10 14:58 as99127f-i2c-0-2d
> -rw-r--r--    1 root     root            0 Apr 10 14:58 chips
>
> and in the as99127f-i2c-0-2d directory:
> server:/proc/sys/dev/sensors/as99127f-i2c-0-2d # ll
> total 0
> dr-xr-xr-x    2 root     root            0 Apr 10 14:58 .
> dr-xr-xr-x    3 root     root            0 Apr 10 14:54 ..
> -r--r--r--    1 root     root            0 Apr 10 14:58 alarms
> -rw-r--r--    1 root     root            0 Apr 10 14:58 beep
> -rw-r--r--    1 root     root            0 Apr 10 14:58 fan1
> -rw-r--r--    1 root     root            0 Apr 10 14:58 fan2
> -rw-r--r--    1 root     root            0 Apr 10 14:58 fan3
> -rw-r--r--    1 root     root            0 Apr 10 14:58 fan_div
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in0
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in1
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in2
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in3
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in4
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in5
> -rw-r--r--    1 root     root            0 Apr 10 14:58 in6
> -rw-r--r--    1 root     root            0 Apr 10 14:58 pwm1
> -rw-r--r--    1 root     root            0 Apr 10 14:58 pwm2
> -rw-r--r--    1 root     root            0 Apr 10 14:58 temp1
> -rw-r--r--    1 root     root            0 Apr 10 14:58 temp2
> -rw-r--r--    1 root     root            0 Apr 10 14:58 temp3
> -r--r--r--    1 root     root            0 Apr 10 14:58 vid
> -rw-r--r--    1 root     root            0 Apr 10 14:58 vrm
>
> the files are with some info, e.g.
> server:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat alarms
> 3779
> server:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat temp1
> 60.0 127.0 30.0
> server:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat temp2
> 60.0 50.0 24.0
>
> I`ve copied the sensors.conf.eg as /etc/sensors.conf but got the same 
> result as before:
> server:/ # sensors -s
> No sensors found!
> thanks again for your help, I greatly appreciate your voluntary work!!!
> regards
> Stephan
>
> Philip Edelbrock schrieb:
>
>>
>> Does you kernel have sysctl support turn on?  I.e., do you see 
>> anything in /proc/sys/dev/sensors?  Also make sure you don't have any 
>> old libsensors floating around from a previous install.  A good 
>> sample /etc/sensors.conf file can be found in 
>> lm-sensors-2.7.0/etc/sensors.conf.eg.  You likely don't need to 
>> modify it after copying it to /etc/sensors.conf.
>>
>>
>> Phil
>>
>>
>> Stephan Zerhau wrote:
>>
>>> hi,
>>> I have a problem with lm_sensors. Maybe it is easy for you to solve 
>>> it, but be assured that I?ve tried anything I know before contacting 
>>> you guys.
>>> After successfully compiling and installing i2c and lm_sensors with 
>>> no error messages at all (even all modules seem to be loaded 
>>> correctly), I get this message whenever I make "sensors -s":    No 
>>> sensors found!
>>
>>
>>
>>
>>
>
>
