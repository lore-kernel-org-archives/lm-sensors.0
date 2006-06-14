From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Jun 2006 16:04:37 +0000
Subject: [lm-sensors] ASUS NCCH-DR confusing 83792 vs. 83627THF
Message-Id: <20060614180437.7cb8c350.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44901813.3080703@fasytek.dk>
In-Reply-To: <44901813.3080703@fasytek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The other thing that puzzles me: In an X86_64 system, I would expect to
> > find the libsensor libraries in a the /lib64 directory, but they actually
> > get installed in /usr/local/lib. What must I do to get these libraries
> > in the proper place ?
> 
> # You should not need to change this. It is the directory into which the
> 
> # library files (both static and shared) will be installed.
> 
> LIBDIR := $(PREFIX)/lib
> 
> maybe you can change this to lib64 so the dir will be /usr/local/lib64 but I
> dont know if such directory can exist.

I can't get why some distributions invented these lib64 directories. On
32-bit systems we have lib, not lib32, so why make it different on
64-bit systems? It may make sense to have a lib32 directory on 64-bit
systems for libraries which are only available in 32-bit format, Gentoo
is doing it almost this way (lib is a link to lib64, and there is lib32
for the 32-bit libraries), but doing it the other way around sounds
weird to me.

However if most distributions do that... Maybe we should detect 64-bit
systems and change the default in this case. Anyone wants to give it a
try?

At any rate, nothing will break if you install your 64-bit
libsensors.so under /usr/local/lib, I'm doing this and it works just
fine.

I wonder why you are installing it by yourself, rather that using the
suse package which would put everything in the right place for you?

> You may also change the PREFIX to / to get it to /lib64 if you like. (all in top
> Makefile)

This would be a very bad idea. /lib (and /lib64) are meant for
libraries fundamental to the system, libsensors sure doesn't qualify.

-- 
Jean Delvare

