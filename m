From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: RFC PATCH sensors-detect (was Re: tickets needing help)
Message-Id: <20040304062020.GC13750@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040303051957.GB9922@earth.solarsys.private>
In-Reply-To: <20040303051957.GB9922@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:
> > -use vars qw(@pci_list);
> > +use vars qw(@pci_list %pci_refs);

* Jean Delvare <khali@linux-fr.org> [2004-03-03 11:00:10 +0100]:
> Why not simply "convert" the old list into the hash, instead of having
> two variables? You can always get a list from a hash using the "values"
> perl function.

OK, I did the conversion (attached).  I also noticed that I had an extra
indirection in there.  It's gone now.

> Once done, we may find that in various places, we are walking the list
> when we could use "exists" instead, and we will be able to optimize
> this. I guess this was your intention anyway. Can you point us to the
> particular places where such changes could be done?

No place at all.  The special SiS handling will need it though.

> > +sub kernel_version
> > +{
> > +  `uname -r` =~ /([0-9]+)\.([0-9]+)\.([0-9]+)(.*)/;
> > +  return ($1, $2, $3, $4);
> > +}
> 
> I'd prefer /^(\d+)\.(\d+)\.(\d+)(.*)/ as the regular expression. BTW, do

Heh, ok.  You begin to see my un-familiarity with Perl...

> we really need the fourth field? I don't much see what we will be doing
> with it, since it's mostly distributor-dependant.

Doesn't hurt.

> Also, I don't think this should be a function. Instead, I'd define a
> global variable (an array, obviously) and  fill it at the beginning of
> the script.

OK.

> We may need functions, on the other hand, for version comparisons.
> Something as "if (kernel_at_least(2,5,75)) { ... }". The function could
> look like:
> 
> sub kernel_at_least
> {
>   my ($maj, $min, $rev) = @_;
>   return 1 if $kver[0] > $maj ||
>     ($kver[0] = maj && ($kver[1] > $min ||
>       ($kver[1] = $min && $kver[2] >= $rev)));
>   return 0;
> }
> 
> (where @kver is the global array containing the kernel version
> information).

Good idea, but I didn't put it in yet.

One other thing: I yanked out the alternate /proc/pci reading routine.
Since CVS doesn't support kernel < 2.4 anymore, it seems unecessary.

Comments?

-- 
Mark M. Hoffman
mhoffman@lightlink.com


Index: sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.281
diff -u -r1.281 sensors-detect
--- sensors-detect	3 Mar 2004 20:19:10 -0000	1.281
+++ sensors-detect	4 Mar 2004 06:24:32 -0000
@@ -1765,6 +1765,14 @@
   }
 }
 
+use vars qw(@kernel_version);
+
+sub initialize_kernel_version
+{
+  `uname -r` =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
+  @kernel_version = ($1, $2, $3, $4);
+}
+
 ###########
 # MODULES #
 ###########
@@ -1784,16 +1792,15 @@
 # PCI ACCESS #
 ##############
 
-use vars qw(@pci_list);
+use vars qw(%pci_list);
 
-# This function returns a list of hashes. Each hash has some PCI information 
+# This function returns a hash of hashes. Each hash has some PCI information
 # (more than we will ever need, probably). The most important
 # fields are 'bus', 'slot', 'func' (they uniquely identify a PCI device in 
 # a computer) and 'vendid','devid' (they uniquely identify a type of device).
