From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] I2C: Skip broken detection step in it87
Message-Id: <20050317063918.GB15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050316121818.33094e7e.khali@linux-fr.org>
In-Reply-To: <20050316121818.33094e7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 16, 2005 at 12:18:18PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> One of the detection steps in the it87 chip driver was reported to be
> broken for some revisions of the IT8712F chip [1] [2]. This detection
> step is a legacy from the lm78 driver and the documentation available
> for the IT8705F and IT8712F chips does not mention it at all. For this
> reason, I propose to skip this detection step for Super-I/O chips.
> Super-I/O chips have already been identified when we reach this step, so
> it is redundant (additionally do being broken). This closes bug #4335.
> 
> Please apply,
> thanks.
> 
> [1] http://bugzilla.kernel.org/show_bug.cgi?idC35
> [2] http://archives.andrew.net.au/lm-sensors/msg29962.html
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
