From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3EF5B718.3050307@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the report.
We've already attempted to fix things in CVS.
Would you please try it for us using gcc 3.3.
There's a link on our home page (May 31st entry)
to the new makefile and the file etc/config.c, which is also needed.



Chiaki wrote:
> Compiling lm_sensors module with gcc 3.3.
> 
> Hi,
> 
> Thank you for the great software packages (LM_SENSORS and I2C.)
> 
> This is a short bug report and workaround caused by
> the latest GCC 3.3.
> 
> Background.
> 
> Recently, I upgraded GCC on my Debian GNU/Linux PC to GCC 3.3.
> After that I upgraded linux kernel to 2.4.21.
> 
> Obviously, GCC 3.3 broke some assumptions that the earlier
> gcc 2.9.x kept, and so
> lm_sensors 2.7.0 could not be compiled right away.
> 
> PROBLEM:
> 
> Basically the problem is this.
> 
> GCC 3.3 no longer honors the user's wish to
> use -I/usr/local/include/ FIRST prior to system header directories.
> (It seems that many people were bitten with mixup
> verson of system headers in such directories , and it seems that
> GCC 3.3 now has an internal list of so called "system header
> directory" which had been the standard places for such
> quasi-system headers for temporary tool development, etc.
> GCC now refuses to honor the inclusion of -Isuch_header_directory
> on the command line. (It prints out that it is ignoring
> such directory  due to this. So far, so good.
> 
> Problem is that
> /usr/local/include is such an ignored header directory!
> 
> This poses a problem for lm_sensors compilation since
> the compilation needs to look at the latest i2c headers
> in the /usr/local/include/linux/l2c.h and other files
> under the directory instead of the outdated i2c header files under
> kernel header directory.
> 
> WORKAROUND:
> 
> After scratching my head for a while and many false starts,
> I finally decided to the following and
> the compilation now succeeds.
> 
> You might want to put a comment regarding this in
> your INSTALL file.
> 
> 1. Create a new directory to store i2c header files.
>    I chose
> 
>       /usr/local/tool-include
> 
>   This must not collide with the gcc's blacklisted system header
>   directory and the above choice is OK.
> 
> 2. Change i2c top-level Make file so tthat the latest
>    i2c headers are stored in the directory created above.
> 
> 
> *** Makefile~	2002-12-05 00:44:32.000000000 +0900
> --- Makefile	2003-06-22 07:08:39.000000000 +0900
> ***************
> *** 73,79 ****
>   # This is the directory into which the header files will be installed.
>   # If you want to make sure your current kernel tree is not overwritten,
>   # the default should work. This is ignored for the i2c build system.
> ! LINUX_INCLUDE_DIR := /usr/local/include/linux
>   #LINUX_INCLUDE_DIR := $(LINUX_HEADERS)/linux
> 
>   # If you want to isntall everything at some other place then at which
> --- 73,79 ----
>   # This is the directory into which the header files will be installed.
>   # If you want to make sure your current kernel tree is not overwritten,
>   # the default should work. This is ignored for the i2c build system.
> ! LINUX_INCLUDE_DIR := /usr/local/tool-include/linux
>   #LINUX_INCLUDE_DIR := $(LINUX_HEADERS)/linux
> 
>   # If you want to isntall everything at some other place then at which
> 
> 
>   run make install to install the headers into the directory.
> 
> 
> 3. Change lm_sensors top level makefile so that it will look
>    for the i2c headers thus stored.
> 
> 
> *** Makefile~	2002-12-05 00:44:32.000000000 +0900
> --- Makefile	2003-06-22 07:22:38.000000000 +0900
> ***************
> *** 49,55 ****
>   # may be used mistakenly. Note: This should point to the directory
>   # *above* the linux/ subdirectory, so to /usr/local/include in the
>   # above example.
> ! I2C_HEADERS=/usr/local/include
>   #I2C_HEADERS=$(LINUX_HEADERS)
> 
>   # Uncomment the third line on SMP systems if the magic invocation
> fails. It
> --- 49,55 ----
>   # may be used mistakenly. Note: This should point to the directory
>   # *above* the linux/ subdirectory, so to /usr/local/include in the
>   # above example.
> ! I2C_HEADERS=/usr/local/tool-include
>   #I2C_HEADERS=$(LINUX_HEADERS)
> 
>   # Uncomment the third line on SMP systems if the magic invocation
> fails. It
> 
> 
> 4. With the above change, the compilation of lm_sensors succeeds
> and I could install lm_sensors modules with gcc 3.3.
> 
> 
> Thank you again for the great piece of software.
> 
> Happy Hacking
> 
> Ishikawa, Chiaki
> 
> 
> PS: The ignoring of "system header" directory used as part of -I
> parameter by the latest gcc is a blessing to some obviously [
> I can certainly think of some scenarios of long debug sessions
> of a bug caused by the mixup of different version header files ]
> but to
> those who knew what we were doing by the sleight of hands (so to
> speak),
> this GCC  change causes an initial pain until all the tool chains are
> modified.
> We can't win always, it seems.
> 
> 
> 
