From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 09 Apr 2015 11:35:35 +0000
Subject: Re: [lm-sensors] [PATCH 02/22] hwmon: (it87) Use feature macros on sio_data
Message-Id: <20150409133535.24cadeb0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428184513-22380-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1428184513-22380-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat,  4 Apr 2015 14:54:53 -0700, Guenter Roeck wrote:
> Feature macros work on sio_data as well, so use them there.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> (...)

I like it.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
