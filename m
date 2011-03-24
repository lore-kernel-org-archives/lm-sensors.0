From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Mar 2011 03:30:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (f71882fg) Secure chip property
Message-Id: <20110324033002.GA15395@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110323214702.69fa03ac@endymion.delvare>
In-Reply-To: <20110323214702.69fa03ac@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 23, 2011 at 04:47:02PM -0400, Jean Delvare wrote:
> Using C99-style array initialization will ensure definitions won't
> drift if the chips enum gets new values added.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hans de Goede <hdegoede@redhat.com>

Excellent idea.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
