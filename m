From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: RFC PATCH sensors-detect (was Re: tickets needing help)
Message-Id: <20040303051957.GB9922@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A couple months ago, I wrote...

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-01-06 00:01:18 -0500]:
> > > To really do it properly, it needs to be aware of 2.4 vs. 2.6, due to
> > > the fact that the ridiculous PCI device unhiding happens at driver
> > > load in the former, at bootup in the latter.
> > > 
> > > I.e. if we only had 2.6 to worry about, i2c-sis96x would have a single
> > > PCI device entry in the table and detection would be nice and generic
> > > like all the rest.
> > > 
> > > Instead, what I should do is yank all the sis96x and sis5595 entries
> > > (because that misdetects all 96x) out of that table and write a
> > > special- purpose function for detecting them properly.
> > > 
> > > I'm not a perl wizard (in fact I dislike perl) so I'm inclined to just
> > > list both devices and attack the rest later, if ever.

I still don't like perl much, but here's a patch/RFC.  It's not at all
complete: I'd just like a second opinion on %pci_refs.  The idea is that
we'll be able to do this:

	if (exists $pci_refs{"1039:0645"}) { ... }

In fact, I think @pci_list should have been a hash of references instead
of an array.  Could it be that sensors-detect is old enough to predate perl5?

Oh, and there's a kernel version function too.  Comments?

(I won't commit any of this before the next release.)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.280
diff -u -r1.280 sensors-detect
--- prog/detect/sensors-detect	2 Mar 2004 21:05:44 -0000	1.280
+++ prog/detect/sensors-detect	3 Mar 2004 05:22:26 -0000
@@ -1784,7 +1784,7 @@
 # PCI ACCESS #
 ##############
 
-use vars qw(@pci_list);
+use vars qw(@pci_list %pci_refs);
 
 # This function returns a list of hashes. Each hash has some PCI information 
 # (more than we will ever need, probably). The most important
@@ -1806,10 +1806,12 @@
     $record->{func} = $dfn & 0x07;
     $record->{vendid} = $vend >> 16;
     $record->{devid} = $vend & 0xffff;
-  push @pci_list,$record;
+    push @pci_list,$record;
+    $pci_refs{ sprintf("%04x:%04x",$record->{vendid},$record->{devid}) } +	\$record;
   }
   close INPUTFILE or return;
-  return @pci_list;
+  return (@pci_list, %pci_refs);
 }
 
 # This function returns a list of hashes. Each hash has some PCI 
@@ -1836,16 +1838,18 @@
         $record->{desc} = $desc;
       }
       push @pci_list,$record;
+      $pci_refs{ sprintf("%04x:%04x",$record->{vendid},$record->{devid}) } +          \$record;
     }
   }
   close INPUTFILE or return;
-  return @pci_list;
+  return (@pci_list, %pci_refs);
 }
 
 sub initialize_proc_pci
 {
-  @pci_list = read_proc_dev_pci;
-  @pci_list = read_proc_pci     if not defined @pci_list;
+  (@pci_list, %pci_refs) = read_proc_dev_pci;
+  (@pci_list, %pci_refs) = read_proc_pci     if not defined @pci_list;
   die "Can't access either /proc/bus/pci/ or /proc/pci!" 
                                     if not defined @pci_list;
 }
@@ -4149,6 +4153,12 @@
   exit;
 }
 
+sub kernel_version
+{
+  `uname -r` =~ /([0-9]+)\.([0-9]+)\.([0-9]+)(.*)/;
+  return ($1, $2, $3, $4);
+}
+
 sub main
 {
   my (@adapters,$res,$did_adapter_detection,$detect_others,$adapter);
