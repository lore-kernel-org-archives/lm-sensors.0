From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Installation   lm_sensors-2.9.0, sur Suse 9.2 , noyau 2.6
Message-Id: <20050213142050.7f2b11c0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502131137.43844.jackie_lola@yahoo.fr>
In-Reply-To: <200502131137.43844.jackie_lola@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jacqueline,

> Thank you for your answer 
> 
>  With  "make user" i  got an error...  but  i think i was was not in
>  the good directory... 

You *need* to be in the "root" lm_sensors directory when running that
command.

> I don't have any explication about "user", in man make. I dont
> understand what  it is ?

The values you pass after "make" are known as "targets". They are a way
to tell make what we want it to do. When you type only "make", a default
target is used. Each project is free to name its targets any way it
wants. Our default target is fine for 2.4 kernels, but not for 2.6
kernels (the default target makes too many things), so we added a "user"
target for 2.6 kernel, which only build the user-space tools.

> jackie@ip-10:~> su root
> Password:
> ip-10:/home/jackie # make user
> make: *** Pas de r?gle pour fabriquer la cible ? user ?. Arr?t.
> ip-10:/home/jackie # make user_install
> make: *** Pas de r?gle pour fabriquer la cible ? user_install ?.
> Arr?t. ip-10:/home/jackie #
> 
> I hope my system is not bad now.. Is it possible to clean it, before
> another  try.

Don't worry about your system, you cannot break anything with these
errors.

All you have to do is run "make user" and "make user_install" in the
correct directory: the lm_sensors root directory.

Hope that helps,
-- 
Jean Delvare
