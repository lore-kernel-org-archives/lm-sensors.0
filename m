From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] I2C: Add support for the LPC47M15x and LPC47M192
Message-Id: <20050502205304.GA9058@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050426220943.1cabf69d.khali@linux-fr.org>
In-Reply-To: <20050426220943.1cabf69d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 26, 2005 at 10:09:43PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This simple patch adds support for the SMSC LPC47M15x and LPC47M192
> chips to the smsc47m1 hardware monitoring driver. These chips are
> compatible with the other ones already supported by the driver, so I see
> no reason not to support them, especially when the Linux 2.4 version of
> the driver does already.
> 
> I also modified the info printks to name the chips by their real name.

Applied, thanks.

greg k-h
