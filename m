From: Pedro <bensoup@free.fr>
Date: Mon, 19 Aug 2013 17:21:08 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6681D/NCT7802 Support?
Message-Id: <52125404.3060101@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
In-Reply-To: <CAFqD5d+OcNEF0KoPn9qUNomYvmH14EuoRtVv-59xG5hcYrGduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 19/08/2013 15:40, Guenter Roeck a =E9crit :
> On 08/18/2013 01:12 PM, Pedro wrote:
>>> On Sat, Sep 17, 2011 at 09:10:11PM -0400, Jeffrey Chenkus wrote:
>>> > Is there any plan to add support for the Nuvoton NCT6681D and=20
>>> NCT7802 chips?
>>
> I added the chip and your request to the lm-sensors page. As this is a=20
> new chip,
> we will have to find someone to write a new driver for it.
>
> Guenter
>

Actually i'm quite confused because i ve found that this board (Gryphon=20
Z87) also uses a NCT6791D. So i compiled your driver (nct6775) and it=20
just works as a charm. I can control fan behaviour.

[    1.261491] nct6775: Enabling hardware monitor logical device mappings.
[    1.261502] nct6775: Found NCT6791D or compatible chip at 0x2e:0x290

But i don't understand why there is also the NCT7802 chip. I don't need=20
it but if i can test some code for you, just ask.

Pedro



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
