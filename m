From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 26 Jun 2009 08:29:33 +0000
Subject: Re: [lm-sensors] Another possible hwmon project
Message-Id: <20090626082933.GD4510@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624081700.GB4949@ubuntu>
In-Reply-To: <20090624081700.GB4949@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 24, 2009 at 10:24:03AM +0200, Hans de Goede wrote:

<snip>

> >>>> I don't think you need to dig that deep wrt DMI,
> >>> I want to know how things work at low level. This makes things easier
> >>> to understand for me.
> >>>
> >>>> what we will most likely
> >>>> and up doing is looking for the strings found inside
> >>>> /sys/devices/virtual/dmi/id/board_name
> >>>> /sys/devices/virtual/dmi/id/board_vendor
> >>> I can't see these files in sysfs. What driver is responsible for creation?
> >>>
> >> Hmm, strange, I dunno on all my systems they just exists. Weird, maybe you
> >> are running a somewhat old kernel ?
> >
> > Ok, I've found the files on my system under /sys/class/dmi/id/. Driver
> > /drivers/firmware/dmi-id.c creates the files. The driver was
> > introduced in 2007.
> >
> 
> Hmm, ok, I have them there too (/sys/class/dmi/id is a symlink to
> /sys/devices/virtual/dmi/id on my system), so if /sys/class/dmi/id
> works on more systems / kernel configs lets use that.

Ok, that's a known issue. Sensors-detect already take care of it.

---
r5530 | khali | 2008-12-05 23:56:30 +0100 (Fr, 05. Dez 2008) | 3 lines

Alternatively look for DMI data in /sys/class/dmi/id, as
/sys/devices/virtual/dmi/id only exists since kernel 2.6.28.

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(Revision 5529)
+++ prog/detect/sensors-detect	(Revision 5530)
@@ -2150,11 +2150,13 @@
   	    'System Manufacturer' => 1,
 	    	    'System Name' => 1,
 		    );
+		    my $dmi_id_dir;
 
	# First try reading the strings from sysfs if available
-	if (-d "$sysfs_root/devices/virtual/dmi/id") {
+	if (-d ($dmi_id_dir = "$sysfs_root/devices/virtual/dmi/id")	# kernel >= 2.6.28
+	 || -d ($dmi_id_dir = "$sysfs_root/class/dmi/id")) {
 	    foreach my $k (keys %items) {
-	    	       $dmi{$k} = sysfs_device_attribute("$sysfs_root/devices/virtual/dmi/id", $k);
+		       		  $dmi{$k} = sysfs_device_attribute($dmi_id_dir, $k);
 				  	   }
 					   } else {
 					     # Else fallback on calling dmidecode
---

Looking for both should be the best.

> > Jean, could you bring some light into the darkness? I've seen you did
> > some work on the DMI stuff.
> >
> > I'm using the most recent mainline kernel form git. Hans, what version
> > do you use?
> >
> 
> I'm using a stock Fedora 11 kernel, I think this might be related to
> the various sysfs compatibility kernel configuration options.
> 
> > BTW, Jean. Hans asked me for working on the automatic configuration of
> > sensors using DMI information.
> >
> 
> Ack, its still something which I would like to see done, so I suggested the
> idea to Andre.
> 
> Andre, as said before I think once you're done orienting yourself, the first
> thing to do is write a proposal how this all will work and send it to the
> list.
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
