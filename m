From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Sep 2006 17:25:33 +0000
Subject: [lm-sensors] [patch] hwmon: fix unchecked returncodes in w83791d
Message-Id: <20060925192533.40929faf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Fix unchecked return-status by replacing all unchecked calls 
> to device_create_file with a single group declaration,
> and one call to sysfs_create_group, and check that one return status.
> 
> Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>
> ---
> $ diffstat pc-set/hwmon-unchecked-return-status-fixes-w83791d.patch
>  w83791d.c |   83 +++++++++++++++++++++++++++++++++++++++++---------------------
>  1 files changed, 55 insertions(+), 28 deletions(-)
> 
> ---
> 
> Its impressive (or embarrassing) how much slop you detect.
> I trust this comment is in right place for auto-strip to 
> keep it out of Changelog.  Is any of this automated, and if so,
> are we/I getting it right (or close) ?

Yes, anything between "---" and the beginning of the actual patch is
dropped upstream. But I'm still editing things manually anyway so it's
no big deal where you add your comments.

> @@ -1029,6 +1054,8 @@ static int w83791d_detach_client(struct 
>  	if (data)
>  		hwmon_device_unregister(data->class_dev);
>  
> +	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
> +
>  	if ((err = i2c_detach_client(client)))
>  		return err;

The "if (data)" is used to differenciate between the real client and
the subclients, exactly as is done in the w83781d driver. As subclients
have no files, the call to sysfs_remove_group() should be made
conditional as well. If not, it'll still work, but with a significant
performance drop.

Thanks,
-- 
Jean Delvare

