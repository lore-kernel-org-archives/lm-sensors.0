From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Aug 2013 20:47:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) Add support for Fam16h (Kabini)
Message-Id: <20130823204752.GA19363@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130823195810.GA12208@roeck-us.net>
 <1377288843-18253-1-git-send-email-wei@aristanetworks.com>
In-Reply-To: <1377288843-18253-1-git-send-email-wei@aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <wei@aristanetworks.com>
Cc: Guenter Roeck <groeck7@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Aug 23, 2013 at 01:14:03PM -0700, Wei Hu wrote:
> The temperature reporting interface stays the same, so we just
> add the PCI-ID to the list.
> 
> Verified on AMD Olive Hill.
> 
> Signed-off-by: Wei Hu <wei@aristanetworks.com>

Applied to -next.

I marked it for inclusion in stable-3.10, so it will ultimately find
its way there. It does not apply cleanly to earlier stable releases.
If is needed in any of those, someone will have to back-port it after
it is available in mainline.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
