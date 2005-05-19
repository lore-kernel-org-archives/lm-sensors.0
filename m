From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH 2.6] I2C: Check for unregistered adapter in
Message-Id: <20041109004929.GB25651@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041106194733.53c8cfa9.khali@linux-fr.org>
In-Reply-To: <20041106194733.53c8cfa9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 06, 2004 at 07:47:33PM +0100, Jean Delvare wrote:
> Hi Greg, hi all,
> 
> This is the patch we discussed about yesterday. I post it here so that
> it can receive the public reviewing it deserves.
> 
> The patch adds a check at the beginning of i2c_del_adapter in case
> someone attempts to remove an adapter that was never added in the first
> place. This sounds like a good safety, as doing so will lead to an oops
> at the moment. Also, I have a need for it in the latest version of my
> i2c-amd756-s4882 patch. I need to remove the original adapter and
> install the virtual ones instead, but I have no way to know if the
> original adapter was succesfully added beforehand or not.
> 
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
