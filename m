From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Incorrect memset in eeprom.c
Message-Id: <20040330222646.GE12583@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040330203502.350fc28b.khali@linux-fr.org>
In-Reply-To: <20040330203502.350fc28b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 30, 2004 at 08:35:02PM +0200, Jean Delvare wrote:
> Quoting Ralf Roesch:
> 
> > currently I'm only working with Linux MIPS 2.4 kernel, 
> > so it would be nice if you could forward the patch for 2.6.
> 
> OK, so here we are. Greg, this is the port to 2.6 of Ralf patch that
> fixes an incorrect memset while initializing the eeprom driver. Please
> apply.

Applied, thanks.

greg k-h
