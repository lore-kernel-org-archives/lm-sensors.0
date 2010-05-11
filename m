From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 11 May 2010 15:48:06 +0000
Subject: Re: [lm-sensors] Intel Atom thermal sensors
Message-Id: <AANLkTil7sceq9zZUE0IBaQD1gmfckafOcfcSVWvNsuMl@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
In-Reply-To: <u2oe21d97a51004271247n7f5d4fbcn2a3de7429c738a08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean!

On Tue, May 11, 2010 at 10:42, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Dmitry,
>
> On Tue, 11 May 2010 09:44:49 -0400, Dmitry Gromov wrote:
>> Hi!
>>
>> Well, if anyone is interested. I successfully installed Ubuntu Server 10.04:
>>
>> Linux dgwind1 2.6.32-21-generic #32-Ubuntu SMP Fri Apr 16 08:09:38 UTC
>> 2010 x86_64 GNU/Linux
>>
>> I re-run sensors-detect hoping it would fix configuration and allow
>> Intel Atom sensors to be reported.
>> It did detect those sensors... but failed to add coretemp driver to /etc/modules
>>
>> Once I loaded coretemp driver, I was able to see 4 outputs of Atom
>> temperature sensors - this is dual core N330 CPU, with hyperthreading.
>> What is interesting though is that it seems like probe of one core
>> reported as Core 0 and 2 and probe of the second core is reported as
>> Core 1 and 3
>
> This is my experience as well. And I think this is incorrect. I'm
> almost certain that there's only one thermal sensor per core, so
> hyperthreaded cores should only be listed once. I have a patch fixing
> this see, below if you want to give it a try.
>

Thank you for the conformation and patch - it is very tempting to try.
If I have some time over weekend, I'll see what I can do.

>> - I thought, they'd be reported sequentially.
>
> This is due to the way the kernel enumerates the CPUs. As I understand
> it, it enumerates all cores first, and only then the hyperthreaded
> siblings.
>

I see, thank you for an explanation.

-- 
DG
NJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
