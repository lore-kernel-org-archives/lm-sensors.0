From: Luca <kronos.it@gmail.com>
Date: Mon, 21 May 2007 21:38:17 +0000
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Message-Id: <68676e00705211438y3fd063fdg39014f4108d92b3d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	<46520F36.4080006@assembler.cz>
In-Reply-To: <46520F36.4080006@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 5/21/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> Hello all,
>
> Sorry for the delay. Glad that someone took a look into this.
> ATK0110 ATK0110:00: atk: adding...
> ATK0110 ATK0110:00: board ID =3D A8VE-SE
> ATK0110 ATK0110:00: temp 0: CPU Temperature [900-1250]
> ATK0110 ATK0110:00: temp 1: MB Temperature [700-1250]
> ATK0110 ATK0110:00: voltage 0: Vcore Voltage [1450-1750]
> ATK0110 ATK0110:00: voltage 1:  +3.3 Voltage [3000-3600]
> ATK0110 ATK0110:00: voltage 2:  +5.0 Voltage [4500-5500]
> ATK0110 ATK0110:00: voltage 3: +12.0 Voltage [11200-13200]
> ATK0110 ATK0110:00: atk_enumerate_fan: invalid fan count 3 (should be 5)
> ATK0110: probe of ATK0110:00 failed with error -22
> ruik@ruik:~$
>
> Not 100% success but at least something ;). I did some research on this s=
ome
> time ago (2005):
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/014050.html
>
>
> I'm attaching my dsdt.bin.

Thanks, I'll take a look at your dsdt (btw, thermal limits seem bogus:
125=C2=B0 is a bit too much O_o).

> Also keep in mind that we will need some
> "synchronizer" for the ACPI versus other drivers.

I don't think it's necessary, the AML interpreter serializes all
callers, so at most one method is executing at a given time, provided
that it doesn't sleep (hwmon methods don't).

Luca
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
