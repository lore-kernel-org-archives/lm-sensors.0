From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Drop useless w83781d RT feature
Message-Id: <20050331200624.GC664@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <osbj411kvoq3ced9i5qiilesvli7rrubbh@4ax.com>
In-Reply-To: <osbj411kvoq3ced9i5qiilesvli7rrubbh@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 30, 2005 at 05:50:50AM +1000, Grant Coady wrote:
> Hi Greg, All,
> 
> This patch removes useless RT feature from w83781d driver.
> 
> Patch applies after the recent "I2C: Fix a common race condition 
> in hardware monitoring" series.

Applied, thanks.

greg k-h
