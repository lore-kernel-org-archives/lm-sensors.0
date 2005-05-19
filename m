From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: Kill unused includes in i2c-sensor-detect.c
Message-Id: <20050131182908.GB21546@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050128225919.09d0ce09.khali@linux-fr.org>
In-Reply-To: <20050128225919.09d0ce09.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 28, 2005 at 10:59:19PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Looks to me like i2c-sensor-detect.c includes a handful of headers it
> doesn't need at all. This patch removes them.
> 
> Please confirm that I am doing the right thing :)
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
