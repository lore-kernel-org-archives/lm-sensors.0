From: "d. d. gmane" <gmanesensors@dubin.org>
Date: Thu, 01 Nov 2007 03:50:13 +0000
Subject: Re: [lm-sensors] Intel DP35DP - P35 Sensor Support?
Message-Id: <47294CF5.5060604@dubin.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071015T022008-788@post.gmane.org>
In-Reply-To: <loom.20071015T022008-788@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,  Hmm.. Strange results indeed.  It's odd that via BIOS HW 
monitoring, that the values are available.  Has intel (un)intentionally 
used a chip that's hard to access? 

When looking for open ioports, 0x0a00 was open, so I used it for all of 
the rest of the testing.  Sadly, I think it's going to be difficult just 
as you predicted.  Thank you for your time in looking at the prior 
messages.  You're doing great work with lm sensors!



[root@skippy ]# isaset 0x2e 0x2f 0x07 0x08
WARNING! Running this program can cause system crashes, data loss and worse!
I will write value 0x08 to address 0x07 of chip with address register 0x2e
and data register 0x2f.
Continue? [Y/n] Y

[root@skippy ]# isaset 0x2e 0x2f 0x60 0x0a
WARNING! Running this program can cause system crashes, data loss and worse!
I will write value 0x0a to address 0x60 of chip with address register 0x2e
and data register 0x2f.
Continue? [Y/n] y

[root@skippy ]# isaset 0x2e 0x2f 0x61 0x00
WARNING! Running this program can cause system crashes, data loss and worse!
I will write value 0x00 to address 0x61 of chip with address register 0x2e
and data register 0x2f.
Continue? [Y/n] Y

[root@skippy ]# isaset 0x2e 0x2f 0x30 0x01
WARNING! Running this program can cause system crashes, data loss and worse!
I will write value 0x01 to address 0x30 of chip with address register 0x2e
and data register 0x2f.
Continue? [Y/n] Y

[root@skippy ]# isadump 0x2e 0x2f 0x08
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 8 using bank register 0x07.
Continue? [Y/n] Y    
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
20: f1 91 00 00 c1 01 00 91 00 91 00 00 00 00 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

[root@skippy ]# isadump -f 0x0a00
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0xa00 to 0xaff.
Continue? [Y/n] Y
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0a90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0aa0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0ab0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0ac0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0ad0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0ae0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0af0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@skippy ]#




Jean Delvare wrote:
> On Tue, 30 Oct 2007 15:26:55 -0700, d. d. gmane wrote:
>   
>> Here are the results of:  isadump 0x2e 0x2f 0x08
>>
>> [root@skippy dump]# pwd
>> /home//lm_sensors-3.0.0-rc3/prog/dump
>>
>> [root@skippy dump]# ./isadump 0x2e 0x2f 0x08
>> WARNING! Running this program can cause system crashes, data loss and worse!
>> I will probe address register 0x2e and data register 0x2f.
>> Probing bank 8 using bank register 0x07.
>> Continue? [Y/n] Y
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
>> 20: f1 91 00 00 c1 01 00 91 00 91 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>     
>
> OK, access to the hardware monitoring device is disabled. If you want
> to investigate a bit further, you can attempt to enable it:
>
> * Search in /proc/ioports for a free space of at least 256 bytes,
> aligned on a 256-byte boundary (e.g. 0x0a00 to 0x0aff).
>
> * Write the address in question to the PC8374L chip and
>   enable the logical device:
>
> isaset 0x2e 0x2f 0x07 0x08
> isaset 0x2e 0x2f 0x60 0x0a # <-- high byte of the address
> isaset 0x2e 0x2f 0x61 0x00 # <-- low byte of the address
> isaset 0x2e 0x2f 0x30 0x01
>
> * Run isadump again and check that the writes were successful:
>
> isadump 0x2e 0x2f 0x08
>
> * If registers 0x30, 0x60 and 0x61 have the expected values, try
>   dumping the logical device's I/O area:
>
> isadump -f 0x0a00 # <-- adjust with the address you used
>
> Only do that if you are really motivated in getting the voltage
> readings. I don't know the PC8374L very well and it seems to be a
> somewhat complex chip - or at least different from what I'm used to.
> Even if the sequence above reveals something interesting, there's
> probably a long way to go before you can get the voltage readings, and
> I am almost certain that you won't get temperatures nor fan speeds from
> that device anyway.
>
>   

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
