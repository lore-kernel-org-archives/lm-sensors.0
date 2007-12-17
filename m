From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 17 Dec 2007 19:14:25 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0712171114w2027a0fg30322e979ee0c95f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Werner,


On Dec 16, 2007 2:41 PM, Werner Goebl <werner.goebl@mail.mcgill.ca> wrote:
> Dear Juerg,
>
> I am running Gutsy on an Optiplex 745 (Kernel 2.6.22-14,
> Intel Q965 chipset) and in order to quiet my always spinning
> fan, I wanted to add the dme1737 module to my old kernel.
> So, I did what you suggested (copy dmel1713.c + create
> Makefile).
>
> When I type "make" it says:
> "make: Nothing to be done for `all'."

Make sure you're using tabs and not whitespaces in your makefile. I.e.:

all:
<TAB>make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules


>
> BTW: You mention to have "the kernel headers intalled to be
> able to compile". Are you referring to "Kconfig" and
> "Makefile" in
> /usr/src/linux-headers-2.6.22-14/drivers/hwmon? (which I
> updated according to
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=9431996f55f8a3c04cdcb63895cf7661e135fadb

No that's not what I meant. What you need are the kernel headers that
are part of the kernel source (or devel) package for your
distribution. Check the /lib/modules/`uname -r`/build directory. If
you find header files in that tree you're all set. Otherwise you have
to locate the package that provides these header files. For Ubuntu,
the package name is something like 'linux-headers-2.6.22-14'.

...juerg


> Thanks for your patience!!
>
> Werner
>
> ---------------------------------------------
> From: Juerg Haefliger <juergh <at> gmail.com>
> Subject: Re: dme1737 module
> Newsgroups: gmane.linux.drivers.sensors
> Date: 2007-08-22 16:11:13 GMT (16 weeks, 4 days, 5 hours and
> 35 minutes ago)
>
> Hi Juergen,
>
> I'm copying the list so others can profit.
>
>
>  > Dear Juerg,
>  >
>  > I own a barebone made by asus which needs the dme1737
> module for lm-sensors to
>  > work correctly. Since it had been included in kernel
> 2.6.23 and I am running 2.6.18 (from
>  > debian etch) I was wondering if there is a stand alone
> version of the module, that I could
>  > compile for my kernel? Is there any way to use it with
> 2.6.18?
>
> Copy the file dme1737.c from the 2.6.23 kernel to a temp
> directory and
> create a Makefile in the same directory that contains the
> following
> lines:
>
> obj-m :=3D dme1737.o
> all:
>          make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules
>
> Then run 'make' which will compile the module. You also need
> to have
> the kernel headers installed to be able to compile.
> Additionally, you will also need the latest 'lm-sensors' package
> (2.10.4 ) or the dme1737 will not be recognized.
>
> Let me know if you need additional help.
> ...juerg
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
