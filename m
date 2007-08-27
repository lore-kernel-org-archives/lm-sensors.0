From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 27 Aug 2007 21:26:16 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0708271426j9ed48ccpfa1eb48b99ff00b3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


> Juerg Haefliger <juergh <at> gmail.com> writes:
>
> >
> > > I own a barebone made by asus which needs the dme1737 module for
> > > lm-sensors to work correctly. Since it had been included in kernel
> > > 2.6.23 and I am running 2.6.18 (from
> > > debian etch) I was wondering if there is a stand alone version
> > > of the module, that I could
> > > compile for my kernel? Is there any way to use it with 2.6.18?
> >
> > Copy the file dme1737.c from the 2.6.23 kernel to a temp directory and
> > create a Makefile in the same directory that contains the following
> > lines:
> >
> > obj-m :=3D dme1737.o
> > all:
> >         make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules
> >
> > Then run 'make' which will compile the module. You also need to have
> > the kernel headers installed to be able to compile.
> > Additionally, you will also need the latest 'lm-sensors' package
> > (2.10.4 ) or the dme1737 will not be recognized.
> >
>
> Thanks a lot, the module seems to work fine. I used the newest sensors-de=
tect
> and it found out the modules I have to use. However, the output of sensors
> is quite short:
>
> jba@lisa:~$ sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>               -1=B0C
> Core0 Temp:
>               +1=B0C
> Core1 Temp:
>               +6=B0C
> Core1 Temp:
>               +6=B0C
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 4c00
>
> k8temp values are wrong, but that is another problem. But why doent
> dme1737 display anything? Is it because of the older lm-sensors version in
> debian (2.10.1-3). Or will it be sufficiant to update the config file?
> If possible I would like to keep the etch version of lm-sensors.

You need a newer lm-sensors. 2.10.1 doesn't know about the dme1737.
Just updating the config file is not enough.

...juerg


> Juergen
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
