From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 14 Jul 2009 15:04:17 +0000
Subject: Re: [lm-sensors] resume lm_sensor from hibernate or suspend
Message-Id: <4A5C9E71.8000707@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A5C7322.6090409@redhat.com>
In-Reply-To: <4A5C7322.6090409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/14/2009 03:21 PM, Jean Delvare wrote:
> Hi Nikola,
>
> On Tue, 14 Jul 2009 13:59:30 +0200, Nikola Pajkovsky wrote:
>> Hi guys,
>>
>>      I'd like to talk about bug
>> https://bugzilla.redhat.com/show_bug.cgi?idH6874. Hans says that's not
>> good idea resume automatically with sensors -s in
>> /usr/lib/pm-utils/sleep.d.
>> Do you have any other idea?
>
> This has the merit of being very simple and to solve the problem
> immediately at hand. However there are a few things to keep in mind:
>
> * Whether limits need to be rewritten may depend on several things,
>    including but not limited to:
>    - resume from RAM vs. resume from disk
>    - hardware monitoring chip model
>    - BIOS implementation details
>
> * You should only call "sensors -s" if you also do it on system boot.
>    If the user/admin is somehow given an option to run it or not at
>    system boot then his/her choice should also be honored at resume time.
>    That being said, the default libsensors configuration file these days
>    no longer contains any possibly wrong "set" statement, so we should
>    be on the safe side either way.
>
> * I thought that restoring devices to their pre-suspend state was the
>    kernel's job? With the proposed user-space solution, I can imagine a
>    scenario where the system is resumed with random sensor limits, an
>    alarm triggers because of this, and only then "sensors -s" is run.
>    This could cause spurious beeping or system halt for example,
>    depending on how the monitoring device in question is wired.
>    That being said, these are issues we would already hit now without
>    your proposed implementation, so it can't make it worse.
>
> All in all I see no problem implementing you idea on a per-distribution
> basis as long as my second point above is taken into consideration.
>
> Hans, did you have any specific issue in mind, which I overlooked?
>

No, I just thought it would be good to discuss this with a wider
audience, and maybe come up with an upstream solution.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
