From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Feb 2009 09:45:56 +0000
Subject: Re: [lm-sensors] [RFC] lm-sensors-3.1.0: Create /etc/sensors.d
Message-Id: <20090226104556.21af9954@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090225084923.GA4434@ubuntu>
In-Reply-To: <20090225084923.GA4434@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 26 Feb 2009 10:38:44 +0100, Andre Prendel wrote:
> On Wed, Feb 25, 2009 at 02:36:01PM +0100, Gabriel C wrote:
> > Jean Delvare wrote:
> > > Yes, I agree, let's create directory sensors.d as part of the
> > > installation process.
> > 
> > Maybe something like the following patch ? :
> 
> Jean, what about applying the patch below. Should I do? Will you do?

Please take care of it.

> > ( maybe some README file in this directory won't be bad to have ? )
> > 
> > Index: etc/Module.mk
> > =================================> > --- etc/Module.mk	(Revision 5663)
> > +++ etc/Module.mk	(Arbeitskopie)
> > @@ -24,12 +24,14 @@
> >  
> >  ETCTARGET := $(MODULE_DIR)/sensors.conf.default
> >  ETCINSTALL := $(ETCDIR)/sensors3.conf
> > +ETCINSTALL_DIR_D := $(ETCDIR)/sensors.d
> >  
> >  
> >  # No all rule
> >  
> >  install-etc:
> >  	$(MKDIR) $(DESTDIR)$(ETCDIR)
> > +	$(MKDIR) $(DESTDIR)$(ETCINSTALL_DIR_D)
> >  	if [ ! -e $(DESTDIR)$(ETCINSTALL) ] ; then \
> >  	  $(INSTALL) -m 644 $(ETCTARGET) $(DESTDIR)$(ETCINSTALL); \
> >  	fi


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
