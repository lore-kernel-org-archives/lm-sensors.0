From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH 2.6] Cleanup fan_div in w83781d
Message-Id: <20040310223322.GB23987@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040310221308.313db75a.khali@linux-fr.org>
In-Reply-To: <20040310221308.313db75a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2004 at 10:13:08PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a proposed patch that cleanups the fan_div code from w83781d.
> The original code was obviously taken from the 2.4 driver, but the way
> things were done in 2.4 do not make any sense anymore (because we now
> have a single value per interface file).

Looks nice, applied, thanks.


greg k-h
