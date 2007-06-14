From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 14 Jun 2007 19:26:25 +0000
Subject: Re: [lm-sensors] sensor-detect and non-compliant SMSC Super I/Os
Message-Id: <191fb4ca0706141226w51f98492mae15d14bd8d21e39@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
In-Reply-To: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/12/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 11 Jun 2007 21:54:50 +0200, Hans de Goede wrote:
> > Juerg Haefliger wrote:
> >  > All,
> >  >
> >  > I looked through a lot of SMSC datasheets the last couple of days with
> >  > the goal to improve sensor-detect to correctly identify more SMSC
> >  > Super I/Os. I noticed that some of the chips don't conform to the ISA
> >  > PNP standard with the device ID register living at a different address
> >  > (0x0d instead of 0x20). In order to correctly identify those chips, a
> >  > somewhat ugly (and totally SMSC specific) hack would be necessary.
> >  > Something like reading from both addresses and then using the value
> >  > from 0x0d for some of the SMSC chips.
> >  >
> >  > I wonder how much value this adds given that none of these Super IOs
> >  > have HW monitoring capabilities? The only benefit I can see is that
> >  > the chip is correctly identified and we can flag it as not being a
> >  > sensor and thus users won't bug us for adding support.
> >  >
> >  > Any thoughts, comments, ideas?
> >  >
> >
> > I think that if the hack isn't too gross, it would be good to also be able to
> > identify those chips.
>
> Same for me, it depends on how the code looks like. If it's clean and
> safe, no objection.
>
> I am curious how you can tell between the two types of register
> mappings? Is there a perfect solution, or do you have some heuristic?

I can't tell. It's arbitrary. Some of these chips have the LPC base
address (0x2e/0x4e) in register 0x12 but not all of them of course.
SMSC doesn't make it easy for us...

Anyways, below is a first shot. Let me know what you think, I'm sure
it has room for improvements :-)

...juerg



--- lm-sensors.orig/prog/detect/sensors-detect	2007-06-13
08:18:39.981298000 -0700
+++ lm-sensors/prog/detect/sensors-detect	2007-06-14 12:18:33.759404000 -0700
@@ -1831,6 +1831,20 @@ use vars qw(@chip_kern24_ids @chip_kern2
 	driver => "via-smbus-only",
 	devid => 0x77,
       },
+      {
+	name => "SMSC LPC47N227 Super IO",
+	driver => "not-a-sensor",
+	devid => 0x5a,
+	# Non-standard device ID register address
+	devidreg => 0x0d,
+      },
+      {
+	name => "SMSC FDC37N769 Super IO",
+	driver => "not-a-sensor",
+	devid => 0x28,
+	# Non-standard device ID register address
+	devidreg => 0x0d,
+      },
     ],
   },
   {
@@ -3193,6 +3207,7 @@ sub scan_superio
 {
   my ($addrreg, $datareg) = @_;
   my ($val, $found);
+  my (%devid, $reg, $chip);

   printf("Probing for Super-I/O at 0x\%x/0x\%x\n", $addrreg, $datareg);

@@ -3206,28 +3221,54 @@ sub scan_superio
     foreach $val (@{$family->{enter}->{$addrreg}}) {
       outb($addrreg, $val);
     }
-# did it work?
-    outb($addrreg, $superio{devidreg});
-    $val = inb($datareg);
-    outb($addrreg, $superio{devidreg} + 1);
-    $val = ($val << 8) | inb($datareg);
-    if ($val = 0x0000 || $val = 0xffff) {
-      print "No\n";
-      next FAMILY;
+# assemble all possible devid registers for this family
+    foreach $chip (\%superio, @{$family->{chips}}) {
+	if ($chip->{devidreg}) {
+	    $devid{$chip->{devidreg}} = 0;
+	}
+    }
+# read devid registers
+    foreach $reg (keys %devid) {
+	outb($addrreg, $reg);
+	$val = inb($datareg);
+	outb($addrreg, $reg + 1);
+	$val = ($val << 8) | inb($datareg);
+	if ($val = 0x0000 || $val = 0xffff) {
+	    delete $devid{$reg};
+	} else {
+	    $devid{$reg} = $val;
+	}
+    }
+    if (!%devid) {
+	print "No\n";
+	next FAMILY;
     }
     print "Yes\n";

     $found = 0;
-    foreach my $chip (@{$family->{chips}}) {
-      if (($chip->{devid} > 0xff && ($val & ($chip->{devid_mask} ||
0xffff)) = $chip->{devid})
-       || ($chip->{devid} <= 0xff && ($val >> 8) = $chip->{devid})) {
-        probe_superio($addrreg, $datareg, $chip);
-        $found++;
-      }
+    foreach $chip (@{$family->{chips}}) {
+	foreach $reg (keys %devid) {
+	    $val = $devid{$reg};
+	    if (($chip->{devid} > 0xff &&
+		 ($val & ($chip->{devid_mask} || 0xffff)) = $chip->{devid}) ||
+		($chip->{devid} <= 0xff && ($val >> 8) = $chip->{devid})) {
+		probe_superio($addrreg, $datareg, $chip);
+		$found++;
+	    }
+	}
     }

     if (!$found) {
-      printf("Found unknown chip with ID 0x%04x\n", $val);
+	if (scalar(keys %devid) = 1 && $devid{$superio{devidreg}}) {
+	    printf("Found unknown chip with ID 0x%04x\n",
+		   $devid{$superio{devidreg}});
+	} else {
+	    printf("Found unknown chip with possible IDs ");
+	    foreach $reg (keys %devid) {
+		printf("0x%04x(0x%02x) ", $devid{$reg}, $reg);
+	    }
+	    printf("\n");
+	}
       # Guess if a logical device could correspond to sensors
       guess_superio_ld($addrreg, $datareg, $family->{guess})
         if defined $family->{guess};

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
