From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 13:53:39 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc4-mm2] drivers: (dynamic sysfs
Message-Id: <2538186705051904531382021a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670505190435648367db@mail.gmail.com>
	 <253818670505190445647685ed@mail.gmail.com>
In-Reply-To: <253818670505190445647685ed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here is the previously mentioned perl script. Its quite simplistic,
and accepts the filename of a source file to update as a parameter, or
uses stdin/stdout if no parameters are given. To update a whole tree
using the below just use something like:

find linux-2.6.12-rc4 -type f -exec ./updatedyncallbackdevattr.pl {} \;

This script should catch every device_attribute callback, including
multiline function signatures and embedded in macros. If it fails to
catch something please let me know.

Thanks,
Yani

---
#!/usr/bin/perl

use strict;

my $infile=shift;

if(!defined $infile){
        open(IN,"<&STDIN") or die "Could not open an input stream";
}else{
        open(IN,"<$infile") or die "Could not open an input stream";
}

my $subs = 0;
my $code = "";

while(<IN>){$code.=$_};
close(IN);

$code =~ s/(ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,)([\s\\]*?char[\s\\]*?\*[^,);]*?[\s\\]*?\))/$1
struct device_attribute *attr,$2/gs && $subs++;
$code =~ s/(ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,)([\s\\]*?const[\s\\]+?char[\s\\]*?\*[^,);]*?[\s\\]*?,[\s\\]*size_t[^,);]*?[\s\\]*\))/$1
struct device_attribute *attr,$2/gs && $subs++;

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
