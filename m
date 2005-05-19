From: jeff.kosowsky@verizon.net (Jeffrey J. Kosowsky)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Following up on ticket: 1108
Message-Id: <15975.35668.184684.840621@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Haven't seen much "news" on the homepages and was just wondering where
things stand and what I might be able to do to help.

Thanks,
Jeff
------------------------------------------------------------

Problem in detail:

I am a newbie at lm_sensors, so please forgive me if I am doing something=20
stupid :)

I have an ASUS p4pe motherboard which according to http://mbm.livewiredev.c=
om/=20
has the ASB100 chipset which apparantly is supported by driver w83781d=20
according to the "new drivers" page for versions >2.6.5.

When I run sensors-detect I get that all probes fail including the one for =
the=20
28381d driver. e.g.,
  Probing for =1B%G=1B$,3u=3D=1B(B=1B%@Winbond W83781D=1B%G=1B$,3u=3D=1B(B=
=1B%@
    Trying address 0x0290... Failed!
  Probing for =1B%G=1B$,3u=3D=1B(B=1B%@Winbond W83782D=1B%G=1B$,3u=3D=1B(B=
=1B%@
    Trying address 0x0290... Failed!

I then get the following output
  #----cut here----
  # I2C adapter drivers
  # I2C chip drivers
  #----cut here----

  #----cut here----
  # I2C module options
  alias char-major-89 i2c-dev
  #----cut here----

When I run =1B%G=1B$,3u=3D=1B(B=1B%@sensors -s=1B%G=1B$,3u=3D=1B(B=1B%@, I =
get "No sensors found"

Any thoughts on what is going wrong here?

I am using a stock unpatched 2.4.20 kernel under RH8.0.(i2c support is comp=
iled=20
in as a module). I also tried separately making and installing the drivers =
from=20
the i2c-2.7.0 package without any success.

I am using lm_sensors-2.6.5-3 which I installed as an RPM that I got off of=
=20
freshrpms.net.

Reply from support:

we have several reports that the ASB100 support doesn=B4t work,
sorry. We=B4re working on it but it may be a few weeks.
