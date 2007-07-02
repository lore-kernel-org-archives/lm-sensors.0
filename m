From: "Ivo Manca" <pinkel@gmail.com>
Date: Mon, 02 Jul 2007 09:34:25 +0000
Subject: [lm-sensors] [RESEND][PATCH 1/3] prog/detect/sensors-detect: Add
Message-Id: <003a01c7bc8c$2ed20e70$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey All,

Please find below a new version of my patch for sensors-detect. This patch 
fixes some issues not to be found on any of my system ;p.

Changelog:
* Applied to latest revision of sensors-detect (4533)
* Bugfix: Error with modprobing when spaces are added to configfile
* Bugfix: Error loading when DMI-info has spaces in
* Bugfix: Invalid alternate files found when DMI-info has spaces in it
* Bugfix: Error with ubuntu (and possibly other distributions) when 
`uname -i` is not supported

(Not sure if patch comes through correctly, uploaded a copy to: 
http://www.pinkelmans.nl/prive/sensors/sensors-detect-20070702.patch )

Signed-off-by: Ivo Manca <pinkel@gmail.com>
---

diff -urbN lm-sensors-3/prog/detect/sensors-detect 
lm-sensors.new/prog/detect/sensors-detect
--- lm-sensors-3/prog/detect/sensors-detect 2007-07-02 02:26:15.000000000 
+0200
+++ lm-sensors.new/prog/detect/sensors-detect 2007-07-02 13:28:21.000000000 
+0200
@@ -33,6 +33,9 @@
 use Fcntl;
 use POSIX;
 use File::Basename;
+use File::Copy;
+use Getopt::Long;
+use LWP::Simple;

 # We will call modprobe, which typically lives in either /sbin,
 # /usr/sbin or /usr/local/bin. So make sure these are all in the PATH.
@@ -5228,6 +5231,332 @@
  return;
 }

