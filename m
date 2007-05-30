From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 30 May 2007 14:17:08 +0000
Subject: Re: [lm-sensors] Sensors-detect with DMI information,
Message-Id: <00e501c7a2c5$366898b0$42ac2ac0@pinkeltje>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_00E2_01C7A2D5.F8C51DB0"
List-Id: <lm-sensors.vger.kernel.org>
References: <005401c79618$f9873e00$a6813491@pinkeltje>
In-Reply-To: <005401c79618$f9873e00$a6813491@pinkeltje>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00E2_01C7A2D5.F8C51DB0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hey all,

It's been a while since I've posted the first patch and I've had no response 
yet. Luckily, I was able to improve the script some more in the meantime, so 
I would like to send in a new patch. Comments and flames are welcome ;)

The patch supports:
 * Command line parameters
  (--automatic, --manual, --version, --verbose, --help, --update)
* Looks up DMI information and tries to match this with a config file in
  /usr/share/lmsensors/motherboards
* Ability to update /usr/share/lmsensors/motherboards with database (Note:
  This database is currently a DUMMY and does not contain any usuable
   information suitable for anything besides testing).
* Proccesses the config file if found.

New since last patch:
* Escaping of slashes in filenames.
* Check for updates before downloading the update
* Saves a dump of DMI information to file.
* Don't initialize DMI information if DMI detection is not enabled
* Displays annotated comments in configfiles
- Some code cleanup
- Added comments

Config files are parsed as following:
It looks in /usr/share/lmsensors/motherboards for a filename matching 
system-manufacturer - baseboard-manufacturer  - system-product-name - 
baseboard-product-name - system-version - baseboard-version. (Without the 
spaces ofcourse ;)). If it can't find this config, it will look for an 
alternate revision: everything  with a different version number. It lists 
these config files and lets the user decide whether to load them or not.

If a configuration file is finally loaded, it looks through it for lines 
starting with:
# modprobe
These modules will be (auto)loaded.

It also parses lines with:
# Comment: blablabla
And prints * blablabla. This is done (i.e.) to notify a user if a 
configuration is found, but the motherboard has no hardware monitoring 
capabilities.


=
I've also added a shellscript which can be added to the lmsensors 
startupscript in /etc/init.d/. This script check for modified DMI 
information (I.E. new motherboard) and then tries to autodetect the 
motherboard using this information.

Because attachments seem to get filtered out when I send them to the list, 
I've also uploaded them at:
Patch: 
http://www.pinkelmans.nl/prive/sensors/sensors-detect-20070530.patch
Shellscript:     http://www.pinkelmans.nl/prive/sensors/shell

Ivo Manca

----- Original Message ----- 
From: "Ivo Manca" <pinkel@gmail.com>
To: <lm-sensors@lm-sensors.org>
Cc: <J.W.R.deGoede@hhs.nl>; "Jasper Alias" <jasperalias@hotmail.com>; "Weg, 
G. van der" <g.vanderweg@student.hhs.nl>; "Jean Delvare" 
<khali@linux-fr.org>; <ejl@eberian.com>
Sent: Monday 14 May 2007 13:13
Subject: Sensors-detect with DMI information, requirements & first version: 
Requestion comment


