From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: help lmsensors
Message-Id: <1040738540.15471.3.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E075D5E.1070309@earthlink.com>
In-Reply-To: <3E075D5E.1070309@earthlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2002-12-23 at 14:00, wing549@earthlink.com wrote:
> help, i have a Abit KX7-333r motherboard, i ran sensors-detect and put 
> in the modules and it didnt work, then someone on irc, ended up telling 
> me to run this options force command, wich worked, but then i messed up 
> my linux and had to reformat and install, (i played with fsck :p) well 
> now when i run make it gives me this....
> [root@localhost lm_sensors-2.7.0]# make
> grep: /lib/modules/2.4.18-18.7.x/build/Makefile: No such file or directory

Look in /lib/modules/2.4.18-18.7.x to see if you have a symbolic link
"build" to /usr/src/linux.

Also check in /usr/src to see that "linux" is a symlink to the kernel
source tree.
That tree may or may not have been installed by default on your
re-install.


> grep: /lib/modules/2.4.18-18.7.x/build/include/linux/autoconf.h: No such 
> file or directory
> make: *** No rule to make target 
> `/lib/modules/2.4.18-18.7.x/build/include/linux/errno.h', needed by 
> `prog/detect/i2cdetect.rd'.  Stop.

-- 
Ed Harrison <ed.tman@verizon.net>
