From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jan 2014 10:49:06 +0000
Subject: Re: [lm-sensors] FanControl can not auto"load"
Message-Id: <20140128114906.76bf0913@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390846853.4041.38.camel@X4-955>
In-Reply-To: <1390846853.4041.38.camel@X4-955>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Frederic,

On Tue, 28 Jan 2014 11:20:44 +0100, Frederic @ GMX wrote:
> Le mardi 28 janvier 2014 =E0 08:12 +0100, Jean Delvare a =E9crit :
> > Why did you want to update in the first place? What problem were you
> > trying to solve?
> A stupid raison :(=20
> 1 - I change my CPU Cooler from a Cooler Master Hyper TX3 to a Scythe
> Mugen 3=20
> 2 - I would like change my CPU to jump to a AMD FX series ... with a new =
motherboard.
> 3 - I want make a lm-sensors config to check/remember the links between
> sensors componants, parameters and fans
> So, as I beleived I can change this config and swith back with my
> previous backed-up config ... it was a dream.
> I forgot the manual install of the downloaded package was not the same
> way of an "official debian package"

Not that it really matters, but I don't quite understand how any of
these required updating to the latest version of lm-sensors.

Also note that every motherboard uses different monitoring chips,
monitoring drivers, and input and output mappings. So there's not so
much from your old configuration information you will be able to reuse
on the new system, I'm afraid.

> > > What I have to check/correct ?
> >=20
> > The way services are started at boot time is distribution specific. I
> > am not familiar with Debian so I can't really help there.
> I had some doubts about the services.=20
> On the donwloaded installation where is set the service startup ?

By default it doesn't install anything related to services. Some
distributions want systemd service files, some want legacy init
scripts, so we leave it on the packager / user.

> May be there is always the link available and the re-install don't
> update this informations ?
> I have to question Google about service on debian distri.

Yes, you'll have to search about services on Debian. Find out how to
get the list of services, the status of a service, how to change if a
service should be started at boot, etc. I'm sorry I can't help here but
it's really distribution-specific and last time I used Debian was in
2001. I didn't know much about it and I've forgotten everything
meanwhile.

> > * Check if the fancontrol daemon is running:
> >   # ps -ef | grep fancontrol
>   frederic@X4-955:~$ ps -ef | grep fancontrol
>   frederic  4355  4312  0 10:56 pts/1    00:00:00 grep fancontrol
>=20
> !!! So it's mean that fancontrol run ???

No. What you're seeing above if yourself searching for a "fancontrol"
process. If fancontrol was running, you'd see another line.

> but fan are full speed.
> I run a terminal with :
> root@X4-955:/home/frederic# /etc/init.d/fancontrol start
> [ ok ] Starting fan speed regulator: fancontrol.
>=20
> then fan speed slow down !

fancontrol definitely still works, what's not working is the automatic
start of the service at boot time.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
