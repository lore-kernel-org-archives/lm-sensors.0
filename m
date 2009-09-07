From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Sep 2009 19:42:58 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090907214258.1ec0800a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 07 Sep 2009 14:08:05 -0500, Karl Schmidt wrote:
> I sure wish there was a way to search for older postings of this mailing =
list.  I think there may be=20
> some ongoing work on the k8temp?

http://marc.info/?l=3Dlm-sensors is searchable.

> Running
>=20
> #sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +21.0=B0C
>=20
>=20
> Trying to create an alarm for that temp:
>=20
> #AMD K8 core temperature monitor
> chip "k8temp-pci-00c3"
> set temp1_max 10
>=20
> But I get this:
>=20
> # sensors -s
> Error: Line 3: Unknown feature name
> k8temp-pci-00c3: No such sub-feature known

The K8 CPU includes simple thermal sensors, which don't have limits. So
what you see is expected. If there were limits, they would be displayed
by "sensors".

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