> Hey all,
>
> Please find attached the (patch for) first version of the updated
> sensors-detect. This patch adds support for looking up sensors
> configurations while using DMI information. It applies to the 3.0.0 branch
> of lmsensors.
>
> Information about the patch:
> * Adds command line parameters
> (--automatic, --manual, --version, --verbose, --help, --update)
> * Looks up DMI information and tries to match this with a config file in
> /usr/share/lmsensors/motherboards
> * Ability to update /usr/share/lmsensors/motherboards with database (Note:
> This database is currently a DUMMY and does not contain any usuable
> information suitable for anything besides testing).
> * Proccesses the config file if found.
>
> It seems like it's already near to a complete working version. Every 
> comment
> will be appriciated.
> If you want to find a checklist with the implemented functions, please
> check: http://www.pinkelmans.nl/prive/sensors/Checklist.pdf
>
> Note 1: The script currentently does not yet escapes backslashes for
> filenames, this will be added soon.
> Note 2: To make the patch more readable, there are no spaces added to 
> nearly
> every line inside the mainfunction of sensors-detect. Therefor the patched
> verion of sensors-detect itself might be hard to read. A patch with the
> added spaces (etc) will be submitted next week or so.
> Note 3: The ability to only download configurations suitable for the 
> current
> architecture will be added if time permits.
>
> Requirements for sensors-detect (Ivo Manca):
> http://www.pinkelmans.nl/prive/sensors/sensors_detect-req.pdf
> Requirements for website (Jasper Alias):
> http://www.pinkelmans.nl/prive/sensors/website-req.pdf
> Please feel free to comment on these requirements or to ask us to 
> eleberate
> them.
>
> Information about the sensors-detect discussion can be found:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19332
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/thread.html#19008
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/thread.html#18932
>
> Ivo Manca
> Jasper Alias
> Gijs van der Weg
> 

------=_NextPart_000_00E2_01C7A2D5.F8C51DB0
Content-Type: application/octet-stream;
	name="shell"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="shell"

#!/bin/sh=0A=
=0A=
OLDDMIFILE=3D/etc/dmistrings=0A=
=0A=
# don't use -t system, since you also get logging info=0A=
NEWDMI=3D`dmidecode -s system-manufacturer 2> /dev/null`=0A=
NEWDMI=3D"$NEWDMI`dmidecode -s system-product-name 2> /dev/null`"=0A=
NEWDMI=3D"$NEWDMI`dmidecode -s system-version 2> /dev/null`"=0A=
NEWDMI=3D"$NEWDMI`dmidecode -s baseboard-manufacturer 2> /dev/null`"=0A=
NEWDMI=3D"$NEWDMI`dmidecode -s baseboard-product-name 2> /dev/null`"=0A=
NEWDMI=3D"$NEWDMI`dmidecode -s baseboard-version 2> /dev/null`"=0A=
=0A=
if [ ! -r "$OLDDMIFILE" ]=0A=
then=0A=
  sensors-detect -a > /dev/null 2> /dev/null=0A=
else=0A=
  # read $OLDDMIFILE=0A=
  OLDDMI=3D`cat $OLDDMIFILE`=0A=
  if [ "$NEWDMI" !=3D "$OLDDMI" ] =0A=
  then=0A=
    sensors-detect -a > /dev/null 2> /dev/null=0A=
  fi=0A=
fi=0A=
=0A=
exit 0
------=_NextPart_000_00E2_01C7A2D5.F8C51DB0
Content-Type: application/octet-stream;
	name="sensors-detect-20070530.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sensors-detect-20070530.patch"

--- sensors-detect-3.0.0	2007-05-09 15:06:41.609375000 +0200
+++ sensors-detect	2007-05-30 13:00:10.890625000 +0200
@@ -33,6 +33,9 @@
 use Fcntl;
 use POSIX;
 use File::Basename;
+use File::Copy;
+use Getopt::Long;
+use LWP::Simple;
=20
 # We will call modprobe and i2cdetect, which typically live in either =
/sbin,
 # /usr/sbin or /usr/local/bin. So make sure these are all in the PATH.
@@ -2117,7 +2120,7 @@
 # AUTODETECTION #
 #################
=20
-use vars qw($modules_conf $dev_i2c $sysfs_root);
+use vars qw($modules_conf $dev_i2c $sysfs_root $verbose);
=20
 sub initialize_conf
 {
@@ -5326,6 +5329,302 @@
 	return;
 }
