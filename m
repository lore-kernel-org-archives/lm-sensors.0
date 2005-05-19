From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] Fix bugs in the new w83627ehf driver
Message-Id: <20050502214159.GA19499@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050502230822.14db6bc3.khali@linux-fr.org>
In-Reply-To: <20050502230822.14db6bc3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 02, 2005 at 11:08:22PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> These are the fixes for the bugs you spotted in my new w83627ehf driver:
> 1* w83627ehf_detect should be declared static.
> 2* Explicit division by 0.
> 
> I'm very sorry for introducing them in the first place, especially the
> second one. I'm glad you spotted them, thanks a lot.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
