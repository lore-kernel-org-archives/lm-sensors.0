From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Apr 2014 15:33:15 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol aborts after suspend/resume
Message-Id: <533D7F3B.7040400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201404021253.49647.l.lunak@centrum.cz>
In-Reply-To: <201404021253.49647.l.lunak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/03/2014 08:25 AM, Lubos Lunak wrote:
> On Thursday 03 of April 2014, Guenter Roeck wrote:
>> On 04/03/2014 07:31 AM, Lubos Lunak wrote:
>>> On Thursday 03 of April 2014, Jean Delvare wrote:
>>>> Hi Lubos,
>>>>
>>>> On Wed, 2 Apr 2014 12:53:49 +0200, Lubos Lunak wrote:
>>>>>    if system running fancontrol is suspended and resumed, fancontrol
>>>>> will abort, as writing the pwm value will fail because of pwm control
>>>>> being set to automatic control after the resume (google for 'fancontrol
>>>>> suspend' for various discussions about this). The attached patch fixes
>>>>> the problem.
>>>>
>>>> I'm afraid this is fixing the problem in the wrong place. The BIOS is
>>>> responsible for restoring the hardware settings at resume time. Failing
>>>> that, the kernel should do it.
>>>>
>>>> So you should first look for a BIOS update, even though the chances
>>>> that it fixes this specific problem are rather low. Then you should
>>>> tell us which hwmon driver you are using, so that we can add proper
>>>> suspend/resume code to it.
>>>
>>>    hwmon_vid
>>
>> Whatever it is, it is not hwmon_vid, sorry. hwmon_vid is just a small
>> module which translates VID data into voltages.
>
>   it87 then?
>
Yes, that would be it, if you have that module loaded. The driver does not
currently implement suspend/resume, so the problem is not surprising if your
configuration changes default settings (which appears to be the case).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
