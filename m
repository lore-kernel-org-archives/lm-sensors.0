From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 26 Jul 2005 16:03:20 +0000
Subject: [lm-sensors] yani-script
Message-Id: <42E64292.6060609@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


back in May, Yani wrote a perl script that did a massive code conversion.

In order to understand the regexs in it, I reformatted one of them
to use perls x regex modifier, which allows regex code to be
reformatted for readability.  Then I added comments to the regex.

here it is, in hopes it will be useful.


-------------- next part --------------
#!/usr/bin/perl

=head1 SYNOPSIS

this script adds a void* pointer to many calls in linux
source, specifically those that are sysfs callbacks.

For example:

559c567
< static ssize_t show_temp##offset##_crit(struct device *dev, char *buf) \
---
> static ssize_t show_temp##offset##_crit(struct device *dev, char *buf, void *sdata) \
564c572
< static ssize_t show_temp##offset##_status(struct device *dev, char *buf) \
---
> static ssize_t show_temp##offset##_status(struct device *dev, char *buf, void *sdata) \


its used like this:

#!/bin/sh
find linux-2.6.12-rc4-sysfsdyncallback-autoupdate -type f -exec
./updatedyncallback.pl {} \; 2>&1 |tee subs.log


It is, in essence, a -pi.bak script, but obviously not a 1-liner.

=cut

use strict;

my $infile=shift;

if(!defined $infile){
    open(IN,"<&STDIN") or die "Could not open an input stream";
} else {
    open(IN,"<$infile") or die "Could not open an input stream";
}

my $subs = 0;
my $code = "";

while(<IN>){$code.=$_};
close(IN);

$code =~ s{
    ( # capture the 'whole' function signature
      
      static		# must be static
      [\s\\]+?		# whitespace, inc \ line-ends
      ssize_t		# sysfs callback return-type 
      [\s\\]+?
      [^(;]+?		# accept chars upto '(' or ';'
       
       # parameter list, with a struct <foo> as 1st arg
       \( \s*?struct
       [\s\\]+?	# allowing whitespace
       
       # where <foo> is one of:
       (?:device|device_driver|subsystem|
	gendisk|module_attribute|sysdev_attribute|
	class|class_device|bus_type|
	cpufreq_policy|subsystem|sys_device)
       
       [\s\\]*?
       \*[^,);]*?,
      [\s\\]*?
      char[\s\\]*?
      \*[^,);]*?
      )			# end of capture
    [\s\\]*?\)		# match literal ) closing the parmlist
}
<$1, void *sdata)>gsx && $subs++;


$code =~ s/(static[\s\\]+?ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device|device_driver|subsystem|gendisk|module_attribute|sysdev_attribute|class|class_device|bus_type|cpufreq_policy|subsystem|sys_device)[\s\\]*?\*[^,);]*?,[\s\\]*?const[\s\\]+?char[\s\\]*?\*[^,);]*?[\s\\]*?,[\s\\]*size_t[^,);]*?)[\s\\]*\)/$1,
void *sdata)/gs && $subs++;

if($subs){
        if(!defined $infile){
                open(OUT,">&STDOUT") or die "Could not open an output stream";
        }else{
                open(OUT,">$infile") or die "Could not open an output stream";
        }
        $|;
        print OUT $code;
        close(OUT);
        $infile && print STDOUT "$infile updated.\n";
}
