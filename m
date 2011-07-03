From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Jul 2011 16:24:26 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (adm1275) Free allocated memory
Message-Id: <20110703162426.GB15945@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 03, 2011 at 03:53:21AM -0400, Jean Delvare wrote:
> On Thu, 30 Jun 2011 10:29:51 -0700, Guenter Roeck wrote:
> > Probe function did not free allocated memory if it failed. Fix it.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Good catch.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Embarassing, actually, since I had that same piece of code in other drivers
and got it right there ;).

Thanks for the review,

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
