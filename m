From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Dec 2013 10:45:00 +0000
Subject: Re: [lm-sensors] Unhandled LM90 irq 308 on Dalmore?
Message-Id: <20131219114500.1b1ea0b7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52B2C5AD.5080405@nvidia.com>
In-Reply-To: <52B2C5AD.5080405-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Hi Paul,

Adding Wei who added interrupt support to the lm90 driver, and moving
to the appropriate list.

On Thu, 19 Dec 2013 02:08:45 -0800, Paul Walmsley wrote:
> Just FYI, the Tegra114 Dalmore board here reports an unhandled IRQ about 
> two minutes after boot:
> 
> [  120.950839] irq 308: nobody cared (try booting with the "irqpoll" option)
> [  120.957654] CPU: 1 PID: 74 Comm: irq/308-lm90 Not tainted 
> 3.13.0-rc4-next-20131218-30442-g28522bc #1
> [  120.966816] [<c0015c44>] (unwind_backtrace) from [<c0011898>] 
> (show_stack+0x10/0x14)
> [  120.974571] [<c0011898>] (show_stack) from [<c0565370>] 
> (dump_stack+0x80/0xcc)
> [  120.981804] [<c0565370>] (dump_stack) from [<c0066030>] 
> (__report_bad_irq+0x20/0xc0)
> [  120.989543] [<c0066030>] (__report_bad_irq) from [<c0066550>] 
> (note_interrupt+0x1f8/0x254)
> [  120.997811] [<c0066550>] (note_interrupt) from [<c0064fc0>] 
> (irq_thread+0x12c/0x158)
> [  121.005613] [<c0064fc0>] (irq_thread) from [<c003fcac>] 
> (kthread+0xc4/0xe0)
> [  121.012614] [<c003fcac>] (kthread) from [<c000e738>] 
> (ret_from_fork+0x14/0x3c)
> [  121.019825] handlers:
> [  121.022117] [<c0064408>] irq_default_primary_handler threaded 
> [<c0384764>] lm90_irq_thread
> [  121.030418] Disabling IRQ #308
> 
> This is on next-20131218.

Which temperature chip is the Tegra114 Dalmore board using?

Is the interrupt shared with something else?

Is there any monitoring script, application or daemon polling for
temperatures on this system?

Wei, I think there is a race condition between lm90_update_device and
lm90_irq_thread. The values in registers LM90_REG_R_STATUS and
MAX6696_REG_R_STATUS2 are cleared on read, and lm90_update_device reads
these registers. So if lm90_update_device runs (caused by someone
reading any value from the sysfs interface) between the interrupt
firing and lm90_irq_thread being run, then lm90_is_tripped will return
false and consequently lm90_irq_thread will return IRQ_NONE.

Best would be if we could lock data->update_lock when the interrupt
fires, but I'm afraid there is no way to do that in a race-free way.

The next best thing I can think of is that lm90_is_tripped should check
for cache validity and read from the cache (instead of or additionally
to reading from the device registers directly.) If the cache is hot
then there's a chance that someone called lm90_update_device and was
able to read the status registers before the interrupt handler did.

In fact we probably have to do both to be completely safe.
data->last_updated is updated by lm90_update_device _after_ the status
registers have been read, so we can't rely on it unless we are also
holding data->update_lock.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
