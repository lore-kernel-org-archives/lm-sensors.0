From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [patch 2/2] i2c/i2c-ite: remove interruptible_sleep_on_timeout()
Message-Id: <20050317064001.GE15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306104150.AB27D1F1F0@trashy.coderock.org>
In-Reply-To: <20050306104150.AB27D1F1F0@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 06, 2005 at 11:41:50AM +0100, domen@coderock.org wrote:
> 
> 
> Replace deprecated interruptible_sleep_on_timeout() with direct
> wait-queue usage. Patch is compile-tested, sort of; the driver does not build in
> vanilla kernel either, but I don't seem to add any warnings..
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Applied, thanks.

greg k-h
