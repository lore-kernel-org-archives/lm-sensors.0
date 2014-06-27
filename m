From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Fri, 27 Jun 2014 17:50:06 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: ntc_thermistor: Adds support for EPCOS ntc thermistor
Message-Id: <2383887.HrpgCMVlam@lenovobook>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com> <53AD7F8F.7070501@roeck-us.net>
In-Reply-To: <53AD7F8F.7070501@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Hello Guenter,

sorry for that, this was my first patch.
I send the patches now separate and with supported email client.

On Friday 27 June 2014 07:28:31 Guenter Roeck wrote:
> On 06/27/2014 05:59 AM, Johannes Pointner wrote:
> > The patch series adds support for the ntc thermistor B57330V2103 from
> >=20
> >   EPCOS.
> >=20
> > Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
>=20
> Hi Johannes,
>=20
> you sent two patches in the same e-mail, and it is all corrupted.
> All tabs have been replaced with spaces.
>=20
> Guenter
>=20
> > ---
> >=20
> >   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 46a311e..97c9c06 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -42,6 +42,7 @@ dmo    Data Modul AG
> >=20
> >   ebv    EBV Elektronik
> >   edt    Emerging Display Technologies
> >   emmicro    EM Microelectronic
> >=20
> > +epcos    EPCOS AG
> >=20
> >   epfl    Ecole Polytechnique F=E9d=E9rale de Lausanne
> >   epson    Seiko Epson Corp.
> >   est    ESTeem Wireless Modems


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
