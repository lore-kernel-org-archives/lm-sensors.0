From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: SMSC 47M14x - where is the output?
Message-Id: <200406080814.i588Eg70028301@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086642878.5504.1239.camel@quickdraw.squawk.com>
In-Reply-To: <1086642878.5504.1239.camel@quickdraw.squawk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Nick,

First of all, congratulations for the much complete report. This is
exactly what we need to help you efficiently. Sometimes it takes 3 or 4
e-mail exchanges before we have enough data to understand what's going
on, while about anything I could need is already there in your case.

Here are the few bits that caught my attention:

>i2c-core.o: i2c core module
>i2c-proc.o version 2.6.1 (20010825)
>lm78.o version 2.6.5 (20020915)
>i2c-core.o: driver LM78(-J) and LM79 sensor driver registered.

You should not load lm78, you don't need it and it could cause trouble.

You are mixing versions of i2c (2.6.1) and lm_sensors (2.6.5). While it
may work in specific cases, it is known to cause trouble in various
cases. Is it what your kernel comes with by default? (i2c 2.6.1 is the
default in 2.4 kernels, but usually distributions including lm_sensors
would update it to at least 2.6.5, or whatever lm_sensors modules
version they are shipping.)

I am somewhat confused that you seem to consider these versions as
"new" and pretent you were using an older version before. For one
thing, the smsc47m1.c driver was first included in version 2.6.4 so it
can't be any older than that. I suspect that you are in fact refering
to the version of the user-space tools; see below.

>i2c-algo-pcf.o: i2c pcf8584 algorithm module
>i2c-elektor.o: i2c pcf8584-isa adapter module
>i2c-algo-bit.o: i2c bit algorithm module
>i2c-elv.o: i2c ELV parallel port adapter module
>i2c-algo-bit.o: i2c bit algorithm module
>i2c-philips-par.o: i2c Philips parallel port adapter module
>i2c-philips-par.o: attaching to parport0
>parport0: cannot grant exclusive access for device i2c-philips-par
>i2c-philips-par: Unable to register with parport.
>i2c-velleman.o: i2c Velleman K8000 adapter module
>i2c-velleman.o: Port 0x378 already in use.

You should also not load these (known as "undetectable adapters" by
sensors-detect). You don't have them and loading the drivers may
confuse your system. We now don't give the user the possibility to load
them anymore, so as to prevent this problem.

>Unable to handle kernel paging request at virtual address f091b398
> printing eip:
>f091b398
>*pde =3D 0191a067
>*pte =3D 00000000
>Oops: 0000
>i2c-isa i2c-i801 sr_mod i2c-dev i2c-philips-par i2c-algo-bit lm78
>i2c-proc i2c-core smbfs i810_audio ac97_codec soundcore radeon agpgart
>binfmt_misc nfsd lock
>CPU:    0
>EIP:    0060:[<f091b398>]    Not tainted
>EFLAGS: 00010286
>
>EIP is at __insmod_i2c-isa_S.data_L292 [i2c-isa] 0x1d58
>(2.4.22-1.2188.nptl)
>eax: 000000d1   ebx: 00000005   ecx: f0917560   edx: 000000d1
>esi: 0000000a   edi: e63b883c   ebp: e63b8800   esp: c4e05dd0
>ds: 0068   es: 0068   ss: 0068
>Process ksysguardd (pid: 4326, stackpage=C4e05000)
>Stack: e63b8800 00000035 f091b64c e63b8800 00000035 e63b8844 2534032c
>00000000
>       e63b883c e63b8800 c4e05e64 f091b88e e63b8800 eea200d1 00000000
>ffffffff
>       000000fa 000000e1 0000014a 000001f4 000004b0 0000014a c013a675
>c18be620
>Call Trace:   [<c013a675>] lru_cache_add [kernel] 0x65 (0xc4e05e28)
>[<f4d8c8e2>] i2c_sysctl_real_R8b6718e6 [i2c-proc] 0x122 (0xc4e05e40)
>[<c020a3af>] __kfree_skb [kernel] 0xef (0xc4e05eb4)
>[<c0259f2b>] unix_stream_recvmsg [kernel] 0x21b (0xc4e05ec4)
>[<c0122bba>] do_sysctl_strategy [kernel] 0x17a (0xc4e05ef8)
>[<c01227d3>] do_sysctl [kernel] 0x93 (0xc4e05f30)
>[<c0122899>] sys_sysctl [kernel] 0x89 (0xc4e05f68)
>[<c0109747>] system_call [kernel] 0x33 (0xc4e05fc0)
>
>
>Code:  Bad EIP value.

*This* is a problem. Never saw a kernel crash? That's what it looks
like. You have another one after that, seems to happen each time you
unload i2c-isa. I can't tell whether this is the fault of i2c-core or
i2c-isa, or both. What I am sure of is that i2c-core 2.6.1 is damn old
and I wouldn't be surprised if the problem was known and already fixed
in later versions (although I cannot seem to find any mention of
something similar in the logs). Or this could be caused by the version
difference between i2c-core and i2c-isa (although this shouldn't).

>root@quickdraw:~=07[root@quickdraw root]# rpm -q kernel
>kernel-2.4.22-1.2115.nptl
>kernel-2.4.22-1.2174.nptl
>kernel-2.4.22-1.2179.nptl
>kernel-2.4.22-1.2188.nptl
>root@quickdraw:~=07[root@quickdraw root]# uname -a
>Linux quickdraw.squawk.com 2.4.22-1.2188.nptl #1 Wed Apr 21 20:36:05 EDT
>2004 i686 i686 i386 GNU/Linux

I guess that this means that you are using the latest kernel available
from your distribution?

>=1B]0;root@quickdraw:~=07[root@quickdraw root]# rpm -q --whatprovides
>/usr/sbin/sensors-detect
>lm_sensors-2.8.1-1

This is interesting. You are using a fairly recent version of the
user-space tools, together with fairly old kernel drivers. Not that it
should cause problems, but I want you to realize that what really
matters, in most cases, is the kernel drivers version, not the
user-space tools version.

OK, these were my "generic" comments. Now for your specific problem, I
just found something interesting in smsc47m1.c's cvs log:
http://www2.lm-sensors.nu/~lm78/cvs/dumpcvs.cgi/lm_sensors2/kernel/chips/sm=
sc47m1.c
Take a look at revision 1.10's comment, it pretty well matches your
problem, doesn't it?

This means that you need to use kernel drivers from lm_sensors version >2.8=
.1, or hack the driver so that it recognizes your chip ID, at your
option. And I doubt that you ever got that chip to work without doing
either. Can you remember how you got it to work in the first place?

Jean Delvare
