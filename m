From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors 2.7.0 and bmcsensors.o
Message-Id: <3E385289.711ABEF0@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
In-Reply-To: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

make sure you didn't give up too soon,
be sure the modules listed in doc/chips/bmcsensors are loaded,
check dmesg - the IPMI modules should tell you if they found something or not.
If there were no complaints at all then you probably are missing a module...

David Brodbeck wrote:
> 
> > -----Original Message-----
> > From: Mark Studebaker [mailto:mds@paradyne.com]
> 
> > you need your kernel patched with IPMI and have it enabled.
> > see doc/chips/bmcsensors for more info.
> 
> Got that going.  Looks like nothing on my system is supported, though.
> (It's a Dell Poweredge 2600.)  The modules load without complaint but
> sensors -s reports 'No sensors found!'.  Ah well.
