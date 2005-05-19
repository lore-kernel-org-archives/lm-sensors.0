From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Improve VID code for the W83627THF
Message-Id: <20050106215449.GC27899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041226153638.122ba238.khali@linux-fr.org>
In-Reply-To: <20041226153638.122ba238.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 26, 2004 at 03:36:38PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch cleans up and improves the VID pins value retrieval for the
> W83627THF chip in the w83627hf driver. Tested successfully by Mark
> Hoffman. The previous code was using an unrelated lock and reading
> register values it didn't need. The new code supports 6-bit VID values
> (as defined by Intel VRM 10), and also ensures that the GPIO pins are
> possibly used as VID inputs.

Applied, thanks.

greg k-h
