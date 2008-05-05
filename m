From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 May 2008 12:33:16 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080505143316.11a8f1e2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Achim,

On Mon, 05 May 2008 14:15:34 +0200, achim wrote:
> He He, the BKDG is tough to read. I tried to figure out the SMbus
> adresses.
>=20
> http://www.abload.de/image.php?img=BAredit-sidebandeis.jpg
>=20
> This is the register where the adress should be in bits 4:6 whom are all
> zero. However bit 3 is set and that should mean that the sideband
> interface is used.
>=20
> http://www.abload.de/image.php?img=3Dsidebandumy.jpg

This isn't how I read the specification. Bit 3 set means that the SBI
is _disabled_. But it your case, bit 3 is _not_ set, is it?

I wonder where the 4 higher SMBus address bits are set.

> (...)
> Thank you for the tip. But under linux only the address space from
> 0x00-0xFF is accesible thru /proc/bus/pci...
> I tried to access 0x1E4 that way=20
>=20
> setpci -s 0:18.3 0x1E4.l=20
>=20
> and only got 0xFFFFFFFF back. Same happens if i try to read
> from /proc/bus/pci/00/18.3 direct (with a small python script).

Ah, I didn't know.

> I tried to read out 0x6e with the -r option. It is possible to read the
> following areas without making the smbus controler nonfunctional.
> 0x00-0x7F,
> 0x80-0x9d,0xa0-0xbd,0xc0-0xdd,0xe0-0xfd
>=20
> ALso i tried to run sensors-detect with excluding 0x2e,0x6e and 0x47. It
> passed but afterwards I had to restart to get rid of the XX'es in the
> i2cdump.

So there must be yet another chip which doesn't like being probed. This
confirms my impression that the safest fix is to blacklist the
motherboard and disable the SMBus entirely. Although I understand that
you don't want to do this now, as you are still investigating.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
