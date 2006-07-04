From: mb@bu3sch.de (Michael Buesch)
Date: Tue, 04 Jul 2006 16:45:32 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <200607041845.33352.mb@bu3sch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch> <20060703224540.GA3785@hansmi.ch>
In-Reply-To: <20060703224540.GA3785@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net, chainsaw@gentoo.org, dtor@insightbb.com, stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 00:45, you wrote:
> +static void ams_handle_irq(void *data)
> +{
> +	enum ams_irq irq = *((enum ams_irq *)data);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ams.irq_lock, flags);
> +
> +	ams.worker_irqs |= irq;
> +	schedule_work(&ams.worker);
> +
> +	spin_unlock_irqrestore(&ams.irq_lock, flags);
> +}

I would say this is racy.
Locks should be added as shown below.

> +static void ams_worker(void *data)
> +{

unsigned long flags;

> +	mutex_lock(&ams.lock);
> +
> +	if (ams.has_device) {

spin_lock_irqsave(&ams.irq_lock, flags);

> +		if (ams.worker_irqs & AMS_IRQ_FREEFALL) {
> +			if (verbose)
> +				printk(KERN_INFO "ams: freefall detected!\n");
> +
> +			ams.worker_irqs &= ~AMS_IRQ_FREEFALL;
> +			ams.clear_irq(AMS_IRQ_FREEFALL);
> +		}
> +
> +		if (ams.worker_irqs & AMS_IRQ_SHOCK) {
> +			if (verbose)
> +				printk(KERN_INFO "ams: shock detected!\n");
> +
> +			ams.worker_irqs &= ~AMS_IRQ_SHOCK;
> +			ams.clear_irq(AMS_IRQ_SHOCK);
> +		

spin_unlock_irqrestore(&ams.irq_lock, flags);

> +	}
> +
> +	mutex_unlock(&ams.lock);
> +}

Otherwise an IRQ could trigger while the bottom half is
executing and corrupt the ams.worker_irqs field, because it
is modified non-atomically.

-- 
Greetings Michael.

