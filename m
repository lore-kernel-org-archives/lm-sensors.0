From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <3E6E7313.50402@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK.  I think I'll have to force myself to stop now....

I keep tweaking the ADT7463 support, but since I don't actually have (or know 
anyone who does) a ADT7463, it seems kinda pointless...

Let's stop with my 2.7.0-lm85-8 patch that is now available on 
FTP.PENGUINCOMPUTING.com at:

ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-lm85-8.patch

Regarding the changes for CVS.  I can create a diff based on Margit's changes 
or you can do it.

I do have a question though.  Margit commented that the #define's for the 
SYSCTL values are now included in the drivers rather than coming from 
sensors.h.  I don't understand that.  It seems like a step backward and asking 
for trouble.  Can you educate me on the reason for this change?  Is sensors.h 
not to be included by kernel drivers?  Why not?  All the rest of the changes 
were trivial changes in the API with i2c, so I'm not really worried about them.

Thanks,
:v)

Mark D. Studebaker wrote:

> I'm back in town, I'll be happy to check in the patch below or something 
> more recent if you are ready.
> Let me know.
> 
> Philip Pokorny wrote:
> 
>> A new version of the LM85 driver for lm_sensors 2.7.0 is available at:
>>
>> ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-lm85-4.patch 
>>
>>
>> This patch has a couple of fixes for a nasty voltage conversion bug 
>> and some fixups related to PWM scaling in libsensors/sensors.
>>
>> I'm currently testing this on a LM85 and ADM1027.
>>
>> Please give it a try.
>> :v)
>>
>> Mark Studebaker wrote:
>>
>>> Subject: Testing LM85 driver
>>> From: Starry Chan <sschan@rasilient.com>
>>> Date: Wed, 26 Feb 2003 14:06:30 -0800
>>> To: sensors@stimpy.netroedge.com
>>>
>>> I would like to know when the LM85 driver will be available. My 
>>> controller board has a LM85 so I can test the driver if it is available.
>>
>>
>>
>>
>>
>>
>>
> 

