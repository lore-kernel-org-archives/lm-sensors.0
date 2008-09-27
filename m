From: Forest Bond <forest@alittletooquiet.net>
Date: Sat, 27 Sep 2008 20:57:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <20080927205736.GB25140@storm.local.network>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1008415002510365364=="
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============1008415002510365364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Juerg,

On Sun, Sep 07, 2008 at 11:32:17AM -0700, Juerg Haefliger wrote:
> On Fri, Sep 5, 2008 at 11:45 AM, Forest Bond <forest@alittletooquiet.net>=
 wrote:
>> On Thu, Jul 10, 2008 at 08:08:16AM +0200, Wilken Gottwalt wrote:
>>> Am Montag 07 Juli 2008 19:29:00 schrieb Juerg Haefliger:
>>>>> Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
>>>>>>> It's the Artigo-Box from Via with a PX10000 board
>>>>>>> (http://www.via.com.tw/en/products/embedded/artigo/).
>>>>>>> No, there are no bios settings dealing with thermal or power
>>>>>>> management. There is nothing I can play with. The bios is very
>>>>>>> rudimentary.

[...]

>>>> I'll try to get some answers from VIA but I'm out of ideas. Looks like
>>>> your CPU doesn't have those thermal sensors.
>>>
>>> This is weird, it's a plain C7.
>>
>> Anybody get anywhere with this?  I'm trying to get some useful data out =
of the
>> Pico-ITX boards as well.
>=20
> Yes I did receive some information from VIA but I haven't had a chance
> yet to fully digest it. From the quick glance that I took, it looks
> like there are different C7 models and the thermal sensors are
> disabled depending on the model. VIA provided some sample BIOS code
> but I need to take a closer look to fully understand it. More later.

Just following up.  Anything new to report here?  Can I do anything to help=
 get
this moving?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI3p5ARO4fQQdv5AwRAqquAJ4/oa5K/MORHW/7UJCXjMHVlIg78ACgnzjr
GLguLdY0Yb80I+ZFGL/BeRI=
=o0oK
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


--===============1008415002510365364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1008415002510365364==--
