From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Oct 2010 02:53:11 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/9] lis3 accelerator feature update
Message-Id: <20101002025311.GA25875@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Oct 01, 2010 at 07:46:47AM -0400, Samu Onkalo wrote:
> This patch set is done to top of 2.6.36-RC5
> 
> Changes are tested only with I2C interface using 8bit sensor since I don't
> have other possibilities.
> 
> I send this as RFC since changes may affect functionalities or use cases
> which I can't test or I don't know to exist. 
> 
Wonder if there is a better mailing list to get good (or even any) feedback
for this patchset. Even though the driver resides in the hwmon directory,
it isn't really a hardware monitoring driver. Neither i2c nor hwmon fits well.

Ideas, anyone ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
