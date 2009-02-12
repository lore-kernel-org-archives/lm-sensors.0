From: Joshua D Doll <joshua.doll@gmail.com>
Date: Thu, 12 Feb 2009 02:36:28 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <49938B2C.1020407@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>	<4964DB3E.6080908@intel.com>	<alpine.DEB.1.10.0901071142200.29147@p34.internal.lan> <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>
In-Reply-To: <49937CDF.10307@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriel C <crazy@frugalware.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Gabriel C wrote:
> Maxim Levitsky wrote:
>
>   
>> On Wed, 2009-01-07 at 11:42 -0500, Justin Piszcz wrote:
>>     
>>> On Wed, 7 Jan 2009, Dan Williams wrote:
>>>
>>>       
>>>> Justin Piszcz wrote:
>>>>         
>>>>> The HECI interface would allow lm_sensors developers to grab the
>>>>> temperatures off the chips on the board.
>>>>>
>>>>> From 2005(?)-2008 there was some chatter about supporting it but it never
>>>>> seemed to happen, is there any eventual planned support for supporting
>>>>> Intel's HECI interface or if the user wants to see the
>>>>> temperatures/voltages just buy a different motherboard with an ITE I/O
>>>>> controller?
>>>>>
>>>>> I have a couple DG965WH boards and it would be nice to see the
>>>>> temperature of the chipset etc without having to reboot into the BIOS.
>>>>>
>>>>>           
>>>> Hi Justin,
>>>>
>>>> I am not up to date on the progress in this area, but perhaps this site 
>>>> (http://www.openamt.org/) has what you are looking for?
>>>>
>>>> Regards,
>>>> Dan
>>>>
>>>>         
>>> Yeah that is the site-- however, will it ever get merged?  I have not 
>>> heard anything about it for a year or so.
>>>       
>> Nope, the heci is just a controller, but we need a way to tell that
>> controller to show us the temperature data.
>> But intel hasn't released the QST sdk, and probably never will.
>>
>> Sad, 
>>     
>
>
> Well I found this interesting thread about :
>
> http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/
>
> It looks like the QST SDK already exists and is planned to be released..
> (  http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/reply/74068/ )
>
>   
>> Best regards,
>> 	Maxim Levitsky
>>
>>     
>
> Gabriel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   
This is good news. I know lots of users are waiting for this.

--Joshua Doll

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
