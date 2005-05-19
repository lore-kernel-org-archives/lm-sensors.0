From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] Make master_xfer debug messages more useful
Message-Id: <20050317063941.GD15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308202853.2d82af32.khali@linux-fr.org>
In-Reply-To: <20050308202853.2d82af32.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 08, 2005 at 08:28:53PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> While working on the recent saa7110 mess, I found that the debug message
> displayed when calling master_xfer wasn't as useful as it could be. Here
> is a patch improving this.

Applied, thanks.

greg k-h
