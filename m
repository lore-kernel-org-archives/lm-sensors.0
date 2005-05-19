From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] i2c/chips/*: use time_after instead of comparing jiffies
Message-Id: <20050217222620.GH21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502021115.31416.adobriyan@mail.ru>
In-Reply-To: <200502021115.31416.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 02, 2005 at 11:15:31AM +0200, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Very nice, thanks for doing this.

Applied.

greg k-h
