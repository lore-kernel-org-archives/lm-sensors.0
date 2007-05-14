From: "Ivo Manca" <pinkel@gmail.com>
Date: Mon, 14 May 2007 11:13:58 +0000
Subject: [lm-sensors] Sensors-detect with DMI information,
Message-Id: <005401c79618$f9873e00$a6813491@pinkeltje>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0051_01C79629.BB4D7670"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0051_01C79629.BB4D7670
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hey all,

Please find attached the (patch for) first version of the updated 
sensors-detect. This patch adds support for looking up sensors 
configurations while using DMI information. It applies to the 3.0.0 branch 
of lmsensors.

Information about the patch:
* Adds command line parameters 
(--automatic, --manual, --version, --verbose, --help, --update)
* Looks up DMI information and tries to match this with a config file in 
/usr/share/lmsensors/motherboards
* Ability to update /usr/share/lmsensors/motherboards with database (Note: 
This database is currently a DUMMY and does not contain any usuable 
information suitable for anything besides testing).
* Proccesses the config file if found.

It seems like it's already near to a complete working version. Every comment 
will be appriciated.
If you want to find a checklist with the implemented functions, please 
check: http://www.pinkelmans.nl/prive/sensors/Checklist.pdf

Note 1: The script currentently does not yet escapes backslashes for 
filenames, this will be added soon.
Note 2: To make the patch more readable, there are no spaces added to nearly 
every line inside the mainfunction of sensors-detect. Therefor the patched 
verion of sensors-detect itself might be hard to read. A patch with the 
added spaces (etc) will be submitted next week or so.
Note 3: The ability to only download configurations suitable for the current 
architecture will be added if time permits.

Requirements for sensors-detect (Ivo Manca): 
http://www.pinkelmans.nl/prive/sensors/sensors_detect-req.pdf
Requirements for website (Jasper Alias): 
http://www.pinkelmans.nl/prive/sensors/website-req.pdf
Please feel free to comment on these requirements or to ask us to eleberate 
them.

Information about the sensors-detect discussion can be found:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19332
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19008
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/thread.html#18932

Ivo Manca
Jasper Alias
Gijs van der Weg 

------=_NextPart_000_0051_01C79629.BB4D7670
Content-Type: application/octet-stream;
	name="sensors-detect.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sensors-detect.patch"

--- sensors-detect-3.0.0	2007-04-27 14:33:44.000000000 +0200=0A=
+++ sensors-detect	2007-05-11 15:44:19.000000000 +0200=0A=
@@ -33,6 +33,9 @@=0A=
 use Fcntl;=0A=
 use POSIX;=0A=
 use File::Basename;=0A=
+use File::Copy;=0A=
+use Getopt::Long;=0A=
+use LWP::Simple;=0A=
 =0A=
 # We will call modprobe and i2cdetect, which typically live in either =
/sbin,=0A=
 # /usr/sbin or /usr/local/bin. So make sure these are all in the PATH.=0A=
@@ -2117,7 +2120,7 @@=0A=
 # AUTODETECTION #=0A=
 #################=0A=
 =0A=
-use vars qw($modules_conf $dev_i2c $sysfs_root);=0A=
+use vars qw($modules_conf $dev_i2c $sysfs_root $verbose);=0A=
 =0A=
 sub initialize_conf=0A=
 {=0A=
@@ -5326,6 +5329,260 @@=0A=
 	return;=0A=
 }=0A=
 =0A=
