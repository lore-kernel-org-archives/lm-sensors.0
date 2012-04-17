From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Apr 2012 11:34:55 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120417133455.38ac9139@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

Again, please keep the discussion list in Cc, for the interest of
other readers and the archives.

On Mon, 16 Apr 2012 18:13:38 +0100, Martin Suchanek wrote:
> > Please list all files that match /usr/lib/libiconv.so.*, and for each
> > of them, check which package provides it.
> >
> only
> /usr/lib/libiconv.so.2 ... php-5.3-fcgi-zend-server package

Hmm, OK. Very odd to have a generic library in such a specific package.
I presume this package isn't part of Ubuntu but is a proprietary
package from Zend?

> Then as a test you can edit prog/sensors/Module.mk, search for the
> > following line:
> >
> > LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then
> > echo \-liconv; else echo; fi)
> >
> > Replace with:
> >
> > LIBICONV :> >
> > and try building again. Obviously this can't be a definitive fix but at
> > least it will tell us if you really need libiconv or not.
> >
> compiled ok
> 
> Is there some conflict ?

Not really a conflict, rather the build system is confused because
libiconf.so.2 is available at runtime but libiconf.so isn't available
for build-time linking. I think we should ignore libiconv in this case,
and hope it's not needed. Please revert the previous change and try the
following patch instead, I'll apply it if it works for you.

---
 prog/sensors/Module.mk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/sensors/Module.mk	2008-03-26 14:37:44.000000000 +0100
+++ lm-sensors/prog/sensors/Module.mk	2012-04-17 13:32:29.857884198 +0200
@@ -37,7 +37,7 @@ INCLUDEFILES += $(PROGSENSORSSOURCES:.c REMOVESENSORSBIN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGSENSORSTARGETS))
 REMOVESENSORSMAN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENSORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))
 
-LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then echo \-liconv; else echo; fi)
+LIBICONV := $(shell if /sbin/ldconfig -p | grep -q '/libiconv\.so$' ; then echo \-liconv; else echo; fi)
 
 $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
 	$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) $(LIBICONV) -Llib -lsensors


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
