From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: RFC: i2c/lm-sensors modules and userland tools in different
Message-Id: <41FC00D9.6030202@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For fun I added a 'userpackage' target to our top-level makefile that makes a
userspace-only tarball. Wasn't hard. What's a little harder is getting
the makefile correct for the userspace tarball. As-is it works by doning
'make user', but make clean is broken, and who knows what else.
I didn't modify 'make package'.

We could either put some fancy sed stuff in 'make userspace' that would
modify the existing Makefile to a new Makefile
(change 'make user' to be the default, fix 'make clean', etc.), 
move the old Makefile out
of the way temporarily, move the new one in, and finish the tar...
or create a separately maintained Makefile.user and put it in
the userspace tarball as Makefile, using the same tricks...

But anyway, the userspace tarball appears doable.
Would rather not combine the i2c tarball with the lm_sensors modules
tarball though, seems like more trouble than it's worth IMHO

Aurelien Jarno wrote:
> Hi all,
> 
> Last week-end, I packaged i2c and lm-sensors for Debian. It what a bit
> tricky, which makes me doing the following suggestion: Why not separate
> i2c and lm_sensors modules from the userland tools? I mean provide two
> tarballs:
> - one which holds the current i2c tarball, as well as the kernel/ part
>   (and the corresponding documentation) of the lm_sensors tarball
>   = kernel modules
> - one which holds all the others file from the lm_sensors tarball
>   = userland tools
> 
> Benefits
> --------
> - A lot of users are using a 2.6 kernel, so they would only need to 
>   install  one package.
> - Simplified instructions for users: always build userland tools, only
>   build modules on a 2.4 kernel.
> - Remove the version dependencies between i2c and lm-sensors. If they 
>   are distributed in the same tarball, they are always compatible.
> - Simplify the work of distribution packagers. It is possible, but not
>   very easy to generate both kernel modules and userland tools from the
>   same package.
> 
> Drawbacks
> ---------
> - Users who only need i2c modules would have to download a bigger
>   tarball. On the other side, a lot of people are now using a 2.6 kernel
>   and don't need the lm_sensors kernel modules source.
> - The version dependency between the userland tools and kernel modules 
>   would not be guaranteed. So are already i2c modules and lm-sensors 
>   modules. Note that it is already the case on most of distributions as 
>   users want to use the userland tools from the distribution, and want
>   to build they own kernel with i2c/lm_sensors patches or with separate
>   modules.
> 
> Any comments?
> 
> Bye,
> Aur?lien
> 
> 