-# /proc/bus/pci/devices is only available on late 2.1 and 2.2 kernels.
 sub read_proc_dev_pci
 {
-  my ($dfn,$vend,@pci_list);
+  my ($dfn,$vend,%pci_list);
   open INPUTFILE, "/proc/bus/pci/devices" or return;
   while (<INPUTFILE>) {
     my $record = {};
@@ -1806,48 +1813,18 @@
     $record->{func} = $dfn & 0x07;
     $record->{vendid} = $vend >> 16;
     $record->{devid} = $vend & 0xffff;
-  push @pci_list,$record;
-  }
-  close INPUTFILE or return;
-  return @pci_list;
-}
-
-# This function returns a list of hashes. Each hash has some PCI 
-# information. The important fields here are 'bus', 'slot', 'func' (they
-# uniquely identify a PCI device in a computer) and 'desc' (a functional
-# description of the PCI device). If this is an 'unknown device', the
-# vendid and devid fields are set instead.
-sub read_proc_pci
-{
-  my @pci_list;
-  open INPUTFILE, "/proc/pci" or return;
-  while (<INPUTFILE>) {
-    my $record = {};
-    if (($record->{bus},$record->{slot},$record->{func}) = 
-        /^\s*Bus\s*(\S)+\s*,\s*device\s*(\S+)\s*,\s*function\s*(\S+)\s*:\s*$/) {
-      my $desc = <INPUTFILE>;
-      $_ = <INPUTFILE>;
-      if (($desc =~ /Unknown device/) and
-              (($record->{vendid},$record->{devid}) = 
-                         /^\s*Vendor id=(\S+)\.\s*Device id=(\S+)\.$/)) {
-        $record->{vendid} = hex $record->{vendid};
-        $record->{devid} = hex $record->{devid};
-      } else {
-        $record->{desc} = $desc;
-      }
-      push @pci_list,$record;
-    }
+    
+    $pci_list{ sprintf("%04x:%04x",$record->{vendid},$record->{devid}) } +	$record;
   }
   close INPUTFILE or return;
-  return @pci_list;
+  return %pci_list;
 }
 
 sub initialize_proc_pci
 {
-  @pci_list = read_proc_dev_pci;
-  @pci_list = read_proc_pci     if not defined @pci_list;
-  die "Can't access either /proc/bus/pci/ or /proc/pci!" 
-                                    if not defined @pci_list;
+  %pci_list = read_proc_dev_pci;
+  die "Can't access /proc/bus/pci/devices!" if not defined %pci_list;
 }
 
 #####################
@@ -1872,10 +1849,10 @@
 
 sub adapter_pci_detection
 {
-  my ($device,$try,@res);
+  my ($key,$device,$try,@res);
   print "Probing for PCI bus adapters...\n";
 
-  foreach $device (@pci_list) {
+  while ( ($key, $device) = each %pci_list) {
     foreach $try (@pci_adapters) {
       if ((defined($device->{vendid}) and 
            $try->{vendid} = $device->{vendid} and
@@ -3390,7 +3367,7 @@
 sub sis5595_isa_detect
 {
   my ($addr) = @_;
-  my ($adapter,$try,$local_try);
+  my ($key,$adapter,$try,$local_try);
   my $found = 0;
   foreach $local_try (@pci_adapters) {
     if ($local_try->{procid} eq "Silicon Integrated Systems SIS5595") {
@@ -3402,7 +3379,7 @@
   return if not $found;
 
   $found = 0;
-  foreach $adapter (@pci_list) {
+  while ( ($key, $adapter) = each %pci_list) {
     if ((defined($adapter->{vendid}) and 
          $try->{vendid} = $adapter->{vendid} and
          $try->{devid} = $adapter->{devid} and
@@ -3426,7 +3403,7 @@
 sub via686a_isa_detect
 {
   my ($addr) = @_;
-  my ($adapter,$try,$local_try);
+  my ($key,$adapter,$try,$local_try);
   my $found = 0;
   foreach $local_try (@pci_adapters) {
     if ($local_try->{procid} eq "VIA Technologies VT82C686 Apollo ACPI") {
@@ -3438,7 +3415,7 @@
   return if not $found;
 
   $found = 0;
-  foreach $adapter (@pci_list) {
+  while ( ($key, $adapter) = each %pci_list) {
     if ((defined($adapter->{vendid}) and 
          $try->{vendid} = $adapter->{vendid} and
          $try->{devid} = $adapter->{devid} and
@@ -3462,7 +3439,7 @@
 sub via8231_isa_detect
 {
   my ($addr) = @_;
-  my ($adapter,$try,$local_try);
+  my ($key,$adapter,$try,$local_try);
   my $found = 0;
   foreach $local_try (@pci_adapters) {
     if ($local_try->{procid} eq "VIA Technologies VT8231 South Bridge") {
@@ -3474,7 +3451,7 @@
   return if not $found;
 
   $found = 0;
-  foreach $adapter (@pci_list) {
+  while ( ($key, $adapter) = each %pci_list) {
     if ((defined($adapter->{vendid}) and 
          $try->{vendid} = $adapter->{vendid} and
          $try->{devid} = $adapter->{devid} and
@@ -4155,6 +4132,7 @@
   initialize_conf;
   initialize_proc_pci;
   initialize_modules_list;
+  initialize_kernel_version;
 
   print "\nThis program will help you determine which I2C/SMBus modules you need to\n",
         "load to use lm_sensors most effectively. You need to have i2c and\n",
