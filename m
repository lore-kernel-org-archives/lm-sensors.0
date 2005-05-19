From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fix for fscpos voltage values
Message-Id: <20050120205814.GA12105@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050120181851.GN26072@desire.ch>
In-Reply-To: <20050120181851.GN26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 20, 2005 at 08:08:33PM +0100, Stefan Ott wrote:
> Multiplied the voltage multipliers by 10 in order to comply with the sysfs
> guidelines.

Applied, thanks.

greg k-h
