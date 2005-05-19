From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Use standard temperature converters for as99127f
Message-Id: <20050125062732.GB2361@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122112337.7fceb7bc.khali@linux-fr.org>
In-Reply-To: <20050122112337.7fceb7bc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 22, 2005 at 11:23:37AM +0100, Jean Delvare wrote:
> 
> The following patch drops the additional code and treats temp2 and temp3
> the same way for all chips supported by the w83781d driver. A similar
> change will be made to the 2.4 version of this driver, and the default
> sensors.conf will be updated accordingly. Users will have to update
> their configuration file, or their readings will of course read twice as
> high as they should due to the old conversion formulae.
> 
> Please apply,

Applied, thanks.

greg k-h
