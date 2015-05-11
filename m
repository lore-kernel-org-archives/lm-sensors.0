From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 May 2015 13:12:27 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <5550AABB.2030006@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/11/2015 03:45 AM, Jean Delvare wrote:
> On Sun, 10 May 2015 09:01:25 -0700, Guenter Roeck wrote:
>> On 05/10/2015 06:42 AM, vt8231@hiddenengine.co.uk wrote:
>> [ ... ]
>>>>>
>>>>> Last note: registers 0xA3-0xA6 have extra configuration bits "Sync
>>>>> T1/2/3". Maybe the driver should handle them but I am not sure how. It
>>>>> could be that the extra outputs should only be exposed to user-space if
>>>>> these bits are 0 (stand alone.) Guenter, any idea/opinion on this?
>>>>
>>>> How about using pwm[4567]_enable ? If I understand correctly, the possible
>>>> modes would be manual or sync(x). In this case we could have 1 (manual),
>>>> 2 (sync with fan1), 3 (sync with fan2), and 4 (sync with fan3), with the
>>>> caveat that the sync settings only make sense if the matching pwmX_enable
>>>> is set to thermal cruise mode.
>>>>
>>>> Does this make sense ?
>
> Not really. The problem is that for now I'm not sure what "sync" really
> refers to. The datasheet mentions temperature channels, and as far as I
> can see each temperature channel is hard-bound to a specific fan
> output. So I suspect that what these configuration bit really mean is
> that the pwm4 output (for example) mirrors the pwm1 output, i.e. pwm4
> has no independent existence. In which case it's better to not expose
> it at all.
>
> If the BIOS specifically configured these bits, there must be a reason
> and that reason would be the way the fans are connected to the chipset.
> Better not change it.
>
> If we really want to expose these bits then abusing pwmX_enable the way
> you suggested is still not correct, pwmX_auto_channels_temp would be
> better suited. But then again I don't think it adds any value if the
> extra PWM outputs only mirror already existing PWM outputs.
>
Ok, fine with me.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
