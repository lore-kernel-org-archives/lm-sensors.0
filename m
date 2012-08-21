From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Aug 2012 15:43:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110): add quirk for Asus M5A78L
Message-Id: <20120821154349.GA25864@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1345563388-9276-1-git-send-email-kronos.it@gmail.com>
In-Reply-To: <1345563388-9276-1-git-send-email-kronos.it@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Aug 21, 2012 at 05:36:28PM +0200, Luca Tettamanti wrote:
> The old interface is bugged and reads the wrong sensor when retrieving
> the reading for the chassis fan (it reads the CPU sensors); the new
> interface works fine.
>=20
> Cc: stable@vger.kernel.org
>=20
> Tested-by: G=F6ran Uddeborg <goeran@uddeborg.se>
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

Applied, thanks

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
