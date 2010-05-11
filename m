From: Valdis.Kletnieks@vt.edu
Date: Tue, 11 May 2010 21:45:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] hwmon: (coretemp) Detect the
Message-Id: <31726.1273614319@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4990513065621723284=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095459.GA12190@owl> <20100510033525.GC9181@owl>
            <20100511080112.GB19762@owl>
In-Reply-To: Your message of "Tue, 11 May 2010 16:01:12 +0800."
             <20100511080112.GB19762@owl>
To: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, huaxu.wan@intel.com, Carsten Emde <Carsten.Emde@osadl.org>

--===============4990513065621723284==
Content-Type: multipart/signed; boundary="==_Exmh_1273614319_4002P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1273614319_4002P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2010 16:01:12 +0800, Huaxu Wan said:
> The thermal sensors of Intel(R) CPUs can be detected by CPUID instruction,
> indicated by CPUID.06H.EAX[0].
> 
> Signed-off-by: Huaxu Wan <huaxu.wan@linux.intel.com>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
> ---
>  drivers/hwmon/coretemp.c |   34 +++++++++++++---------------------
>  1 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index e9b7fbc..be0ddcf 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -451,28 +451,20 @@ static int __init coretemp_init(void)
> 
>         for_each_online_cpu(i) {
>                 struct cpuinfo_x86 *c = &cpu_data(i);
> +               /*
> +                * CPUID.06H.EAX[0] indicates whether the CPU has thermal
> +                * sensors. We check this bit only, all the early CPUs
> +                * without thermal sensors will be filtered out.
> +                */
> +               if (c->cpuid_level >= 6 && (cpuid_eax(0x06) & 0x01)) {
> +                       err = coretemp_device_add(i);
> +                       if (err)
> +                               goto exit_devices_unreg;

OK, that looks sane. :)  For what it's worth, feel free to stick on a

Reviewed-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--==_Exmh_1273614319_4002P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFL6c/vcC3lWbTT17ARAuBfAJ4plHpopKHZq+yHrj5jGUlyfp1tYgCfcVPw
lUkc3KUlaFp0+ACO9iAyEg4=
=vaAT
-----END PGP SIGNATURE-----

--==_Exmh_1273614319_4002P--



--===============4990513065621723284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4990513065621723284==--

