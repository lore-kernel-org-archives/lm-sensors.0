From: raphael@clifford.net (Raphael Clifford)
Date: Sat, 11 Mar 2006 12:55:20 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware
Message-Id: <4412C8B8.5000507@clifford.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
>
>   
>> I get
>>
>> smsc47m1-isa-0800
>> Adapter: ISA adapter
>> fan1:     1861 RPM  (min =  640 RPM, div = 8)         
>> fan2:     1107 RPM  (min =  640 RPM, div = 8)         
>>
>> smsc47m192-i2c-0-2d
>> Adapter: SMBus PIIX4 adapter at 0400
>>
>> in0:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
>> in1:       +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
>> in2:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
>> in3:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
>> in5:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)  
>> in6:       +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
>> in7:       +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
>> temp1:     +35.0 C  (low  =  -128 C, high =  +127 C) 
>> temp2:     +55.0 C  (low  =  -128 C, high =   +60 C) 
>> temp3:    +116.0 C  (low  =  -128 C, high =  +127 C) 
>> vid:      +1.550 V  (VRM Version 2.4)
>>
>>
>> which is fantastic!
>>     
>
> I see that you don't have the new configuration file installed (labels
> should be different). So you may want to copy
> lm_sensors2/etc/sensors.conf.eg to /etc/sensors.conf before you go on
> hacking your configuration file.
>
>   
Updated on my system.
>> temp2 is my CPU temp I am 99% sure.  The low and high figures appear to
>> be meaningless and change depending on what the cpu is doing.  For example
>>
>> temp2:     +57.0 C  (low  =   +55 C, high =   +65 C)
>>
>> under light load.
>>     
>
> This is really strange. Please load the i2c-dev module, then try
> "i2cdump 0 0x2d b" from times to times and see if registers 0x37 and
> 0x38 change that way too. I guess they will.
>
> Maybe something (BIOS?) is accessing the chip too, but if so I'd expect
> other problems to show sooner or later. And I don't get the point
> of changing these limits on the fly anyway.
>
>   

Here are some data points.

 sensors
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:     1683 RPM  (min =  640 RPM, div = 8)         
fan2:     1107 RPM  (min =  640 RPM, div = 8)         

smsc47m192-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0400

+2.5V:     +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
VCore:     +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
+5V:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
VCC:       +3.32 V  (min =  +0.00 V, max =  +4.38 V)  
+1.5V:     +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
+1.8V:     +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
Chip Temp: +36.0 C  (low  =  -128 C, high =  +127 C) 
CPU Temp:  +63.0 C  (low  =   +55 C, high =   +65 C) 
Sys Temp: +116.0 C  (low  =  -128 C, high =  +127 C) 
vid:      +1.550 V  (VRM Version 2.4)

localhost ~ # i2cdump 0 0x2d b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2d, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 50 00    XXXXXXXXXXXXXXP.
20: 00 00 00 00 09 c1 40 23 XX XX XX ff 00 ff 00 ff    ....??@#XXX.....
30: 00 ff 00 ff 00 ff 00 41 37 7f 80 XX XX XX 55 20    .......A7??XXXU
40: 29 0f 0c XX XX XX XX 00 XX 80 00 02 00 00 XX 04    )??XXXX.X?.?..X?
50: 00 00 74 XX ff 00 ff 00 7f 80 XX XX XX XX XX XX    ..tX....??XXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX


and then after some CPU work


 i2cdump 0 0x2d b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2d, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 50 00    XXXXXXXXXXXXXXP.
20: 00 00 00 00 09 c1 43 23 XX XX XX ff 00 ff 00 ff    ....??C#XXX.....
30: 00 ff 00 ff 00 ff 00 7f 3c 7f 80 XX XX XX 55 20    .......?<??XXXU
40: 29 0f 0c XX XX XX XX 00 XX 80 00 02 00 00 XX 04    )??XXXX.X?.?..X?
50: 00 00 74 XX ff 00 ff 00 7f 80 XX XX XX XX XX XX    ..tX....??XXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
localhost ~ # sensors
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min =  640 RPM, div = 8)         
fan2:        0 RPM  (min =  640 RPM, div = 8)         

smsc47m192-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0400

+2.5V:     +0.00 V  (min =  +0.00 V, max =  +3.32 V)   ALARM
VCore:     +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.38 V)   ALARM
+5V:       +0.00 V  (min =  +0.00 V, max =  +6.64 V)   ALARM
VCC:       +3.32 V  (min =  +0.00 V, max =  +4.38 V)  
+1.5V:     +0.00 V  (min =  +0.00 V, max =  +1.99 V)   ALARM
+1.8V:     +0.00 V  (min =  +0.00 V, max =  +2.39 V)   ALARM
Chip Temp: +36.0 C  (low  =  -128 C, high =  +127 C) 
CPU Temp:  +67.0 C  (low  =   +60 C, high =  +127 C) 
Sys Temp: +116.0 C  (low  =  -128 C, high =  +127 C) 


Hope that helps somehow?

It looks to me that register 0x37 changes from 41 to 7f and 0x38 changes
from 37 to 3c.


> Hartmut, I guess you never observed anything like this on your own
> system?
>
> Raphael, do you have any option in your BIOS which could be related to
> that "feature"?
>
>   

Not that I know of. I will check of course.


Raphael

