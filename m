From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 13:17:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] abituguru3: enable reading from AUX3
Message-Id: <20081009151721.25f9d3c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1223485560-3806-2-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1223485560-3806-2-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 09 Oct 2008 09:46:39 +0200, Hans de Goede wrote:
> 
> 
> Alistair John Strachan wrote:
> > The table for the Abit AT8 32X was incorrectly missing an entry
> > for the sixth ("AUX3") fan. Add this entry, exporting the fan
> > reading to userspace.
> > 
> > Closes lm-sensors.org ticket #2339.
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
