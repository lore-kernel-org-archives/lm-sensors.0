From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Oct 2012 14:00:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CP
Message-Id: <20121010140039.GA8699@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Oct 10, 2012 at 03:44:56PM +0200, Jean Delvare wrote:
[ ... ]
>=20
> Documentation/hwmon/coretemp says 125=B0C for Atom 230 and 330. N5xx
> aren't listed in this document BTW.
>=20
Reminds me ... we have a discrepancy in the code regarding the 230, and use=
 100
degrees C instead of 125 for it. Any idea where this is documented ? I wasn=
't
able to find definite numbers over the weekend, and I don't recall why I us=
ed
100 for the 230 when I introduced tjmax_table.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
