From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Jan 2008 09:33:43 +0000
Subject: Re: [lm-sensors] [PATCH] HARDWARE MONITORING: Remove redundant
Message-Id: <20080129103343.565b74b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LFD.1.00.0801281327470.22776@localhost.localdomain>
In-Reply-To: <alpine.LFD.1.00.0801281327470.22776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Robert,

On Mon, 28 Jan 2008 13:30:22 -0500 (EST), Robert P. J. Day wrote:
>=20
> Since this source file already includes <log2.h>, there's no reason
> for it to redefine a power of 2 check.
>=20
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

This patch is already in Mark's hwmon-testing tree:
http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit;h=
=89eab87c21ffed88fe990876a7f754a4ddb34a83

All you have to do is wait for him to send a pull request to Linus
(which should happen within a week, I guess.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
