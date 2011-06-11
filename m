From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 11 Jun 2011 16:05:18 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (ibmaem) Initialize sysfs
Message-Id: <20110611160517.GA26406@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306267814-31505-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306267814-31505-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 11, 2011 at 05:36:07AM -0400, Jean Delvare wrote:
> On Tue, 24 May 2011 13:10:12 -0700, Guenter Roeck wrote:
> > Initialize dynamically allocated sysfs attributes before device_create_file()
> > call to suppress lockdep_init_map() warning if lockdep debugging is enabled.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Compile tested only.
> 
> Can't test either, but looks good to me:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Applied.

> Candidate for stable series?
> 
Yes, I added the necessary Cc:

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
