From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH 2.6] Add PCI quirk for SMBus on the Toshiba Satellite A40
Message-Id: <20050217231815.GD22195@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050213204639.1f0b4a27.khali@linux-fr.org>
In-Reply-To: <20050213204639.1f0b4a27.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>, Frans Pop <aragorn@tiscali.nl>

On Sun, Feb 13, 2005 at 08:46:39PM +0100, Jean Delvare wrote:
> Hi all,
> 
> The Toshiba Satellite A40 laptop hides its SMBus device, much like a
> number of Asus boards reputedly do. This prevents access to the LM90
> hardware monitoring chip. This simple patch extends the PCI quirk used
> for the Asus and HP systems to this Toshiba laptop.
> 
> Please consider for merge into the PCI subsystem,
> thanks.
> 
> Signed-off-by: Frans Pop <aragorn@tiscali.nl>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h
