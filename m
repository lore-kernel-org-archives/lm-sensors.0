From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Jan 2009 14:54:50 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (k8temp) fix temperature
Message-Id: <20090109155450.199ceb6d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215231213.GC7013@alberich.amd.com>
In-Reply-To: <20081215231213.GC7013@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 9 Jan 2009 15:41:02 +0100, Andreas Herrmann wrote:
> On Fri, Jan 09, 2009 at 02:34:39PM +0100, Jean Delvare wrote:
> > If you apply the same offset to all sensors, you'll still obtain
> > something odd:
> >=20
> >  k8temp-pci-00c3
> >  Adapter: PCI adapter
> >  Core0 Temp:
> >               +38=B0C
> >  Core0 Temp:
> >               +24=B0C
> >  Core1 Temp:
> >               +42=B0C
> >  Core1 Temp:
> >               +26=B0C
> >=20
> > That's not terribly realistic, is it? Unless both sensors for a given
> > core are very far apart -
> > but I suspect each core is pretty small,
> > isn't it?
>=20
> "Far" is relative, isn't it ;-)
>=20
> Guess this is from an idle system.
> Please bring load on both cores and look at the temperature
> differences again.

Well that's not my system, so I can't do the tests. But next time
someone reports with a rev.G K8, we'll ask him/her.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
