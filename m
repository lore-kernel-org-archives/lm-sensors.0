From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 15:49:54 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add tachometer pulses per fan
Message-Id: <20110304154954.GB1804@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299204264-10435-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299204264-10435-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 04, 2011 at 03:43:12AM -0500, Jean Delvare wrote:
> On Thu, 3 Mar 2011 18:04:24 -0800, Guenter Roeck wrote:
> > Some fan control chips support a configuration register to set the number of
> > tachometer pulses per fan revolution. Add an ABI attribute to support this
> > configuration register.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Applied to -next, thanks.

You should have the libsensors patch by now.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
