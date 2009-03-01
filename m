From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 01 Mar 2009 13:58:15 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <20090301145815.7739ea9c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sun, 1 Mar 2009 20:50:49 +1000, David O'Shea wrote:
> > Did you try using DECLARE_PCI_FIXUP_EARLY() instead of
> > DECLARE_PCI_FIXUP_HEADER()? I suspect this would let you use the IDE
> > controller.
> 
> I'm afraid I didn't look around that much so wasn't aware of that one!
> 
> > But as said above, I am now also fine with you using one of the USB
> > controllers if you prefer; it's up to you. When you have a working
> > patch, please send it to me and I'll review it quickly so that it can
> > make it into 2.6.30.
> 
> I prefer to stick to using the USB since it requires less changes and knowing as little as I do about the code it is probably best that I do as little as possible to it :)

OK.

> I have attached a patch.  Apologies in advance if I got it wrong somehow!  Also I'm afraid it is based on an older kernel version (2.6.27) since this is what Fedora 10 includes - it was not until you mentioned 2.6.30 that I knew this was old :(  I hope this is acceptable anyway since the patch is pretty simple.

Your patch looks OK and it applies fine to 2.6.29-rc6. All it is
missing is a proper subject, header comment, and your Signed-off-by
as per Documentation/SubmittingPatches' "Sign your work" section.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
