From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030913212955.07555e89.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Client found at address 0x1f
> Probing for `Maxim MAX6650/MAX6651'... Success!
>     (confidence 4, driver `max6650')

Hey, that's great. That's a brand new driver written by John Morris.
Please let us know how it does work for you.

> Client found at address 0x4d
> (...)
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> (...)
> Probing for `TI THMC10'... Success!
>     (confidence 6, driver `adm1021')

That's bad. Shouldn't do that. See right below.

> Driver `adm1021' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
>     Busdriver `i2c-piix4', I2C address 0x4d
>     Chip `TI THMC10' (confidence: 6)
>   Misdetects:
>   * Bus `SMBus PIIX4 adapter at 2180' (Non-I2C SMBus adapter)
>     Busdriver `i2c-piix4', I2C address 0x4d
>     Chip `Maxim MAX1617' (confidence: 3)
> (...)
> options adm1021 ignore=0,0x4d

There's a first problem there. The sensors-detect script is confused by
the fact that two possible chips were detected at address 0x4d. It
*should* chose the higher-confidence'd one and silently ignore the other
one.

Attached is a patch that I believe should do that. I can't really test
it, could you please apply and test?

> Board:       +53?C  (low =  +20?C, high =  +60?C)        
> CPU:         +52?C  (low =  +20?C, high =  +60?C)        
> (...)
> Board:      -101?C  (low = -101?C, high = -101?C)        
> CPU:        -101?C  (low = -101?C, high =  +60?C)        ALARM (HIGH)

Interesting. Without the config file, everything seems to be OK. Once
you tell sensors to read the config file, values are weird. What's even
stranger is that the config section for thmc50 is almost empty. So it
looks like a coincidence to me.


> Thu Sep 11 16:47:11 EST 2003
> >>> even though the time indicates 1-2seconds have passed, in reality
> >>> a HELL of a lot more time has passed

This means that your system clock itself is being slowed. That's bad.

> i2c-piix4.o: Error: no response!
> i2c-piix4.o: Error: no response!
> i2c-piix4.o: Error: no response!
> i2c-piix4.o: Error: no response!
> i2c-piix4.o: Error: no response!
> i2c-piix4.o: Error: no response!
> (...)

The problem is obviously there. The adm1021 module isn't even loaded and
i2c-piix4 already complains. So that's your piix4 that is causing the
trouble, not the thmc50 chipset. On the other hand, you have the same
messages on your second try, while everything is working OK.

> After the reboot I try again, this time telling lmsensors to use the
> ISA bus for its readings. In this case, no slowdown and everything is
> rosy.

As I stated once before, your chipsets have no ISA interface, so this
choice doesn't actually change anything. I believe sensors-detect gives
you the same configuration files in both cases. So, if you observe a
different behavior, there must be something else that is significantly
different.

> And now for the AMD system. This exhibits different problems in that
> it doesn't slow the system down any, but the readings given are static
> (ie no updates) in both 2.4 and 2.6 series kernels.
> (...)
> lm84-i2c-1-4e
> Adapter: SMBus nForce2 adapter at 2000
> Algorithm: Non-I2C SMBus adapter
> Board:       +38?C  (low =  +15?C, high = -128?C)        
> CPU:          +8?C  (low =   +0?C, high = -128?C)        

Probably a misdetected chip, I don't think this is a real LM84. Please
provide the output of "i2cdump 1 0x4e" (after unloading the adm1021
module). I'll take a look, maybe you have a chipset we don't have
support for yet.

> Not sure what further info I can give you. If you can think of
> something then please shout. :)

For your first problem, you have to believe me when I say that the ISA
vs. non-ISA access cannot be the real difference between your tries. You
have to do some more testing and find another difference. I don't think
we can help you without that information.

For the second problem, provide the requested output and we'll see what
we can do.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.245
diff -u -r1.245 sensors-detect
--- sensors-detect	8 Sep 2003 17:38:23 -0000	1.245
+++ sensors-detect	13 Sep 2003 17:40:22 -0000
@@ -1958,7 +1958,8 @@
 {
   my ($chipdriver,$datahash) = @_;
   my ($i,$new_detected_ref,$new_misdetected_ref,$detected_ref,$misdetected_ref,
-      $main_entry,$detected_entry,$put_in_detected,@hash_addrs,@entry_addrs);
+      $main_entry,$detected_entry,$put_in_detected,@hash_addrs,@entry_addrs,
+      $do_not_add);
 
   # First determine where the hash has to be added.
   for ($i = 0; $i < @chips_detected; $i++) {
@@ -1979,6 +1980,7 @@
   push @hash_addrs, @{$datahash->{i2c_sub_addrs}}
        if exists $datahash->{i2c_sub_addrs};
   $put_in_detected = 1;
+  $do_not_add = 0;
   FIND_LOOP:
   foreach $main_entry (@chips_detected) {
     foreach $detected_entry (@{$main_entry->{detected}}) {
@@ -1990,6 +1992,9 @@
         if ($detected_entry->{conf} >= $datahash->{conf}) {
           $put_in_detected = 0;
         }
+        if ($chipdriver eq $main_entry->{driver}) {
+          $do_not_add = 1;
+        }
         last FIND_LOOP;
       }
     }
@@ -2000,6 +2005,10 @@
     # match at least in one main or sub address. This may not be the
     # best idea to do, as it may remove detections without replacing
     # them with second-best ones. Too bad.
+    # (Khali 2003-09-13) If the driver is the same, the "misdetected"
+    # entry is simply deleted; failing to do so cause the configuration
+    # lines generated later to look very confusing (the driver will
+    # be told to ignore valid addresses).
     @hash_addrs = ($datahash->{i2c_addr});
     push @hash_addrs, @{$datahash->{i2c_sub_addrs}} 
          if exists $datahash->{i2c_sub_addrs};
@@ -2012,7 +2021,8 @@
              if exists $detected_ref->[$i]->{i2c_sub_addrs};
         if ($detected_ref->[$i]->{i2c_devnr} = $datahash->{i2c_devnr} and
             any_list_match \@entry_addrs, \@hash_addrs) {
-          push @$misdetected_ref,$detected_ref->[$i];
+          push @$misdetected_ref,$detected_ref->[$i]
+            unless $chipdriver eq $main_entry->{driver};
           splice @$detected_ref, $i, 1;
         }
       }
@@ -2022,7 +2032,8 @@
     push @$new_detected_ref, $datahash;
   } else {
     # No hard work here 
-    push @$new_misdetected_ref, $datahash;
+    push @$new_misdetected_ref, $datahash
+      unless $do_not_add;
   }
 }
 
