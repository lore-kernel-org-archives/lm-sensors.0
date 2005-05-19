From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] Trivial: group Intel on I2C Hardware Bus support
Message-Id: <20050317063856.GA15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <71ss2156tl8s8mb4afff8511nu3gke4qi8@4ax.com>
In-Reply-To: <71ss2156tl8s8mb4afff8511nu3gke4qi8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 17, 2005 at 09:58:54AM +1100, Grant Coady wrote:
> Hi Greg, All,
> 
> >From an end-user perspective it is easy to miss the third Intel PIIX
> entry on the menuconfig "I2C Hardware Bus support" screen.
> Also the Intel 801 menu item does not mention ICH.
> 
> This trivial patch groups three Intel entries together, adds ICH to
> menu item, and ICH5/ICH5R to the help section.  Includes suggestions 
> from Jean Delvare.
> 
> Previously submitted against 2.6.11-mm2
> 
> Signed-off-by: Grant Coady <gcoady@gmail.com>

Applied, thanks.

greg k-h
