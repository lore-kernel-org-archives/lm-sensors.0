From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 18:09:05 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for 2.6.40
Message-Id: <1306260545.2163.400.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306164092-13024-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1306164092-13024-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, 2011-05-23 at 16:07 -0400, Jean Delvare wrote:
> Hi Guenter,
>=20
> On Mon, 23 May 2011 08:21:32 -0700, Guenter Roeck wrote:
> > Per Dal=C3=A9n (1):
> >       hwmon: Add support for MAX6642
>=20
> I see no trace of this device on wiki/Devices nor in sensors-detect.
> Can it be added please?

While writing the sensors-detect code, I concluded that device detection
is too weak. I requested samples; once I get those I'll either improve
the detection code or drop it from the driver.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
