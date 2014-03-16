From: =?ISO-8859-2?Q?Grzegorz_S=F3jka?= <pld@sojka.co>
Date: Sun, 16 Mar 2014 18:33:03 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <5325EE5F.8000601@sojka.co>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 03/16/14 12:17, Jean Delvare wrote:
> Hi Grzegorz,
>
> Please keep the list in Cc.
OK. Sorry.
>
> On Sun, 16 Mar 2014 11:33:51 +0100, Grzegorz S=F3jka wrote:
>> On 03/14/14 07:53, Jean Delvare wrote:
>>> I think we've seen this ID many times in the past, but we don't know
>>> what chip it is and/or we don't have a datasheet. If you can have a
>>> physical look at the board and find the chip name, that would be a
>>> start.
>> The is a lot of tiny chips on the MB so small that its extremely
>> difficult to read the symbols (without disassemble). What should I look =
for?
>
> The Super-I/O shouldn't be that small, actually it is generally one of
> the largest chips on the board. You'd be looking for a chip with "SMSC"
> clearly readable on top of it, like:
> http://i00.i.aliimg.com/photo/v0/559896002/IC_CHIP_LPC47N350_NE_SMSC_QFP.=
jpg_220x220.jpg
I did not found anything like this. I did not disassemble the pc. Its=20
SFF so some parts of MB are covered by other components. What I was able=20
to read is the markings on the following chip:

WINBOND
WPCD376HAKFG
917SG291580312FG

Does it help or should I look for something else?

--=20
Pozdrawiam
Grzesiek



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
