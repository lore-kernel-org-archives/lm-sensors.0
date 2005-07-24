From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Jul 2005 18:02:11 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <20050724180208.1515133e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> I was poking around to see if could grok the sysfs api support
> that would allow replacing the long lists of
>                 device_create_file(&new_client->dev,
>                 &dev_attr_inX_input);
> 
> with something like:
>     for(i=0; i<vpoints_max; i++) {
>                 device_create_file(&new_client->dev,
>                 &dev_attr_in[i].in);
>                 device_create_file(&new_client->dev,
>                 &dev_attr_in[i].max);
>                 device_create_file(&new_client->dev,
>                 &dev_attr_in[i].min);
>     }
> 
> looking at it again now, it appears to hinge upon doing something
> clever with DEVICE_ATTR, and unwinding some of the large-ish macros.
> ... and a bunch of stuff I havent yet understood.

You're correct, things could be done in a more efficient way. There is a
sysfs attribute group API which could be used, or we could use for()
loops like you proposed (and I proposed before you [1]). But you also
have to remember that some drivers will not create all sysfs files
depending on which chip they detected and what features these chips may
have disabled.

So it's a tricky point, and decisions should be taken on a by-driver
basis. And you better know that driver pretty well before you do.

[1] http://lkml.org/lkml/2005/5/19/140

-- 
Jean Delvare
