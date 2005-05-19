From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: Do not show disabled pc87360 fans
Message-Id: <20050131182914.GC21546@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050127231022.6331ef93.khali@linux-fr.org>
In-Reply-To: <20050127231022.6331ef93.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 27, 2005 at 11:10:22PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The pc87360 driver create sysfs files even for disabled fans. Since data
> won't ever be updated, it doesn't make much sense. The following patch
> adds some tests to only create the interface files that are actually
> needed.
> 
> Please apply,

Applied, thanks.

greg k-h
