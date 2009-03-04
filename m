From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Mar 2009 09:16:59 +0000
Subject: Re: [lm-sensors] Coding style in sensors daemon (sensord)
Message-Id: <20090304101659.55fa8bd6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090304091128.GA4632@ubuntu>
In-Reply-To: <20090304091128.GA4632@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Andre,

On Wed, 4 Mar 2009 10:11:29 +0100, Andre Prendel wrote:
> looking at the source code in prog/sensord I've seen gnu coding
> style. IMO this is really hard to read. In sensors/ and dump/ we are
> using the kernel style and I prefer this one.
> 
> To be consistent and ease reading and fixing, I will spend some time
> to bring the sensord code in shape.
> 
> Any objections?

No objections, please go ahead. sensord was contributed by Merlin
Hughes a long time ago, and while I (and others) spent a significant
amount of time cleaning up the coding style of other parts of the code,
sensord didn't receive too much love over the past few years... Just
the minimum to keep it alive. You are very welcome to improve the
sensord code, be it the style or the code itself.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
