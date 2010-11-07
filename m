From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 17:27:07 +0000
Subject: Re: [lm-sensors] [PATCH 7/7] hwmon: (w83795) Check for BEEP pin
Message-Id: <20101107172707.GG18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164759.7e64110f@endymion.delvare>
In-Reply-To: <20101107164759.7e64110f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:47:59AM -0500, Jean Delvare wrote:
> On the W83795ADG, there's a single pin for BEEP and OVT#, so you
> can't have both. Check the configuration and don't create beep
> attributes when BEEP pin is not available.
> 
> The W83795G has a dedicated BEEP pin so the functionality is always
> available there.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
