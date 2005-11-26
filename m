From: reuben-lmsensors@reub.net (Reuben Farrelly)
Date: Sat, 26 Nov 2005 14:29:03 +0000
Subject: [lm-sensors] Re: it87 and lm85 tickets
Message-Id: <43886314.8090806@reub.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374305.6030000@mds.gotdns.com>
In-Reply-To: <42374305.6030000@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

[this is a resend, previously resent to the old mailing list address a few days 
ago which now bounces]

Not sure where we got with this bug (started off at 
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket33) but thought I'd 
follow up, as I may have been the one holding things up in the past.

Note that this is with my second (slightly older) Intel board, completely 
separate issue to the ADT7476ARQZ chip detection which I posted about earlier today.

On 29/03/2005 4:15 a.m., Philip Pokorny wrote:
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
> That's helpful.  Thanks Khali...
> 
>>
>> The chip is pretty hard to locate on the board but if it's really 
>> necessary I can try again :(
> 
> 
> You might check again.  But instead of looking for a chip with "LM85", 
> look for a 24-pin surface mount package with "LM96???" on it.  It will 
> be smaller than the keys on your keyboard, but larger than the tip of a 
> pen or pencil.

I've put a picture of the chip up online at http://www.reub.net/files/kernel/
and can confirm that it is an LM96000 chip.

This is still an issue in current kernels (2.6.15-rc2-mm1 at least), as I'm 
still seeing the warning message when booting up:

i2c_adapter i2c-0: Unrecognized version/stepping 0x69 Defaulting to LM85.

Is there anything else I can do to get the ball rolling on this again?

Most if not all of the functionality is there with the LM85 so it's not a 
showstopper.

Thanks,
Reuben




