From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] I2C: Fix debug in w83781d driver
Message-Id: <20040802231203.GB15751@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040731220947.7b9b0285.khali@linux-fr.org>
In-Reply-To: <20040731220947.7b9b0285.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 31, 2004 at 10:09:47PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The trivial patch below fixes two debug prints in the w83781d driver
> (one needless dereference and one debug print without device info).
> Please apply.

Applied, thanks.

greg k-h
