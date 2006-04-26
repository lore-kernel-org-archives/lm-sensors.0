From: bezaur@gmail.com (Charles Spirakis)
Date: Wed, 26 Apr 2006 21:54:19 +0000
Subject: [lm-sensors] sensors-detect: Update sensors-detect to handle new
Message-Id: <5bfe43f80604261454g6c48e2a3o926d5a783976563f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All --

Based on an earlier discussion:

>> * sensors-detect needs to be updated, as for now it points the W83791D
> > owners to the w83781d driver regardless of the kernel version. Patch
>> > anyone?
>>
>> Yes, it detects the w83791d correctly and tells you to load the
w83781d driver:
>>
>> Driver `w83781d' (should be inserted):
>>   Detects correctly:
>>   * Bus `SMBus I801 adapter at 0540'
>>     Busdriver `i2c-i801', I2C address 0x2c (and 0x48 0x49)
>>     Chip `Winbond W83791D' (confidence: 7)
>>
>> I haven't looked at that code/scripts, but I can update depending on
>> how you want to handle it (check for 2.4 vs. 2.6 and output as
>> appropriate?)
>
>I haven't look in deep either, but I remember that we have a similar
>case for one SiS SMBus driver: it's named i2c-sis645 on Linux 2.4 and
>i2c-sis96x on Linux 2.6, and we have some code to pick the right driver
>depending on the kernel version. So let's do it the same way for the
>W83791D case and it should be fine.

To handle the 2.4/2.6 different for the SiS adapter, there are extra
sis elements (@pci_adapters_sis5595 @pci_adapters_sis645
@pci_adapters_sis96x ~ line 844) and a new routine
(adapter_pci_detection_sis_96x() ~ line 2134) which then pushes one or
more of the new elements onto the @pci_adapters list as needed (called
~ line 2183). Line numbers are based on sensors-detect perl script
from the lm-sensors package version 2.10.0.

Since the w83781d is part of the @chip_ids list and not part of the
@pci_adapters list (or checks), it seemed like trying to overuse the
sis subroutine may not make sense. Thus, there seemed to be three
choices for handling the w83791d:

1) Follow the general sis pattern and create two new entries for the
w83791d - one for the 2.4 kernel and one for the 2.6 kernel, then
create a routine to pushd the correct entry onto the @chip_ids list
(similar to what the SiS is doing for the adapter, but for chips).

2) Create a routine that walks the @chip_ids list and modifies
specific chip_id entries for earlier kernels as needed.

3) Special case the driver field to allow for a "driver-choice"
(similar to "to-be-written" and "not-a-sensor" that's available now).
When the "driver-choice" string is seen, then have a driver_choice
field (a new field in a chip element) point to a subroutine to give
you the actual driver name.

4) Other???

I admit, Perl is not my native language so it's possible (4) is the
right answer. So, before submitting an "official" patch, I prototyped
choices (1) and (2) above and included them below for comment. If it's
easier, I can turn one (or both) into a real patch for people to
try...

Preferences? Thoughts? Comments?

-- charles


== Not a real patch, but something to give people a feel for the
changes for option 1 =
--- sensors-detect.000  Tue Apr 25 11:20:26 2006
+++ sensors-detect      Wed Apr 26 14:37:30 2006
@@ -915,6 +915,24 @@
             w83791sd_detect vt1211_i2c_detect vt1211_alias_detect
             smsc47m192_detect);

+# Special case chip information goes here and would be included in
+# the chip_special_cases routine below
+use vars qw($chip_ids_kern24_w83791d $chip_ids_kern26_w83791d);
+$chip_ids_kern24_w83791d = {
+       name => "Winbond W83791D",
+       driver => "w83781d",
+       i2c_addrs => [0x2c..0x2f],
+       i2c_detect => sub { w83781d_detect 7, @_},
+};
+
+$chip_ids_kern26_w83791d = {
+       name => "Winbond W83791D",
+       driver => "w83791d",
+       i2c_addrs => [0x2c..0x2f],
+       i2c_detect => sub { w83781d_detect 7, @_},
+};
+
+
 # This is a list of all recognized chips.
 # Each entry must have the following fields:
 #  name: The full chip name
@@ -1054,12 +1072,6 @@
        i2c_detect => sub { w83781d_detect 2, @_},
      } ,
      {
-       name => "Winbond W83791D",
-       driver => "w83781d",
-       i2c_addrs => [0x2c..0x2f],
-       i2c_detect => sub { w83781d_detect 7, @_},
-     },
-     {
        name => "Winbond W83792D",
        driver => "w83792d",
        i2c_addrs => [0x2c..0x2f],
@@ -2844,6 +2856,20 @@
 # this program will surely confuse them. But we guarantee never to write to
 # any of these devices.

+# This routine allows you to select which chips are optionally added to the
+# chip detection list. The most common use is to allow for different chip
+# detection/drivers based on different linux kernels
+# This routine follows the pattern of the Sis adapter special cases
+sub chip_special_cases
+{
+  # Based on the kernel, add the appropriate chip structure to the
+  # chip_ids detection list
+  if (kernel_version_at_least(2,6,0)) {
+    push @chip_ids, $chip_ids_kern26_w83791d;
+  } elsif (kernel_version_at_least(2,4,0)) {
+    push @chip_ids, $chip_ids_kern24_w83791d;
+  }
+}

 # $_[0]: A reference to the file descriptor to access this chip.
 #        We may assume an i2c_set_slave_addr was already done.
@@ -5077,6 +5103,10 @@
     }
   }

+  # Before looking for chips, make sure any special case chips are
+  # added to the chip_ids list
+  chip_special_cases();
+
   print "\n We are now going to do the adapter probings. Some adapters may ",
         "hang halfway\n",
         " through; we can't really help that. Also, some chips will
be double ",


== not a real patch, but something to give people a feel for the
changes for option 2  =
--- sensors-detect.000  Tue Apr 25 11:20:26 2006
+++ sensors-detect      Wed Apr 26 11:28:07 2006
@@ -1055,7 +1055,7 @@
      } ,
      {
        name => "Winbond W83791D",
-       driver => "w83781d",
+       driver => "w83791d",
        i2c_addrs => [0x2c..0x2f],
        i2c_detect => sub { w83781d_detect 7, @_},
      },
@@ -2844,6 +2844,27 @@
 # this program will surely confuse them. But we guarantee never to write to
 # any of these devices.

+# The @chip_ids list is based on what's needed for the most recent kernel
+# (2.6 in our case). This routine allows you to add or modify entries
+# on the chip_ids list if you have special case needs.
+sub chip_special_cases
+{
+  my $chip_ref;
+
+  # Based on the kernel, add the appropriate chip structure to the
+  # chip_ids detection list
+  if (kernel_version_at_least(2,6,0)) {
+    # Nothing to do
+  } elsif (kernel_version_at_least(2,4,0)) {
+    for $chip_ref (@chip_ids) {
+      # The w83791d chip uses the w83781d driver from 2.4 kernels
+      if ($chip_ref->{'name'} eq 'Winbond W83791D') {
+        $chip_ref->{'driver'} = "w83781d";
+      }
+    }
+  }
+}
+

 # $_[0]: A reference to the file descriptor to access this chip.
 #        We may assume an i2c_set_slave_addr was already done.
@@ -5077,6 +5098,10 @@
     }
   }

+  # Before looking for chips, make sure any special case chip needs
+  # are handled
+  chip_special_cases();
+
   print "\n We are now going to do the adapter probings. Some adapters may ",
         "hang halfway\n",
         " through; we can't really help that. Also, some chips will
be double ",

===== end of proposed email =======
