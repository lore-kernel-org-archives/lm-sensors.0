From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 10 May 2007 07:30:20 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon - switch to using
Message-Id: <20070510003020.6afa855a.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200705080025.36131.dtor@insightbb.com>
In-Reply-To: <200705080025.36131.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 May 2007 08:13:10 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> Hi Dmitry,
> 
> On Tue, 8 May 2007 23:13:13 -0400, Dmitry Torokhov wrote:
> > In preparation for struct class_device -> struct device input
> > core conversion, switch to using input_dev->dev.parent when
> > specifying device position in sysfs tree.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

Thanks.

> ...
> Fine with me, however don't you think this patch would be better
> carried through the input tree? If it goes through the hwmon tree, it
> won't go upstream before 2.6.23-rc1, and you might find it difficult to
> synchronize the other related input patches.

I'll merge it in the next batch, tomorrow I guess.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
