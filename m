From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050201081800.GA21968@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131185955.GA18316@stusta.de>
In-Reply-To: <20050131185955.GA18316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 07:59:55PM +0100, Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
