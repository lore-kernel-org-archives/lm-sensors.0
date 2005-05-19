From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Fix MAX6657/8/9 detection in lm90
Message-Id: <20050106215426.GB27899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041226152229.16d51a7c.khali@linux-fr.org>
In-Reply-To: <20041226152229.16d51a7c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 26, 2004 at 03:22:29PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> I received no additional feedback about my MAX6657/8/9 detection fix.
> Since it was correct for the only chips I got a report for, I propose we
> apply it. After all, maybe people don't know they have such a chip
> because the detection was previously not correct.
> 
> The patch below is the one I sent to the LM Sensors and Linux Kernel
> mailing-lists two weeks ago, unchanged. Thanks.

Applied, thanks.

greg k-h
