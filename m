From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Nov 2013 18:07:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] drm/radeon/dpm: Convert to use devm_hwmon_register_with_groups
Message-Id: <20131125180741.GA20159@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385185921-17220-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385185921-17220-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>
Cc: lm-sensors@lm-sensors.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Fri, Nov 22, 2013 at 09:52:00PM -0800, Guenter Roeck wrote:
> Simplify the code and fix race condition seen because
> attribute files were created after hwmon device registration.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested only; unfortunately I don't have the the necessary hardware.
> 
Update: Tested working on actual hardware.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
