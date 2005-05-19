From: eu@marcelopenna.org (Marcelo Penna Guerra)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test1
Message-Id: <200307231443.56168.eu@marcelopenna.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10586300964092@kroah.com>
In-Reply-To: <10586300964092@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

This code doesn't work well. I was porting this code to 2.5 myself, so I did 
some fixes to the code in 2.6.0-test1-ac3.

On Saturday 19 July 2003 12:54, Greg KH wrote:

> +	smbus->adapter.algo_data = smbus;
> +*/

The problem is here. If you leave this line commented out, you'll have 
problems when inserting the chip module.

>  	smbus->adapter = nforce2_adapter;

Also, I don't see the point in commenting out all this lines just to introduce 
a nforce2_adapter struct. If this is the correct aprouch, just remove the 
duplicate code instead of just commenting it out.

Attached is a patch to fix this problems. I can't test it very well as I can 
only see the sensors in my board with i2c-isa, but everything loads fine.
This patch also moves the PCI ids to the pci_ids.h file.

Marcelo Penna Guerra
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-nforce2.diff
Type: text/x-diff
Size: 2087 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030723/7351f75f/i2c-nforce2.bin
