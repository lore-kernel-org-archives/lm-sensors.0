From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <heu841pt88u2qbe1a7he5etj22bab50b27@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Mar 2005 21:19:40 +0100, Jean Delvare <khali@linux-fr.org> wrote:
. . .
>I have put my patches here:
>http://jdelvare.net1.nerim.net/sensors/lock-on-set/
>
>Feel free to review and comment.

Methinks I'll change mine to not move 'val' assignment under lock
and add blank in macro -- follow similar style.

And you've answered my other query, multiple exit okay:
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
rather than do nasty thing to 'count' with patches I posted

>As a side note, you'll notice that I did *not* add locking for
>data->vrm. This is not a miss, I did on purpose. data->vrm isn't read
>frop the chip, so it's not changed by the update function. The sysfs
>change function is the only place where the value can change (let alone
>init time), so the lock isn't necessary (until someone can prove
>otherwise).
Agree.  Two for, any against?
. . .
>> Then I can do fan_div at slower pace later as it is less 
>> important change than correcting locking.
>
>Absolutely, this would be the better approach. Once we have all the
>locking fixes, we can do a big patch, co-sign it and send it to Greg.
>After that, you are free to go on with whatever fixes you want.

Am setting up -mm3 now, redo my patches against that once it compiles.

Cheers,
Grant.
