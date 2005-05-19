From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [Fwd: PATCH: bmcsensors and i2c-ipmi port to 2.6]
Message-Id: <405CC78A.4080805@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056FCE9.2020904@utsc.utoronto.ca>
In-Reply-To: <4056FCE9.2020904@utsc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the sensors mailing list is the one.
Phil please sign Yani up.

Yani Ioannou wrote:
> Wow.. and I thought allowing for 50 sensors was over cautious. Yes, 
> dynamic callbacks would be much more scalable (nevermind easier to code, 
> and less of an eye-sore), but we can't bypass the device.h 
> implementation if only for the kobj hiearchy. I can't imagine why the 
> device sysfs callbacks don't pass information on the file they pertain 
> to, like the base sysfs callbacks, I can only think there must be a good 
> reason, or something I'm missing.
> 
> I'll get about to changing the naming when I get time, it won't take 
> much to change, on the dynamic generation of sysfs entries however I 
> could do with all the help I can get :-)
> 
> I suppose I really should subscribe to the relevant mailing list, but is 
> that the lm_sensors or kernel one?
> 
> Thanks,
> Yani
> 
> Mark Studebaker wrote:
> 
>> thanks for the submission.
>> hopefully you can figure out a way to generate the sysfs entries 
>> dynamically.
>> The static generation is unfortunate. Perhaps Greg could help us here.
>> Also I got mail from one person who had 70 sensors on his BMC.
>>
>> I'm not running 2.6 on my BMC machine but I may try to backport the 
>> write code
>> and test it on 2.4.
>>
>> We've recently changed the sysfs naming convention (from temp_min1 to 
>> temp1_min,
>> for example), so we'll need the naming reworked.
>>
>> mds
> 
> 
> 
