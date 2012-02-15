From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Wed, 15 Feb 2012 15:17:42 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <20120215151742.GB12613@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Feb 15, 2012 at 06:21:19AM -0800, Kenneth Cox wrote:
> Jean,
>=20
> Thanks for the response.
>=20
> On Tue, Feb 14, 2012 at 11:29 PM, Jean Delvare <khali@linux-fr.org> wrote:
>=20
>     Hi Kenneth,
>=20
>     On Mon, 13 Feb 2012 16:46:33 -0800, Kenneth Cox wrote:
>     > I am having trouble getting lm-sensors to work as it should I belie=
ve
>     that
>     > part of the problem is support for a newer chip set. here are the s=
pecs:
>     >
>     > CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics
>     > family(18) model(1) stepping(0)
>     >
>     > MoBo: ASRock A75M-HVS
>     >
>     > I'm using the onboard Radeon graphics.
>     >
>     > I ran the sensors-detect script saying yes to everything. The outpu=
t of
>     > sensors:
>     > k10temp-pci-00c3
>     > Adapter: PCI adapter
>     > temp1:         +9.8=B0C  (high =3D +70.0=B0C)
>     >                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)
>     >
>     > That's much colder than room temp and only gives data for the PCI
>     adapter.
>=20
>     This isn't the temperature of "the PCI adapter", the value is from yo=
ur
>     CPU. This happens to be implemented as a PCI device in AMD processors,
>     which is why you see "PCI adapter" in the output, but this is rather
>     misleading I admit.
>=20
>     The reported temperature indeed looks wrong, however it isn't
>     necessarily surprising. This isn't an absolute temperature, but rather
>     a temperature margin from the CPU's max, and it is only accurate when
>     you get close to the limit. So from the above, one can say that your
>     CPU is running very cool ans safe, and that's about it.
>=20
>     That being said, I think this is the first report I see for this fami=
ly
>     of CPU. Andreas, Andre, do you think there's any bug to be fixed here?
>=20
>=20
> Got it. That's excellent news. At least I know I can trust the output to =
let me
> know if it's getting to warm. I did not trust it at all before.
>=20
>=20
>     > I also tried downloading the latest version of sensors-detect from
>     > http://www.lm-sensors.org/wiki/Devices and rerunning. It did not ch=
ange
>     > anything.
>     >
>     > Is there a way to get sensor data for the CPU and accurate data fro=
m the
>     > PCI adapter? Any help would be appreciated.
>=20
>     What kind of system is this? If this is a laptop you're probably out =
of
>     luck. If this is a desktop system, I would expect a hardware monitori=
ng
>     chip on the SMBus or in the Super-I/O chip. Maybe it is too recent and
>     we don't know about it yet. Please provide the full output of
>     sensors-detect.

Hi Kenneth,

I just can second what Jean already said. The reported temperature
(Tctl) is

  "on its own scale aligned to the processors cooling
  requirements. Therefore Tctl does not represent a temperature which
  could be measured on the die or the case of the processor. Instead,
  it specifies the processor temperature relative to the maximum
  operating temperature, Tctl_max."

(Quoted from the AMD Family 12h Processor BKDG.) You have a FM1 socket
processor. Tctl_max is 70 in your case.  So the reported temperature
of 9.8 is far below that maximum operating temperature.


HTH,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
