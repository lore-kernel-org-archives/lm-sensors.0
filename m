From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 14 May 2009 19:07:35 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <4A0C6BF7.9010107@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,



I'm posting this to mailing list. I did no changes a long time. I need to check
that. In the meanwhile can you give me an output of "cpuid" utility.

Thanks,
Rudolf





Gnu Belarusian wrote:
> Hallo!
> 
> Module hwmon_vid (drivers/hwmon/hwmon-vid.c) from linux-2.6.29(.3) returns  
> incorrect voltage for my CPU from it8716f sensor (real/2). 
> With module from 2.6.26 voltage is correct.
> 
> Code changed between versions:
> 
>  int vid_from_reg(int val, u8 vrm)
>  {
>         int vid;
> @@ -96,9 +102,16 @@
>                 if (val < 0x02 || val > 0xb2)
>                         return 0;
>                 return((1600000 - (val - 2) * 6250 + 500) / 1000);
> -       case 24:                /* Opteron processor */
> +
> +       case 24:                /* Athlon64 & Opteron */
>                 val &= 0x1f;
> -               return(val = 0x1f ? 0 : 1550 - val * 25);
> +               if (val = 0x1f)
> +                       return 0;
> +                               /* fall through */
> +       case 25:                /* AMD NPT 0Fh */
> +               val &= 0x3f;
> +               return (val < 32) ? 1550 - 25 * val
> +                       : 775 - (25 * (val - 31)) / 2;
> 
> May be you should revert old code.
> 
> My CPU is AMD BE-2350 stepping 01. IT87 sensor: IT8716F chip at 0x228, revision 0.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoMa/QACgkQ3J9wPJqZRNWzWwCfco9A7j9dMJhVoeFaHcgS6QSp
vmkAn2l+5gDcPnsSbsa7/AKCpbLCtM/I
=pf/j
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
