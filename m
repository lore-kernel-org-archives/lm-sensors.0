From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Forced i2c chip drivers have no name
Message-Id: <20040315211236.GD32636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040312231647.21a101ca.khali@linux-fr.org>
In-Reply-To: <20040312231647.21a101ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 12, 2004 at 11:16:47PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> I just noticed that I am doing something wrong in the i2c chip drivers I
> ported to Linux 2.6. If these drivers are forced to a specific chip type
> ("kind" as we call it internally), then the device doesn't have its name
> set (and defaults to an empty string).

Nice catch.

> Affected drivers: gl518sm, lm83, lm90, w83l785ts.
> 
> I could verify the problem on my ADM1032 chip (lm90 driver). I also
> verified that the proposed patch fixes the issue.
> 
> You may notice that I fix the problem differently for gl518sm and
> w83l785ts on the one hand, and lm83 and lm90 on the other hand. This is
> because the first two drivers are not expected to support more a single
> chip in the future, while lm90 already does and lm83 could someday (for
> example, support for the LM82 could be added on request).
> 
> Please apply (on top of your current tree),

Applied, thanks.

greg k-h
