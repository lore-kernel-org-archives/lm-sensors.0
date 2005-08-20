From: bmeier@infovia.com.ar (Beat Meier)
Date: Sat, 20 Aug 2005 02:45:24 +0000
Subject: [lm-sensors] lm77 driver locks up with kernel-2.6.12
Message-Id: <43067CE9.90308@infovia.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <43027C3E.6020309@infovia.com.ar>
In-Reply-To: <43027C3E.6020309@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>>What's wrong? Anyone having this problem?
>>
>>    
>>
>
>Hello,
>
>Lets see if it is chip driver problem or bus driver problem or hw problem. (or any combination)
>Please can you just modprobe the scx200_acb driver and also i2c-dev.
>
>When done with this please several times try:
>i2cdump -y 0 0x48 w
>
>0 is the bus number, add there yours. i2cdetect -l will tell you how many busses you have.
>  
>
Hello Rudolf

By the dump the only which changes are the first 2 columns if there are 
no problems

     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: 7802 f800 2000 0005 a000 0004 0004 0004
same until
f8: 7802 f800 2000 0005 a000 0004 0004 0004

Diff of last colum of several dumps

< f8: b002 b000 2000 0005 a000 0004 0004 0004
 > f8: a802 a800 2000 0005 a000 0004 0004 0004

< f8: a802 a800 2000 0005 a000 0004 0004 0004
 > f8: 7802 f800 2000 0005 a000 0004 0004 0004

< f8: 7802 f800 2000 0005 a000 0004 0004 0004
 > f8: 6002 e000 2000 0005 a000 0004 0004 0004

If there is the problem with the bad temp. the dump is as follows:

     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
same until
f8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX

and syslog messages:

Aug 19 21:34:43 localhost kernel: i2c_adapter i2c-0: timeout in state 
address
Aug 19 21:35:35 localhost last message repeated 6 times
Aug 19 21:36:36 localhost last message repeated 41 times
Aug 19 21:37:37 localhost last message repeated 60 times
Aug 19 21:38:38 localhost last message repeated 60 times
Aug 19 21:39:39 localhost last message repeated 59 times

i2cdetect -l 
returns nothing but lm77 is without userspace support


>0x48 is chip addr also supply yours. You can use:
> i2cdetect 0
>to detect all devices on the bus. (better to restart/poweroff the system after that to be sure we do not interfere with yet another issues)
>
>  
>
In good state: needs 4 seconds to complete

woc1:/var/log/wpa_supplicant# time  i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

real    0m4.057s
user    0m0.004s
sys     0m0.018s



in bad state: more than 2 minutes
woc1:/var/log/wpa_supplicant# time  i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

real    2m16.644s
user    0m0.003s
sys     0m0.545s

and in syslog the following messages comes:
Aug 19 21:31:05 localhost kernel: i2c_adapter i2c-0: timeout in state quick
Aug 19 21:31:36 localhost last message repeated 26 times
Aug 19 21:32:37 localhost last message repeated 45 times
Aug 19 21:33:38 localhost last message repeated 39 times


>Also please check syslog if you can see something there. You can also try to switch all debug flags in menuconfig (i2c section)
>
>  
>
When the problem begins i.e. the following appers (current: 37 ok)
Fri Aug 19 21:23:19 ART 2005 current:37 low:10 lowHyst:12 high:64 
highHist:62 critical:80 criticalHyst:78
Fri Aug 19 21:23:24 ART 2005 current:37 low:10 lowHyst:12 high:64 
highHist:62 critical:80 criticalHyst:78
Fri Aug 19 21:23:30 ART 2005 current:37 low:10 lowHyst:12 high:64 
highHist:62 critical:80 criticalHyst:78
Fri Aug 19 21:23:35 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0
Fri Aug 19 21:23:51 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0
Fri Aug 19 21:24:05 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0
Fri Aug 19 21:24:20 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0
Fri Aug 19 21:24:32 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0
Fri Aug 19 21:24:48 ART 2005 current:4095 low:4095 lowHyst:8191 
high:4095 highHist:0 critical:4095 criticalHyst:0

the syslog messages are:

Jan  1 00:09:55 localhost kernel: i2c_adapter i2c-0: timeout in state 
address
Jan  1 00:11:29 localhost kernel: i2c_adapter i2c-0: timeout in state 
command
Jan  1 00:11:51 localhost kernel: i2c_adapter i2c-0: timeout in state 
repeat_start
Jan  1 00:12:31 localhost kernel: i2c_adapter i2c-0: timeout in state 
command
Aug 19 20:07:39 localhost kernel: i2c_adapter i2c-0: timeout in state 
address
Aug 19 20:09:11 localhost kernel: i2c_adapter i2c-0: timeout in state read
Aug 19 20:09:12 localhost kernel: i2c_adapter i2c-0: timeout in state 
address
Aug 19 20:09:46 localhost last message repeated 16 times
Aug 19 20:10:47 localhost last message repeated 32 times

>  
>

>Thanks
>
>regards
>Rudolf
>
>  
>
Thanks to you!!!

Beat
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050820/abf15043/attachment-0001.html
