From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 16:10:20 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <68676e00910060910m7744a6dcua2a344ce44b9de6e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
	 <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
	 <4AC939BB.8090600@wasp.net.au>
	 <68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>
	 <4ACA21E8.6080501@msgid.tls.msk.ru>
	 <68676e00910060800h4cb84dcl9f610f6b23a88e5c@mail.gmail.com>
	 <4ACB60A7.307@msgid.tls.msk.ru>
	 <68676e00910060834p338c77c8kae8156a1f8dc68a9@mail.gmail.com>
	 <4ACB653B.9090707@msgid.tls.msk.ru>
In-Reply-To: <4ACB653B.9090707@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Brad Campbell <brad@wasp.net.au>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Oct 6, 2009 at 5:41 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Luca Tettamanti wrote:
>>
>> On Tue, Oct 6, 2009 at 5:22 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>> Ok.  Now a pure technical question, finally.  Is there a
>>> way to made asus_atk0110 to be able to *set* fan speeds
>>> too, in a way as it's done by it87?
>>
>> In term of Q-FAN profiles: yes, but I still haven't managed to make it
>> work (the interface is there though).
>
> Oh, so it's basically boils down to Silent/Optimal/Normal choices
> as in the BIOS settings, right?  I mean, still no pwm_* controls
> as it87 offers?..

It's motherboard specific. On some model with w83627ehf it's possible
to activate thermal cruise control (with a given target temperature).
I've never seen direct pwm or dc control; it's theoretically doable
with a custom DSDT ;-)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
