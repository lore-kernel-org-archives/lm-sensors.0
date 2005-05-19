From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] i2c-nforce2: add support for nForce4 (patch against
Message-Id: <20050217232204.GB22369@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502180019.20440.hfvogt@gmx.net>
In-Reply-To: <200502180019.20440.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 18, 2005 at 12:19:20AM +0100, Hans-Frieder Vogt wrote:
> Greg,
> 
> can you please apply the attached patch (against 2.6.11-rc4, but works as well 
> for 2.6.11-rc3-mm2),  that adds support for the two SMBusses of the nForce4 
> to the i2c-nforce2 i2c bus driver.
> The patch is reported to work on the standard nForce4 (i.e. non-Ultra, 
> non-SLI), but I expect that it works as well for the other nForce4 chipsets, 
> that seem to have the same PCI-id for the SMBus-device.
> 
> This patch was proposed by Chuck <chunkeey@web.de>, thanks to him for the 
> information, testing and his patch.

Can I get a "Signed-off-by:" line from someone?  :)

thanks,

greg k-h
