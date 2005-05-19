From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Module license issues with i2c 2.6.2 & lm_sensors 2.6.2
Message-Id: <3C41BA6A.1148DE20@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1010847424.19120.0.camel@mail.1ar.org>
In-Reply-To: <1010847424.19120.0.camel@mail.1ar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- keywest we will be putting in a patch to sync with kernel 2.4.18
shortly,
that should cover it.

- piix4 the patch just moves it from top to bottom

- adm1024 was missed, thanks

- i2c modules missing GPL I omitted on purpose because there
  was no GPL boilerplate at the top of the file, we need to contact
  the authors to verify license status.

thanks
mds

Ajay Ramaswamy wrote:
> 
> These 2 patches add the MODULE_LICENSE(GPL) to all the remaining cases.
> Please consider applying.
> 
> regards
> Ajay
> 
> 
>                                 Name: i2c-modules-license.patch
>    i2c-modules-license.patch    Type: text/x-patch
>                             Encoding: quoted-printable
> 
>                                        Name: lm_sensors-modules-license.patch
>    lm_sensors-modules-license.patch    Type: text/x-patch
>                                    Encoding: quoted-printable
