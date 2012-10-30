From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 16:52:25 +0000
Subject: Re: [lm-sensors] drivers/hwmon/w83627ehf.c:2672 w83627ehf_resume() error: buffer overflow 'W83627EHF
Message-Id: <20121030165225.GB11394@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Oct 30, 2012 at 06:54:56AM -0700, Guenter Roeck wrote:
> On Tue, Oct 30, 2012 at 02:50:14PM +0100, Jean Delvare wrote:
> > On Tue, 30 Oct 2012 06:30:32 -0700, Guenter Roeck wrote:
> > > Hi Jean,
> > >=20
> > > On Tue, Oct 30, 2012 at 12:22:29PM +0100, Jean Delvare wrote:
> > > > Hi Peter,
> > > >=20
> > > > On Mon, 29 Oct 2012 21:58:47 +0100, Peter H=FCwe wrote:
> > > > > FYI, there are new smatch warnings show up in
> > > > >=20
> > > > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next master
> > > > > head:   8243aafc4f54244984d7ea707265e98810a3a066
> > > > > commit: 0110e1dd583ee412ccde1ba027dced6b828fb466 hwmon: (w83627eh=
f) Add support for suspend
> > > > > date:   32 hours ago
> > > > > :::::: branch date: 3 hours ago
> > > > > :::::: commit date: 32 hours ago
> > > > >=20
> > > > >   drivers/hwmon/w83627ehf.c:911 w83627ehf_update_device() error: =
buffer overflow 'W83627EHF_REG_TEMP_OFFSET' 3 <=3D 8
> > > > >   drivers/hwmon/w83627ehf.c:909 w83627ehf_update_device() error: =
buffer overflow 'data->temp_offset' 3 <=3D 8
> > > > > + drivers/hwmon/w83627ehf.c:2672 w83627ehf_resume() error: buffer=
 overflow 'W83627EHF_REG_TEMP_OFFSET' 3 <=3D 8
> > > > > + drivers/hwmon/w83627ehf.c:2673 w83627ehf_resume() error: buffer=
 overflow 'data->temp_offset' 3 <=3D 8
> > > > >=20
> > > > > git remote update next
> > > > > git checkout 0110e1dd583ee412ccde1ba027dced6b828fb466
> > > > > vim +2672 drivers/hwmon/w83627ehf.c
> > > > >=20
> > > > > 0110e1dd Jean Delvare 2012-10-25  2666                           =
                    data->temp_max[i]);
> > > > > 0110e1dd Jean Delvare 2012-10-25  2667                  if (data-=
>reg_temp_hyst[i])
> > > > > 0110e1dd Jean Delvare 2012-10-25  2668                          w=
83627ehf_write_temp(data, data->reg_temp_hyst[i],
> > > > > 0110e1dd Jean Delvare 2012-10-25  2669                           =
                    data->temp_max_hyst[i]);
> > > > > 0110e1dd Jean Delvare 2012-10-25  2670                  if (data-=
>have_temp_offset & (1 << i))
> > > > > 0110e1dd Jean Delvare 2012-10-25  2671                          w=
83627ehf_write_value(data,
> > > > > 0110e1dd Jean Delvare 2012-10-25 @2672                           =
                     W83627EHF_REG_TEMP_OFFSET[i],
> > > > > 0110e1dd Jean Delvare 2012-10-25 @2673                           =
                     data->temp_offset[i]);
> > > > > 0110e1dd Jean Delvare 2012-10-25  2674          }
> > > > > 0110e1dd Jean Delvare 2012-10-25  2675 =20
> > > > > 0110e1dd Jean Delvare 2012-10-25  2676          /* Restore other =
settings */
> > > > >=20
> > > > > I checked it and it seems valid.
> > > >=20
> > > > Actually this is a false positive, only the lower 3 bits of
> > > > data->have_temp_offset can be set so the write is never attempted w=
ith
> > > > i >=3D 3. However this isn't something a static code analyzer can e=
asily
> > > > figure out, so it would be better and safer to adjust the code to m=
ake
> > > > it more obvious. I'll send a patch.
> > >
> > > If you really want to patch it, there are more places like that; pret=
ty much
> > > every loop around the temperature registers is affected. I marked the=
 others
> > > as false positive quite some time ago.
> >=20
> > Marked how?
> >=20
> On coverity. Only looks like they changed the UI and I don't find the rep=
orts
> anymore :(. I'll try again later today.
>=20
Looks like it was only one case in update_device, and you fixed it in your
patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
