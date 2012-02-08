From: Greg KH <greg@kroah.com>
Date: Wed, 08 Feb 2012 16:37:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <20120208163728.GB3401@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 07, 2012 at 03:52:24PM -0800, Guenter Roeck wrote:
> NCT6776F can select fan input pins for fans 3 to 5 with a secondary set of
> chip register bits. Check that second set of bits in addition to the first set
> to detect if fans 3..5 are monitored.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Cc: stable@vger.kernel.org # 3.0+
> Acked-by: Jean Delvare <khali@linux-fr.org>
> ---
> Backport to 3.0
> Upstream commit: 585c0fd8216e0c9f98e2434092af7ec0f999522d

Applied, thanks.

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
