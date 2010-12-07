From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 07 Dec 2010 14:12:40 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <AANLkTikViTpELohrtAe0ccSFqw7NHBZ33vE7K+m5W_tX@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Please use "reply all"

On Mon, Dec 6, 2010 at 6:47 AM, Billy DeVincentis <billydv1@verizon.net> wrote:
> On 12/04/2010 08:12 AM, Luca Tettamanti wrote:
>>
>> Please reply to all, don't trim the CC list.
>>
>> On Sat, Dec 4, 2010 at 6:11 AM, Billy DeVincentis<billydv1@verizon.net>
>>  wrote:
>>>
>>>         Okay, I have tried booting with the acpi=force irqpoll and this
>>> does
>>> nothing more than make the system slow and unusable, but on the other
>>> hand,
>>> the mouse and keyboard don't freeze.
>>
>> irqpoll it's just a band aid; can you access the machine using the
>> network (e.g. ssh)?
>
> Yes, always.

Ok, excellent. When the keyboard freezes ssh into the machine and take
a snapshot of /proc/interrupts, then press a few keys and take another
snapshot.
Please also send me the dmesg (after the lock up).

Are you able to compile a custom kernel?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
