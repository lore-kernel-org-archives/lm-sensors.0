From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 17 Sep 2007 18:43:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Update
Message-Id: <20070917184310.GN30825@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4495801329412206370=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164905.GM32667@tree.beaverton.ibm.com> <20070828232504.GP32667@tree.beaverton.ibm.com> <20070911132335.GJ31992@jupiter.solarsys.private> <20070914192924.GL30825@tree.beaverton.ibm.com> <20070917192808.44ad60cc@hyperion.delvare>
In-Reply-To: <20070917192808.44ad60cc@hyperion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com


--===============4495801329412206370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Content-Disposition: inline


--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2007 at 07:28:08PM +0200, Jean Delvare wrote:
> Thanks for the update. I have some more comments. And sorry if it looks
> like nitpicking, but this is a standard interface we're defining so we
> better make sure that we get it right.

Agreed. :)
>=20
> First of all, please think of a better subject line for this patch.
> "Update Documentation/hwmon/sysfs-interface" is too vague when your
> patch is rather specific.

Will change to:
"Add power meter spec to Documentation/hwmon/sysfs-interface"

> > +power[1-*]_average_lowest	Historical average minimum power use
> > +				Unit: microWatt
> > +				RO
>=20
> How useful are historical extremes of an average?

I don't know if anybody ever really requires this data, but the device
I'm talking to records the extremes in hardware, so I put it in the driver.

> > +power[1-*]_high_low_reset	Reset input_highest/input_lowest.
> > +				WO
>=20
> I don't much like this name. It sounds like a name crafted for the
> specific feature of a given chip, while we try to use generic names for

Guilty as charged.  Since ibmpex is the only on-board power meter hardware
to which I have access, the interface proposal includes the various odd
pieces that the hardware provides in addition to the meters.  I
could take the historical extreme and reset bits out of the proposal and
put them in something like Documentation/hwmon/ibmpex.txt as extra
chip-specific features if people prefer that.

> the standard interface. I would rather go for power[1-*]_reset_history

Me too.

> if we have a single file for resetting all the extremes of a given
> channel, or power[1-*]_input_lowest_reset and
> power[1-*]_input_highest_reset if we go for a per-value reset.

The ibmpex hardware only knows how to reset all of them.

> Alternatively, we could simply make the power[1-*]_input_lowest and
> power[1-*]_input_highest files writable, and "cat power1_input >
> power1_input_lowest" (or any write?) would reset the history.

I'd prefer to leave it explicitly called out as a separate sysfs knob,
unless there are established precedents for resetting a sensor by
writing something to its sysfs file.

--D

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7sq+a6vRYYgWQuURAsy5AKCokS1kRlaOrdBIdW8sxftF9UENgQCdHiEN
lm+egk4wriLTpkZ4/h2K/lI=
=mBhM
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--


--===============4495801329412206370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4495801329412206370==--
