From: Werner Goebl <werner.goebl@mail.mcgill.ca>
Date: Sun, 16 Dec 2007 22:41:59 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <4765A9B7.5030106@mail.mcgill.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Juerg,

I am running Gutsy on an Optiplex 745 (Kernel 2.6.22-14,=20
Intel Q965 chipset) and in order to quiet my always spinning=20
fan, I wanted to add the dme1737 module to my old kernel.
So, I did what you suggested (copy dmel1713.c + create=20
Makefile).

When I type "make" it says:
"make: Nothing to be done for `all'."

BTW: You mention to have "the kernel headers intalled to be=20
able to compile". Are you referring to "Kconfig" and=20
"Makefile" in=20
/usr/src/linux-headers-2.6.22-14/drivers/hwmon? (which I=20
updated according to
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=9431996f55f8a3c04cdcb63895cf7661e135fadb

Thanks for your patience!!

Werner

---------------------------------------------
From: Juerg Haefliger <juergh <at> gmail.com>
Subject: Re: dme1737 module
Newsgroups: gmane.linux.drivers.sensors
Date: 2007-08-22 16:11:13 GMT (16 weeks, 4 days, 5 hours and=20
35 minutes ago)

Hi Juergen,

I'm copying the list so others can profit.


 > Dear Juerg,
 >
 > I own a barebone made by asus which needs the dme1737=20
module for lm-sensors to
 > work correctly. Since it had been included in kernel=20
2.6.23 and I am running 2.6.18 (from
 > debian etch) I was wondering if there is a stand alone=20
version of the module, that I could
 > compile for my kernel? Is there any way to use it with=20
2.6.18?

Copy the file dme1737.c from the 2.6.23 kernel to a temp=20
directory and
create a Makefile in the same directory that contains the=20
following
lines:

obj-m :=3D dme1737.o
all:
         make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules

Then run 'make' which will compile the module. You also need=20
to have
the kernel headers installed to be able to compile.
Additionally, you will also need the latest 'lm-sensors' package
(2.10.4 ) or the dme1737 will not be recognized.

Let me know if you need additional help.
...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
