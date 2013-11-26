From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Nov 2013 13:55:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] drm/radeon/dpm: Convert to use devm_hwmon_register_with_groups
Message-Id: <CADnq5_PKAJT84csBN6AhqwhaZQu-YejfDyv=wiORwX1+03zt1A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385185921-17220-1-git-send-email-linux@roeck-us.net>
	<20131125180741.GA20159@roeck-us.net>
In-Reply-To: <20131125180741.GA20159@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, lm-sensors@lm-sensors.org

On Mon, Nov 25, 2013 at 1:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Nov 22, 2013 at 09:52:00PM -0800, Guenter Roeck wrote:
>> Simplify the code and fix race condition seen because
>> attribute files were created after hwmon device registration.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Compile tested only; unfortunately I don't have the the necessary hardware.
>>
> Update: Tested working on actual hardware.

Applied. thanks!

Alex

>
> Guenter
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
