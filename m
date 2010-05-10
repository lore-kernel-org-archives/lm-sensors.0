From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 10 May 2010 22:46:32 +0000
Subject: Re: [lm-sensors] [patch]hp_accel: Fix race in device removal
Message-Id: <20100510154632.bbe181d8.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <201005071804.20462.oneukum@suse.de>
In-Reply-To: <201005071804.20462.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.de>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@ucw.cz>, Pavel Herrmann <morpheus.ibis@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, stable@kernel.org

On Fri, 7 May 2010 18:04:20 +0200
Oliver Neukum <oneukum@suse.de> wrote:

> >From 505056649f5ecb1ebb086981243b9870ce961a87 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 7 May 2010 18:02:07 +0200
> Subject: [PATCH] hp_accel: Fix race in device removal
> 
> The work queue has to be flushed after the device has been made
> inaccessible.
> 

You cc'ed stable@kernel.org so presumably you think it's a pretty
serious bug.

But alas, I (and presumably others) cannot confirm that, because you
didn't describe the bug :( This also means that if someone hits a
problem with this driver, they won't easily be able to work out whether
this patch will fix it.


Under what circumstances does it trigger?

What are the observed effects when it triggers?

Please always include this sort of information when sending bugfixes, thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
