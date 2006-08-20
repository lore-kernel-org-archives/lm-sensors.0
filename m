From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 20 Aug 2006 18:16:46 +0000
Subject: [lm-sensors] [PATCH] f75383 /f75384 driver
Message-Id: <44E8A70E.6090102@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1155997256.19938.6.camel@rapsure.rapsure.net>
In-Reply-To: <1155997256.19938.6.camel@rapsure.rapsure.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Brian Beardall wrote:
> On Sat, 2006-08-19 at 14:49 -0600, Jim Cromie wrote:
>   
>> Brian Beardall wrote:
>>     
>>
>>> and so they can be handled with one code execution line. Is there
>>> a dev in lm_sensors to allow the change in read frequencies?
>>>   
>>>       
>> Im not sure what you mean here.
>> Do you want some sensor reads to fetch *fresher* data than others ?
>>
>>     
>>>>> +	struct f75383_data *data = f75383_update_device(dev);
>>>>>       
>>>>>           
>> you could add a 2nd param to your update-device, allowing caller to 
>> indicate desired freshness.
>> or you could carve update_device for separate sensors, and fetch each
>>  
>> separately.
>>     
> The entire device reads the temperature sensors depending on a a
> register value. So I can make in read at different Hz, or I can also
> make it only update when a call is made to the device. However I have it
> setup for 15Hz update right now. 
>   

I still dont get what youre after - theres no question here.

IIUC, the standard usage of lm-sensor kernel modules is to support 
user-demanded queries,
such as those done by a user-space daemon. 

In this context, why does your driver have/need 15hz anything
-  is it 'scanning' its own inputs, looking for out-of-range values ?

It seems easy to expose the Freq as a mod-param,
which is then controllable at runtime via /proc/sys/<something>  (IIRC)
but Im unclear on what its for.


>>     
>>>> hth
>>>> jimc
>>>>     
>>>>         
>>>   
>>>       
>
>
>   


