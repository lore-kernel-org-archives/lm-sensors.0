From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 19 Nov 2010 14:42:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lis3lv02d_i2c) Fix compile
Message-Id: <20101119144239.GA17616@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101119145510.1c59d6c4@endymion.delvare>
In-Reply-To: <20101119145510.1c59d6c4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 19, 2010 at 08:55:10AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 18 Nov 2010 21:10:52 -0800, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> When sending a patch which removes a warning, I suggest including that
> warning in the description. Without the warning, it's difficult to
> review the proposed code change.
> 
Good point. Resent with warnings added. Hopefully it makes it to the list this time.

The warnings are from the "Build regressions/improvements in v2.6.37-rc2" post sent to lkml.
There is another one in there, but I have no idea how to fix it. I'll send it to the list for input.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
