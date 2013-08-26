From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 26 Aug 2013 12:13:26 +0000
Subject: Re: [lm-sensors] [RFC PATCH 01/14] cpufreq: cpufreq-cpu0: add dt node parsing for 'cooling-zones'
Message-Id: <521B4666.3050509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8495510903638146047=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com> <1377299755-5134-2-git-send-email-eduardo.valentin@ti.com> <CAKohpomuFWyH6ss4_L-0j9WyXtsZEygWrFLYXE6Oj_AD-DJUjA@mail.gmail.com>
In-Reply-To: <CAKohpomuFWyH6ss4_L-0j9WyXtsZEygWrFLYXE6Oj_AD-DJUjA@mail.gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, wni@nvidia.com, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>

--===============8495510903638146047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ePhlHHvf9knPPA6FoBMTfiBehuXBtURD7"

--ePhlHHvf9knPPA6FoBMTfiBehuXBtURD7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26-08-2013 00:42, Viresh Kumar wrote:
> On 24 August 2013 04:45, Eduardo Valentin <eduardo.valentin@ti.com> wro=
te:
>> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-=
cpu0.c
>> index ad1fde2..ede6487 100644
>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>> @@ -20,6 +20,9 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +#include <linux/cpu_cooling.h>
>> +#include <linux/cpumask.h>
>=20
> In alphabetical order please..
>=20

OK.

>> @@ -268,6 +272,13 @@ static int cpu0_cpufreq_probe(struct platform_dev=
ice *pdev)
>>                 goto out_free_table;
>>         }
>>
>> +       /*
>> +        * For now, just loading the cooling device;
>> +        * thermal DT code takes care of matching them.
>> +        */
>> +       if (of_find_property(np, "cooling-zones", NULL))
>> +               cdev =3D cpufreq_cooling_register(cpu_present_mask);
>=20
> Should we check if it passed or failed? And if failed Atleast flag an
> appropriate message?
>=20

Yes, we need error checking code. I will add in next version. Thanks Kuma=
r.

>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--ePhlHHvf9knPPA6FoBMTfiBehuXBtURD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIbRm0ACgkQCXcVR3XQvP2ItQD9FMwdPTChGTJS8wyntuj0OUYy
w1BiN+rFVWkcVLtDTGEA/3Tp9oX3NNQ8QvOACJmCKPSxfLtd7xgT/kGOOJzWdjbf
=YWgD
-----END PGP SIGNATURE-----

--ePhlHHvf9knPPA6FoBMTfiBehuXBtURD7--


--===============8495510903638146047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8495510903638146047==--