=20
+###########
+# DMI #
+###########
+
+use vars qw(%dmi $libraryPath);
+
+sub initialize_dmi_data
+{
+  my $version;
+  my @items =3D (
+    'system-manufacturer',
+    'system-product-name',
+    'system-version',
+    'baseboard-manufacturer',
+    'baseboard-product-name',
+    'baseboard-version',
+  );
+
+  return 0 unless open(local *DMIDECODE, "dmidecode --version =
2>/dev/null |");
+  $version =3D <DMIDECODE>;
+  close(DMIDECODE);
+  return 0 unless defined $version;
+
+  # We need at least version 2.7
+  chomp $version;
+  return 0 unless $version =3D~ m/^(\d+).(\d+)$/;
+  return 0 unless (($1 =3D=3D 2 && $2 >=3D 7) || $1 > 2);
+
+  open(local *DMISTRINGS, ">/etc/dmistrings") or die "Sorry, can't =
create /etc/dmistrings ($!)";
+
+  foreach my $k (@items) {
+    next unless open(local *DMIDECODE, "dmidecode -s $k |");
+    $dmi{$k} =3D <DMIDECODE>;
+    close(DMIDECODE);
+    # Strip trailing white-space, discard empty field
+    $dmi{$k} =3D~ s/\s*$// if defined $dmi{$k};
+    delete $dmi{$k} if (!defined $dmi{$k} || $dmi{$k} eq '');
+    #write the DMI information to a file for later reference
+    print DMISTRINGS $dmi{$k};
+   }
+   return 1;
+}
+
+sub update_database
+{
+  my ($url,@headinfo,$modify_date_file,$modify_date_web,$file);
+
+  $url =3D "http://www.pinkelmans.nl/prive/sensors/latest.tar.gz"; =20
+  $file =3D $libraryPath."latest.tar.gz";
+ =20
+  print "\nChecking for updates...\n";
+ =20
+  # Read the head to get the last-modified-date
+  @headinfo =3D head($url);
+  if (@headinfo) {
+    $modify_date_web =3D $headinfo[2];
+  } else {
+    print @headinfo . "Errors: Problems with the website\n";
+    return 0;
+  }
+ =20
+  # check if library path exists, if not: create
+  if (not -d $libraryPath) {
+    my $dir;=20
+    my $accum=3D"";
+    foreach $dir (split(/\//, $libraryPath)){
+      $accum =3D "$accum$dir/";
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
+ =20
+  # check if file exists localy, to check if there is a newer one =
available
+  if (-e $file) {
+    $modify_date_file =3D (stat($file))[9];
+    if ($modify_date_web <=3D $modify_date_file) {
+      print "No update available\n";
+      return 0;
+    }
+  }
+ =20
+ =20
+  print "Downloading tarball...";
+  print "\nFrom: ".$url." To: ".$file."\n" if $verbose;
+  my $response =3D getstore($url, $file);
+ =20
+  # set modify date to the same date as the file on the website to get =
them in-sync;
+  utime $modify_date_web, $modify_date_web, $file;
+  if (is_success($response )) {
+    print "Extracting tarball...";
+	print "\nFrom: ".$file." To: ".$libraryPath." with: tar-xzf \n" if =
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
+  my $mode =3D $_[0];
+  my $update =3D 0;
+
+  # initialize the dmi data
+  if (!initialize_dmi_data()) {
+    print "Error! 'dmidecode' can not be found or loaded. Please make =
sure \n",
+          "it is installed. \n",
+          "Skipping DMI detection.\n\n";=20
+    return 0;
+  }
+
+  print $mode =3D=3D 2 ? "Entering DMI Detection mode...\n" : "\n";
+
+  # check whether to update or not, based on automatic mode =
(mode=3D=3D2), available local database and user input
+  $update =3D -1 if $mode =3D=3D 2; # don't update if automatic mode is =
enabled
+  if (!$update) {
+    if (not -d $libraryPath)  {
+      print "It seems that the database with the different motherboard =
configurations is\n".
+            "not available on your system. You needed to download and =
install this \n".
+            "database to continue.\n".
+            "Do you wish to download and install the database? =
(YES/no): ";
+      if (<STDIN> =3D~ /\s*[Nn]/) {
+        print "\nNo database available. Aborting.\n";
+        return 0;
+      } else {
+        $update =3D 1;
+      }
+    } else {
+    print "Before finding the apropriate config file, you can choose to =
update\n".
+        "your database with a database downloaded from internet. \n".
+        "Do you want to check for updates? (YES/no)";
+        $update =3D 1 unless (<STDIN> =3D~ /\s*[Nn]/);
+    }
+  }
+ =20
+  if ($update =3D=3D 1) {
+    update_database();
+    print "\n";
+  }
+ =20
+  print_dmi_data() if $verbose;
+ =20
+  return find_config_file($mode);
+}
+
+sub print_dmi_data
+{
+  print "This is the output of your DMI information: \n",
+       "# System Manufacturer: ", $dmi{'system-manufacturer'}, "\n",
+       "# System Productname: ", $dmi{'system-product-name'}, "\n",
+       "# System Version: ", $dmi{'system-version'}, "\n",
+       "# Baseboard Manufacturer: ", $dmi{'baseboard-manufacturer'}, =
"\n",
+       "# Baseboard Productname: ", $dmi{'baseboard-product-name'}, =
"\n",
+       "# Baseboard Version: ", $dmi{'baseboard-version'}, "\n\n";
+}
+
+sub find_config_file
+{
+  # find the config file corrensponding to the DMI information
+  my $mode =3D $_[0];
+  my $find_file =3D $dmi{'system-manufacturer'}. =
"-".$dmi{'baseboard-manufacturer'}. "-".$dmi{'system-product-name'}. =
"-".$dmi{'baseboard-product-name'}."-";
+  my $find_version =3D $dmi{'system-version'}. =
"-".$dmi{'baseboard-version'};
+ =20
+  # strip the character / (directory separator) from the dmi-info
+  $find_file =3D~ s/\//./g; =20
+  $find_version =3D~ s/\//./g;   =20
+ =20
+  $find_file =3D $libraryPath.$find_file;
+ =20
+  my $config_file;
+ =20
+  # search for config file matching revision
+  print "Looking for configfile '".$find_file.$find_version. "'\n" if =
$verbose;
+  if (-e $find_file.$find_version)  {
+    $config_file =3D $find_file.$find_version;
+  } else {
+    print "Configfile not found \n" if $verbose;
+    if ($mode !=3D 2) {
+      # search for alternative revisions and let the user decided =
wether to load it or not
+      print "Looking for alternative configfiles: '".$find_file."*'\n" =
if $verbose;
+      my @alternate_config_files;
+      my $file_name;
+      my $nr_alternate_config_files;
+      my $count;
+      while ($file_name =3D glob($find_file."*")) {
+        $file_name =3D~ s/$find_file//;
+        push(@alternate_config_files,$file_name);
+      }
+      $nr_alternate_config_files =3D scalar(@alternate_config_files);
+      if ($nr_alternate_config_files > 0) {
+        print "I was able to find ",$nr_alternate_config_files," =
alternate configurations after comparing\n",
+              "the information from the DMI table with the available =
configuration files.\n";
+        print "These configurations match your motherboard manufacturer =
and model, \n".
+              "but are tested for a different revision. Your revision =
is: \n\n";
+        print "* ",$find_version,"\n\n";
+        print "The available configrations are for the following =
revisions:\n\n";
+        foreach $file_name(@alternate_config_files) {
+          $count++;
+          print$count,". ",$file_name,"\n";
+        }
+        print "\nPlease choose the configuration you want to load.\n",
+              "Note: These configurations are not tested for your =
specefic motherboard\n",
+              "model. Use them at your own risk.\n";
+        print "Enter 0 or hit return if you want to exit detection =
through DMI.\n";
+        print "Config file [0-",$nr_alternate_config_files,"]: ";
+        my $inp =3D<STDIN>;
+        print "\n";
+        if ($inp =3D~ /^[1-$nr_alternate_config_files]$/) {
+          $config_file =3D $find_file.$alternate_config_files[$inp-1];
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
+sub load_config_file=20
+{
+  my $config_file =3D $_[0];
+  my $mode =3D $_[1];
+  my (@modules, $module, $modprobes,$comment);
+
+  print "Using config: ",$config_file,"\n\n";
+ =20
+  # backup old config if automatic mode is enabled
+  if (!(-e "/etc/sensors.conf.sensorsdetect")) {
+    copy ("/etc/sensors.conf", "/etc/sensors.conf.sensorsdetect");=20
+    print "Backup of /etc/sensors.conf saved at =
/etc/sensors.conf.sensorsdetect\n";
+  }
+ =20
+  # copy config to /etc/sensors.conf
+  copy ($config_file, "/etc/sensors.conf");
+
+  # parse config file
+  open FILE, "/etc/sensors.conf" or die "Can't open config file";
+  while(<FILE>) {
+    if ($_ =3D~ m/^# modprobe /) {
+      # modprobe found!
+      $_ =3D~ s/^# modprobe //;
+      $_ =3D~ s/\n//;
+      push(@modules,$_);
+    }
+    if ($_ =3D~ m/^# Comment: /) {
+      #comment found!
+      $_ =3D~ s/^# Comment: //;
+      $comment .=3D "* ".$_."\n";
+    }
+  }
+ =20
+  # show the found comments first
+  print $comment;
+=20
+  # generate modprobes
+  $modprobes .=3D "# Drivers found by sensors-detect with DMI detection =
enabled\n";
+ =20
+  # load modules and add to autoload
+  foreach $module(@modules) {
+    if (exists($modules_list{$module})) {
+      print "Module `$module' already loaded.\n";
+    } else {
+      print "Load `$module' (say NO if built into your kernel)? =
(YES/no): " unless ($mode =3D=3D 2);
+      unless ($mode !=3D 2 && <STDIN> =3D~ /^\s*[Nn]/) {
+        if (system ("modprobe", $module)) {
+          print "Loading failed... skipping.\n";
+          $modprobes .=3D "# Warning: the required module $module is =
not currently installed\n".
+                        "# on your system. For status of 2.6 kernel =
ports check\n".
+                        "# http://www.lm-sensors.org/wiki/Devices. If =
driver is built\n".
+                        "# into the kernel, or unavailable, comment out =
the following line.\n";
+        } else {
+          print "Module loaded successfully.\n";
+        }
+      }
+    }
+    $modprobes .=3D "modprobe $module\n";
+  }
+  print "DMI detection succeeded and config file succesfully =
loaded!\n\n";
+  return (1,$modprobes);
+}
+
 ################
 # MAIN PROGRAM #
 ################
@@ -5380,12 +5679,11 @@
 # A second array, called=20
 sub generate_modprobes
 {
-  my ($prefer_isa) =3D @_;
+  my ($prefer_isa,$modprobes) =3D @_;
=20
   my =
($chip,$detection,$nr,$i,@optionlist,@probelist,$driver,$isa,$adap);
   my $bmcsensors =3D 0;
   my @adapters;
-  my $modprobes =3D "";
   my $configfile =3D "";
=20
   # These are always needed
@@ -5528,9 +5826,29 @@
  =20
 }
=20
+sub VersionMessage
+{
+  print "# sensors-detect revision $revision\n\n";
+  exit;
+}
+sub HelpMessage
+{
+  print "Usage: sensors-detect [OPTION]\n",
+        "  -a  --automatic       Don't ask anything, use defaults\n",
+        "  -?, --help            Display this help\n",
+        "  -m, --manual          Only use old way of probing\n",
+        "  -u  --update          Update the database, then quit\n",
+        "  -v  --verbose         Display extra information useful for =
debugging\n",
+        "      --version         Display the program version\n",
+        "\n",
+        "Default mode is:  use DMI detection first, fallback to old way =
of probing\n";
+  exit;
+}
+
 sub main
 {
-  my (@adapters,$res,$did_adapter_detection,$adapter);
+  my =
(@adapters,$res,$did_adapter_detection,$adapter,$modprobes,$configfile,$u=
pdate,$inp);
+  my $dmi_success =3D 0;
=20
   # We won't go very far if not root
   unless ($> =3D=3D 0) {
@@ -5538,6 +5856,16 @@
     exit -1;
   }
=20
+  # Parse the command line parameters=20
+  my $mode =3D 1; #0 =3D manual  1 =3D dmi, 2 =3D automatic=20
+  $libraryPath =3D "/usr/share/lmsensors/motherboards/";
+ =20
+  my $result =3D GetOptions ("verbose|v"=3D> \$verbose, "update" =3D> =
\$update, "automatic"=3D> sub {$mode =3D 2 },"manual"=3D> sub { $mode =
=3D 0 }, "help|?"=3D> sub { HelpMessage() },"version" =3D> sub { =
VersionMessage() });
+  if ($update) { # not an GetOptions sub. Verbose won't be passed if =
you specify "-u -v", when the update function is called in a sub. Now it =
will be passed.
+    update_database();=20
+    exit;
+  }
+ =20
   initialize_conf;
   initialize_proc_pci;
   initialize_modules_list;
@@ -5556,6 +5884,32 @@
     unless kernel_version_at_least(2, 6, 0);
   print "\n";
=20
+  #  dmi automaticly, interactive or disabled
+ =20
+  if ($mode > 0) {
+    if ($mode =3D=3D 2) { #  start dmi detection if automatic mode is =
enabled
+      ($dmi_success, $modprobes) =3D dmi_detection($mode);
+      # create dmidecode information file, used by automatic startup =
script
+    } else {
+       print "We can start looking up the DMI table to find a config =
file. This\n",
+             "is the safest way to locate the available sensors.\n".
+             "Do you want to lookup the DMI table now? (YES/no): ";
+      $inp =3D <STDIN>;
+      if (not $inp =3D~ /\s*[Nn]/) { #  start dmi detection if manual =
mode is enabled and user presses "yes"=20
+        ($dmi_success, $modprobes) =3D dmi_detection($mode);
+        # create dmidecode information file, used by automatic startup =
script
+      }
+    }
+  }
+=20
+  if ($dmi_success =3D=3D 0) { # dmi detection not started or =
unsuccesful
+    if ($mode =3D=3D 2) { # quit if automatic mode enabled
+    die "Detection using the DMI information failed. \n",
+       "Please update your database or use non-automatic mode for =
detection \n";
+    }
+ =20
+  print "Detection using the DMI information failed. Switching to old =
mode. \n\n" unless ($mode =3D=3D 0 || $inp =3D~ /\s*[Nn]/);
+ =20
   print "We can start with probing for (PCI) I2C or SMBus adapters.\n";
   print "Do you want to probe now? (YES/no): ";
   @adapters =3D adapter_pci_detection=20
@@ -5615,7 +5969,7 @@
         "If you found that the adapter hung after probing a certain =
address,\n",
         "you can specify that address to remain unprobed.\n";
=20
-  my ($inp,@not_to_scan,$inp2);
+  my (@not_to_scan,$inp2);
   # i2cdetect -l either cats /proc/bus/i2c or scans sysfs for the same =
information
   open(local *INPUTFILE, "i2cdetect -l |") or die "Couldn't find =
i2cdetect program!!";
   local $_;
@@ -5665,9 +6019,11 @@
   }
   print "\n";
=20
+ } # end "DMI" mode to detect CPU sensors.
+=20
   print "Some CPUs or memory controllers may also contain embedded =
sensors.\n";
-  print "Do you want to scan for them? (YES/no): ";
-  unless (<STDIN> =3D~ /^\s*n/i) {
+  print "Do you want to scan for them? (YES/no): " unless ($mode =3D=3D =
2);
+  unless ($mode !=3D 2 && <STDIN> =3D~ /^\s*n/i) {
     $| =3D 1;
     foreach my $entry (@cpu_ids) {
       scan_cpu($entry);
@@ -5675,7 +6031,9 @@
     $| =3D 0;
   }
   print "\n";
-
+=20
+ if ($dmi_success =3D=3D 0) # dmi detection not started or unsuccesful
+ {
   if(! @chips_detected) {
     print "Sorry, no sensors were detected.\n",
           "Either your sensors are not supported, or they are connected =
to an\n",
@@ -5727,12 +6085,14 @@
   }
   print "\n";
=20
-  print "I will now generate the commands needed to load the required =
modules.\n".
-        "Just press ENTER to continue: ";
-  <STDIN>;
+ } # end "DMI" mode
+  ($modprobes, $configfile) =3D generate_modprobes(1,$modprobes);	# 1 =
=3D=3D prefer ISA
+=20
+  print "I will now generate the commands needed to load the required =
modules.\n";
+  print "Just press ENTER to continue: " unless ($mode =3D=3D 2);
+  <STDIN> unless ($mode =3D=3D 2);
     =20
   print "\n";
-  my ($modprobes, $configfile) =3D generate_modprobes 1;	# 1 =3D=3D =
prefer ISA
   print "To make the sensors modules behave correctly, add these lines =
to\n".
         "$modules_conf:\n\n";
   print "#----cut here----\n".
@@ -5755,13 +6115,21 @@
   my $have_sysconfig =3D -d '/etc/sysconfig';
   printf "Do you want to \%s /etc/sysconfig/lm_sensors? (\%s): ",
          (-e '/etc/sysconfig/lm_sensors' ? 'overwrite' : 'generate'),
-         ($have_sysconfig ? 'YES/no' : 'yes/NO');
-  $_ =3D <STDIN>;
+         ($have_sysconfig ? 'YES/no' : 'yes/NO') unless ($mode =3D=3D =
2);
+  $_ =3D $mode =3D=3D 2 ? "" : <STDIN>;
+ =20
   if (($have_sysconfig and not m/^\s*n/i) or m/^\s*y/i) {
     unless ($have_sysconfig) {
       mkdir '/etc/sysconfig', 0777
         or die "Sorry, can't create /etc/sysconfig ($!)";
     }
+
+    if (($mode =3D=3D 2) && (!(-e =
"/etc/sysconfig/lm_sensors.sensorsdetect"))) {=20
+      # backup the lmsensors sysconfig
+      copy =
("/etc/sysconfig/lm_sensors","/etc/sysconfig/lm_sensors.sensorsdetect");
+      print "Backup of /etc/sysconfig/lm_sensors saved at =
/etc/sysconfig/lm_sensors.sensorsdetect\n\n";
+    }
+
     open(local *SYSCONFIG, ">/etc/sysconfig/lm_sensors")
       or die "Sorry, can't create /etc/sysconfig/lm_sensors ($!)";
     print SYSCONFIG <<'EOT';
@@ -5809,6 +6177,7 @@
     }
     print SYSCONFIG $sysconfig;
=20
+    print "/etc/sysconfig/lm_senors is overwritten with the new =
config.\n";
     print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
           "for initialization at boot time.\n"
       unless -f "/etc/init.d/lm_sensors";

------=_NextPart_000_00E2_01C7A2D5.F8C51DB0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_00E2_01C7A2D5.F8C51DB0--

