From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <3DEE4938.8841660F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I see. Well, MODPREF controls where the modules get installed.
That should be the same as the kernel that we compiled against,
which is the one defined in LINUX:= .
So don't you think MODPREF should do the "-L" thing?
But I don't know what happens if we default to /usr/src/linux...

Jean Delvare wrote:
> 
> > why did you back out MODPREF in the makefiles?
> > I liked it the way it was... is there any way to keep
> > $KERNELVERSION???
> 
> The new way doesn't work anymore since I modified the LINUX := lines. If
> the build symlink was not found, it would use /usr/src/linux as the base
> source tree but would install the modules in
> /lib/modules/$KERNELVERSION, which may not match the version present in
> /usr/src/linux.
> 
> An alternative is to use the same "if [ -L ... ]" thing for MODPREF as I
> used for LINUX. I can do it if you really want me to do so, but frankly,
> I don't see the idea. The way things are right now work, so?
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