+###########
+# DMI #
+###########
+
+use vars qw(%dmi $libraryPath $verbose);
+
+sub initialize_dmi_data
+{
+  my $version;
+  my @items = (
+    'system-manufacturer',
+    'system-product-name',
+    'system-version',
+    'baseboard-manufacturer',
+    'baseboard-product-name',
+    'baseboard-version',
+  );
+
+  return 0 unless open(local *DMIDECODE, "dmidecode --version 2>/dev/null 
|");
+  $version = <DMIDECODE>;
+  close(DMIDECODE);
+  return 0 unless defined $version;
+
+  # We need at least version 2.7
+  chomp $version;
+  return 0 unless $version =~ m/^(\d+).(\d+)$/;
+  return 0 unless (($1 = 2 && $2 >= 7) || $1 > 2);
+
+  open(local *DMISTRINGS, ">/etc/dmistrings") or die "Sorry, can't create 
/etc/dmistrings ($!)";
+
+  foreach my $k (@items) {
+    next unless open(local *DMIDECODE, "dmidecode -s $k |");
+    $dmi{$k} = <DMIDECODE>;
+    close(DMIDECODE);
+    # Strip trailing white-space
+    $dmi{$k} =~ s/\s*$// if defined $dmi{$k};
+    #write the DMI information to a file for later reference
+    print DMISTRINGS $dmi{$k};
+   }
+   return 1;
+}
+
+sub update_database
+{
+  my 
($website,$url,@headinfo,$modify_date_file,$modify_date_web,$file,$architecture);
+
+  $website = "http://tom.ti.thrijswijk.nl/ali50478/DMI_site/tarball/";
+  $file = $libraryPath."latest.tar.gz";
+
+  print "\n";
+  print "Checking for updates...\n" if not $verbose;
+
+  # determine architecture
+  return 0 unless open(local *ARCH, "uname -i 2>/dev/null |");
+  $architecture = <ARCH>;
+  close(ARCH);
+  if ($architecture) {
+    chomp $architecture;
+
+    # try to get tarball for specific architecture first
+    # Read the head to get the last-modified-date
+    $url = $website.$architecture.".tar.gz";
+    print "Checking for updates at: ".$url."\n" if $verbose;
+    @headinfo = head($url);
+    if (@headinfo) {
+      $modify_date_web = $headinfo[2];
+    }
+  }
+  if (not @headinfo or not $architecture)
+  {
+    # fail back to generic tarball
+    $url = $website."latest.tar.gz";
+    print "Can't find architecture specific tarball. \nFallback to: 
".$url."\n" if $verbose;
+    @headinfo = head($url);
+    if (@headinfo) {
+      $modify_date_web = $headinfo[2];
+    } else {
+      print @headinfo . "Errors: Problems with the website\n";
+      return 0;
+    }
+  }
+
+  # check if file exists localy, to check if there is a newer one available
+  if (-e $file) {
+    $modify_date_file = (stat($file))[9];
+    if ($modify_date_web <= $modify_date_file) {
+      print "No update available\n";
+      return 0;
+    }
+  }
+
+  # check if library path exists, if not: create
+  if (not -d $libraryPath) {
+    my $dir;
+    my $accum="";
+    foreach $dir (split(/\//, $libraryPath)){
+      $accum = "$accum$dir/";
+      if(defined($dir) && $dir ne ""){
+        if(! -d "$accum"){
+          mkdir $accum;
+          print "Making dir: ".$accum."\n" if $verbose;
+        }
+      }
+    }
+    if (not -d $libraryPath) {
+      print "Error: Can not create directory: ".$libraryPath."\n";
+      print "Error details: " . $! . "\n" if $verbose;
+    }
+  }
+
+  print "Downloading tarball...";
+  print "\nFrom: ".$url." To: ".$file."\n" if $verbose;
+  my $response = getstore($url, $file);
+
+  # set modify date to the same date as the file on the website to get them 
in-sync;
+  utime $modify_date_web, $modify_date_web, $file;
+  if (is_success($response )) {
+    print "Extracting tarball...";
+    print "\nFrom: ".$file." To: ".$libraryPath." with: tar -xzf \n" if 
$verbose;
+    if (!system("tar -xzf ".$file." -C ".$libraryPath)) {
+      print "Extracting completed...Update progress completed!\n";
+    } else {
+      print "Error: failed to extract tarball!\n";
+    }
+  } else
+  {
+    print "Error: failed to download file!\n";
+  }
+}
+
+sub dmi_detection
+{
+  my $mode = $_[0];
+  my $update = 0;
+
+  # initialize the dmi data
+  if (!initialize_dmi_data()) {
+    print "Error! 'dmidecode' can not be found or loaded. Please make sure 
\n",
+          "it is installed. \n",
+          "Skipping DMI detection.\n\n";
+    return 0;
+  }
+
+  print $mode = 2 ? "Entering DMI Detection mode...\n" : "\n";
+
+  # check whether to update or not, based on automatic mode (mode=2), 
available local database and user input
+  $update = -1 if $mode = 2; # don't update if automatic mode is enabled
+  if (!$update) {
+    if (not -d $libraryPath)  {
+      print "It seems that the database with the different motherboard 
configurations is\n".
+            "not available on your system. You needed to download and 
install this \n".
+            "database to continue.\n".
+            "Do you wish to download and install the database? (YES/no): ";
+      if (<STDIN> =~ /\s*[Nn]/) {
+        print "\nNo database available. Aborting.\n";
+        return 0;
+      } else {
+        $update = 1;
+      }
+    } else {
+    print "Before finding the apropriate config file, you can choose to 
update\n".
+        "your database with a database downloaded from internet. \n".
+        "Do you want to check for updates? (YES/no)";
+        $update = 1 unless (<STDIN> =~ /\s*[Nn]/);
+    }
+  }
+
+  if ($update = 1) {
+    update_database();
+    print "\n";
+  }
+
+  print_dmi_data() if $verbose;
+
+  return find_config_file($mode);
+}
+
+sub print_dmi_data
+{
+  print "This is the output of your DMI information: \n",
+       "# System Manufacturer: ", $dmi{'system-manufacturer'}, "\n",
+       "# System Productname: ", $dmi{'system-product-name'}, "\n",
+       "# System Version: ", $dmi{'system-version'}, "\n",
+       "# Baseboard Manufacturer: ", $dmi{'baseboard-manufacturer'}, "\n",
+       "# Baseboard Productname: ", $dmi{'baseboard-product-name'}, "\n",
+       "# Baseboard Version: ", $dmi{'baseboard-version'}, "\n\n";
+}
+
+sub find_config_file
+{
+  # find the config file corrensponding to the DMI information
+  my $mode = $_[0];
+  my $find_file = $dmi{'system-manufacturer'}. 
"-".$dmi{'baseboard-manufacturer'}. "-".$dmi{'system-product-name'}. 
"-".$dmi{'baseboard-product-name'}."-";
+  my $find_version = $dmi{'system-version'}. "-".$dmi{'baseboard-version'};
+
+  # strip the character / (directory separator) from the dmi-info
+  $find_file =~ s/\//./g;
+  $find_version =~ s/\//./g;
+
+  $find_file = $libraryPath.$find_file;
+
+  my $config_file;
+
+  # search for config file matching revision
+  print "Looking for configfile '".$find_file.$find_version. "'\n" if 
$verbose;
+  if (-e $find_file.$find_version)  {
+    $config_file = $find_file.$find_version;
+  } else {
+    print "Configfile not found \n" if $verbose;
+    if ($mode != 2) {
+      # search for alternative revisions and let the user decided wether to 
load it or not
+      print "Looking for alternate configfiles: '".$find_file."*'\n" if 
$verbose;
+      my @alternate_config_files;
+      my $file_name;
+      my $nr_alternate_config_files;
+      my $count;
+      while ($file_name = glob("'".$find_file."'*")) {
+        $file_name =~ s/$find_file//;
+        push(@alternate_config_files,$file_name);
+      }
+      $nr_alternate_config_files = scalar(@alternate_config_files);
+      if ($nr_alternate_config_files > 0) {
+        print "I was able to find ",$nr_alternate_config_files," alternate 
configurations after comparing\n",
+              "the information from the DMI table with the available 
configuration files.\n";
+        print "These configurations match your motherboard manufacturer and 
model, \n".
+              "but are tested for a different revision. Your revision is: 
\n\n";
+        print "* ",$find_version,"\n\n";
+        print "The available configrations are for the following 
revisions:\n\n";
+        foreach $file_name(@alternate_config_files) {
+          $count++;
+          print$count,". ",$file_name,"\n";
+        }
+        print "\nPlease choose the configuration you want to load.\n",
+              "Note: These configurations are not tested for your specefic 
motherboard\n",
+              "model. Use them at your own risk.\n";
+        print "Enter 0 or hit return if you want to exit detection through 
DMI.\n";
+        print "Config file [0-",$nr_alternate_config_files,"]: ";
+        my $inp =<STDIN>;
+        print "\n";
+        if ($inp =~ /^[1-$nr_alternate_config_files]$/) {
+          $config_file = $find_file.$alternate_config_files[$inp-1];
+        }
+      }
+    }
+  }
+  if ($config_file) {
+    return load_config_file($config_file,$mode);
+  } else {
+    print "No configuration found.\n\n";
+    return 0;
+  }
+}
+
+sub load_config_file
+{
+  my $config_file = $_[0];
+  my $mode = $_[1];
+  my (@modules, $module, $modprobes,$comment);
+
+  print "Using config: ",$config_file,"\n\n";
+
+  # backup the old config if this hasn't been done before.
+  if (!(-e "/etc/sensors.conf.sensorsdetect")) {
+    copy ("/etc/sensors.conf", "/etc/sensors.conf.sensorsdetect");
+    print "Backup of /etc/sensors.conf saved at 
/etc/sensors.conf.sensorsdetect\n";
+  }
+
+  # copy config to /etc/sensors.conf
+  copy ($config_file, "/etc/sensors.conf");
+
+  # parse config file
+  open FILE, "/etc/sensors.conf" or die "Can't open config file";
+  while(<FILE>) {
+    if ($_ =~ m/^# modprobe /) {
+      # modprobe found!
+      $_ =~ s/^# modprobe //;
+      $_ =~ s/\n//;
+      # strip whitespaces
+      $_ =~ s/\s+//g;
+      push(@modules,$_);
+    }
+    if ($_ =~ m/^# minimum-kernel-version /) {
+      $_ =~ s/^# minimum-kernel-version //;
+      $_ =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
+      if (!kernel_version_at_least($1,$2,$3)) {
+        print "Error! Your motherboard's configuration is only supported 
with kernel version\n",
+              "$1.$2.$3 or higher while your kernel version is 
".$kernel_version[0].".".$kernel_version[1].".".$kernel_version[2]."\n";
+        return 0;
+     }
+    }
+    if ($_ =~ m/^# comment /) {
+      #comment found!
+      $_ =~ s/^# comment //;
+      $comment .= "* ".$_."\n";
+    }
+  }
+  # show the found comments first
+  print $comment if ($comment);
+
+  # generate modprobes
+  $modprobes .= "# Drivers found by sensors-detect with DMI detection 
enabled\n";
+
+  # load modules and add to autoload
+  foreach $module(@modules) {
+    if (exists($modules_list{$module})) {
+      print "Module `$module' already loaded.\n";
+    } else {
+      print "Load `$module' (say NO if built into your kernel)? (YES/no): " 
unless ($mode = 2);
+      unless ($mode != 2 && <STDIN> =~ /^\s*[Nn]/) {
+        if (system ("modprobe", $module)) {
+          print "Loading failed... skipping.\n";
+          $modprobes .= "# Warning: the required module $module is not 
currently installed\n".
+                        "# on your system. For status of 2.6 kernel ports 
check\n".
+                        "# http://www.lm-sensors.org/wiki/Devices. If 
driver is built\n".
+                        "# into the kernel, or unavailable, comment out the 
following line.\n";
+        } else {
+          print "Module loaded successfully.\n";
+        }
+      }
+    }
+    $modprobes .= "modprobe $module\n";
+  }
+  print "DMI detection succeeded and config file succesfully loaded!\n\n";
+  return (1,$modprobes);
+}
+
 ################
 # MAIN PROGRAM #
 ################
@@ -5282,11 +5611,10 @@
 # A second array, called
 sub generate_modprobes
 {
-  my ($prefer_isa) = @_;
+  my ($prefer_isa,$modprobes) = @_;

   my ($chip,$detection,$nr,$i,@optionlist,@probelist,$driver,$isa,$adap);
   my $ipmi = 0;
-  my $modprobes = "";
   my $configfile = "";

   # These are always needed
@@ -5422,9 +5750,29 @@

 }

+sub VersionMessage
+{
+  print "# sensors-detect revision $revision\n\n";
+  exit;
+}
+
+sub HelpMessage
+{
+  print "Usage: sensors-detect [OPTION]\n",
+        "  -a  --automatic       Don't ask anything, use defaults\n",
+        "  -m, --manual          Only use old way of probing\n",
+        "  -u  --update          Update the database, then quit\n",
+        "  -v  --verbose         Display extra information useful for 
debugging\n",
+        "  -?, --help            Display this help\n",
+        "      --version         Display the program version\n",
+        "\n",
+        "Default mode is:  use DMI detection first, fallback to old way of 
probing\n";
+  exit;
+}
+
 sub main
 {
-  my (@adapters,$res,$did_adapter_detection,$adapter);
+  my 
(@adapters,$res,$did_adapter_detection,$adapter,$modprobes,$configfile,$update,$inp,$dmi_success);

   # We won't go very far if not root
   unless ($> = 0) {
@@ -5432,6 +5780,16 @@
     exit -1;
   }

+  # Parse the command line parameters
+  my $mode = 1; #0 = manual  1 = dmi, 2 = automatic
+  $libraryPath = "/usr/share/lmsensors/motherboards/";
+
+  my $result = GetOptions ("verbose|v"=> \$verbose, "update" => \$update, 
"automatic"=> sub {$mode = 2 },"manual"=> sub { $mode = 0 }, "help|?"=> sub 
{ HelpMessage() },"version" => sub { VersionMessage() });
+  if ($update) { # not an GetOptions sub. Verbose won't be passed if you 
specify "-u -v", when the update function is called in a sub. Now it will be 
passed.
+    update_database();
+    exit;
+  }
+
   initialize_conf;
   initialize_proc_pci;
   initialize_modules_list;
@@ -5450,6 +5808,30 @@
     unless kernel_version_at_least(2, 6, 0);
   print "\n";

+  #  dmi automaticly, interactive or disabled
+
+  if ($mode > 0) {
+    if ($mode = 2) { #  start dmi detection if automatic mode is enabled
+      ($dmi_success, $modprobes) = dmi_detection($mode);
+    } else {
+       print "We can start looking up the DMI table to find a config file. 
This\n",
+             "is the safest way to locate the available sensors.\n".
+             "Do you want to lookup the DMI table now? (YES/no): ";
+      $inp = <STDIN>;
+      if (not $inp =~ /\s*[Nn]/) { #  start dmi detection if manual mode is 
enabled and user presses "yes"
+        ($dmi_success, $modprobes) = dmi_detection($mode);
+      }
+    }
+  }
+
+  if ($dmi_success = 0) { # dmi detection not started or unsuccesful
+    if ($mode = 2) { # quit if automatic mode enabled
+        die "Detection using the DMI information failed. \n",
+            "Please update your database or use non-automatic mode for 
detection \n";
+    }
+
+    print "Detection using the DMI information failed. Switching to old 
mode. \n\n" unless ($mode = 0 || $inp =~ /\s*[Nn]/);
+
   print "We can start with probing for (PCI) I2C or SMBus adapters.\n";
   print "Do you want to probe now? (YES/no): ";
   @adapters = adapter_pci_detection
@@ -5556,10 +5938,11 @@
     close_ioports();
   }
   print "\n";
+  } # end "NO-DMI" mode to detect CPU sensors.

   print "Some CPUs or memory controllers may also contain embedded 
sensors.\n";
-  print "Do you want to scan for them? (YES/no): ";
-  unless (<STDIN> =~ /^\s*n/i) {
+  print "Do you want to scan for them? (YES/no): " unless ($mode = 2);
+  unless ($mode != 2 && <STDIN> =~ /^\s*n/i) {
     $| = 1;
     foreach my $entry (@cpu_ids) {
       scan_cpu($entry);
@@ -5568,6 +5951,8 @@
   }
   print "\n";

+  if (!$dmi_success) # dmi detection not started or unsuccesful
+  {
   if(! @chips_detected) {
     print "Sorry, no sensors were detected.\n",
           "Either your sensors are not supported, or they are connected to 
an\n",
@@ -5611,13 +5996,13 @@
     }
   }
   print "\n";
-
-  print "I will now generate the commands needed to load the required 
modules.\n".
-        "Just press ENTER to continue: ";
-  <STDIN>;
+  } # end "DMI" mode
+  ($modprobes, $configfile) = generate_modprobes(1,$modprobes); # 1 = 
prefer ISA
+  print "I will now generate the commands needed to load the required 
modules.\n";
+  print "Just press ENTER to continue: " unless ($mode = 2);
+  <STDIN> unless ($mode = 2);

   print "\n";
-  my ($modprobes, $configfile) = generate_modprobes 1; # 1 = prefer ISA
   print "To make the sensors modules behave correctly, add these lines 
to\n".
         "$modules_conf:\n\n";
   print "#----cut here----\n".
@@ -5640,13 +6025,20 @@
   my $have_sysconfig = -d '/etc/sysconfig';
   printf "Do you want to \%s /etc/sysconfig/lm_sensors? (\%s): ",
          (-e '/etc/sysconfig/lm_sensors' ? 'overwrite' : 'generate'),
-         ($have_sysconfig ? 'YES/no' : 'yes/NO');
-  $_ = <STDIN>;
+         ($have_sysconfig ? 'YES/no' : 'yes/NO') unless ($mode = 2);
+  $_ = $mode = 2 ? "" : <STDIN>;
   if (($have_sysconfig and not m/^\s*n/i) or m/^\s*y/i) {
     unless ($have_sysconfig) {
       mkdir '/etc/sysconfig', 0777
         or die "Sorry, can't create /etc/sysconfig ($!)";
     }
+
+    if (($mode = 2) && (!(-e "/etc/sysconfig/lm_sensors.sensorsdetect"))) 
{
+      # backup the lmsensors sysconfig
+      copy 
("/etc/sysconfig/lm_sensors","/etc/sysconfig/lm_sensors.sensorsdetect");
+      print "Backup of /etc/sysconfig/lm_sensors saved at 
/etc/sysconfig/lm_sensors.sensorsdetect\n\n";
+    }
+
     open(local *SYSCONFIG, ">/etc/sysconfig/lm_sensors")
       or die "Sorry, can't create /etc/sysconfig/lm_sensors ($!)";
     print SYSCONFIG <<'EOT';
@@ -5694,6 +6086,7 @@
     }
     print SYSCONFIG $sysconfig;

+    print "/etc/sysconfig/lm_senors is overwritten with the new config.\n";
     print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
           "for initialization at boot time.\n"
       unless -f "/etc/init.d/lm_sensors"; 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
