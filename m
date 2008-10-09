From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 13:16:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] abituguru3: enable DMI probing feature
Message-Id: <20081009151658.0586c450@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1223485560-3806-3-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1223485560-3806-3-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 09 Oct 2008 09:47:10 +0200, Hans de Goede wrote:
> 
> 
> Alistair John Strachan wrote:
> > Enable driver checking of the DMI product name (when enabled) on
> > an Abit AT8 32X, instead of falling back to a manual probe. This
> > eliminates false negatives and eventually will help avoid
> > unnecessary bus probes on unsupported mainboards.
> > 
> > Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> > Tested-by: Daniel Exner <dex@dragonslave.de>
> 
> Looks good,
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Queued up for 2.6.27, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
