From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040614174835.GD26862@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 08, 2004 at 10:21:22PM -0400, Mark M. Hoffman wrote:
> Hi Greg:
> 
> This patch applies on top of the previous one in the thread
> (which applied to 2.6.7-rc2).  Please apply.
> 
> * * * * *
> 
> Pick a VRM (for VID interpretation) based on the VRM & OVT config,
> if available.  Props to Jean Delvare <khali@linux-fr.org> for the
> idea & code fragment.

Applied, thanks.

Oh, can you add the Signed-off-by: line to your patches from now on?

thanks,

greg k-h
