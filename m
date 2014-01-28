From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jan 2014 07:22:23 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <20140128082223.120ad882@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi John, Guenter,

On Mon, 27 Jan 2014 14:22:51 -0800 (PST), John wrote:
> > The above log refers to hwmon1/pwmX and hwmon1/fanX_input,
> > yet the errors refer to hwmon1/device/pwmX and
> > hwmon1/device/fanX_input. So there is an obvious mismatch.
> > How does the actual configuration file look like ?
>=20
> I deleted /etc/fancontrol* and rebuilt again under 3.13 (it is attached a=
fter I edited it). =A0It now works. =A0I am not sure what I did the first t=
ime through. =A0Sorry for the noise to the list.

It's not only noise, the problem is real. Thanks for reporting it early
so we have a chance to fix it before it hits too many users.

Guenter, you did update quite a few hwmon drivers lately and as a
consequence their attributes moved from hwmonN/device to hwmonN. While
libsensors already knows how to deal with this, fancontrol does not. So
the change is likely to break many fancontrol user setups out there,
which is not good.=20

I think we need to teach fancontrol about this change and have it look
at the new place automatically whenever referenced attributes are
missing at the old place.

John, would you be willing to assist us by testing an updated version
of the fancontrol script on a 3.13 kernel using your old 3.12
configuration file?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
