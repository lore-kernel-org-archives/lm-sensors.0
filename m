From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 08 Oct 2007 16:33:23 +0000
Subject: Re: [lm-sensors] Unknown chip on Dell Latitude D630
Message-Id: <191fb4ca0710080933v4e737c69p10d9042b3f43db6e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200710071631.00273.arnestaecker@web.de>
In-Reply-To: <200710071631.00273.arnestaecker@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Arne,


On 10/7/07, Arne St=E4cker <arnestaecker@web.de> wrote:
> Hi,
> when I run sensors-detect, I get:
>
> ...
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3201
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown non-standard chip with ID 0x13
> ...

This is an unknown chip. You could try the superiotool
(http://linuxbios.org/Superiotool) to check if it can find something.
Other than that, you would have to open your machine and look for a
chip with the SMSC logo an tell us the chip name. Maybe we can do
something with that information...

...juerg


> I'm using Gentoo (x86), kernel 2.6.22.9, lm-sensors 2.10.4.
>
> regards
>  Arne
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
