From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Delete useless instruction in it87
Message-Id: <20050328210327.GB3752@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050324222458.658f4660.khali@linux-fr.org>
In-Reply-To: <20050324222458.658f4660.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 24, 2005 at 10:24:58PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The IT8705F doesn't support VID, so it's quite pointless to give a value
> to it (and an arbitrary one at that). I think that this instruction was
> there for compatibility reasons some times ago, but the reasons went
> away while the instruction was left in place. We can safely delete it
> now.
> 
> Thanks to Rudolf Marek for testing the patch (you never know).
> 
> Please apply,
> thanks.

Applied, thanks.

greg k-h
