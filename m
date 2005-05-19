From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Installation   lm_sensors-2.9.0, sur Suse 9.2 , noyau 2.6
Message-Id: <20050213114930.32baaea3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502131137.43844.jackie_lola@yahoo.fr>
In-Reply-To: <200502131137.43844.jackie_lola@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jacqueline,

> Impossible to install with the two commands  make user and make
> user_install.
>  I have a mother board  Asus P4PE-X with Pentium Celeron 2,4 Ghz
> 
> 
> When in the good rep :
> 
> ip-10:/home/jackie/Documents/Paquetages/Ksensors/lm_sensors-2.9.0/lm_
> sensors-2.9.0
>  
> Doing :  make 
> 
> here is the second part of errors message.

Hm, you are supposed to run "make user", *not* "make". What happens when
you run "make user"?

-- 
Jean Delvare
