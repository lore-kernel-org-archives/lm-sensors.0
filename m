From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH 2.6] Invert as99127f beep bits in kernel space
Message-Id: <20040505221738.GC29885@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040502155822.05b7da2a.khali@linux-fr.org>
In-Reply-To: <20040502155822.05b7da2a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 02, 2004 at 03:58:22PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch changes the way we invert beep bits for the AS99127F
> sensor chip. This chip behaves differently from the other chips in that
> a disabled bit is 1, not 0. So far we didn't handle that specificity in
> the w83781d driver, so it was left to user-space applications to handle
> it. For the sake of uniformity, it's obviously better if it's done in
> the driver instead (although the meaning of each bit is still
> chip-dependant).
> 
> I already did a similar change to the 2.4 driver and the sensors
> program. I don't think that many user-space application will be
> affected, since most of them don't handle the beep mask as far as I can
> tell.
> 
> This also close Debian bug #209299:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug 9299
> 
> Successfully tested on my AS99127F rev.1 chip. Aurelien Jarno also
> checked that there were no regression on non-Asus chips.
> 
> Please apply,

Applied, thanks.

greg k-h
