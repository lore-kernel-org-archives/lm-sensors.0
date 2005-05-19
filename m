From: max.maverick@maverick.eu.org (Benoit Plessis)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <Pine.LNX.4.44.0307181431480.5779-100000@anubis.univ-lemans.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 18 Jul 2003, Mark M. Hoffman (mhoffman@lightlink.com) wrote:

> * Jean Delvare <khali@linux-fr.org> [2003-07-16 14:53:29 +0200]:
> [..]
>
> Fan 2 works fine for me.  You probably need to increase the fan
> divisor in sensors.conf (maybe mbmon has a higher default value?)

it works for me but only after running mbmon, (maybe it's the
fact i'm using the 2.7.0 debian lm-sensor package).

> [..]
>
> The total of our support for ASB100 right now is to pretend that it's
> an as99127f.  If we're going to do more than that, my vote is to put
> it into a different file altogether.  Rationale...

it seem mbmon is using the same file for asb100 as99127f and
w83781d since they shared many fonctions.

> > I don't plan to make the changes myself, because I don't have a
> > motherboard with an ASB100 on it. I know Mark Hoffman does, so I guess
> > it would be easier for him to do the changes. If you have sufficent
> > knowledge, maybe you could help too?
>
> Bryan A, do you want to do this?  Have a look here for info:
>
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/new_drivers
>
> If not I will eventually get around to it.
>
> Regards,

I for myself will look around this WE, if i'm able to do
something i will send it monday.

--
Benoit Plessis					+33 6 77 42 78 32
<benoit.plessis@tuxfamily.org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76
