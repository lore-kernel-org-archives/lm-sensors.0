From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 14:34:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (w83795) More style cleanups
Message-Id: <20101028143448.GA4123@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101028155620.5cb01b08@endymion.delvare>
In-Reply-To: <20101028155620.5cb01b08@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 28, 2010 at 09:56:20AM -0400, Jean Delvare wrote:
> Cleanups suggested by Guenter Roeck, falling into 4 categories:
> * Swapping test orders, because if (var = CONSTANT) is much easier to
>   read than if (CONSTANT = var).
> * Simplifying comparisons with 0.
> * Dropping unneeded masks.
> * Dropping unneeded parentheses and curly braces.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
