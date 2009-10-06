From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 15:34:19 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <68676e00910060834p338c77c8kae8156a1f8dc68a9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
	 <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
	 <4AC939BB.8090600@wasp.net.au>
	 <68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>
	 <4ACA21E8.6080501@msgid.tls.msk.ru>
	 <68676e00910060800h4cb84dcl9f610f6b23a88e5c@mail.gmail.com>
	 <4ACB60A7.307@msgid.tls.msk.ru>
In-Reply-To: <4ACB60A7.307@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Brad Campbell <brad@wasp.net.au>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Oct 6, 2009 at 5:22 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Luca Tettamanti wrote:
>>
>> On Mon, Oct 5, 2009 at 6:42 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> []
>>>
>>> Well, I just tried it here and it works here too, on 3 different
>>> asus motherboards.  But asus_atk0110 is far less useful than the
>>> it87 variant.  Yes atk0110 shows correct labels for various sensors,
>>> but for one there's no way to control fan speeds using it, at least
>>> not currently, -- something which is done by it87 easily.
>
> []
>>
>> The main reason for using atk0110 is correctness: the resources are
>> claimed by ACPI, it might not be safe to touch them (for the same
>> reason two drivers are not allowed to map e.g. the same PCI BAR).
>> On newer boards the risk of collision is pretty high, since the hwmon
>> chip is used by an EC that works in background... on other boards the
>> risk is much lower since the hwmon chip doesn't seem to be probed
>> actively.
>> Anyway, as user you can override this decision with
>> "acpi_enforce_resources=lax", but _I_ wouldn't recommend it.
>
> If there's a choice between "does not work but correct" and
> "incorrect but works", i'd prefer the latter, and I'd say any
> sane person agrees.
>
> I spent quite some time choosing a motherboard that is able
> to control fan speeds.  Now if know that it does that "incorrectly".
> So I should either throw it away because one of the most
> important criterias (ability to control noise level) does
> not satisfy me anymore, or use it the "wrong" way as I did
> for whole last year.  Ditto for 4 other asus motherboards
> that have exactly the same problem.

Most Asus mobos have Q-FAN settings in the BIOS screen; you can use
automatic management to let the hardware control the fan, the driver
does not interfere with that (and if it does then it's a bug).

> Ok.  Now a pure technical question, finally.  Is there a
> way to made asus_atk0110 to be able to *set* fan speeds
> too, in a way as it's done by it87?

In term of Q-FAN profiles: yes, but I still haven't managed to make it
work (the interface is there though).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
