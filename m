From: Hubert Kario <hka@qbs.com.pl>
Date: Tue, 01 Sep 2009 18:26:41 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <200909012026.42247.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Saturday 29 August 2009 18:03:36 Tech2009 wrote:
> > Message: 3
> > Date: Sat, 29 Aug 2009 10:30:25 +0200
> > From: Hubert Kario <hka@qbs.com.pl>
> > Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage
> > System SS4200
> > To: lm-sensors@lm-sensors.org
> > Message-ID: <200908291030.25637.hka@qbs.com.pl>
> > Content-Type: text/plain;  charset=3D"iso-8859-2"
> >
> >
> >
> > and what shows dmesg?
>
> dmesg output after sensors-detect:
> [ 1815.988770] i2c /dev entries driver
>
> dmesg output after sensors:
> (blank)
So there doesn't appear to be any problem...
>
>
> The bundled Linux image does not appear to use the dme1737 module or
> lmsensors. The web interface loads several closed source libraries, and
> I'm not sure how they access the hardware.
They may access the hardware directly, is the web interface running as root?
Also, you may check /sys file system, look in /sys/bus/platform/drivers/ fo=
r=20
it, the module may be compiled in in the bundled image
>
> Is there something I should try to determine why sensors-detect sees the
> chip but sensors does not?
you could try one of the parameters aviable for the module, for list of all=
 of=20
them, run:
modinfo dme1737


--=20
Hubert Kario
QBS - Quality Business Software
ul. Ksawer=F3w 30/85
02-656 Warszawa
POLAND
tel. +48 (22) 646-61-51, 646-74-24
fax +48 (22) 646-61-50


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
