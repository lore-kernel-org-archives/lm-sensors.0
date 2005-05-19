From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] Enable changing fan_divs in lm80 driver
Message-Id: <20040409185652.GD17187@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040404230032.3f256372.khali@linux-fr.org>
In-Reply-To: <20040404230032.3f256372.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 04, 2004 at 11:00:32PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> For some reason the original lm80 driver in 2.6 cannot set fan_divs
> (while the 2.4 driver could). This patch brings support back. It was
> lightly tested by one user.
> 
> This patch also suggests some code cleanups (fan code refactoring). I'll
> send a different patch later for these.
> 
> Please apply,

Applied, thanks.

greg k-h
