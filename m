From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 05:55:01 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm78) Make ISA interface
Message-Id: <20110728055501.GB21792@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110723181030.72a8dc7b@endymion.delvare>
In-Reply-To: <20110723181030.72a8dc7b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 23, 2011 at 12:10:30PM -0400, Jean Delvare wrote:
> We should only include support for the ISA interface of the LM78/LM79
> if CONFIG_ISA is set. Not only this makes the driver somewhat smaller
> on most architectures, but this also avoids poking at random I/O
> ports on these architectures.
> 
> This is very similiar to what was done for the w83781d driver in
> October 2008.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Dean Nelson <dnelson@redhat.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
