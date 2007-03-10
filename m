From: corentin.labbe@geomatys.fr (corentin.labbe)
Date: Sat, 10 Mar 2007 21:51:38 +0000
Subject: [lm-sensors] sensor-detect patch for detecting SMSC SCH5504-NS
Message-Id: <45F3286A.8060804@geomatys.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5E8AB.9060809@geomatys.fr>
In-Reply-To: <45D5E8AB.9060809@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare a ?crit :
> Hi Corentin,
> 
> On Mon, 05 Mar 2007 22:25:58 +0100, corentin.labbe wrote:
>> patch patched:)
>>
>> --- sensors-detect-old  2007-03-04 21:16:18.000000000 +0100
>> +++ sensors-detect      2007-03-05 22:22:56.000000000 +0100
>> @@ -1812,6 +1812,12 @@
>>           logdev => 0x08,
>>         },
>>         {
>> +        name => "SMSC SCH5504-NS Super IO",
>> +        # No datasheet
>> +        driver => "not-a-sensor",
>> +        devid => 0x79,
>> +      },
>> +      {
>>           name => "SMSC LPC47M584-NC Super IO",
>>           # No datasheet
>>           devid => 0x76,
> 
> I'm sorry but your patch still doesn't apply. Check it by yourself. If
> this is your e-mail client corrupting the patch, try sending it as an
> attachement. Or maybe you built your patch based on a modified source
> file - try fetching lm-sensors SVN again and base your patch on that.
> 
> Thanks,

This is the patch updated.

LABBE C.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensordetect.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070310/d2132041/attachment-0001.pl 
