From: "John Brier" <johnbrier@gmail.com>
Date: Thu, 25 Dec 2008 18:05:55 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <f421b28c0812251005k6af2f261s6a6545e2f1504265@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 25, 2008 at 9:29 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi John,
Hi Jean! thanks for responding!

>
> Preliminary note: using something as old as lm-sensors 2.10.1 with
> a kernel as recent as 2.6.26.5 doesn't make much sense IMHO. We do
> our best to preserve compatibility but it's hard to always get it
> right.
>

Fair enough. I expected this.

>> yet I still get this "warning" If it's only a warning why don't I get
>> the actual readings from my hardware?
>
> The warning documented above is unrelated to your problem, this is
> why.
>
>> I looked into upgrading to
>> lm-sensors 3 and libsenseors4 packages from Debian testing tree but
>> the dependencies were pretty bad, I might as well upgrade the whole
>> system to testing.
>
> Shouldn't be. For one thing you should be able to install libsensors3
> and libsensors4 in parallel. Once this is done you should be able to
> upgrade lm-sensors (and only lm-sensors) from version 2.x to version
> 3.x. I am no Debian expert though, maybe I'm missing something.

lm-sensors 3 and libsensors 4 want a newer version of libc6 than I
have installed, and upgrading that seems like a bad idea (it would
probably force upgrading all the packages on the system since they all
depend on libc6, thus I might as well move the whole system from
debian stable to debian testing) In the end this may be the only
solution :-(

==============[root@tb303 ~]# dpkg -i libsensors4_3.0.2-1+b2_amd64.deb
(Reading database ... 30914 files and directories currently installed.)
Preparing to replace libsensors4 1:3.0.2-1+b2 (using
libsensors4_3.0.2-1+b2_amd64.deb) ...
Unpacking replacement libsensors4 ...
dpkg: dependency problems prevent configuration of libsensors4:
 libsensors4 depends on libc6 (>= 2.7-1); however:
  Version of libc6 on system is 2.3.6.ds1-13etch7.
dpkg: error processing libsensors4 (--install):
 dependency problems - leaving unconfigured
Errors were encountered while processing:
 libsensors4
[root@tb303 ~]# dpkg -i lm-sensors_3.0.2-1+b2_amd64.deb
(Reading database ... 30914 files and directories currently installed.)
Preparing to replace lm-sensors 1:2.10.1-3 (using
lm-sensors_3.0.2-1+b2_amd64.deb) ...
Unpacking replacement lm-sensors ...
dpkg: dependency problems prevent configuration of lm-sensors:
 lm-sensors depends on libc6 (>= 2.7-1); however:
  Version of libc6 on system is 2.3.6.ds1-13etch7.
 lm-sensors depends on libsensors4 (>= 1:3.0.0-1); however:
  Package libsensors4 is not configured yet.
dpkg: error processing lm-sensors (--install):
 dependency problems - leaving unconfigured
Errors were encountered while processing:
 lm-sensors
[root@tb303 ~]# dpkg -i libc6_2.7-16_amd64.deb
dpkg: regarding libc6_2.7-16_amd64.deb containing libc6:
 libc6 conflicts with tzdata-etch
  tzdata provides tzdata-etch and is installed.
dpkg: error processing libc6_2.7-16_amd64.deb (--install):
 conflicting packages - not installing libc6
Errors were encountered while processing:
 libc6_2.7-16_amd64.deb
[root@tb303 ~]# dpkg -p libc6
Package: libc6
Priority: required
Section: libs
Installed-Size: 11468
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Architecture: amd64
Source: glibc
Version: 2.7-16
Provides: glibc-2.7-1
Depends: libgcc1
Suggests: locales, glibc-doc
Conflicts: libterm-readline-gnu-perl (<< 1.15-2), tzdata (<< 2007k-1),
tzdata-etch
Filename: pool/main/g/glibc/libc6_2.3.6.ds1-13etch5_amd64.deb
Size: 4936850
MD5sum: d25329a43a9631173dac87a4ed161ee5
Description: GNU C Library: Shared libraries
 Contains the standard libraries that are used by nearly all programs on
 the system. This package includes shared versions of the standard C library
 and the standard math library, as well as many others.
==============


>
>> I have run sensors-detect and have the proper modules loaded.
>
> Which modules are these?

i2c_nforce2
w83627hf
k8temp is compiled directly into the kernel (non modular).


>
> Please provide the full output of sensors-detect.
http://pastebin.ca/1293524

>
> Did this system ever work with a different combination of lm-sensors
> version and kernel version? And what system is this?

Yes it worked with an older kernel and same version of lm-sensors (not
certain on the version of lm-sensors because I've updated since then
of course, this was a year ago that it worked). The kernel it used to
work on (I can test this again) was 2.6.20.1.

The system is MSI K8N Neo4 Platinum nforce4 based motherboard.
http://www.msicomputer.com/product/p_spec.asp?model=K8N_Neo4_Platinum&class=mb

John Brier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
