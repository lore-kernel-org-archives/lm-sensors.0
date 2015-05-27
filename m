From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 May 2015 00:19:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ntc: Ensure iio channel is of type IIO_VOLTGE
Message-Id: <20150527001931.GA29583@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432672844-28133-1-git-send-email-chris.lesiak@licor.com>
In-Reply-To: <1432672844-28133-1-git-send-email-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 26, 2015 at 03:40:44PM -0500, Chris Lesiak wrote:
> When configured via device tree, the associated iio device needs to be
> measuring voltage for the converstion to resistance to be correct.
> Return -EINVAL if that is not the case.
> 
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>

Applied, after fixing the spelling errors in subject and description.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
