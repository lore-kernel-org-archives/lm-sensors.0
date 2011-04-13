From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 13 Apr 2011 13:58:34 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (sht15) clean-up the probe
Message-Id: <1302702429-sup-5170@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,
Excerpts from Jonathan Cameron's message of 2011-04-13 07:37:37 -0400:
> On 04/12/11 20:34, Vivien Didelot wrote:
> > * Move the creation of sysfs attributes after the end of the
> >   initialization, and remove them in the error path.
> > * Release regulator in the error path.
> > * Add a soft reset command (need to wait 11ms before next command).
> Ideally add something to say why this is needed. (the heater issue that
> Guenter raised).

The soft reset in this patch just ensures to wait 11ms after this
command is sent (previously the probe function didn't deal with that).
The heater issue that Guenter raised (i.e. disabling the heater on
module unload) is fixed in the next patch.

Btw, thanks you all for you comments and reviews.

Regards,
Vivien.

> > 
> > Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
