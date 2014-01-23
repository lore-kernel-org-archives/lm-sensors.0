From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Jan 2014 07:41:01 +0000
Subject: Re: [lm-sensors] sensors
Message-Id: <20140123084101.4428f692@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
In-Reply-To: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 22 Jan 2014 20:59:30 -0800, Guenter Roeck wrote:
> On 01/22/2014 03:27 PM, Ryan wrote:
>  > radeon-pci-0100
>  > Adapter: PCI adapter
>  > temp1:       -128.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)
>=20
> This suggests that there is either no temperature sensor attached to
> the graphics adapter (that is most likely), or that it is broken.

First time I see this. I'd suggest that Ryan reports this to the radeon
driver folks. I think all recent Radeon chips are supposed to have at
least an internal thermal sensor. If I'm wrong then the ones which do
not shouldn't instantiate a hwmon class device at all.

There's another odd thing about this graphics chipset. From
lshw_short.txt:

/0/100/1/0                  generic        Illegal Vendor ID
/0/100/1/0.1                multimedia     Cedar HDMI Audio [Radeon HD 5400=
/6300 Series]

So the main PCI device has a wrong device ID. I'm curious how the
radeon driver even manages to bind to it then. Does lspci look wrong
too?

Could be defective hardware...

You may also try removing radeon.dpm=3D1 from your boot command line and
see if it makes any difference. Which reminds me I should really add it
back on mine, I forgot to do so last time I reinstalled my system.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
