From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors 2.7.0 and bmcsensors.o
Message-Id: <3E2D8D2D.86EEC479@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
In-Reply-To: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you need your kernel patched with IPMI and have it enabled.
see doc/chips/bmcsensors for more info.

David Brodbeck wrote:
> 
> I'm having an odd problem with lm_sensors 2.7.0.  I can't get the bmcsensors
> module to compile.  'make' simply doesn't generate a .o file from
> bmcsensors.c.  I'm sure there's some silly piece of configuration I'm
> missing, but I can't figure it out.  According to sensors_detect I need to
> load this module.
> 
> ----------
> 
> David Brodbeck, System Administrator
> InterClean Equipment, Inc.
> Ypsilanti, Michigan
> davidb@mail.interclean.com
> (734) 975-2967 x221
