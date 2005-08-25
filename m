From: stefan@desire.ch (Stefan Ott)
Date: Thu, 25 Aug 2005 17:00:57 +0000
Subject: [lm-sensors] Re: Possible off-by-one error in fscpos
Message-Id: <20050825150010.GG15881@desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050825132807.165a85bf.khali@linux-fr.org>
In-Reply-To: <20050825132807.165a85bf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

You're right, that should be nr-1. However, I can't test it because what
it does is clear a temperature alert - I would have to remove/disable
the CPU's heatsink in order to get such an alert in the first place.
What I could test was which values are actually passed as nr and, as you
noticed, those values are between 1 and 3, not between 0 and 2.

Regards
Stefan

On Thu, Aug 25, 2005 at 01:28:07PM +0200, Jean Delvare wrote:
> Hi Stefan,
> 
> Coverity uncovered a possible off-by-one error in your Linux 2.6 fscpos
> driver, in function set_temp_reset. I believe it is correct, and the fix
> is probably as simple as:
> 
>  drivers/hwmon/fscpos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.13-rc7.orig/drivers/hwmon/fscpos.c	2005-08-24 21:37:02.000000000 +0200
> +++ linux-2.6.13-rc7/drivers/hwmon/fscpos.c	2005-08-25 13:23:13.000000000 +0200
> @@ -168,7 +168,7 @@
>  				"experience to the module author.\n");
>  
>  	/* Supported value: 2 (clears the status) */
> -	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr], 2);
> +	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr - 1], 2);
>  	return count;
>  }
>  
> 
> Can you please comment on this, confirm the problem and solution, and
> test the patch?
> 
> Thanks,
> -- 
> Jean Delvare

-- 
Stefan Ott
http://www.desire.ch/

"Give a man a fire and he's warm for a day, but set fire to him and he's
warm for the rest of his life."  -- Terry Pratchett, Jingo
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050825/22597e10/attachment.bin
