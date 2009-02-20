From: Gabriel C <crazy@frugalware.org>
Date: Fri, 20 Feb 2009 14:04:47 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard and weird sensors output
Message-Id: <499EB87F.2070706@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <499372A3.6080803@frugalware.org>
In-Reply-To: <499372A3.6080803@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> On Fri, 20 Feb 2009 14:20:05 +0100, Gabriel C wrote:
>> Gabriel C wrote:
>>
>>> Jean Delvare wrote:
>>>> OK, thanks for reporting. I have just committed a fix to sensors-detect
>>>> so that it will differentiate between LM96000/PC8374L (have sensors)
>>>> and WPCD377I (no sensors) on the SMBus. Please give it a try:
>>>> http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
>>>
>>> Thanks , I will test when I'm home and report back.
>> It does work for me , the new output is :
>>
>> ...
>>
>> Probing for `National Semiconductor LM96000 or PC8374L'...  No
>> ...
>>
>> Probing for `Winbond WPCD377I'...                           Yes
>>     (confidence 7, not a hardware monitoring chip)
> 
> As expected. Thanks for reporting.
> 
>> ..
>>
>> Jean it is possible these chips have something to do with Intel's QST ?
> 
> No, they do not. The idea (as far as I understand it) is that these
> boards have Super-I/O chips with reduced features (no hardware
> monitoring) because the south bridge (ICH8+) has QST support. So you
> need AMT/QST support for hardware monitoring features.
> 


Ah ok. I do have AMT ( heci linux driver ) but open source QST SDK is not yet released :/

However according to http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/reply/74068/
with an NDA one could get a copy of the SDK even yet.

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
