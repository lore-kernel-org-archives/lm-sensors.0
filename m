From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 20 Dec 2012 16:39:45 +0000
Subject: Re: [lm-sensors] i2c tools build failure with gcc 4.6
Message-Id: <20121220163945.GB32096@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121220010733.GA31336@roeck-us.net>
 <20121220104510.2fa8a0fb@endymion.delvare>
 <20121220142006.GB32230@roeck-us.net>
 <20121220153735.2ae73802@endymion.delvare>
 <20121220155354.3e600483@endymion.delvare>
In-Reply-To: <20121220155354.3e600483-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Thu, Dec 20, 2012 at 03:53:54PM +0100, Jean Delvare wrote:
> On Thu, 20 Dec 2012 15:37:35 +0100, Jean Delvare wrote:
> > On Thu, 20 Dec 2012 06:20:06 -0800, Guenter Roeck wrote:
> > > On Thu, Dec 20, 2012 at 10:45:10AM +0100, Jean Delvare wrote:
> > > > Hi Guenter,
> > > > 
> > > > On Wed, 19 Dec 2012 17:07:33 -0800, Guenter Roeck wrote:
> > > > > Seen with latest i2c-tools from svn repository.
> > > > 
> > > > With the subversion repository having gone on vacation, "latest"
> > > > doesn't mean much :(
> > > > 
> > > Oh, right, "the latest one I have", which is svn revision 6075. Is that the
> > > latest ?
> > 
> > "svn status -u" says 6091 but I think this includes the changes to
> > other trees (lm-sensors.) I have i2c-tools/CHANGES at revision 6083.
> 
> The SVN repository should be back now, thanks to Axel Thimm.
> 

I found the problem. -li2c must be specified after the .o files.

Patch:

diff --git a/tools/Module.mk b/tools/Module.mk
index 1979248..bfd3250 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -21,16 +21,16 @@ TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 #
 
 $(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o
-	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
 $(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) -o $@ $^  $(TOOLS_LDFLAGS)
 
 $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
 $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
-	$(CC) $(LDFLAGS) $(TOOLS_LDFLAGS) -o $@ $^
+	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
 #
 # Objects

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
