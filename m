From: rboone@rtd.com (Robert W. Boone)
Date: Fri, 02 Sep 2005 19:59:21 +0000
Subject: [lm-sensors] "Debug: sleeping function called from invalid
Message-Id: <FF8C54C9B0FBD6429771E0886CDF47A903496E@rtdexchange2.rtdext.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF8C54C9B0FBD6429771E0886CDF47A9034963@rtdexchange2.rtdext.com>
In-Reply-To: <FF8C54C9B0FBD6429771E0886CDF47A9034963@rtdexchange2.rtdext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org] 
> Sent: Wednesday, August 24, 2005 5:08 PM
> To: Robert W. Boone
> Cc: LM Sensors
> Subject: Re: [lm-sensors] "Debug: sleeping function called 
> from invalid context" message from i2c_clients_command()
> 
> 
> Hi Robert,
> 
> > I'm running a 2.6.12.2 kernel built directly from kernel.org
> > sources.  After invoking xawtv on my frame grabber card, any
> > time I change the video input the following messages show up
> > in the system log:
> 
> Before anything else, I'd suggest that you try 2.6.12.5 and 
> 2.6.13-rc7,
> in case the problem has already been fixed. The saa7134 
> driver has many
> many fixes in 2.6.13-rc7.
> 
> > 	Debug: sleeping function called from invalid context at
> > include/asm/semaphore.h:102
> > 	in_atomic():0, irqs_disabled():1
> > 	  [<cf843cc2>] i2c_clients_command+0x22/0xf0 [i2c_core]
> > 	  [<cf97e824>] video_do_ioctl+0xd94/0x1210 [saa7134]
> > 	  [<c031b914>] sock_def_readable+0x34/0x70
> > 	  [<c038eeea>] unix_stream_sendmsg+0x2ca/0x3b0
> > 	  [<c03970d2>] schedule_timeout+0x92/0x100
> > 	  [<cf88732b>] video_usercopy+0x6b/0x180 [videodev]
> > 	  [<c0199f6a>] do_select+0x3da/0x4b0
> > 	  [<c017f992>] do_sync_write+0xb2/0x100
> > 	  [<cf97ecb9>] video_ioctl+0x19/0x20 [saa7134]
> > 	  [<cf97da90>] video_do_ioctl+0x0/0x1210 [saa7134]
> > 	  [<cf97eca0>] video_ioctl+0x0/0x20 [saa7134]
> > 	  [<c0199069>] do_ioctl+0x69/0x70
> > 	  [<c01991ac>] vfs_ioctl+0x5c/0x1f0
> > 	  [<c01993b2>] sys_ioctl+0x72/0x90
> > 	  [<c0103b95>] syscall_call+0x7/0xb
> > 
> > Any help would be greatly appreciated.  If additional info
> > is needed, please do not hesitate to ask.
> 
> Not related to the i2c subsystem per se as far as I can see, 
> so there's
> not much we can do for you I fear.
> 
> > This is also being posted to the video4linux mailing list.
> 
> I'd believe they are more likely to have an idea about what's 
> going on.
> 
> -- 
> Jean Delvare





Jean:

	Sorry it took so long for me to get back to this ... been
busy fighting other fires.

	I've tried the 2.6.12.5 and 2.6.13 kernels and they both
exhibit the same problem.

	Thanks for the suggestions and for taking a look at the
problem.


Sincerely,


Robert W. Boone
Software Engineer II
RTD Embedded Technologies
103 Innovation Boulevard
State College, PA  16803
