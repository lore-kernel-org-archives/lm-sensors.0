From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 20 Oct 2011 14:27:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (w83627ehf) Fix negative 8-bit
Message-Id: <1319120847.3720.270.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111020090645.1b85f1aa@endymion.delvare>
In-Reply-To: <20111020090645.1b85f1aa@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-10-20 at 03:06 -0400, Jean Delvare wrote:
> Since 8-bit temperature values are now handled in 16-bit struct
> members, values have to be cast to s8 for negative temperatures to be
> properly handled. This is broken since kernel version 2.6.39
> (commit bce26c58df86599c9570cee83eac58bdaae760e4.)
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: stable@kernel.org

Applied, and sorry for the breakage.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
