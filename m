From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Add secondary Super-I/O address support to
Message-Id: <20050106215458.GD27899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041226153110.52338750.khali@linux-fr.org>
In-Reply-To: <20041226153110.52338750.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 26, 2004 at 03:31:10PM +0100, Jean Delvare wrote:
> Hi Greg, 
> 
> This patch adds support for the secondary Super-I/O address to the
> w83627hf driver. Most manufacturer use the primary address but at least
> the EPoX EP-9NDA3+ had a Winbond W83627THF at the secondary address.

Applied, thanks.

greg k-h
