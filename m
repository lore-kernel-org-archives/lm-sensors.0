From: Leandro de Marco <leandromarco@gmail.com>
Date: Mon, 07 Jul 2014 17:07:17 +0000
Subject: Re: [lm-sensors] Help with PMBus VOUT_COMMAND
Message-Id: <CAFO4QpAf40ivrF7JY1MVYjtPeJZW5_N3_qBPoOBGExXGLONefg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFO4QpCX7THAeyOyvzx7grmixaFKaVC4Eh2WmnyxV8-4FT94kg@mail.gmail.com>
In-Reply-To: <CAFO4QpCX7THAeyOyvzx7grmixaFKaVC4Eh2WmnyxV8-4FT94kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

I am sorry that you have already answered this. I couldn't find any
answer at list archives.

Thanks for the help!

On Fri, Jul 4, 2014 at 12:38 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/04/2014 08:22 AM, Leandro de Marco wrote:
>>
>> Hi. I need to configure a BMR464 vout parameter.
>>
>> For what I've read this is not supported and won't be supported as a
>> sysfs interface entry, as this is intended for monitoring purposes
>> only.
>>
>> I found this message, from 1 year ago, that received no response:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2013-July/039441.html
>>
>> Is the ioctl a better approach to set the output? Can't we set this
>> via sys-fs interface and allow only a privileged user to change it?
>>
>> I would like to have some direction here about what is the best way to
>> implement this.
>>
>> Thanks!
>>
> From my original reply:
>
> "Wrong approach, unfortunately. The regulator subsystem should be used to
> control
>  voltages and power supplies. See Documentation/power/regulator/ for
> details.
>  The driver should register itself as power regulator. Since it is a PMBus
>  device, any implementation should be generic and not just support a single
> chip.
>  So far no one asked for it, so I did not bother to implement it. Basic idea
> is
>  quite straightforward, but this is one area where PMBus devices have lots
> of
>  subtle differences, so it would probably need a generic interface/API which
>  is triggered by device specific flags and/or callbacks (ie only chips
>  implementing the callbacks and/or flags would be registered as
> regulators)."
>
> Alternative would be to set the value you need / want with the i2cset
> command
> from user space. This may be an easy way to proceed if you plan to set
> different
> values only for testing.
>
> Guenter
>



-- 
Leandro
--------------------------------------------------------------------------
My Mind is Not for Rent.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
