From: "Jean Delvare" <khali@linux-fr.org>
Date: Wed, 02 Jan 2008 14:22:12 +0000
Subject: Re: [lm-sensors] Intel D201GLY2, Winbond W83627DHG-B
Message-Id: <X1quru6W.1199283732.3577200.khali@gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4776808D.80202@freenet.de>
In-Reply-To: <4776808D.80202@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Le 29/12/2007, Rudolf Marek =E9crit:
>You have double times bad luck! For the coretemp driver you need
>following patch:
>http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mitdiff_plain;h=C940336b4403540c498fceb102c7142799252129
>
>(or newer kernel)
>
>And for w83627ehg:
>
>Loading the module 'w83627ehf' writes "kernel: w83627ehf:
>unsupported chip ID: 0xffff" to /var/log/syslog.
>
>This is in fact harmful, your chip is on secondary address (0x4e) so the
>driver is really loaded(this is fixed already). What is a problem is too o=
ld
>libsensors3 library.
>
>See:
>
>    # sensors
>    w83627dhg-i2c-9191-290
>     ERROR: Can't get adapter or algorithm?!?
>
>This means if you go to /sys/class/hwmon/hwmon0/ dir you will see the
>files there. So you can check the temp?_input directly there. I would
>suggest upgrading the lm-sensors package to something newer. Please
>check the CHANGES maybe it will be documented what version you need.

He'll need lm-sensors >=3D 2.10.2 for W83627DHG (and coretemp) support,
and >=3D 2.10.3 for the bogus chip name and the warning to go away.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
