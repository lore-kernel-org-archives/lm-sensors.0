From: Lou Gosselin <tech2009@evergrove.com>
Date: Sat, 30 Jan 2010 20:27:21 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <4B649629.7080008@evergrove.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020300010406050800080501"
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300010406050800080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The email didn't specify the range to dump, but thanks for the advice.
I'm attaching the output for 0x2e.
Let me know if you'd like anything else.


Jean Delvare wrote:
> Hi Lou,
>
> On Fri, 29 Jan 2010 19:17:06 -0500, Lou Gosselin wrote:
>   
>> I've attached two files.
>> sensors.txt shows the output that I get with sensors-detect and sensors.
>>
>> i2cbus.txt shows output for i2cdetect and i2cdump.
>> Let me point out that after running "i2cdump 0 0x6a", lmsensors was no 
>> longer responsive. Furthermore the machine failed to reboot until I did 
>> a cold boot.
>>     
>
> Let me point out that dumping random i2c chips is a very bad idea.
> Especially chips in the 0x86-0x6a range, are often clock chips which
> don't like being dumped at all...
>
>   
>> (...)
>> I'll give any suggestions a shot, or if you're willing, I can setup one 
>> of these machines for you to connect to.
>>     
>
> The chip I would like to see a dump of is the one at 0x2e. This will
> give us the chip ID of your SMSC chip. It's probably only a matter of
> adding the right ID to the driver.
>
>   


--------------020300010406050800080501
Content-Type: text/plain;
 name="lmsensor.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lmsensor.txt"

intel-ss4200:~# i2cdump 0 0x2e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 02 48 00 0f    ............?H.?
20: c0 57 c0 c3 bf fd 15 1a ff ff 40 11 b4 10 ff ff    ?W??????..@???..
30: 6b 6b 6b 30 0b 00 0f 00 40 00 48 f7 0f 00 5c 69    kkk0?.?.@.H??.\i
40: 05 00 00 18 00 ff 00 ff 00 ff 00 ff 00 ff 81 44    ?..?..........?D
50: 81 7f 81 4b ff ff ff ff ff ff ff ff 02 c2 c2 7b    ???K........???{
60: 7b 7b e8 88 6b 6b 6b 33 32 64 40 41 73 22 20 00    {{??kkk32d@As" .
70: 6b 6b 6b 00 00 00 00 00 00 00 30 00 00 00 ec 1c    kkk.......0...??
80: 7e a4 0f 00 00 6c 4c 2e cc 00 33 33 24 24 19 19    ~??..lL.?.33$$??
90: 04 04 04 04 0c 0c 0c 5a f1 c0 b5 00 ff 00 ff 00    ???????Z???.....
a0: 00 00 0c 00 00 ff ff 07 0b fe ff fe ff ff ff ff    ..?....???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 0f 0f 00 00 00 00    ......((????....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

--------------020300010406050800080501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020300010406050800080501--
