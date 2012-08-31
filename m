From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Date: Fri, 31 Aug 2012 11:37:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/8] mfd: Add Dialog DA906x core driver.
Message-Id: <5755960.24LjLssrFx@laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241445@sw-eng-lt-dc-vm2> <20120825183113.GE6520@opensource.wolfsonmicro.com> <201208311220@sw-eng-lt-dc-vm2>
In-Reply-To: <201208311220@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Andrew Jones <drjones@redhat.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Anthony Olech <anthony.olech@diasemi.com>

Le vendredi 31 ao=FBt 2012 12:20:00 Krystian Garbaciak a =E9crit :
> > On Fri, Aug 24, 2012 at 02:50:00PM +0100, Krystian Garbaciak wrote:
> > > This is MFD module providing access to registers and interrupts of
> > > DA906x
> > > series PMIC. It is used by other functional modules, registered as MFD
> > > cells. Driver uses regmap with paging to access extended register lis=
t.
> > > Register map is divided into two pages, where the second page is used
> > > during initialisation.>=20
> > Your selection of people to CC here appears both large and random...
>=20
> I've added any maintainer for my modules from maintainer list.

You should filter manually what get_maintainer.pl tells you, sometimes it's=
=20
too verbose.

I'm not maintainer of any of the files/tree this patch is touching.

Anyways, it's quite pleasing to see that get_maintainer knows me :)

Regards,

Philippe


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
