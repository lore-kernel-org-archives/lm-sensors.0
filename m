From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 Jan 2011 17:56:50 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <20110122185650.5d66d58e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jerry,

On Wed, 19 Jan 2011 10:52:04 -0800, Jerry Lin wrote:
> > Jerry, please try the stand-alone coretemp driver at:
> > =A0http://khali.linux-fr.org/devel/misc/coretemp/
> > This is basically the version from the latest kernel, with some
> > compatibility bits added so that it builds and runs on older kernels
> > too.
> >
> > Installation instructions can be downloaded from:
> > =A0http://khali.linux-fr.org/devel/misc/INSTALL
> > This is a document I just wrote, let me know if it contains errors or
> > can be improved in any way.
>=20
> Thanks for your instructions. I was able to follow your instructions
> until the make step, at which point I got:
>=20
> "Makefile:37: warning: overriding commands for target `modules_install'
> Makefile:29: warning: ignoring old commands for target `modules_install'
> /home/jerry/coretemp/Makefile:37: warning: overriding commands for
> target `modules_install'
> /home/jerry/coretemp/Makefile:29: warning: ignoring old commands for
> target `modules_install'
>   CC [M]  /home/jerry/coretemp/coretemp.o
> /home/jerry/coretemp/coretemp.c:572: warning: data definition has no
> type or storage class
> /home/jerry/coretemp/coretemp.c:572: warning: type defaults to =E2 in
> declaration of =E2
> /home/jerry/coretemp/coretemp.c:573: error: expected identifier or =E2
> before =E2 token
> /home/jerry/coretemp/coretemp.c:574:2: error: #endif without #if
> /home/jerry/coretemp/coretemp.c:576: error: expected declaration
> specifiers or =E2 before =E2 token
> /home/jerry/coretemp/coretemp.c:576: warning: data definition has no
> type or storage class
> /home/jerry/coretemp/coretemp.c:576: warning: type defaults to =E2 in
> declaration of =E2
>=20
> /home/jerry/coretemp/coretemp.c:576: warning: function declaration
> isn=E2t a prototype
> /home/jerry/coretemp/coretemp.c:577: error: expected identifier or =E2 be=
fore =E2
> /home/jerry/coretemp/coretemp.c:583: error: expected =E2, =E2, =E2, =E2 o=
r =E2
> before =E2 token
> /home/jerry/coretemp/coretemp.c:585: error: expected identifier or =E2
> before =E2 token
> /home/jerry/coretemp/coretemp.c:587: error: redefinition of =E2
> /home/jerry/coretemp/coretemp.c:550: note: previous definition of =E2 was=
 here
> /home/jerry/coretemp/coretemp.c:606: error: redefinition of =E2
> /home/jerry/coretemp/coretemp.c:570: note: previous definition of =E2 was=
 here
> /home/jerry/coretemp/coretemp.c:606: error: redefinition of =E2
> /home/jerry/coretemp/coretemp.c:570: note: previous definition of =E2 was=
 here
> /home/jerry/coretemp/coretemp.c:607: error: redefinition of =E2
> /home/jerry/coretemp/coretemp.c:571: note: previous definition of =E2 was=
 here
> /home/jerry/coretemp/coretemp.c:607: error: redefinition of =E2
> /home/jerry/coretemp/coretemp.c:571: note: previous definition of =E2 was=
 here
> make[2]: *** [/home/jerry/coretemp/coretemp.o] Error 1
> make[1]: *** [_module_/home/jerry/coretemp] Error 2
> make: *** [modules] Error 2"
>=20
> When I view the source via less, I don't see the "=E2" characters (I
> retrieved the source via wget).

There was apparently a data corruption, either over the network or on
the disk. I've uploaded the files again, they seem to have been
transferred properly this time, so please download them and try again.

> Questions:
> 1) Is there something I should do differently to get the module compiled?

No, you did the right thing but the source files were corrupted.

> 2) If I upgraded the kernel to 2.6.35, would most of my problems go
> away? (I can't easily do that right now because the machines are in
> use, but I can try to do that at the next maintenance window.)

Yes, it would help for the coretemp driver, which would work out of the
box. The jc42 driver only made it into kernel 2.6.36 though, so you
would still have to build that one out-of-tree. So overall I don't
think it's worth it.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
