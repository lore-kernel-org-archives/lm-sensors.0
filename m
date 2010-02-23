From: Gabriel C <nix.or.die@googlemail.com>
Date: Tue, 23 Feb 2010 16:58:59 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <4B8416DC.4040904@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan> <4964DB3E.6080908@intel.com> <alpine.DEB.1.10.0901071142200.29147@p34.internal.lan> <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org> <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
In-Reply-To: <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 12.02.2009 18:39, Justin Piszcz wrote:

> 
> 
> On Thu, 12 Feb 2009, Gabriel C wrote:
> 
>> Maxim Levitsky wrote:
>>
>>> On Wed, 2009-01-07 at 11:42 -0500, Justin Piszcz wrote:
>>>> On Wed, 7 Jan 2009, Dan Williams wrote:
>>>>
>>>>> Justin Piszcz wrote:
>>>>>> The HECI interface would allow lm_sensors developers to grab the
>>>>>> temperatures off the chips on the board.
>>>>>>
>>>>>> From 2005(?)-2008 there was some chatter about supporting it but
>>>>>> it never
>>>>>> seemed to happen, is there any eventual planned support for
>>>>>> supporting
>>>>>> Intel's HECI interface or if the user wants to see the
>>>>>> temperatures/voltages just buy a different motherboard with an ITE
>>>>>> I/O
>>>>>> controller?
>>>>>>
>>>>>> I have a couple DG965WH boards and it would be nice to see the
>>>>>> temperature of the chipset etc without having to reboot into the
>>>>>> BIOS.
>>>>>>
>>>>> Hi Justin,
>>>>>
>>>>> I am not up to date on the progress in this area, but perhaps this
>>>>> site
>>>>> (http://www.openamt.org/) has what you are looking for?
>>>>>
>>>>> Regards,
>>>>> Dan
>>>>>
>>>> Yeah that is the site-- however, will it ever get merged?  I have not
>>>> heard anything about it for a year or so.
>>>
>>> Nope, the heci is just a controller, but we need a way to tell that
>>> controller to show us the temperature data.
>>> But intel hasn't released the QST sdk, and probably never will.
>>>
>>> Sad,
>>
>>
>> Well I found this interesting thread about :
>>
>> http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/
>>
>>
>> It looks like the QST SDK already exists and is planned to be released..
>> ( 
>> http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/reply/74068/
>> )
>>
>>>
>>> Best regards,
>>>     Maxim Levitsky
>>>
>>
>> Gabriel
> 
> I volunteer to test any patches if/when they are created after the SDK
> is released.



Ok good news :) The QST SDK is out ..

http://software.intel.com/en-us/blogs/2010/02/18/great-news-the-intelr-qst-sdk-is-now-public/


http://software.intel.com/en-us/articles/Intel_Quiet_System_Technology_Software_Development_Kit/



Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
