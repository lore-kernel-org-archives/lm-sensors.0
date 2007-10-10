From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 10 Oct 2007 17:12:05 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710101012s5e01f138t5b15c5c0954fc81d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hu Juergen,


On 10/9/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
>
> > -----Urspr=FCngliche Nachricht-----
> > Von: "Juerg Haefliger" <juergh@gmail.com>
> >
> > > Juerg, you could patch i2c-nforce2 to return more useful error codes.
> > > Such a patch could go upstream. Alternatively, building the i2c-nforc=
e2
> > > driver with CONFIG_I2C_DEBUG_BUS=3Dy may provide some hints.
> >
> > I was thinking of doing that. First I have to try to recreate the
> > problem on my machine.
> >
> > Juergen: Do you feel like recompiling i2c_nforce2 with debugging enable=
d?
> >
>
> This would require compiling a single module and exchanging it against th=
e default
> debian module? Then ist no problem. Is it ok to use the debian sources (2=
.6.18-5-k7)?

I believe so.


> And how to turn on debugging?

I don't know if there's an easier way but I usually do it the following way:
1) copy the i2c-nforce2.c file from the kernel source to a temp dir.
2) add a Makefile to the temp dir with the following content:

obj-m :=3D i2c-nforce2.o
EXTRA_CFLAGS +=3D -DDEBUG
all:
	make -C /lib/modules/`uname -r`/build M=3D`pwd` modules

3) compile the module by running make
4) reload the new module. You have to remove the dme1737 module before
unloading the i2c-nforce2 module.

...juerg



> Juergen
> _______________________________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
