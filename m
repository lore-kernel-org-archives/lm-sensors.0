From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 29 Jun 2014 01:16:30 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] fs: asus_atk0110: Fix DEFINE_SIMPLE_ATTRIBUTE semicolon definition and 
Message-Id: <53AF68EE.5080103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1403999769.git.joe@perches.com> <530fc2e19919f12996227b27645be7e8f911a7ba.1403999769.git.joe@perches.com>
In-Reply-To: <530fc2e19919f12996227b27645be7e8f911a7ba.1403999769.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <jdelvare@suse.de>, Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 06/28/2014 05:20 PM, Joe Perches wrote:
> The DEFINE_SIMPLE_ATTRIBUTE macro should not end in a ;
> Fix the one use in the kernel tree that did not have a semicolon.
>
> Signed-off-by: Joe Perches <joe@perches.com>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
