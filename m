From: alanc@pipstechnology.co.uk (Alan Clucas)
Date: Wed, 07 Feb 2007 10:14:36 +0000
Subject: [lm-sensors] DS75
Message-Id: <45C9A68C.2020003@pipstechnology.co.uk>
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
> On Tue, 06 Feb 2007 10:19:21 +0000, Alan Clucas wrote:
>>> Wow. I have to admit it's not exactly what I expected. The fact that
>>> some (seemingly random) unused addresses work while others return an
>>> error instead is rather puzzling. At least this gives us several ways
>>> to detect the DS75.
>> I did run it several times and reboot just to check - those "random" 
>> addresses are fixed and always the same.
> 
> OK, thanks for checking this, I was wondering. I'm also curious to know
> whether other DS75 chips behave exactly the same or if it's
> chip-specific.

I've tested it on another chip from another batch with exactly the same 
random addresses (output varied as the temperature of the board was 
different, but otherwise looked the same). Once we have more running 
systems I'll do some more tests.

>> Your sensors detect patch works fine:
>>
>> Next adapter: CS5535 ACB0 (i2c-0)
>> Do you want to scan it? (YES/no/selectively): yes
>> Client found at address 0x48
>> Probing for `National Semiconductor LM75'...                No
>> Probing for `Dallas Semiconductor DS75'...                  Success!
>>      (confidence 6, driver `lm75')
>> Probing for `National Semiconductor LM77'...                No
>> Probing for `Dallas Semiconductor DS1621'...                No
>> Probing for `Maxim MAX6650/MAX6651'...                      No
>> Probing for `National Semiconductor LM92'...                No
>> Probing for `National Semiconductor LM76'...                No
>> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> 
> OK, great, thanks for testing. I'll apply the patch to SVN soon.
> 
>> I'm happy to do the kernel patch for this. Do we want it to continue to 
>> return kind=lm75 as well as name="lm75"; I'm not sure of all the 
>> implications of kind.
> 
> For now libsensors needs to know about all names, otherwise it doesn't
> recognizes the chip features. If we decide to have a separate prefix
> for the DS75, this means we must update libsensors as well (that's a
> trivial change but it must be done.) Both approaches make sense, so
> it's really up to you, whether you prefer a nice separate prefix or
> compatibility with older versions of libsensors. Note that if you ever
> want to take benefit of the additional resolution bits of the DS75,
> having a separate prefix will be useful.
> 
> I'm waiting for your patch, if you're quick enough it can make it into
> kernel 2.6.21.

Attached is the kernel patch and a patch for libsensors as well. The 
libsensors patch does not include your sensors-detect patch.

I have changed the detected name to ds75, hence the libsensors patch. I 
haven't managed to find any lm75 devices here, so I haven't tested this 
on one of those, which would be good before it goes too far. The patch 
is simple enough, but you never can tell.

Feedback appreciated.

Thanks,
Alan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-ds75-support.patch
Type: text/x-patch
Size: 1507 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070207/1e897e96/attachment.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kernel-ds75-support.patch
Type: text/x-patch
Size: 3374 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070207/1e897e96/attachment-0001.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: alanc.vcf
Type: text/x-vcard
Size: 562 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070207/1e897e96/attachment.vcf 
