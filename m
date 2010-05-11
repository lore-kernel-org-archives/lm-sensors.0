From: Oliver Neukum <oneukum@suse.de>
Date: Tue, 11 May 2010 05:55:07 +0000
Subject: Re: [lm-sensors] [patch]hp_accel: Fix race in device removal
Message-Id: <201005110755.07717.oneukum@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <201005071804.20462.oneukum@suse.de> <20100510154632.bbe181d8.akpm@linux-foundation.org>
In-Reply-To: <20100510154632.bbe181d8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@ucw.cz>, Pavel Herrmann <morpheus.ibis@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, stable@kernel.org

Am Dienstag, 11. Mai 2010 00:46:32 schrieb Andrew Morton:
> But alas, I (and presumably others) cannot confirm that, because you
> didn't describe the bug :( This also means that if someone hits a
> problem with this driver, they won't easily be able to work out whether
> this patch will fix it.
> 
> 
> Under what circumstances does it trigger?
> 
> What are the observed effects when it triggers?
> 
> Please always include this sort of information when sending bugfixes, thanks.

Sorry,

the patch closes a window during which a work queue might remain
active after the device is removed and would then lead to ACPI calls
with undefined behavior.

	Regards
		Oliver

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
