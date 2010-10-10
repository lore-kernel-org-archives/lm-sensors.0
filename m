From: "Fred ." <eldmannen@gmail.com>
Date: Sun, 10 Oct 2010 22:42:27 +0000
Subject: Re: [lm-sensors] [RFC v2] Support of chassis intrusion detection
Message-Id: <AANLkTimOAMHGrjf3+7uOxWVKjzVMsYkdUzWnAfxEhVjE@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310170340.4c63de39@hyperion.delvare>
In-Reply-To: <20090310170340.4c63de39@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 7, 2010 at 4:33 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, Oct 07, 2010 at 08:55:46AM -0400, Fred . wrote:
>> http://www.lm-sensors.org/ticket/2370
>> Ticket says the interface definition is now upstream.
>>
> It is.
Since it is, then I suppose its a good time to add support for this in
the user-space tools.

>> Since the interface definition is upstreams, why have not support been
>> added to libsensors and sensors?
>>
> Browsing through the drivers, it seems that none have been converted
> to use the new interface. I would guess that until that has been done,
> it does not make sense to add untestable support for it to libsensors.
Which came first, the chicken or the egg?
Time to implement support for this in the user-space tools.
Hopefully support in drivers will follow.

> Please keep in mind that most of the work done in the linux kernel is voluntary.
> Especially work like this, which is a bit out of mainstream. You are always
> invited to make a contribution yourself, modify the drivers as needed, and
> submit your patches. Including, of course, libsensors.
Unfortunately, I am not technical enough to be able to contribute.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
