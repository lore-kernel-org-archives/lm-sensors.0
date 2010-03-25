From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 25 Mar 2010 18:16:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] resource: shared I/O region support
Message-Id: <20100325181633.0313b8a5@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk>
	<1269523063-30346-1-git-send-email-me@mortis.eu>
	<20100325155705.1ec79dbc@lxorguk.ukuu.org.uk>
	<20100325180347.GA2761@salidar.me.mortis.eu>
In-Reply-To: <20100325180347.GA2761@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> Always fun reviewing your own code ;-)
> 
> New patch attached.
> 
> One question though. I did some reading in
> Documentation/memory-barriers.txt and think it is correct *not* to call
> set_current_state(TASK_INTERRUPTIBLE) after schedule() finishes. Could
> you confirm or deny that?

After the schedule() returns we will be in TASK_RUNNING which is where we
want to be ...


> +			if (res->flags & IORESOURCE_MUXED)
> +				wake_up(&muxed_resource_wait);
>  			kfree(res);
>  			return;

And you'll want a

Signed-off-by: Alan Cox <alan@linux.intel.com>


>  		}


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
