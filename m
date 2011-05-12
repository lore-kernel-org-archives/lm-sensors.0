From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 May 2011 12:01:24 +0000
Subject: Re: [lm-sensors] [PATCH v10 2/2] Use "request_muxed_region" in it87
Message-Id: <20110512140124.004a5921@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304966644-19798-1-git-send-email-natg@google.com>
	<1304966731-19896-1-git-send-email-natg@google.com>
In-Reply-To: <1304966731-19896-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mikew@google.com

On Mon,  9 May 2011 11:45:31 -0700, Nat Gurumoorthy wrote:
> 02 - Chages to hwmon it87 driver to use "request_muxed_region"
> Serialize access to the hardware by using "request_muxed_region" macro defined
> by Alan Cox. Call to this macro will hold off the requestor if the resource is
> currently busy. "superio_enter" will return an error if call to 
> "request_muxed_region" fails. Rest of the code change is to ripple an error
> return from superio_enter to the top level.
> 
> Signed-off-by: Nat Gurumoorthy <natg@google.com>
> ---
> (...)

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
