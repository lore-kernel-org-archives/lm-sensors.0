From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Apr 2008 16:14:46 +0000
Subject: Re: [lm-sensors] [Patch] lm-sensors crash on non x86 hardware
Message-Id: <20080410181446.74f7a728@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080410171111.3f275bcb@de.ibm.com>
In-Reply-To: <20080410171111.3f275bcb@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Thu, 10 Apr 2008 17:11:11 +0200, Christian Krafft wrote:
> Hi,
> 
> Please consider this tiny patch for inclusion.
> It provides the user with more precise info.
> 
> Index: lm_sensors-2.10.0/prog/detect/sensors-detect
> =================================> --- lm_sensors-2.10.0.orig/prog/detect/sensors-detect
> +++ lm_sensors-2.10.0/prog/detect/sensors-detect

2.10.0 is old...

> @@ -5153,7 +5153,7 @@ sub main
>  
>    print "\nSome chips are also accessible through the ISA bus. ISA probes are\n".
>          "typically a bit more dangerous, as we have to write to I/O ports to do\n".
> -        "this. This is usually safe though.\n\n";
> +        "this. This is usually safe on x86 acrhitecture.\n\n";
>    if ($> != 0) {
>      print "As you are not root, we shall skip this step.\n";
>    } else {
> @@ -5167,7 +5167,7 @@ sub main
>  
>    print "\nSome Super I/O chips may also contain sensors. Super I/O probes are\n".
>          "typically a bit more dangerous, as we have to write to I/O ports to do\n".
> -        "this. This is usually safe though.\n\n";
> +        "this. This is usually safe on x86 acrhitecture.\n\n";
>    if ($> != 0) {
>      print "As you are not root, we shall skip this step.\n";
>    } else {

We already skip these probes on PPC:
http://www.lm-sensors.org/changeset/5125
Isn't it sufficient?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
