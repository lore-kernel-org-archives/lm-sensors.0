From: Curt.Blank@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 06:27:48 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says use
Message-Id: <4600D064.1020703@curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, I answered my own question, yes I can backport the w83627ehf driver 
from 2.6.21 to 2.6.16.

If anyone is interested I put the patches here:

http://www.curtronics.com/patches/

Not bad for one nights work.

Below is the living proof. The chip ID reported by the W83627DHG on this 
MB was different then what the 2.6.21 w83627ehf code looked for so now 
it looks for both. There are 4 fans connected to this MB but only 3 are 
showing up, the 4th is a MSI installed fan on the Northbridge chip. 
Maybe I can't see that one, I don't know at this point. I have to 
validate the voltages also, they don't look quite right.

-Curt

w83627dhg-isa-0a10
Adapter: ISA adapter
in0:       +1.24 V  (min =  +0.00 V, max =  +1.74 V) 
in1:       +1.86 V  (min =  +1.06 V, max =  +0.79 V) 
in2:       +3.26 V  (min =  +2.34 V, max =  +3.36 V) 
in3:       +3.26 V  (min =  +0.90 V, max =  +2.77 V) 
in4:       +1.54 V  (min =  +1.23 V, max =  +0.02 V) 
in5:       +1.46 V  (min =  +0.24 V, max =  +0.78 V) 
in6:       +1.60 V  (min =  +0.17 V, max =  +0.53 V) 
in7:       +3.26 V  (min =  +2.18 V, max =  +2.26 V) 
in8:       +2.99 V  (min =  +2.08 V, max =  +0.86 V) 
fan1:     4326 RPM  (min =    0 RPM, div = 8)
fan2:     2812 RPM  (min = 9926 RPM, div = 8)
fan3:     6750 RPM  (min = 8881 RPM, div = 8)
fan4:        0 RPM  (min =  703 RPM, div = 128)
fan5:        0 RPM  (min = 10546 RPM, div = 128)
temp1:       +41?C  (high =   +53?C, hyst =   +16?C)  
temp2:     +28.5?C  (high = +80.0?C, hyst = +75.0?C)  
temp3:      +1.0?C  (high = +80.0?C, hyst = +75.0?C)  

Curt Blank wrote:

> Well that explains it. In kernel 2.6.21 and I have 2.6.16.
>
> If I'm reading things right that's not even a stable kernel yet. Any 
> chance of me being able to backport it to the 2.6.16 w83627ehf driver 
> for my use?
>
> Looks like I'm slightly on the bleeding edge.
>
> -Curt
>
> Curt Blank wrote:
>
>> In the meantime....
>>
>> Winbond W83627DHG
>>
>> http://www.curtronics.com/Pics/MSI_K9N4_SLI-F_Winbond.jpg
>>
>> How's that for Hi-Res. Couldn't use a flash and lighting was a bitch 
>> (running server).
>>
>> -Curt
>>
>> Jan van Tiggelen wrote:
>>
>>  
>>
>>> OK, the question is out to MSI. I expect it to take up to about a 
>>> day or 2
>>> before we have the full answer.
>>>
>>> Will post back to you in a personal message when I get the schematics.
>>>
>>> Kind regards,
>>>
>>> Jan van Tiggelen
>>>
>>>
>>> -----Original Message-----
>>> From: Curt Blank [mailto:curt at curtronics.com] Sent: Tuesday, March 
>>> 20, 2007 7:44 PM
>>> To: David Hubbard
>>> Cc: Jan van Tiggelen; lm-sensors at lm-sensors.org
>>> Subject: Re: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use
>>> w83627ehfbut it won't load
>>>
>>> Jan/David
>>>
>>> Thanks! Man you guys are great.
>>>
>>> I built this server so I am familiar with the MB but it sounds like 
>>> Jan has the answer.
>>>
>>> I did try installing all the Winbond drivers one at a time but no luck.
>>>
>>> -Curt
>>>
>>> On Tue, 20 Mar 2007, David Hubbard wrote:
>>>
>>>
>>>
>>>   
>>>
>>>> Hi Jan,
>>>>
>>>> On 3/20/07, Jan van Tiggelen <den_tichel at zonnet.nl> wrote:
>>>>  
>>>>     
>>>>
>>>>> Curt / David,
>>>>>
>>>>> Would it be of any help if you get a full spec of the motherboard,
>>>>>    
>>>>>       
>>>>
>>> including
>>>
>>>
>>>   
>>>
>>>>> the schematics? I have access to that.
>>>>>
>>>>> That way you don't need to take the server apart, and you can be sure
>>>>>    
>>>>>       
>>>>
>>> that
>>>
>>>
>>>   
>>>
>>>>> the chip is used exactly for what purpose you would expect.
>>>>>
>>>>> Kind regards,
>>>>>
>>>>> Jan van Tiggelen
>>>>>    
>>>>>       
>>>>
>>>> Yes, that would be the best way.
>>>>
>>>> David
>>>>
>>>>
>>>>  
>>>>     
>>>
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors at lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>  
>>


