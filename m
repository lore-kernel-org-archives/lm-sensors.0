From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: it87 and lm85 tickets
Message-Id: <42792FB2.4070807@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374305.6030000@mds.gotdns.com>
In-Reply-To: <42374305.6030000@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

reminder we need a patch for this from Philip - or are  you waiting for verification from Reuben
that the chip is on the board?
ticket 1933
mds

Philip Pokorny wrote:
> Reuben Farrelly wrote:
> 
>> Hi Philip,
>>
>> Philip Pokorny wrote:
>>
>>> Jean Delvare wrote:
>>>
>>>>> lm85 new stepping 0x69: ticket 1933 (khali)
>>>>>   
>>>>
>>>>
>>>>
>>>>
>>>> I AM NOT THE LM85 GUY!
>>>>
>>>> The driver was written and is maintained by Philip Pokorny and Justin
>>>> Thiessen at Penguin Computing.
>>>>
>>>> #1933: [waiting for user data]
>>>>  
>>>>
>>>
>>> So, I guess I *am* the LM85 guy.
>>>
>>> Yes, please send or reply with 'i2c-dump 0 0x2e' when lm85 is *not* 
>>> loaded.
>>
>>
>>
>> Here you go..
>>
>> [root@typhoon ~]# i2cdump 0 0x2e
>> No size specified (using byte-data access)
>> WARNING! This program can confuse your I2C bus, cause data loss and 
>> worse!
>> I will probe file /dev/i2c-0, address 0x2e, mode byte
>> Continue? [Y/n]
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 30: 4d 4d 4d 00 00 00 00 00 00 00 00 00 00 00 01 69    MMM...........?i
> 
> 
> 
> So this says that it's a National Semiconductor part (0x3e is 0x01) and 
> that's it's *not* an LM85 (0x3f is 0x69) but according to the lm96000 
> datasheet it is a superset of the lm85 functionality.  Unfortunately, 
> the only value listed for 0x3f in the lm96000 datasheet is 0x68.
> 
> So, most likely this is a later version of the lm96000.
> 
>>
>> Probing for `National Semiconductor LM85 or LM96000'... Success!
>>     (confidence 7, driver `lm85')
> 
> 
> 
> That's helpful.  Thanks Khali...
> 
>>
>> The chip is pretty hard to locate on the board but if it's really 
>> necessary I can try again :(
> 
> 
> 
> You might check again.  But instead of looking for a chip with "LM85", 
> look for a 24-pin surface mount package with "LM96???" on it.  It will 
> be smaller than the keys on your keyboard, but larger than the tip of a 
> pen or pencil.
> 
> I'll review the LM96000 datasheet and see if there is any additional 
> functionality we might want to add to the lm85 driver.
> 
> :v)
> 

