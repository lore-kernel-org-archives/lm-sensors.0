From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 18:16:07 +0000
Subject: Re: [lm-sensors] kernel TODO 20070708
Message-Id: <20070709201607.5a25b87a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070708181411.GE3584@jupiter.solarsys.private>
In-Reply-To: <20070708181411.GE3584@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jul 2007 14:14:11 -0400, Mark M. Hoffman wrote:
> [PATCH] Apple SMC driver - fix input device
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019462.html
> status: not sure it belongs in my tree, will deal with it later

Same comment as last time: this one is already upstream!

> [ patch ]  de-macro-fy w83627hf.c
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020340.html
> status: wants reviewer

I will test this one after Jim provides a patch that applies on top of
your stack.

> [PATCH] adm1021 dynamic sysfs callbacks added
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020344.html
> status: wants reviewer

I will review this one once Krzysztof will have split the cleanup parts
to a separate patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
