From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Dec 2006 14:21:26 +0000
Subject: [lm-sensors] [PATCH libsensors] emit line number for each 'set'
Message-Id: <20061205152126.9df588b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061205034132.GE5592@jupiter.solarsys.private>
In-Reply-To: <20061205034132.GE5592@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Mon, 4 Dec 2006 22:41:32 -0500, Mark M. Hoffman wrote:
> You asked about this on IRC last Sunday, and unfortunately I gave you some bad
> information.  Turns out it is trivial after all.  I completely forgot about
> libsensors error.h.
> 
> Index: lib/access.c
> =================================> --- lib/access.c	(revision 4253)
> +++ lib/access.c	(working copy)
> @@ -460,6 +460,8 @@
>  				continue;
>  			}
>  			if ((res = sensors_set_feature(name, feature_nr, value))) {
> +				sensors_parse_error("Can't set feature.",
> +						chip->sets[i].lineno);
>  				err = res;
>  				continue;
>  			}

Very nice. It's sort of abusing the "sensors_parse_error" name as this
isn't a parse error, but I guess we don't really care. Care to apply
this change to our SVN tree?

Thanks,
-- 
Jean Delvare