+###########=0A=
+# DMI #=0A=
+###########=0A=
+=0A=
+use vars qw(%dmi $libraryPath);=0A=
+=0A=
+sub initialize_dmi_data=0A=
+{=0A=
+  my $version;=0A=
+  my @items =3D (=0A=
+    'system-manufacturer',=0A=
+    'system-product-name',=0A=
+    'system-version',=0A=
+    'baseboard-manufacturer',=0A=
+    'baseboard-product-name',=0A=
+    'baseboard-version',=0A=
+  );=0A=
+=0A=
+  return unless open(local *DMIDECODE, "dmidecode --version 2>/dev/null =
|");=0A=
+  $version =3D <DMIDECODE>;=0A=
+  close(DMIDECODE);=0A=
+  return unless defined $version;=0A=
+=0A=
+  # We need at least version 2.7=0A=
+  chomp $version;=0A=
+  return unless $version =3D~ m/^(\d+).(\d+)$/;=0A=
+  return unless (($1 =3D=3D 2 && $2 >=3D 7) || $1 > 2);=0A=
+=0A=
+  foreach my $k (@items) {=0A=
+    next unless open(local *DMIDECODE, "dmidecode -s $k |");=0A=
+    $dmi{$k} =3D <DMIDECODE>;=0A=
+    close(DMIDECODE);=0A=
+    # Strip trailing white-space, discard empty field=0A=
+    $dmi{$k} =3D~ s/\s*$// if defined $dmi{$k};=0A=
+    delete $dmi{$k} if (!defined $dmi{$k} || $dmi{$k} eq '');=0A=
+  }=0A=
+}=0A=
+=0A=
+sub update_database=0A=
+{=0A=
+  my $url =3D "http://www.pinkelmans.nl/prive/sensors/latest.tar.gz";  =0A=
+  print "\nStarting update progress...\n";=0A=
+  if (not -d $libraryPath) {=0A=
+    my $dir; =0A=
+    my $accum=3D"";=0A=
+    foreach $dir (split(/\//, $libraryPath)){=0A=
+      $accum =3D "$accum$dir/";=0A=
+      if(defined($dir) && $dir ne ""){=0A=
+        if(! -d "$accum"){=0A=
+          mkdir $accum;=0A=
+          print "Making dir: ".$accum."\n" if $verbose;=0A=
+        }=0A=
+      }=0A=
+    }=0A=
+    if (not -d $libraryPath) {=0A=
+      print "Error: Can not create directory: ".$libraryPath."\n";=0A=
+      print "Error details: " . $! . "\n" if $verbose;=0A=
+    }=0A=
+  }=0A=
+  print "Downloading tarball...";=0A=
+  my $file =3D $libraryPath."latest.tar.gz";=0A=
+  print "\nFrom: ".$url." To: ".$file."\n" if $verbose;=0A=
+  my $response =3D getstore($url, $file);=0A=
+  if (is_success($response )) {=0A=
+    print "Extracting tarball...";=0A=
+	print "\nFrom: ".$file." To: ".$libraryPath." with: tar-xzf \n" if =
$verbose;=0A=
+    if (!system("tar -xzf ".$file." -C ".$libraryPath)) {=0A=
+      print "Extracting completed...Update progress completed!\n";=0A=
+    }=0A=
+    else {=0A=
+      print "Error: failed to extract tarball!\n";=0A=
+    }=0A=
+    print "\n"=0A=
+  }=0A=
+  else=0A=
+  {=0A=
+    print "Error: failed to download file!\n";=0A=
+  }=0A=
+}=0A=
+=0A=
+sub dmi_detection=0A=
+{=0A=
+  my $mode =3D $_[0];=0A=
+  my $update =3D 0;=0A=
+=0A=
+  if (!defined($dmi{'system-manufacturer'})) {=0A=
+    print "Error! 'dmidecode' can not be found or loaded. Please make =
sure \n",=0A=
+          "it is installed. \n",=0A=
+          "Skipping DMI detection.\n"; =0A=
+    return 0;=0A=
+  }=0A=
+  =0A=
+  print $mode =3D=3D 2 ? "Entering DMI Detection mode...\n" : "\n";=0A=
+=0A=
+  $update =3D 1 if $mode =3D=3D 2;=0A=
+  if (!$update) {=0A=
+    if (not -d $libraryPath)  {=0A=
+      print "It seems that the database with the different motherboard =
configurations is\n".=0A=
+            "not available on your system. You needed to download and =
install this \n".=0A=
+            "database to continue.\n".=0A=
+            "Do you wish to download and install the database? =
(YES/no): ";=0A=
+      if (<STDIN> =3D~ /\s*[Nn]/) {=0A=
+        print "\nNo database available. Aborting.\n";=0A=
+        return 0;=0A=
+      }=0A=
+      else {=0A=
+        $update =3D 1;=0A=
+      }=0A=
+    }=0A=
+    else {=0A=
+    print "Before finding the apropriate config file, you can choose to =
update\n".=0A=
+        "your database with a database downloaded from internet. \n".=0A=
+        "Do you want to check for updates? (YES/no)";=0A=
+        $update =3D 1 unless (<STDIN> =3D~ /\s*[Nn]/);=0A=
+    }=0A=
+  }=0A=
+  =0A=
+  update_database() if $update =3D=3D 1;=0A=
+  =0A=
+  print_dmi_data() if $verbose;=0A=
+  =0A=
+  return find_config_file($mode);=0A=
+}=0A=
+=0A=
+sub print_dmi_data=0A=
+{=0A=
+  print "This is the output of your DMI information: \n",=0A=
+       "# System Manufacturer: ", $dmi{'system-manufacturer'}, "\n",=0A=
+       "# System Productname: ", $dmi{'system-product-name'}, "\n",=0A=
+       "# System Version: ", $dmi{'system-version'}, "\n",=0A=
+       "# Baseboard Manufacturer: ", $dmi{'baseboard-manufacturer'}, =
"\n",=0A=
+       "# Baseboard Productname: ", $dmi{'baseboard-product-name'}, =
"\n",=0A=
+       "# Baseboard Version: ", $dmi{'baseboard-version'}, "\n\n";=0A=
+}=0A=
+=0A=
+sub find_config_file=0A=
+{=0A=
+  my $mode =3D $_[0];=0A=
+  my $find_file =3D $libraryPath.$dmi{'system-manufacturer'}. =
"-".$dmi{'baseboard-manufacturer'}. "-".$dmi{'system-product-name'}. =
"-".$dmi{'baseboard-product-name'}."-";=0A=
+  my $find_version =3D $dmi{'system-version'}. =
"-".$dmi{'baseboard-version'};=0A=
+  $find_file =3D~ s/\s//g;  # strip spaces=0A=
+  $find_version =3D~ s/\s//g;  # strip spaces=0A=
+  =0A=
+  my $config_file;=0A=
+  =0A=
+  print "Looking for configfile ".$find_file.$find_version. "\n" if =
$verbose;=0A=
+  if (-e $find_file.$find_version)  {=0A=
+    $config_file =3D $find_file.$find_version;=0A=
+  }=0A=
+  else {=0A=
+    print "Configfile not found \n" if $verbose;=0A=
+    if ($mode !=3D 2) {=0A=
+      print "Looking for alternative configfiles: ".$find_file."*\n" if =
$verbose;=0A=
+      my @alternate_config_files;=0A=
+      my $file_name;=0A=
+      my $nr_alternate_config_files;=0A=
+      my $count;=0A=
+      while ($file_name =3D glob($find_file."*"))=0A=
+      {=0A=
+        $file_name =3D~ s/$find_file//;=0A=
+        push(@alternate_config_files,$file_name);=0A=
+      }=0A=
+      $nr_alternate_config_files =3D scalar(@alternate_config_files);=0A=
+      if ($nr_alternate_config_files > 0) {=0A=
+        print "I was able to find ",$nr_alternate_config_files," =
alternate configurations after comparing\n",=0A=
+              "the information from the DMI table with the available =
configuration files.\n";=0A=
+        print "These configurations match your motherboard manufacturer =
and model, \n".=0A=
+              "but are tested for a different revision. Your revision =
is: \n\n";=0A=
+        print "* ",$find_version,"\n\n";=0A=
+        print "The available configrations are for the following =
revisions:\n\n";=0A=
+        foreach $file_name(@alternate_config_files)=0A=
+        {=0A=
+          $count++;=0A=
+          print$count,". ",$file_name,"\n";=0A=
+        }=0A=
+        print "\nPlease choose the configuration you want to load.\n",=0A=
+              "Note: These configurations are not tested for your =
specefic motherboard\n",=0A=
+              "model. Use them at your own risk.\n";=0A=
+        print "Enter 0 or hit return if you want to exit detection =
through DMI.\n";=0A=
+        print "Config file [0-",$nr_alternate_config_files,"]: ";=0A=
+        my $inp =3D<STDIN>;=0A=
+        print "\n";=0A=
+        if ($inp =3D~ /^[1-$nr_alternate_config_files]$/)=0A=
+        {=0A=
+          $config_file =3D $find_file.$alternate_config_files[$inp-1];=0A=
+        }=0A=
+      }=0A=
+    }=0A=
+  }=0A=
+  if ($config_file) {=0A=
+    return load_config_file($config_file,$mode);=0A=
+  }=0A=
+  else {=0A=
+    print "No configuration found.\n\n";=0A=
+    return 0;=0A=
+  }=0A=
+}=0A=
+=0A=
+sub load_config_file =0A=
+{=0A=
+  my $config_file =3D $_[0];=0A=
+  my $mode =3D $_[1];=0A=
+  my (@modules, $module, $modprobes);=0A=
+=0A=
+  print "Using config: ",$config_file,"\n\n";=0A=
+  =0A=
+  # try parsing the config?=0A=
+  =0A=
+  # backup config=0A=
+  if (!(-e "/etc/sensors.conf.sensorsdetect")) {=0A=
+    copy ("/etc/sensors.conf", "/etc/sensors.conf.sensorsdetect"); =0A=
+    print "Backup of /etc/sensors.conf saved at =
/etc/sensors.conf.sensorsdetect\n";=0A=
+  }=0A=
+  =0A=
+  # copy config=0A=
+  copy ($config_file, "/etc/sensors.conf");=0A=
+	=0A=
+  # load modules=0A=
+  open FILE, "/etc/sensors.conf" or die "Can't open config file";=0A=
+  while(<FILE>) {=0A=
+    if ($_ =3D~ m/^# modprobe /) {=0A=
+      $_ =3D~ s/^# modprobe //;=0A=
+      $_ =3D~ s/\n//;=0A=
+      push(@modules,$_);=0A=
+    }=0A=
+  }=0A=
+ =0A=
+  # generate modprobes=0A=
+  $modprobes .=3D "# Drivers found by sensors-detect with DMI detection =
enabled\n";=0A=
+  =0A=
+  # load modules and add to autoload=0A=
+  foreach $module(@modules) {=0A=
+    if (exists($modules_list{$module})) {=0A=
+      print "Module `$module' already loaded.\n";=0A=
+    } else {=0A=
+      print "Load `$module' (say NO if built into your kernel)? =
(YES/no): " unless ($mode =3D=3D 2);=0A=
+      unless ($mode !=3D 2 && <STDIN> =3D~ /^\s*[Nn]/) {=0A=
+        if (system ("modprobe", $module)) {=0A=
+          print "Loading failed... skipping.\n";=0A=
+          $modprobes .=3D "# Warning: the required module $module is =
not currently installed\n".=0A=
+                        "# on your system. For status of 2.6 kernel =
ports check\n".=0A=
+                        "# http://www.lm-sensors.org/wiki/Devices. If =
driver is built\n".=0A=
+                        "# into the kernel, or unavailable, comment out =
the following line.\n";=0A=
+        } else {=0A=
+          print "Module loaded successfully.\n";=0A=
+        }=0A=
+      }=0A=
+    }=0A=
+  $modprobes .=3D "modprobe $module\n";=0A=
+  }=0A=
+  print "DMI detection succeeded and config file succesfully =
loaded!\n\n";=0A=
+  return (1,$modprobes);=0A=
+}=0A=
+=0A=
 ################=0A=
 # MAIN PROGRAM #=0A=
 ################=0A=
@@ -5378,14 +5635,14 @@=0A=
 #  nr_later: Number of the bus when the modprobes are done (not =
included if the=0A=
 #        driver should not be loaded)=0A=
 # A second array, called =0A=
+=0A=
 sub generate_modprobes=0A=
 {=0A=
-  my ($prefer_isa) =3D @_;=0A=
+  my ($prefer_isa,$modprobes) =3D @_;=0A=
 =0A=
   my =
($chip,$detection,$nr,$i,@optionlist,@probelist,$driver,$isa,$adap);=0A=
   my $bmcsensors =3D 0;=0A=
   my @adapters;=0A=
-  my $modprobes =3D "";=0A=
   my $configfile =3D "";=0A=
 =0A=
   # These are always needed=0A=
@@ -5528,9 +5785,29 @@=0A=
   =0A=
 }=0A=
 =0A=
+sub VersionMessage=0A=
+{=0A=
+  print "# sensors-detect revision $revision\n\n";=0A=
+  exit;=0A=
+}=0A=
+sub HelpMessage=0A=
+{=0A=
+  print "Usage: sensors-detect [OPTION]\n",=0A=
+        "  -a  --automatic       Don't ask anything, use defaults\n",=0A=
+        "  -?, --help            Display this help\n",=0A=
+        "  -m, --manual          Only use old way of probing\n",=0A=
+        "  -u  --update          Update the database, then quit\n",=0A=
+        "  -v  --verbose         Display extra information useful for =
debugging\n",=0A=
+        "      --version         Display the program version\n",=0A=
+        "\n",=0A=
+        "Default mode is:  use DMI detection first, fallback to old way =
of probing\n";=0A=
+  exit;=0A=
+}=0A=
+=0A=
 sub main=0A=
 {=0A=
-  my (@adapters,$res,$did_adapter_detection,$adapter);=0A=
+  my =
(@adapters,$res,$did_adapter_detection,$adapter,$modprobes,$configfile,$u=
pdate,$inp);=0A=
+  my $dmi_success =3D 0;=0A=
 =0A=
   # We won't go very far if not root=0A=
   unless ($> =3D=3D 0) {=0A=
@@ -5538,12 +5815,24 @@=0A=
     exit -1;=0A=
   }=0A=
 =0A=
+  # Parse the command line parameters =0A=
+  my $mode =3D 1; #0 =3D manual  1 =3D dmi, 2 =3D automatic =0A=
+  $libraryPath =3D "/usr/share/lmsensors/motherboards/";=0A=
+  =0A=
+  my $result =3D GetOptions ("verbose|v"=3D> \$verbose, "update" =3D> =
\$update, "automatic"=3D> sub {$mode =3D 2 },"manual"=3D> sub { $mode =
=3D 0 }, "help|?"=3D> sub { HelpMessage() },"version" =3D> sub { =
VersionMessage() });=0A=
+  if ($update) # not an GetOptions sub. Verbose won't be passed if you =
specify "-u -v", when the update function is called in a sub. Now it =
will be passed.=0A=
+  {=0A=
+    update_database(); =0A=
+    exit;=0A=
+  }=0A=
+  =0A=
   initialize_conf;=0A=
   initialize_proc_pci;=0A=
   initialize_modules_list;=0A=
   initialize_modules_supported;=0A=
   initialize_kernel_version;=0A=
   initialize_cpu_list();=0A=
+  initialize_dmi_data();=0A=
 =0A=
   print "# sensors-detect revision $revision\n\n";=0A=
 =0A=
@@ -5556,6 +5845,33 @@=0A=
     unless kernel_version_at_least(2, 6, 0);=0A=
   print "\n";=0A=
 =0A=
+  #  dmi automaticly, interactive or disabled=0A=
+  =0A=
+  if ($mode > 0)=0A=
+  {=0A=
+    if ($mode =3D=3D 2) {=0A=
+      ($dmi_success, $modprobes) =3D dmi_detection($mode);=0A=
+    }=0A=
+    else=0A=
+    {=0A=
+       print "We can start looking up the DMI table to find a config =
file. This\n",=0A=
+             "is the safest way to locate the available sensors.\n".=0A=
+             "Do you want to lookup the DMI table now? (YES/no): ";=0A=
+      $inp =3D <STDIN>;=0A=
+      ($dmi_success, $modprobes) =3D dmi_detection($mode) if (not $inp =
=3D~ /\s*[Nn]/);=0A=
+    }=0A=
+  }=0A=
+ =0A=
+  if ($dmi_success =3D=3D 0)=0A=
+  {  =0A=
+    if ($mode =3D=3D 2)=0A=
+    {=0A=
+    die "Detection using the DMI information failed. \n",=0A=
+       "Please update your database or use non-automatic mode for =
detection \n";=0A=
+    }=0A=
+  =0A=
+  print "Detection using the DMI information failed. Switching to old =
mode. \n\n" unless ($mode =3D=3D 0 || $inp =3D~ /\s*[Nn]/);=0A=
+  =0A=
   print "We can start with probing for (PCI) I2C or SMBus adapters.\n";=0A=
   print "Do you want to probe now? (YES/no): ";=0A=
   @adapters =3D adapter_pci_detection =0A=
@@ -5615,7 +5931,7 @@=0A=
         "If you found that the adapter hung after probing a certain =
address,\n",=0A=
         "you can specify that address to remain unprobed.\n";=0A=
 =0A=
-  my ($inp,@not_to_scan,$inp2);=0A=
+  my (@not_to_scan,$inp2);=0A=
   # i2cdetect -l either cats /proc/bus/i2c or scans sysfs for the same =
information=0A=
   open(local *INPUTFILE, "i2cdetect -l |") or die "Couldn't find =
i2cdetect program!!";=0A=
   local $_;=0A=
@@ -5665,9 +5981,11 @@=0A=
   }=0A=
   print "\n";=0A=
 =0A=
+ } # end "DMI" mode=0A=
+ =0A=
   print "Some CPUs or memory controllers may also contain embedded =
sensors.\n";=0A=
-  print "Do you want to scan for them? (YES/no): ";=0A=
-  unless (<STDIN> =3D~ /^\s*n/i) {=0A=
+  print "Do you want to scan for them? (YES/no): " unless ($mode =3D=3D =
2);=0A=
+  unless ($mode !=3D 2 && <STDIN> =3D~ /^\s*n/i) {=0A=
     $| =3D 1;=0A=
     foreach my $entry (@cpu_ids) {=0A=
       scan_cpu($entry);=0A=
@@ -5675,8 +5993,10 @@=0A=
     $| =3D 0;=0A=
   }=0A=
   print "\n";=0A=
-=0A=
-  if(! @chips_detected) {=0A=
+ =0A=
+ if ($dmi_success =3D=3D 0)=0A=
+ {=0A=
+  if(! @chips_detected && $dmi_success =3D=3D 1) {=0A=
     print "Sorry, no sensors were detected.\n",=0A=
           "Either your sensors are not supported, or they are connected =
to an\n",=0A=
           "I2C or SMBus adapter that is not supported. See doc/FAQ,\n",=0A=
@@ -5727,12 +6047,14 @@=0A=
   }=0A=
   print "\n";=0A=
 =0A=
-  print "I will now generate the commands needed to load the required =
modules.\n".=0A=
-        "Just press ENTER to continue: ";=0A=
-  <STDIN>;=0A=
+ } # end "DMI" mode=0A=
+  ($modprobes, $configfile) =3D generate_modprobes(1,$modprobes);	# 1 =
=3D=3D prefer ISA=0A=
+ =0A=
+  print "I will now generate the commands needed to load the required =
modules.\n";=0A=
+  print "Just press ENTER to continue: " unless ($mode =3D=3D 2);=0A=
+  <STDIN> unless ($mode =3D=3D 2);=0A=
      =0A=
   print "\n";=0A=
-  my ($modprobes, $configfile) =3D generate_modprobes 1;	# 1 =3D=3D =
prefer ISA=0A=
   print "To make the sensors modules behave correctly, add these lines =
to\n".=0A=
         "$modules_conf:\n\n";=0A=
   print "#----cut here----\n".=0A=
@@ -5755,13 +6077,21 @@=0A=
   my $have_sysconfig =3D -d '/etc/sysconfig';=0A=
   printf "Do you want to \%s /etc/sysconfig/lm_sensors? (\%s): ",=0A=
          (-e '/etc/sysconfig/lm_sensors' ? 'overwrite' : 'generate'),=0A=
-         ($have_sysconfig ? 'YES/no' : 'yes/NO');=0A=
-  $_ =3D <STDIN>;=0A=
+         ($have_sysconfig ? 'YES/no' : 'yes/NO') unless ($mode =3D=3D =
2);=0A=
+  $_ =3D $mode =3D=3D 2 ? "" : <STDIN>;=0A=
+  =0A=
   if (($have_sysconfig and not m/^\s*n/i) or m/^\s*y/i) {=0A=
     unless ($have_sysconfig) {=0A=
       mkdir '/etc/sysconfig', 0777=0A=
         or die "Sorry, can't create /etc/sysconfig ($!)";=0A=
     }=0A=
+=0A=
+    if (($mode =3D=3D 2) && (!(-e =
"/etc/sysconfig/lm_sensors.sensorsdetect"))) # backup the lmsensors =
sysconfig=0A=
+    {=0A=
+      copy =
("/etc/sysconfig/lm_sensors","/etc/sysconfig/lm_sensors.sensorsdetect");=0A=
+      print "Backup of /etc/sysconfig/lm_sensors saved at =
/etc/sysconfig/lm_sensors.sensorsdetect\n\n";=0A=
+    }=0A=
+=0A=
     open(local *SYSCONFIG, ">/etc/sysconfig/lm_sensors")=0A=
       or die "Sorry, can't create /etc/sysconfig/lm_sensors ($!)";=0A=
     print SYSCONFIG <<'EOT';=0A=
@@ -5809,6 +6139,7 @@=0A=
     }=0A=
     print SYSCONFIG $sysconfig;=0A=
 =0A=
+    print "/etc/sysconfig/lm_senors is overwritten with the new =
config.\n";=0A=
     print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".=0A=
           "for initialization at boot time.\n"=0A=
       unless -f "/etc/init.d/lm_sensors";=0A=

------=_NextPart_000_0051_01C79629.BB4D7670
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0051_01C79629.BB4D7670--

