From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Jan 2012 03:18:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm63) Reorganize the code
Message-Id: <20120127031820.GA27607@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120126215345.3eb84ccd@endymion.delvare>
In-Reply-To: <20120126215345.3eb84ccd@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 26, 2012 at 03:53:45PM -0500, Jean Delvare wrote:
> Reorder functions and driver declaration to no longer need to
> forward-declare functions. Also rename new_client to just client
> everywhere for readability.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
