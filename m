From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 19 Mar 2008 01:06:59 +0000
Subject: Re: [lm-sensors] Strange temperature values
Message-Id: <Pine.LNX.4.64.0803181958560.9251@birdbird.example.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="655872-1328205256-1205888819=:9251"
List-Id: <lm-sensors.vger.kernel.org>
References: <47DFA4D2.1060009@givemefish.com>
In-Reply-To: <47DFA4D2.1060009@givemefish.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--655872-1328205256-1205888819=:9251
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 18 Mar 2008, lists@givemefish.com wrote:
> However, the sensor values that we see are very strange.  They are
> all positive values, but they range from 0 to 2500 C.

There was some recent discussion about updating some of the drivers to
deal with hardware that reports values with 0.001 deg C resolution
rather than the more common 0.1 deg C resolution.  I am not sure but I
think some Intel boards were affected by this.  In other words, dividing
your reported temperatures by 100 may give you the actual values.

> temp1:     +71.0=B0C  (high =3D   +50=B0C, hyst =3D    +0=B0C)
0.71 C (probably not connected)

> temp2:      +0.0=B0C  (high =3D   +50=B0C, hyst =3D    +0=B0C)
> temp3:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +2=B0C)
0 C (probably not connected)

> temp4:    +1780.0=B0C  (high =3D    +0=B0C, hyst =3D    +2=B0C)
17.80 C

> temp5:    +1860.0=B0C  (high =3D    +0=B0C, hyst =3D    +2=B0C)
18.60 C

> temp6:    +1940.0=B0C  (high =3D    +0=B0C, hyst =3D    +2=B0C)
19.40 C

> temp7:    +720.0=B0C  (high =3D    +8=B0C, hyst =3D    +0=B0C)
0.72 C (probably not connected)

> temp8:    +2520.0=B0C  (high =3D   +66=B0C, hyst =3D    +2=B0C)
25.20 C

If the machine is sitting in an air-conditioned data center, those
values don't seem out of line.

> # sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

The latest version of sensors-detect is "5108 (2008-01-22 13:22:47
+0100)"; you may get better results from a newer version of the
complete lm-sensors package if possible.

Matt Roberds

--655872-1328205256-1205888819=:9251
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--655872-1328205256-1205888819=:9251--
