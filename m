From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Sep 2011 03:50:22 +0000
Subject: Re: [lm-sensors] AMD Phenom II Family 16h
Message-Id: <20110924035022.GA19653@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201109232108.25627.pablow.1422@gmail.com>
In-Reply-To: <201109232108.25627.pablow.1422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Sep 23, 2011 at 08:06:19PM -0400, Pablo Fabian Wagner Boian wrote:
> Hi everyone.
> I've got a question regarding AMD Phenom II Family 16h. I'm using the k10=
temp=20
> which appear to be the lastest (the stand alone one, downloaded from lm-
> sensors.org), and it gives me a temp not matching the real (about -10=BAC=
 diff=20
> between them). And, should it provides me a temp reading for all cores? (=
6 in=20
> my case), because I got only one.
>=20
I can not comment on the accuracy, but the k10temp module reads the tempera=
ture
from the northbridge, and there is only one no matter how many cores your c=
hip has.
I guess the chip only reports the package temperature, not the per-core tem=
perature.

Having said that ... the driver officially only supports up to family 15h a=
s far
as I can see. Did you patch it, or does it just work ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
