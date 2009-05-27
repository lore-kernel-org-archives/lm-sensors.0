From: Matthew Wilcox <matthew@wil.cx>
Date: Wed, 27 May 2009 16:38:37 +0000
Subject: Re: [lm-sensors] PCI: Quirk for hwmon access on MSI MS-7031 board
Message-Id: <20090527163837.GI5816@parisc-linux.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090525220652.04c2468f@hyperion.delvare>
In-Reply-To: <20090525220652.04c2468f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 27, 2009 at 06:30:05PM +0200, Jean Delvare wrote:
> > > +#if defined CONFIG_X86 && (defined CONFIG_HWMON || defined CONFIG_HWMON_MODULE)
> > 
> > I don't like this.  It goes against the principle that enabling a module
> > shouldn't cause the base kernel to get rebuilt. Is there a reason that
> > the hardware monitoring code can't contain this quirk instead of the
> > generic PCI code?
> 
> No reason other than the fact that putting it in pci/quirks.c was
> easier. I can certainly move the quirk to hwmon/hwmon.c, but as far as
> I can see you have the exact same problem there: enabling or disabling
> PCI support will cause the base hwmon module to be rebuilt. If hwmon is
> built into the kernel then you have to relink the kernel.

Trust me, if you enable or disable PCI support, you already have to
relink the kernel ;-)

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
