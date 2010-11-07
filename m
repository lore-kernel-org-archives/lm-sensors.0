From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 16:32:30 +0000
Subject: Re: [lm-sensors] [PATCH 4/7] hwmon: (w83795) Print the actual
Message-Id: <20101107163230.GD18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101107164553.225d0647@endymion.delvare>
In-Reply-To: <20101107164553.225d0647@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 10:45:53AM -0500, Jean Delvare wrote:
> Don't expose raw register values to user-space. Decode and encode
> temperature channels selected as temperature sources as needed.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
