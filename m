From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Nov 2009 09:09:11 +0000
Subject: Re: [lm-sensors] +
Message-Id: <20091114100911.2facb8d3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Fri, 13 Nov 2009 19:56:28 -0800, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      drivers/hwmon/f75375s.c: fix warning, and probable bug
> has been added to the -mm tree.  Its filename is
>      drivers-hwmon-f75375sc-fix-warning-and-probable-bug.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: drivers/hwmon/f75375s.c: fix warning, and probable bug
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/hwmon/f75375s.c: In function 'f75375_detect':
> drivers/hwmon/f75375s.c:689: warning: comparison is always false due to limited range of data type
> drivers/hwmon/f75375s.c:689: warning: comparison is always false due to limited range of data type
> drivers/hwmon/f75375s.c:691: warning: comparison is always false due to limited range of data type
> drivers/hwmon/f75375s.c:691: warning: comparison is always false due to limited range of data type
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/hwmon/f75375s.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/hwmon/f75375s.c~a drivers/hwmon/f75375s.c
> --- a/drivers/hwmon/f75375s.c~a
> +++ a/drivers/hwmon/f75375s.c
> @@ -681,7 +681,7 @@ static int f75375_detect(struct i2c_clie
>  			 struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	u8 vendid, chipid, version;
> +	u16 vendid, chipid, version;
>  	const char *name;
>  
>  	vendid = f75375_read16(client, F75375_REG_VENDOR);

Good catch. I am responsible for this bug, which was introduced by my
patch hwmon-cleanup-detect-functions.patch. I wonder why your gcc
warned you about the problem and did not tell me. Anyway, thanks for
reporting, it's fixed now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
