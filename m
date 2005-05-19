From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Last call 2.7.0
Message-Id: <3DE8FB1F.22A4476F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DE2BB4D.A6B73F17@paradyne.com>
In-Reply-To: <3DE2BB4D.A6B73F17@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Mon, Nov 25, 2002 at 07:07:41PM -0500, Mark D. Studebaker wrote:
> 
> > everything should be in by now.
> 
> Thanks. In the meantime I obtained a winbond w83791d CNR testing card
> and implemented/fixed PEC and process calls, and block reads/writes in
> the driver. ARP now works with smbus-arp.c. Patch attached.
> 
> > Please review / update documentation for dependencies on i2c, etc.
> > I already took a shot at README, INSTALL, QUICKSTART.
> 
> Thanks. All looks OK.
> 
> > Please test compilation/installation on 2.2/2.4.
> 
> 2.2 doesn't (cannot) work, the driver uses too much of 2.4
> functionality. 2.2 doesn't support the x86_64 (Hammer) architecture
> anyway ...
> 


If it's too hard to make it work on kernel 2.2, we'll have to do
something
in Module.mk so it doesn't try to compile - or else remove it from
Module.mk completely.
If the 8111 is for hammer, then is there a CONFIG_xxx option for hammer
in the kernel .config
we can look for?
