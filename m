From: Jae Sammy <jaesammy@gmail.com>
Date: Thu, 09 Sep 2010 04:12:11 +0000
Subject: Re: [lm-sensors] ECS H55H-I Support (Suspected IT8721F Chipset)
Message-Id: <AANLkTikAVn+9O1TvcxBOuZuiUm2jiRpcfJw+pMWn60iZ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
In-Reply-To: <AANLkTi=Bp+JJm8GoSG14X-b7BuCP_NwnxP2=nTeWWpXD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Was able to get temperature readings on my ECS H55H-I.  Not really
sure how to configure the sensors.conf for my mobo but all I'm really
interested in is temperature so I think I am there.

Not sure about the temperature scaling:
temp1:       +49.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor
temp2:      -128.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor =
=3D disabled
temp3:       +37.0=B0C  (low  =3D +127.0=B0C, high =3D +80.0=B0C)  sensor =
=3D thermal diode

49 and 37 seem pretty low but if they're right I'd be really happy.

Thanks for the patches Virgil!

On Wed, Sep 8, 2010 at 1:15 PM, Virgil Gheorghiu
<virgilg@cs.uchicago.edu> wrote:
> Good afternoon, Jae, Jean,
>
>>>> Rumor says that there's a chip named IT8758E with device ID 0x8721.
>
> This is true. See a message about "Kernel support for ITE8758E" from a few
> days back.
> This motherboard is a Shuttle SX58; rrd output from my hacked it87.ko and
> sensors.conf can be seen here:
> http://sensors.cs.uchicago.edu/cgi-bin/kailash.rrdcgi
>
> Attached are patches to it87.c (vs linux-2.6.35.4), sensors-detect (vs
> lm-sensors-3.1.2), and a sensors.conf for this motherboard.
> I also have a picture of the chip, and it matches the SMD packaging Jae
> provided.
> Please let me know how else I can help.
>
> Thank you,
> Virgil Gheorghiu
> Systems Administrator
> Department of Computer Science
> The University of Chicago
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
