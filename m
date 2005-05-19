From: shiny_razor@hotmail.com (Kris Jones)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: i2c-2.7.0 compile errors... right place to ask?
Message-Id: <Law9-F97aQz8xckA1Qc0006cdb2@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Law9-F29F5TvMpR4YzQ0000e8ad@hotmail.com>
In-Reply-To: <Law9-F29F5TvMpR4YzQ0000e8ad@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

First off, I am a novice at kernel-related stuff, I've only compiled one a =

few times, and that was with lots of help, and I've never done anything wit=
h=20
modules.

So I was attempting this compile on a RH 8.0 box, but I ran up2date and=20
updated the kernel, so I don't think the source matches. I think that=20
might've been the cause of the problems on that one.

So I switched to a different box running RH 7.3, and I'm still getting=20
errors, but they seem to be a bit more rational. I believe it has something=
=20
to do with where the headers are installed, but I'm at a loss...

I'm running kernel 2.4.18-10 on it, and I downloaded the source from=20
ftp.kernel.org, gunzipped it and untarred it in /usr/src, so all the source=
=20
is located in /usr/src/linux.

I don't know what I should be doing to the kernel source from there, or if =
I=20
should be doing anything at all. I did a "make clean" there, but that's all.

So I go to the i2c source dir and do a "make clean" and then a "make=20
install" and I get this:
gcc -I/lib/modules/2.4.18-10/build/include -O2 -DLM_SENSORS -D__KERNEL__=20
-DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -c kernel/i2c-core.c -o=20
kernel/i2c-core.o
In file included from /usr/include/linux/module.h:20, from=20
kernel/i2c-core.c:26:
/usr/include/linux/modversions.h:1:2: #error Modules should never use=20
kernel-headers system headers,
/usr/include/linux/modversions.h:2:2: #error but rather headers from an=20
appropriate kernel-source package.
/usr/include/linux/modversions.h:3:2: #error Change -I/usr/src/linux/includ=
e=20
(or similar) to
/usr/include/linux/modversions.h:4:2: #error -I/lib/modules/$(uname=20
-r)/build/include
/usr/include/linux/modversions.h:5:2: #error to build against the=20
currently-running kernel.
kernel/i2c-core.c:43:25: asm/uaccess.h: No such file or directory
make: *** [kernel/i2c-core.o] Error 1

I looked at the paths in the Makefile, but they seem ok set to default.

Also, how do I know if i2c support is compiled into my kernel?

Thanks!
>From: "Mark D. Studebaker " <mds@paradyne.com>
>Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
>To: Kris Jones <shiny_razor@hotmail.com>
>CC: LM Sensors <sensors@stimpy.netroedge.com>
>Subject: Re: i2c-2.7.0 compile errors... right place to ask?
>Date: Sat, 21 Jun 2003 12:31:05 -0400
>
>
>
>Kris Jones wrote:
>>I've been trying to get lm_sensors to work for several days now, but I'm =

>>having the hardest time getting i2c to compile.
>>
>>I looked for a support forum mailing list or web-address, but this was=20
>>about the only one I found. Is this the right place to ask some questions=
=20
>>about compiling i2c?
>>
>
>
>yes. what's the problem?
>

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* =20
http://join.msn.com/?page=FEatures/virus
