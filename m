From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 22 Aug 2007 16:11:13 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,

I'm copying the list so others can profit.


> Dear Juerg,
>
> I own a barebone made by asus which needs the dme1737 module for lm-senso=
rs to
> work correctly. Since it had been included in kernel 2.6.23 and I am runn=
ing 2.6.18 (from
> debian etch) I was wondering if there is a stand alone version of the mod=
ule, that I could
> compile for my kernel? Is there any way to use it with 2.6.18?

Copy the file dme1737.c from the 2.6.23 kernel to a temp directory and
create a Makefile in the same directory that contains the following
lines:

obj-m :=3D dme1737.o
all:
        make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules

Then run 'make' which will compile the module. You also need to have
the kernel headers installed to be able to compile.
Additionally, you will also need the latest 'lm-sensors' package
(2.10.4 ) or the dme1737 will not be recognized.

Let me know if you need additional help.
...juerg


> J=FCrgen
> _______________________________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
