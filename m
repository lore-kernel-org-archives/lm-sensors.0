From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 30 Jun 2011 14:22:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon-vid: Add support for VIA family 6
Message-Id: <20110630142246.GB13161@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110630143432.12d32eb8@endymion.delvare>
In-Reply-To: <20110630143432.12d32eb8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 30, 2011 at 08:34:32AM -0400, Jean Delvare wrote:
> The VIA family 6 model D CPU (C7-D, Eden 90 nm) can use two different
> VID tables, we have to check the value of a MSR to decide which one to
> use.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
