From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Feb 2006 08:21:31 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <YgV7gDxq.1140769291.7006250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark, Juerg,

On 2006-02-24, Mark M. Hoffman wrote:
> > Thanks for the hint. You're right, I didn't have the "name" attribute
> > implemented but after fixing this, it still doesn't work. See the
> > strace output below, it looks like sensors is going after i2c-adapter
> > which of course is not there. Am I missing something here?
>
> Hmmm... I guess it's a libsensors bug - try this patch.
>
> Jean: comments?
>
> Index: lib/sysfs.c
> =================================> RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
> retrieving revision 1.4
> diff -u -r1.4 sysfs.c
> --- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
> +++ lib/sysfs.c	24 Feb 2006 05:23:58 -0000
> @@ -171,7 +171,7 @@
>  	int ret = 0;
> 
>  	if (!(cls = sysfs_open_class("i2c-adapter"))) {
> -		ret = -SENSORS_ERR_PROC;
> +		/* not an error - sensors completely without I2C is
> +                  possible */
>  		goto exit0;
>  	}

Seems so. I could reproduce the bug yesterday evening by removing all i2c
stuff from my kernel. I had never tried that before, because even on the
system where I can use a totally i2c-free hardware monitoring driver
(f71805f), I have other devices which use i2c (my DC10+ grabber).

I did not send a patch yesterday as I first wanted to make sure it would
work properly, and I was short of time for the additional tests. We need
to make sure that nowhere in the libsensors code we assumed that at
least one i2c adapter had been found. I'll look into it this evening.

Thanks Juerg for spotting and reporting the bug, hopefully we can fix it
shortly now.

--
Jean

