From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH] UTF-8 fix
Message-Id: <20040131113326.4886e054.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040130170803.GA9376@penguin.localdomain>
In-Reply-To: <20040130170803.GA9376@penguin.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors doesn't print degree sign correctly on utf-8 console. This
> patch fixes it.

Hi Sebek,

Interesting patch. I'm not using UTF-8 but believe many people do and
will appreciate the change you propose.

I took a look at the patch itself and I won't accept it as is, because
of the code duplication it adds. First because there are three places
where you have to "intercept" temperature prints (common, lm92 and lm80,
which you forgot BTW). Second because you have to handle both Celcius
and Farhenheit each time. I of course do not blame you, but ourselves,
for that, since this is the base code that is bad.

I changed that by centralizing the construction of the "degrees" string
in a single place (in main.c, because it is in no way chip dependant). I
just commited the change to CVS.

I would appreciate it much if you could checkout our CVS code (module
lm_sensors2) and submit a new patch based on it. You should only need to
intervene in one place (where degstr is built, in main.c), which will
make the patch much cleaner IMHO.

I don't do it myself because 1* I'd like you to test the change I just
made and 2* I couldn't test the UTF-8 thing, so your help is needed
anyway.

Thanks.

> 
> 
> diff -urN lm_sensors2/CHANGES lm_sensors2-new/CHANGES
> --- lm_sensors2/CHANGES	2004-01-24 14:51:11.000000000 +0100
> +++ lm_sensors2-new/CHANGES	2004-01-30 13:00:13.000000000 +0100
> @@ -31,6 +31,7 @@
>                     Drop linux 2.2 support
>                     Add w83627hf
>    Program sensors: Do not show algorithm by default
> +                   Fix output to UTF-8 console
>    Program sensors-detect: Fix PATH issues
>    
>  
> diff -urN lm_sensors2/prog/sensors/chips.c
> lm_sensors2-new/prog/sensors/chips.c---
> lm_sensors2/prog/sensors/chips.c	2004-01-27 18:19:03.000000000 +0100+++
> lm_sensors2-new/prog/sensors/chips.c	2004-01-30 12:59:05.000000000 +0100@@ -34,6 +34,7 @@
>  static inline float deg_ctof( float );
>  
>  extern int fahrenheit;
> +extern int utf8;
>  
>  char *spacestr(int n)
>  {
> @@ -65,12 +66,18 @@
>     char degv[5];
>  
>     if (fahrenheit) {
> -      sprintf(degv, "%cF", 176);
> +      if (utf8)
> +        sprintf(degv, "%c%cF", 0xc2, 0xb0);
> +      else
> +        sprintf(degv, "%cF", 176);
>        n_cur  = deg_ctof(n_cur);
>        n_over = deg_ctof(n_over);
>        n_hyst = deg_ctof(n_hyst);
>     } else {
> -      sprintf(degv, "%cC", 176);
> +      if (utf8)
> +        sprintf(degv, "%c%cC", 0xc2, 0xb0);
> +      else
> +        sprintf(degv, "%cC", 176);
>     }
>  
>  /* use %* to pass precision as an argument */
> @@ -4065,13 +4072,19 @@
>  	char suffix[5];
>  
>  	if (fahrenheit) {
> -		sprintf (suffix,"%cF",176);
> +		if (utf8)
> +			sprintf (suffix,"%c%cF",0xc2,0xb0);
> +		else
> +			sprintf (suffix,"%cF",176);
>  		n_cur = deg_ctof (n_cur);
>  		n_high = deg_ctof (n_high);
>  		n_low = deg_ctof (n_low);
>  		n_crit = deg_ctof (n_crit);
>  		n_hyst = deg_ctof (n_hyst);
> -	} else sprintf (suffix,"%cC",176);
> +	} else if (utf8)
> +		sprintf (suffix,"%c%cC",0xc2,0xb0);
> +	else
> +		sprintf (suffix,"%cC",176);
>  
>  	printf ("%+6.4f%s (high = %+6.4f%s, low = %+6.4f%s, crit >  	%+6.4f%s, hyst = %+6.4f%s)",
>  			n_cur,suffix,
> diff -urN lm_sensors2/prog/sensors/main.c
> lm_sensors2-new/prog/sensors/main.c--- lm_sensors2/prog/sensors/main.c	2004-01-25
> 19:56:52.000000000 +0100+++ lm_sensors2-new/prog/sensors/main.c	2004-01-30 12:59:05.000000000 +0100
> @@ -22,6 +22,8 @@
>  #include <getopt.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <locale.h>
> +#include <langinfo.h>
>  
>  #include "lib/sensors.h" 
>  #include "lib/error.h"
> @@ -53,6 +55,7 @@
>  sensors_chip_name chips[CHIPS_MAX];
>  int chips_count=0;
>  int do_sets, do_unknown, fahrenheit, show_algorithm, hide_adapter,
>  hide_unknown;
> +int utf8;
>  
>  void print_short_help(void)
>  {
> @@ -167,6 +170,13 @@
>      { 0,0,0,0 }
>    };
>  
> +  setlocale(LC_CTYPE, "");
> +
> +  if (strcmp(nl_langinfo(CODESET), "UTF-8") = 0)
> +    utf8 = 1;
> +  else
> +    utf8 = 0;
> +
>    do_unknown = 0;
>    do_sets = 0;
>    show_algorithm = 0;
> 
> 
> -- 
> Marcel Sebek
> jabber: sebek@jabber.cz                     ICQ: 279852819
> linux user number: 307850                 GPG ID: 5F88735E
> GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E
> 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
