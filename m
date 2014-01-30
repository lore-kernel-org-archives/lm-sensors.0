From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 Jan 2014 17:01:53 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <20140130180153.731d57d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 29 Jan 2014 19:23:23 -0800, Alun Evans wrote:
> Seemingly though IPMI is going via the BMC chip over an I2C bus to pull t=
he temperatures from the DIMMs.
>=20
> I wonder if I=92m meant to be going that way as well to get the access to=
 that I2C bus.

Well, as a side note, mixing IPMI and native access is not a good idea
anyway. So if you intend to use IPMI I suppose you should stick to that.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
