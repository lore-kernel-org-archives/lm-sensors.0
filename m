From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: sensord now installed, but --rrd-file argument is fatal
Message-Id: <20040403161916.GA22622@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Moving this to the lm_sensors list.

On Thu, Apr 01, 2004 at 07:59:45PM +0200, J G Miller wrote:
> I have installed the sensord package (which also caused the rrdtool
> package to be installed as well) but with the included startup argument
> to invoke rrd, sensord crashes
>=20
>    munmap(0x40000000, 4096)                =3D 0
>    stat64("/var/log/sensord.rrd", 0xbfffe15c) =3D -1 ENOENT (No such file=
 or directory)
>    time([1080841795])                      =3D 1080841795
>    open("/usr/share/zoneinfo/CET", O_RDONLY) =3D 3
>    fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeu5, ...}) =3D 0
>    mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=
 0) =3D 0x40000000
>    read(3, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"..., 4=
096) =3D 755
>    close(3)                                =3D 0
>    munmap(0x40000000, 4096)                =3D 0
>    rt_sigaction(SIGPIPE, {0x4ecffa30, [], SA_RESTORER, 0x4ec4e868}, {SIG_=
DFL}, 8) =3D 0
>    socket(PF_UNIX, SOCK_DGRAM, 0)          =3D 3
>    fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
>    connect(3, {sa_family=AF_UNIX, path=3D"/dev/log"}, 16) =3D 0
>    send(3, "<166>Apr  1 19:49:55 sensord: cr"..., 59, 0) =3D 59
>    rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) =3D 0
>    +++ killed by SIGSEGV +++
>=20
> Removing the --rrd-file /var/log/sensord.rrd argument from the startup
> line of sensord allowed sensord to startup, with logging going to the def=
ault
> syslog.
>=20
> Since no sensord.rrd file is created, it looks like there is a serious bug
> in the routines to create this file in the sensord executable.
>=20
> Since this is not a packaging issue, and unless you can offer any advice,
> I should probably report this as a bug to the lm-sensors developpers,
> since I cannot find this bug described at their site.

On Sat, Apr 03, 2004 at 05:33:42PM +0200, J G Miller wrote:
> >From the man page
>=20
>        -r, --rrd-file file
>=20
>            Specify a round-robin database into  which  to  log  all  sens=
or
>            readings;  e.g.,  `/var/log/sensord.rrd'.  This database will =
be
>            created if  it  does  not  exist.
>=20
> Since this feature is broken, it should not be the default setup in the
> installed /etc/init.d/sensord file.

I investigated this and sensord seems to not like using -a and -r
together (logging average load and logging to rrd). Try removing the
-a from the init.d script.

Is this a known problem? Any cure? :)
--=20
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040403=
/0e6fcc79/attachment.bin
