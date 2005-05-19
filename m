From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Restore compatibility with 2.4 kernels
Message-Id: <ac921f990503081235345ad520@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308142854.GA31643@bode.aurel32.net>
In-Reply-To: <20050308142854.GA31643@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 8 Mar 2005 21:12:16 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Hi James,
>=20
> > In particular I was still seeing panics when unloading sensors
> > drivers.   It seems to fix this.
>=20
> I thought 2.9.0 had fixed the problem?
>=20
Nope, not always.   It made it far more infrequent, but over the weeks
that passed we discovered it did not completely make the problem go
away.  I have output from a panic you would like to see it.

> I'm a bit surprised that Aurelien's patch would help with sensors.
> Supposedly the problem is the lack of binary compatibility between i2c
> 2.9.0 and in-kernel i2c. If you use lm_sensors 2.9.0 then you must use
> i2c 2.9.0 as well, so what Aurelien's patch would address are problems
> with in-kernel, non-sensors i2c stuff such as media/video drivers.
>=20
Well, I missed it too, but Dave Knierim (my partner in crime), noticed
this paragraph
in Aurelian's email:

     But there is one more semaphore in i2c, called list, used to lock the
     list of i2c clients. This one is not present in the kernel, as this
     list was not locked in i2c 2.7.0 and previous versions. I supposed it
     has been added due to some race conditions that have been observed, so=
 I
     choosed to use the same semaphore as for i2c transfer to lock the clie=
nts
--->list. It has the drawback to not allow an i2c transfer while
--->adding/removing a client or to not allow adding a new client during an
--->i2c transfer. I don't consider that as a problem, as adding/removing a
     client does not happen so often. I have also checked that not i2c
     transfers are asked between too lock of the list.

That is what Dave noticed, which sounded like it would completely
remove the opportunity for someone to read the proc entries while the
driver was going away, and it seems to work.
But then I might have missed something .

And I am pretty sure we don't use the in-kernel i2c stuff as I
specifically turn off the building of all of those driverers and all
things i2c and lm_sensors in our kernel that we build.  Mainly because
we build i2c and lm_sensors as seperate rpms so we can easily build it
right from your CVS, but still have all the modules go to all the same
places.

Like I said, though, it seems to have fixed the panics, but I won't
_really_ know for days, as I have yet to figure out a sequence that
would guarantee it once we switched to 2.9.0.

Here is the output from a bonified 2.9.0 panic while unloading drivers
as someone is trying to read its proc entries:

   localhost.localdomain login: Unable to handle kernel paging request
at virtual a
   ddress f8a88293
   *pde =3D 4057989c
   Oops: 0000
   eeprom smsc47m1 i2c-i801 i2c-isa i2c-proc i2c-dev i2c-core segled
power pciclock
   s leds autofs4 mpc iptable_filter ip_tables e1000 i810-tco microcode ide=
-scsi
   CPU:    1
   EIP:    0060:[<f8a88293>]    Tainted: P
   EFLAGS: 00010296

   EIP is at __insmod_i2c-i801_S.bss_L16 [i2c-i801] 0x3c4b
(2.4.21-27.0.2.ELprerel2
   .0.0_50.2.0smp/i686)
   eax: 000000b6   ebx: 00000000   ecx: f8a84440   edx: 000000b6
   esi: 00000001   edi: 0000002c   ebp: f687ab80   esp: f5f9fd94
   ds: 0068   es: 0068   ss: 0068
   Process sensors (pid: 10359, stackpage=F5f9f000)
   Stack: f687ab80 0000002c c0158dcd c4f25c80 00000202 00000000
000001d2 00000000
          00000000 f687ab80 f687ab80 f8a883e6 f687ab80 0000002c
00000282 fff96000
          00000000 fff96280 f687abc4 f687ab80 f5f9fe60 00000000
c3526eec f8a88d19
   Call Trace:   [<c0158dcd>] __alloc_pages_limit [kernel] 0x7d (0xf5f9fd9c)
   [<c0143348>] do_no_page [kernel] 0x368 (0xf5f9fdf8)
   [<f8a7a790>] i2c_sysctl_real_Rsmp_e7981530 [i2c-proc] 0xe0 (0xf5f9fe10)
   [<f8a7a702>] i2c_sysctl_real_Rsmp_e7981530 [i2c-proc] 0x52 (0xf5f9fe30)
   [<c0143971>] handle_mm_fault [kernel] 0xd1 (0xf5f9fec0)
   [<c0130c05>] do_sysctl_strategy [kernel] 0x175 (0xf5f9ff00)
   [<c0130803>] do_sysctl [kernel] 0x93 (0xf5f9ff38)
   [<c01308bf>] sys_sysctl [kernel] 0x7f (0xf5f9ff70)

   Code: Bad EIP value.

   Kernel panic: Fatal exception
   lm87.o version 2.9.0 (20041228)
   lm87.o version 2.9.0 (20041228)
   lm87.o version 2.9.0 (20041228)

Not really sure my the module printed is name and version 3 times, but
it really did.

Cheers...james
> --
> Jean Delvare
>
