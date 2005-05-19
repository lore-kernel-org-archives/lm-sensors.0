From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [linux-usb-devel] [PATCH 1/63] usb/message: make
Message-Id: <20050215231012.GB2377@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050209001232.GC5661@us.ibm.com> <20050215222937.GA16488@kroah.com>
In-Reply-To: <20050215222937.GA16488@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: gregkh@us.ibm.com, marcel@holtmann.org, maxk@qualcomm.com, jt@hpl.hp.com, perex@suse.cz, linux-dvb-maintainer@linuxtv.org, johnpol@2ka.mipt.ru, linux-usb-devel@lists.sourceforge.net, bluez-devel@lists.sourceforge.net, irda-users@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-dvb@linuxtv.org, sensors@stimpy.netroedge.com

On Tue, Feb 15, 2005 at 02:29:38PM -0800, Greg KH wrote:
> On Tue, Feb 08, 2005 at 04:12:32PM -0800, Nishanth Aravamudan wrote:
> > Hi,
> > 
> > Sent to everyone so that build and compile tests will be possible. Only Greg
> > should need to pull this into a tree, though, to send upstream.
> 
> Ugh, 63+ patches...
> 
> Anyway, I've applied all of these, and your additional one, to my tree.
> If you could make sure and check the next -mm release to make sure I got
> them all, I'd appreciate it.
> 
> thanks a lot for your work, I appreciate it.

No problem! I will keep my eye on the USB tree in the next -MM and make
sure there aren't any stray unchanged usb_{bulk,control}_msg()s around.
Thanks for your help!

-Nish
