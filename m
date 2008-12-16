From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 13:22:33 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081216142233.7ed1e282@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ludovic,

On Mon, 15 Dec 2008 23:20:03 +0100, Ludovic Leb=E8gue wrote:
> f8000-isa-0a00
> Adapter: ISA adapter
> in0:         +1.68 V
> in1:         +1.67 V
> in2:         +1.64 V
> (...)
> Voltage indication seems to be divided by two. I guess sensors3.conf
> should be modified for f8000 chip.

Correct. My f8000 driver was handling the scaling internally but Hans'
f71882fg driver doesn't, so compute formulas will be needed in
sensors3.conf:

chip "f8000-*"

   compute in0  @*2, @/2
   compute in1  @*2, @/2
   compute in2  @*2, @/2

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
