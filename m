From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Dec 2014 03:01:09 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <5490F1F5.9060307@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/16/2014 03:10 PM, Richard Llom wrote:
> Guenter Roeck wrote:
>> On Thu, Dec 11, 2014 at 04:06:02PM +0100, Richard Llom wrote:
>>> Jean Delvare wrote:
>>>> On Thu, 11 Dec 2014 12:26:30 +0100, Richard Llom wrote:
>>>>> after a recent kernel update to 3.17.4 in my distro I can't read my
>>>>> sensors anymore with my beloved ksysguard (/System Monitor). Strange
>>>>> thing is, I can still see the sensors with "sensors" (see below).
>>>>>
>>>> Can you run ksysguard from a terminal and see if it's
>>>> spitting any error message (or logging them somewhere maybe?)
>>>>
>>> This is the output from the terminal
>>> ksysguard(3168) KSGRD::SensorAgent::processAnswer: Received UNKNOWN
>>> COMMAND for:  "lmsensors/k10temp-pci-00c3/temp1?"
>>> ...
>>>
>> FWIW, I tried ksysguard with a 3.18 kernel and did not see any problems.
>> I currently have acpitz-virtual, coretemp, nct6792, max6695, tmp435, and
>> tmp451 connected to the system. I tried with Ubuntu 14.04 and 14.10.
>>
> I tried it with a former kernel (3.16) on a live session of chakra and it
> works there, too...
>
>
> Is there any information on how to debug this further?
>

I for my part have no idea right now :-(.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
