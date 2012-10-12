From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 12 Oct 2012 16:48:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CP
Message-Id: <20121012164824.GD6300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Oct 12, 2012 at 11:01:32AM +0200, Jean Delvare wrote:
> On Fri, 12 Oct 2012 10:40:32 +0200, Jean Delvare wrote:
> > I think we simply never bothered special-casing the Atom 230/330.
>=20
> Oh actually we did, I didn't remember that. So well no, I have no idea
> where the 100=B0C for Atom 230 comes from, probably we just got it wrong
> when introducing tjmax_table in commit 41e58a1f.
>=20
Maybe. Part of the problem is that TjMax is really 90 C according to the
230/330 datasheet, and that at least the 330 uses not TjMax but 125 as
the base temperature for its temperature offset calculation. So we don't
really have an idea what the 230 does.

Would be great if you have a chance to test it with the 230 before we blind=
ly
change it to some other value.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
