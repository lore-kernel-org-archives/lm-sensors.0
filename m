From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH 2.6] i2c-parport: support the ADM1031 evaluation board
Message-Id: <20040528204628.GB10127@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040522225324.572fcdc9.khali@linux-fr.org>
In-Reply-To: <20040522225324.572fcdc9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 22, 2004 at 10:53:24PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch adds support for the ADM1030 and ADM1031 evaluation
> boards to the i2c-parport and i2c-parport-light drivers. They are almost
> compatible with the already supported ADM1025 and ADM1032 boards, except
> that the ADM1032 board needs some pins to be set high to draw its power,
> while the same pins power up heating resistors on the ADM1031 board. I
> considered it was a bit dangerous to do that by default, so I ended up
> with two different device definitions, one with powering pins set, and
> one with these pins cleared.
> 
> Please apply,

Applied, thanks.

greg k-h
