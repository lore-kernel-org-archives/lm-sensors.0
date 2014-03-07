From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Mar 2014 20:55:06 +0000
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Message-Id: <20140307205506.GA6870@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <531A1EEE.9090101@netscape.net>
In-Reply-To: <531A1EEE.9090101@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel Krause <manuelkrause@netscape.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, Mar 07, 2014 at 08:33:02PM +0100, Manuel Krause wrote:
> Please have a short look at the following BUG report + the comments
> -- this message here is a kind of FWD-ing it:
> https://bugs.archlinux.org/task/39005
>=20
> I came late to test kernel 3.13 with the .5 one, as it was the time
> that the related -CK/BFS patch became available.
>=20
> I'm not using Archlinux, but openSUSE, and my problems are quite the
> same. Especially these with smelling melting plastics.
>=20
> My own reports went to Con Kolivas' Blog first:
> "I get weird temperatures and abrupt 100% fan actions with vanilla
> 3.13.5 with this CK and most recent BFQ at my HP Notebook.
> In gkrellm the highest T had been @74=B0C, so far (3.12.13), and is
> now growing to 94=B0C. Then, the fan goes to 100% for 10~30secs
> cooling it to approx. 82=B0C.
> That is not good, if I compare 74 to 94 =B0C.
> Have I missed a .CONFIG option for 3.13, especially?"
>=20
> I'd get the same without (Con's && BFQ's) patches.
>=20
> Machine:           HP Notebook with Core2Duo CPU (Penryn)
> Distro:            openSUSE 13.1, 64bit, continuously updated
> Desktop:           KDE 4.12.3
> MESA & drm & Xorg: most recent ones from:
> http://download.opensuse.org/repositories/home:/pontostroy:/X11/openSUSE_=
13.1/x86_64/
>=20
> Current kernel:    3.13.6 vanilla from openSUSE repos, with
>                    -ck1 and BFQ patches
> Same behaviour:    without these patches
>=20
> Last good kernel:  3.12.13 vanilla + CK2 + BFQ
>=20

Can you add more information about your fan control policy ?
Do you rely on the hardware for automatic fan speed control,
or do you run the fancontrol script ?

What is the output from the 'sensors' command ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
