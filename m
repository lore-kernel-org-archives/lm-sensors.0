From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 28 Jan 2010 12:37:16 +0000
Subject: Re: [lm-sensors] ATK0110 on ASUS P6T WS Pro (BIOS 0804): CHASSIS3
Message-Id: <68676e01001280437q36f3b642i4eda98f1984936a2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B5C22F4.2030801@gmx.de>
In-Reply-To: <4B5C22F4.2030801@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 27, 2010 at 9:16 PM, Reinhard Nissl <rnissl@gmx.de> wrote:
> Hi,
>
> Am 24.01.2010 11:37, schrieb Reinhard Nissl:
>
>> what can I do to make it report the real fan speed like shown in
>> the BIOS?
>
> I'm sorry for consuming resources, because the fan speed wasn't
> reported in the BIOS either. I recalled that it showed up last
> time I was in BIOS but I didn't check it before posting, as the
> fan was rotating.
>
> The problem was, that fan voltage was too low and as a result the
> board didn't recognize the level of the generated RPM signal.
> Increasing fan supply voltage fixed the issue.

Ok, no problem :-)
Your board is nonetheless interesting because it has both the
interfaces available (and both seems to be working).
If you could check the exact spelling of the labels in the BIOS it
might help me to better understand how the interface is selected.
E.g. does the BIOS display "CPU Fan Speed" or "CPU FAN Speed"?

thanks,
Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
