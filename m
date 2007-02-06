From: alanc@pipstechnology.co.uk (Alan Clucas)
Date: Tue, 06 Feb 2007 10:19:21 +0000
Subject: [lm-sensors] DS75
Message-Id: <45C85629.3070002@pipstechnology.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Alan, 
> 
> On Mon, 05 Feb 2007 13:12:46 +0000, Alan Clucas wrote:
>>> Yes, I'd appreciate a debug log and/or output of i2cdump for a Dallas
>>> DS75 chip.
>> Hi Jean, this is the output I get for the device:
>>
>> localhost ~ # i2cdump -y 0 0x48
>> No size specified (using byte-data access)
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 50 30 4b 50 50 50 50 50 50 50 50 50 50 50 50 50    P0KPPPPPPPPPPPPP
>> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 20: XX XX 4b XX XX XX XX XX XX XX XX XX XX XX XX XX    XXKXXXXXXXXXXXXX
>> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 40: 50 00 4b 50 50 50 50 50 50 50 50 50 50 50 50 50    P.KPPPPPPPPPPPPP
>> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 50 XX    XXXXXXXXXXXXXXPX
>> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>>
>> localhost ~ # i2cdump -y 0 0x48 w
>>       0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
>> 00: 8050 0030 004b 0050 0050 0050 0050 0050
>> 08: 0050 0050 0050 0050 0050 0050 0050 0050
>> 10: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 18: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 20: XXXX XXXX 004b XXXX XXXX XXXX XXXX XXXX
>> 28: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 30: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 38: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 40: 8050 0000 004b 0050 0050 0050 0050 0050
>> 48: 0050 0050 0050 0050 0050 0050 0050 0050
>> 50: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 60: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 70: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 80: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 88: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 90: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> 98: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> a0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> a8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> b0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> b8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> c0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> c8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> d0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> d8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> e0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> e8: XXXX XXXX XXXX XXXX XXXX XXXX 0050 XXXX
>> f0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
>> f8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
> 
> Wow. I have to admit it's not exactly what I expected. The fact that
> some (seemingly random) unused addresses work while others return an
> error instead is rather puzzling. At least this gives us several ways
> to detect the DS75.

I did run it several times and reboot just to check - those "random" 
addresses are fixed and always the same.

>>> Can you use perl on your system? I'd like to add detection for the DS75
>>> to sensors-detect first, and when it's ready, port the code to the lm75
>>> driver.
>> Yes, I have perl. sensors-detect currently does not detect it as an 
>> lm75, agreeing with the unpatched kernel.
>>
>> We only have a couple of fully functional boards, and I may break stuff 
>> or need to run other long term tests, so turnaround on testing may be 
>> intermittent.
> 
> OK. Attached is a patch against sensors-detect from our SVN repository.
> Please give it a try, it should detect your DS75. Compared to the LM75
> detection, I removed the cycle-over-8 test as your kernel patch did,
> and additionally I'm checking that registers 0x08 to 0x0f behave the
> same as 0x04 to 0x07 (which isn't true of the LM75.) If it works OK for
> you, we can use the same approach in the lm75 kernel driver. Please
> report.

We could also check for the 0x00-0x0f mirror at 0x40-0x4f if we want to 
be more sure.

Your sensors detect patch works fine:

Next adapter: CS5535 ACB0 (i2c-0)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x48
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  Success!
     (confidence 6, driver `lm75')
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621'...                No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

I'm happy to do the kernel patch for this. Do we want it to continue to 
return kind=lm75 as well as name="lm75"; I'm not sure of all the 
implications of kind.

Thanks,
Alan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: alanc.vcf
Type: text/x-vcard
Size: 562 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070206/2ea06550/attachment.vcf 
