From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 May 2011 14:02:02 +0000
Subject: Re: [lm-sensors] [PATCH] i8k: Properly handle errors
Message-Id: <20110508140202.GB29524@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110508104600.0bae8f45@endymion.delvare>
In-Reply-To: <20110508104600.0bae8f45@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 08, 2011 at 04:46:00AM -0400, Jean Delvare wrote:
> My code originally didn't expect the temperature sensor to be missing,
> and also didn't properly handle run-time errors. This is fixed now.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Massimo Dal Zotto <dz@debian.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
