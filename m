From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 26 Feb 2009 09:38:44 +0000
Subject: Re: [lm-sensors] [RFC] lm-sensors-3.1.0: Create
Message-Id: <20090226093844.GA4330@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090225144338.GA10526@ubuntu>
In-Reply-To: <20090225144338.GA10526@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 25, 2009 at 02:36:01PM +0100, Gabriel C wrote:
> Jean Delvare wrote:
> 
> > Hi Andre,
> > 
> > On Wed, 25 Feb 2009 11:20:09 +0100, Andre Prendel wrote:
> >> On Wed, Feb 25, 2009 at 10:11:21AM +0100, Jean Delvare wrote:
> >>> On Wed, 25 Feb 2009 09:49:23 +0100, Andre Prendel wrote:
> >>>> lm-sensors-3.1.0 will introduce multiple configuration files support. The
> >>>> related directory /etc/sensors.d is not created by default. Maybe we
> >>>> should do that during installation, shouldn't we?
> >>> I agree. While this directory isn't required, its presence will make
> >>> people realize that they can put configuration files there. Want to
> >>> give it a try?
> >> Do you know how other packages handle such things? You are a packager
> >> too, aren't you? Maybe we should leave that to the packagers?
> > 
> > I package some projects in openSUSE but not that many, and none of them
> > has an /etc/*.d directory so I can't compare. I don't see why this
> > should be left to the packager. We define the default as we see fit,
> > and then each packager is free to chose which file they package and
> > which they don't.
> > 
> > All I can say is that all /etc/*.d directories in openSUSE belong to at
> > least one package. And sometimes the directory is empty
> > (/etc/aliases.d, /etc/depmod.d). So it seems to be expected that
> > packages create these directories.
> > 
> >> Nevertheless, IMO we should provide the infrastructure (directory
> >> layout) for the multiple configuration files support.
> > 
> > Yes, I agree, let's create directory sensors.d as part of the
> > installation process.
> > 
 
> 
> Maybe something like the following patch ? :

Jean, what about applying the patch below. Should I do? Will you do?

> ( maybe some README file in this directory won't be bad to have ? )
> 
> Index: etc/Module.mk
> =================================> --- etc/Module.mk	(Revision 5663)
> +++ etc/Module.mk	(Arbeitskopie)
> @@ -24,12 +24,14 @@
>  
>  ETCTARGET := $(MODULE_DIR)/sensors.conf.default
>  ETCINSTALL := $(ETCDIR)/sensors3.conf
> +ETCINSTALL_DIR_D := $(ETCDIR)/sensors.d
>  
>  
>  # No all rule
>  
>  install-etc:
>  	$(MKDIR) $(DESTDIR)$(ETCDIR)
> +	$(MKDIR) $(DESTDIR)$(ETCINSTALL_DIR_D)
>  	if [ ! -e $(DESTDIR)$(ETCINSTALL) ] ; then \
>  	  $(INSTALL) -m 644 $(ETCTARGET) $(DESTDIR)$(ETCINSTALL); \
>  	fi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
