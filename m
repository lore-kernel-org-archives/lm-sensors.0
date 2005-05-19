From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] I2C: Refine detection of LM75 chips
Message-Id: <20040714183528.GC10099@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040714105222.262c586d.khali@linux-fr.org>
In-Reply-To: <20040714105222.262c586d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 14, 2004 at 10:52:22AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The LM75 detection method was a bit loose so far and would accept
> non-LM75-compatible chips from times to times. It should be better now.
> Additionally, the help for the lm75 driver was reworked because we now
> know that the LM75 and the LM77 are not compatible.
> 
> Please apply,
> thanks.
> 
> Signed-off-by: Jean Delvare <khali at linux-fr dot org>

Applied, thanks.

greg k-h
