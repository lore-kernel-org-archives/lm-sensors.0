From: kress@hal.saar.de (Michael Kress)
Date: Sun, 08 Oct 2006 13:07:00 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4528F7F4.7070004@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Jean Delvare wrote:
> Given that every distribution is different, and different versions of
> rpm support a different set of features, I fail to see the point in
> shipping .spec files at all. They are better maintained by each
> distribution. 
That sounds logical.
> So I propose that we simply delete this RPM directory
> from both our i2c and lm-sensors trees. Objections anyone?
>   
maybe you can keep it somehow as a contrib element, I think that adds
quite some value to every tar ball. :)
>> [root at matrix lm-sensors-r4197-20061007/prog/sensors]# ./sensors
>> pc87427-isa-0840
>> Adapter: ISA adapter
>>     
>
> Not so good. You should see all the values here. I suspect your new
> "sensors" links with an old libsensors. You can check with "sensors -v"
> or "ldd sensors".
>   
ok, sorry for the confusion, that's because I just started sensors from
the build tree. I didn't want to install the thing without an rpm.
Anyways, I grabbed the spec file from centos and built my own rpm,
without the patches. :)

-----8<-----8<-----8<-----SNIP-----8<-----8<-----8<-----
[root at matrix ~]# sensors
pc87427-isa-0840
Adapter: ISA adapter
fan1:     3678 RPM  (min =  712 RPM)
fan2:     3391 RPM  (min =  712 RPM)
fan3:     3400 RPM  (min =  712 RPM)
fan4:     3366 RPM  (min =  712 RPM)
fan5:        0 RPM  (min =  712 RPM)          FAULT
fan6:     2896 RPM  (min =  712 RPM)
fan7:        0 RPM  (min =  712 RPM)          FAULT
fan8:     2812 RPM  (min =  712 RPM)

-----8<-----8<-----8<-----SNIP-----8<-----8<-----8<-----
[root at matrix ~]# rpm -qi lm_sensors
Name        : lm_sensors                   Relocations: (not relocatable)
Version     : 2.10.1                            Vendor: (none)
Release     : 1.0.0                         Build Date: So 08 Okt 2006
14:27:46 CEST
Install Date: So 08 Okt 2006 14:29:34 CEST      Build Host: matrix
Group       : Applications/System           Source RPM:
lm_sensors-2.10.1-1.0.0.src.rpm
Size        : 1925845                          License: GPL
Signature   : (none)
URL         : http://secure.netroedge.com/~lm78/
Summary     : Hardware monitoring tools.
Description :
The lm_sensors package includes a collection of modules for general SMBus
access and hardware monitoring.  NOTE: this requires special support which
is not in standard 2.2-vintage kernels.

-----8<-----8<-----8<-----SNIP-----8<-----8<-----8<-----

Question: Shouldn't the libs as defined in lm_sensors Makefile go to
something more architecture specific?
I changed my local copy of the Makefile from the snapshot to the
following in order to comply with rpm's strict architecture handling.
That allowed me too build the x86_64 package.

BTW, I attached my .spec file, maybe somebody has some use for it. It
only works with the patch applied as shown below.

Instructions:
get
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2
tar xjvf lm-sensors-r4197-20061007.tar.bz2
mv lm-sensors-r4197-20061007 lm_sensors-2.10.1
cd lm_sensors-2.10.1
cp prog/init/lm_sensors.sysconfig /usr/src/redhat/SOURCES
cp prog/init/lm_sensors.init /usr/src/redhat/SOURCES
patch -p1 < patchfile (see patch listed below)
cd ..
tar czvf lm_sensors-2.10.1.tar.gz lm_sensors-2.10.1
put lm_sensors-2.10.1.tar.gz under /usr/src/redhat/SOURCES
put spec file under /usr/src/redhat/SPECS
rpmbuild -ba lm_sensors.spec
cross fingers

Please note: These installations instructions are just from my memory,
they don't claim to comply to any standard neither lm_sensors' nor
centos' standars. I just wanted to make it work under centos without
having files lying around that I can't remove properly should I ever
uninstall or upgrade lm_sensors.

Thanks for your help so far!

Greetings - Michael

[root at matrix SOURCES]# diff -Naur lm-sensors-r4197-20061007/Makefile
lm_sensors-2.10.1/Makefile
--- lm-sensors-r4197-20061007/Makefile 2006-09-17 23:01:35.000000000 +0200
+++ lm_sensors-2.10.1/Makefile 2006-10-08 14:05:31.000000000 +0200
@@ -113,9 +113,16 @@
 # configuration file is found
 ETCDIR := /etc

+# determine machine type (hardware)
+MACHINE := $(shell uname -m)
+
 # You should not need to change this. It is the directory into which the
 # library files (both static and shared) will be installed.
-LIBDIR := $(PREFIX)/lib
+ifeq ($(MACHINE),x86_64)
+    LIBDIR := $(PREFIX)/lib64
+else
+    LIBDIR := $(PREFIX)/lib
+endif

 EXLDFLAGS := -Wl,-rpath,$(LIBDIR)

@@ -143,8 +150,6 @@
 # manual pages will be installed.
 MANDIR := $(PREFIX)/man

-MACHINE := $(shell uname -m)
-
 # Extra non-default programs to build; e.g., sensord
 # PROG_EXTRA := sensord


-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: lm_sensors.spec
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061008/54f92c71/attachment-0001.pl 
