From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2012 11:22:11 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120418132211.4fcef7e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 18 Apr 2012 11:20:40 +0100, Martin Suchanek wrote:
> This '/libiconv\.so$' gave me error "/bin/sh: Syntax error: Unterminated
> quoted string". I do not know why ?

My bad, I should have tested more carefully. I tested the command
outside of "make" and it worked, but "make" interprets '$' so it needs
special care.

Updated patch follows, hopefully it will work OK this time:

---
 prog/sensors/Module.mk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/sensors/Module.mk	2008-03-26 14:37:44.000000000 +0100
+++ lm-sensors/prog/sensors/Module.mk	2012-04-18 13:17:51.978110528 +0200
@@ -37,7 +37,7 @@ INCLUDEFILES += $(PROGSENSORSSOURCES:.c REMOVESENSORSBIN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGSENSORSTARGETS))
 REMOVESENSORSMAN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(PROGSENSORSMAN1DIR)/%,$(PROGSENSORSMAN1FILES))
 
-LIBICONV := $(shell if /sbin/ldconfig -p | grep -q libiconv\\.so ; then echo \-liconv; else echo; fi)
+LIBICONV := $(shell if /sbin/ldconfig -p | grep -q '/libiconv\.so$$' ; then echo \-liconv; else echo; fi)
 
 $(PROGSENSORSTARGETS): $(PROGSENSORSSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
 	$(CC) $(EXLDFLAGS) -o $@ $(PROGSENSORSSOURCES:.c=.ro) $(LIBICONV) -Llib -lsensors


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
