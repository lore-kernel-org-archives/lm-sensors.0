From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <d120d5000504210909f0e0713@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
In-Reply-To: <1114089504.29655.93.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnpol@2ka.mipt.ru
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

One more thing...

On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> 
> > w1-master-drop-attrs.patch
> >    Get rid of unneeded master device attributes:
> >    - 'pointer' and 'attempts' are meaningless for userspace;
> >    - information provided by 'slaves' and 'slave_count' can be gathered
> >      from other sysfs bits;
> >    - w1_slave_found has to be rearranged now that slave_count field is gone.
> 
> attempts is usefull for broken lines.

It simply increments with every search i.e. every 10 secondsby default
and does not provide indication of the quality of the wire.

-- 
Dmitry
