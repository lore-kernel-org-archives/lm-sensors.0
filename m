From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 06 Oct 2009 15:41:47 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <4ACB653B.9090707@msgid.tls.msk.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>	 <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>	 <4AC939BB.8090600@wasp.net.au>	 <68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>	 <4ACA21E8.6080501@msgid.tls.msk.ru>	 <68676e00910060800h4cb84dcl9f610f6b23a88e5c@mail.gmail.com>	 <4ACB60A7.307@msgid.tls.msk.ru> <68676e00910060834p338c77c8kae8156a1f8dc68a9@mail.gmail.com>
In-Reply-To: <68676e00910060834p338c77c8kae8156a1f8dc68a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Brad Campbell <brad@wasp.net.au>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Luca Tettamanti wrote:
> On Tue, Oct 6, 2009 at 5:22 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
[]
> Most Asus mobos have Q-FAN settings in the BIOS screen; you can use
> automatic management to let the hardware control the fan, the driver
> does not interfere with that (and if it does then it's a bug).

I know the Q-Fan works. But I wanted exactly the ability to control
it from software (a-la fanspeed).  Here, due to the way my machine
is built, the fan isn't needed most of the time (there's a large
air duct inside that covers large CPU heatsink, hdd, northbridge
heatsink and the PSU, that gets use of natural airflow), but it's
used when the temperature grows.  So that most of the time, the
system is 100% quiet, and only when I run something that uses much
power it starts heating slowly, until a fan gets turned on.  That
to say, the built-in q-fan profile isn't sufficient ;)  And yes,
I'm such a crazy fan-noise-hater, and all the components of this
system are choosen to satisfy this my craziness, including many
parts that I made myself (airduct, noise-dampering matherials
inside the case, fan mounting and placement and so on).

>> Ok.  Now a pure technical question, finally.  Is there a
>> way to made asus_atk0110 to be able to *set* fan speeds
>> too, in a way as it's done by it87?
> 
> In term of Q-FAN profiles: yes, but I still haven't managed to make it
> work (the interface is there though).

Oh, so it's basically boils down to Silent/Optimal/Normal choices
as in the BIOS settings, right?  I mean, still no pwm_* controls
as it87 offers?..

Thanks!

/mjt

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
