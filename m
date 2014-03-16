From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 16 Mar 2014 11:17:31 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <20140316121731.37c176aa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Grzegorz,

Please keep the list in Cc.

On Sun, 16 Mar 2014 11:33:51 +0100, Grzegorz S=F3jka wrote:
> On 03/14/14 07:53, Jean Delvare wrote:
> > I think we've seen this ID many times in the past, but we don't know
> > what chip it is and/or we don't have a datasheet. If you can have a
> > physical look at the board and find the chip name, that would be a
> > start.
> The is a lot of tiny chips on the MB so small that its extremely=20
> difficult to read the symbols (without disassemble). What should I look f=
or?

The Super-I/O shouldn't be that small, actually it is generally one of
the largest chips on the board. You'd be looking for a chip with "SMSC"
clearly readable on top of it, like:
http://i00.i.aliimg.com/photo/v0/559896002/IC_CHIP_LPC47N350_NE_SMSC_QFP.jp=
g_220x220.jpg

> > Not all LPC chips include hardware monitoring features though.
> The PSU and CPU fans speeds are controlled according to CPU and PSU=20
> temperatures. There is even a king of simple adjustment in the BIOS.=20
> According to the specs both sense and controlling signals of the PSU fan =

> are connected directly to the MB. So there is some electronics on the MB =

> capable of measuring temperatures and adjusting fan speeds and probably=20
> measuring fan speeds.

OK, that's thin, but that's a start.

> > Does the BIOS display any fan speed on this system?
> The BIOS does not show any temp or fan readings. Although, the machine=20
> supports remote management via intel vPro. Is is possible that sensors=20
> are only exposed to remote management hardware??

Everything is possible.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
