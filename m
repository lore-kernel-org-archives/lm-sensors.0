From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2012 14:42:18 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120418164218.386aa38b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 18 Apr 2012 14:11:47 +0100, Martin Suchanek wrote:
> On Wed, Apr 18, 2012 at 12:22 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > My bad, I should have tested more carefully. I tested the command
> > outside of "make" and it worked, but "make" interprets '$' so it needs
> > special care.
> >
> > Updated patch follows, hopefully it will work OK this time:
> >
> > ---
> >  prog/sensors/Module.mk |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- lm-sensors.orig/prog/sensors/Module.mk      2008-03-26
> > 14:37:44.000000000 +0100
> > +++ lm-sensors/prog/sensors/Module.mk   2012-04-18 13:17:51.978110528 +0200
> > @@ -37,7 +37,7 @@ INCLUDEFILES += $(PROGSENSORSSOURCES:.c> >  REMOVESENSORSBIN := $(patsubst
> > $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGSENSORSTARGETS))
> >  REMOVESENSORSMAN := $(patsubst
> > $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENSORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))
> >
> > -LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then
> > echo \-liconv; else echo; fi)
> > +LIBICONV := $(shell if /sbin/ldconfig -p | grep -q '/libiconv\.so$$' ;
> > then echo \-liconv; else echo; fi)
> >
> >  $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
> >        $(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) $(LIBICONV)
> > -Llib -lsensors
> >
> >
> > compiled/installed succesfully.
> Should I test it by some way ?

If it build OK (without warning), that should be enough.

> (
> There is one warning within sudo make install:
> ******************************************************************************
> Warning: Library directory /usr/local/lib is not in /etc/ld.so.conf!
>          Add it and run /sbin/ldconfig for the userspace tools to work.
> ******************************************************************************
> I have checked /etc/ld.so.conf and it contains include
> /etc/ld.so.conf.d/*.conf which actually include /usr/local/bin in
> /etc/ld.so.conf.d/libc.conf
> )

This is another bug, when this check was written the includes
in /etc/ld.so.conf did not exist. So the check should be completed to
take this case into account. The following patch should do. I know it's
not complete as I hardcoded /etc/ld.so.conf.d/*.conf but in practice
that should be good enough.

---
 lib/Module.mk |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lm-sensors.orig/lib/Module.mk	2012-04-05 10:33:39.000000000 +0200
+++ lm-sensors/lib/Module.mk	2012-04-18 16:41:28.432532280 +0200
@@ -144,10 +144,10 @@ endif
 	     echo '         Run the following command: rm /usr/lib/$(LIBSHBASENAME)*' ; \
 	     echo '******************************************************************************' ; \
 	   fi ; \
-	   grep -q '^$(LIBDIR)$$' /etc/ld.so.conf || \
-	   grep -q '^$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
-	   grep -q '[[:space:]:,]$(LIBDIR)$$' /etc/ld.so.conf || \
-	   grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' /etc/ld.so.conf || \
+	   cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)$$' || \
+	   cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '^$(LIBDIR)[[:space:]:,=]' || \
+	   cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)$$' || \
+	   cat /etc/ld.so.conf /etc/ld.so.conf.d/*.conf 2>/dev/null | grep -q '[[:space:]:,]$(LIBDIR)[[:space:]:,=]' || \
 		( echo '******************************************************************************' ; \
 		  echo 'Warning: Library directory $(LIBDIR) is not in /etc/ld.so.conf!' ; \
 		  echo '         Add it and run /sbin/ldconfig for the userspace tools to work.' ; \


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
