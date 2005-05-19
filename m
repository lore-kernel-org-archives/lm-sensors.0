From: linux@brodo.de (Dominik Brodowski)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] p4b_smbus quirk update
Message-Id: <20030517091921.GA3381@brodo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030202110314.GA1759@brodo.de>
In-Reply-To: <20030202110314.GA1759@brodo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 16, 2003 at 06:48:08PM -0500, Mark D. Studebaker  wrote:
> That's a good idea.
> Did you submit it to the kernel?
> If it gets in let us know.
> thanks

Merged in 2.5.69-bk11.

	Dominik

> Dominik Brodowski wrote:
> >Hi,
> >
> >The p4b_smbus.c module located in lm_sensors-2.7.0/prog/hotplug does not
> >work for 2.5. kernels. Also, the code can be simplified much if enabling 
> >the
> >SMBus device is done as a "pci quirk" in drivers/pci/quirks.c in the linux
> >kernel sources. A patch for linux-kernel 2.5.59 is attached below. 
> >However, it _might_ be wise to add a check so that only Asus mainboards 
> >are affected.
> >
> >	Dominik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030517/085ae645/attachment.bin
