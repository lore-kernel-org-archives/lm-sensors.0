From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Fix broken force parameter handling
Message-Id: <20050328210448.GF3752@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050327192856.6827c93d.khali@linux-fr.org>
In-Reply-To: <20050327192856.6827c93d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 27, 2005 at 07:28:56PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> I just noticed a nasty bug in the way the "force" parameter is handled
> for non-sensors i2c chip drivers. The "force" parameter supposedy is a
> list of adapter, address *pairs* where supported chips are
> unquestionably assumed to be. However, after handling one pair, the i2c
> core code searches for the next one *three* values later, not two. So
> with the current code, the second and third pairs wouldn't be properly
> handled. The fourth one would be, and so on.
> 
> As a side note, this questions the need of an array parameter handling
> up to 24 of such pairs, when obviously nobody ever required more than
> one for the past 6 years.
> 
> Please apply,

Applied, thanks.

greg k-h
