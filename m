From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <3E766FF5.6040807@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

your patch is checked in.
Thanks again for generating such a complete patch,
and for being willing to make changes to fit our evolving standards.
And thanks to the rest of you for testing.

After I checked it in unchanged, I then made some cleanups and changes
to get it to compile in CVS.
While I was happy to do the changes, it would be helpful
if you wish to test my changes, or
for any subsequent development, if you used CVS as a base.
Unfortunately CVS is a little challenging at the moment,
and you will need i2c-CVS as well.
Let me know if you need any help.

mds


Philip Pokorny wrote:
> OK.  I think I'll have to force myself to stop now....
> 
> I keep tweaking the ADT7463 support, but since I don't actually have (or 
> know anyone who does) a ADT7463, it seems kinda pointless...
> 
> Let's stop with my 2.7.0-lm85-8 patch that is now available on 
> FTP.PENGUINCOMPUTING.com at:
> 
> ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-lm85-8.patch 
> 
> 
> Regarding the changes for CVS.  I can create a diff based on Margit's 
> changes or you can do it.
> 
> I do have a question though.  Margit commented that the #define's for 
> the SYSCTL values are now included in the drivers rather than coming 
> from sensors.h.  I don't understand that.  It seems like a step backward 
> and asking for trouble.  Can you educate me on the reason for this 
> change?  Is sensors.h not to be included by kernel drivers?  Why not?  
> All the rest of the changes were trivial changes in the API with i2c, so 
> I'm not really worried about them.
> 
> Thanks,
> :v)
> 
> Mark D. Studebaker wrote:
> 
>> I'm back in town, I'll be happy to check in the patch below or 
>> something more recent if you are ready.
>> Let me know.
>>
>> Philip Pokorny wrote:
>>
>>> A new version of the LM85 driver for lm_sensors 2.7.0 is available at:
>>>
>>> ftp://ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-lm85-4.patch 
>>>
>>>
>>> This patch has a couple of fixes for a nasty voltage conversion bug 
>>> and some fixups related to PWM scaling in libsensors/sensors.
>>>
>>> I'm currently testing this on a LM85 and ADM1027.
>>>
>>> Please give it a try.
>>> :v)
>>>
>>> Mark Studebaker wrote:
>>>
>>>> Subject: Testing LM85 driver
>>>> From: Starry Chan <sschan@rasilient.com>
>>>> Date: Wed, 26 Feb 2003 14:06:30 -0800
>>>> To: sensors@stimpy.netroedge.com
>>>>
>>>> I would like to know when the LM85 driver will be available. My 
>>>> controller board has a LM85 so I can test the driver if it is 
>>>> available.
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>
> 
> 
