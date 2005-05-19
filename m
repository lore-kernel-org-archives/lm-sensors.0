From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: [PATCH] Segfault fixed
Message-Id: <20020807134036.52ca8cc9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020805165608.GA10003@dreamland.darkstar.net>
In-Reply-To: <20020805165608.GA10003@dreamland.darkstar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Running  "sensors -c"  without any  argument gives  a segfault. This 
> is caused by a wrong optstring passed to getopt_long. The fix is
> trivial:
> 
> 
> --- main.c~	Wed Jul 10 13:57:13 2002
> +++ main.c	Mon Aug  5 18:50:57 2002
> @@ -158,7 +158,7 @@
>    do_sets = 0;
>    hide_adapter = 0;
>    while (1) {
> -    c = getopt_long(argc,argv,"hsvfAcu:",long_opts,NULL);
> +    c = getopt_long(argc,argv,"hsvfAc:u:",long_opts,NULL);
>      if (c = EOF)
>        break;
>      switch(c) {

Exact, the fault is mine. I introduced this bug when adding the -A flag.
The correct string is even "hsvfAc:u" (I moved the column from c to u).
Shame on me.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
