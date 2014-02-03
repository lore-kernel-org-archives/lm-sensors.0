From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 15:11:12 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (lm63) Create all sysfs groups in one call
Message-Id: <20140203161112.5409207f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391390510-19238-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391390510-19238-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  2 Feb 2014 17:21:49 -0800, Guenter Roeck wrote:
> We can create all sysfs groups in one call by using sysfs_create_groups
> instead of using sysfs_create_group individually for each group.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Handle newly introduced group for temp2_type
> 
>  drivers/hwmon/lm63.c |   42 ++++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 28 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
