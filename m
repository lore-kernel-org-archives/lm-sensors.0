From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
Message-Id: <20041119171204.GA19845@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116222506.7c64e122.khali@linux-fr.org> <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
In-Reply-To: <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Leibold <thomas@plx.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:23:43AM -0800, Thomas Leibold wrote:
> Hi Greg,
> 
> This is the all new and improved version of the patch:
> - following the advise from Jean Delvare I removed the redundant definition
> of the PCI IDs from the driver and just add them to the pci_ids.h file.
> - the patch is now created against linux 2.6.10-RC2.
> 
> Signed-off-by: Thomas Leibold <thomas@plx.com>

Applied, thanks.

greg k-h
