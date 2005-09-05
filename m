From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 05 Sep 2005 19:51:51 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050905175121.GA24875@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> On 2005-08-31, Mark M. Hoffman wrote:
> > As I pointed out on #linux-sensors, there is what I consider to be a bug
> > in the /sys/class/hwmon handling: if /sys/class/hwmon is not present,
> > SPD/eeproms will be read normally by sensors(1); but if it *is* present,
> > then SPD/eeproms will not be found or displayed.

* Jean Delvare <khali@linux-fr.org> [2005-08-31 11:30:23 +0200]:
> It's a feature :')

> On 2005-08-31, Mark M. Hoffman wrote:
> > Even if we plan to get rid of SPD/eeprom reading from sensors(1) (which
> > I think is sensible), the current behavior is surprising, to say the
> > least.

* Jean Delvare <khali@linux-fr.org> [2005-08-31 11:30:23 +0200]:
> This is true and is likely to raise an unreasonable number of support
> requests.  We need to anticipate that, you are plain right.

> On 2005-08-31, Mark M. Hoffman wrote:
> > I'm sorry I haven't had time to work up a fix - I have a four-day
> > weekend coming up during which I should have some time.  At any rate,
> > IMO it's a release-stopper.

* Jean Delvare <khali@linux-fr.org> [2005-08-31 11:30:23 +0200]:
> I have been thinking of it, and came to the conclusion that it was merely
> a documentation issue.  I was planning to add en entry in the FAQ, a
> news item on our website when we release, and a note to kernel26.html. 
> Don't you think it is sufficient?  What do you suggest?  I would like
> to avoid adding temporary code to libsensors if possible, as we will
> ultimately drop non-hwmon support anyway.

I don't think just documenting it is enough.  Here is an example scenario
that better demonstrates the present "surprising" behavior:

(with just i2c-i801 and eeprom modules loaded using Linux 2.6.12-rc6-mm2)

# sensors

(shows eeprom info)

# modprobe lm78

# sensors

(shows lm78 info but *not* eeprom info)

I know you don't want a lot of temporary code shoved in there, and for that 
matter neither do I.  So here is a minimal patch.  It simply disables eeprom
display for all 2.6.x kernels.  We can rip out the guts of the eeprom code
for the next release - my libsysfs patchset in progress already does some
of that anyway.

This should be easier to document and may also generate fewer bug reports.

Index: lib/proc.c
=================================RCS file: /home/cvs/lm_sensors2/lib/proc.c,v
retrieving revision 1.45
diff -U4 -r1.45 proc.c
--- lib/proc.c	19 Aug 2005 02:59:52 -0000	1.45
+++ lib/proc.c	5 Sep 2005 17:51:22 -0000
@@ -92,8 +92,12 @@
 	/* We don't care about subclients */
 	if (len >= 10 && !strcmp(x + len - 10, " subclient"))
 		return 0;
 
+	/* also, ignore eeproms for all 2.6.x kernels */
+	if (!strcmp(x, "eeprom"))
+		return 0;
+
 	/* Fill in the entry fields */
 	entry.name.prefix = strdup(x);
 	if (entry.name.prefix = NULL)
 		return -SENSORS_ERR_PARSE; /* No better error :( */

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

