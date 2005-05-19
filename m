From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: [Fwd: userland i2c ioctl commands..]
Message-Id: <20031108165427.GA6770@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FAACF03.3040900@edgedesign.us>
In-Reply-To: <3FAACF03.3040900@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 06, 2003 at 02:45:23PM -0800, Philip Edelbrock wrote:
> 
> I'm guessing somebody else can answer this better than I can.  Who wants 
> to take a stab?
> 
> 
> Phil
> 
> -------- Original Message --------
> From: 	- Thu Nov 6 14:43:07 2003
> X-UIDL: 	63bd79ec803c391a
> X-Mozilla-Status: 	0001
> X-Mozilla-Status2: 	00000000
> Return-Path: 	<kkyzivat@physiometrix.com>
> Received: 	from mercury.physiometrix.com (mercury.physiometrix.com 
> [66.112.162.232]) by Ren.netroedge.com (8.12.10/8.12.8) with ESMTP id 
> hA6MSoJE002924 for <phil@netroedge.com>; Thu, 6 Nov 2003 14:28:50 -0800
> Received: 	from MA01WK-KK.physiometrix.com [192.168.168.83] by 
> mercury.physiometrix.com with XWall v3.28 ; Thu, 6 Nov 2003 17:42:14 -0500
> Message-ID: 	<3FAACE45.3010200@physiometrix.com>
> Date: 	Thu, 06 Nov 2003 17:42:13 -0500
> From: 	Keith Kyzivat <kkyzivat@physiometrix.com>
> User-Agent: 	Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) 
> Gecko/20030924 Thunderbird/0.3
> X-Accept-Language: 	en-us, en
> MIME-Version: 	1.0
> To: 	phil@netroedge.com
> Subject: 	userland i2c ioctl commands..
> Content-Type: 	text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 	7bit
> X-Quarentine-Loop: 	Processed
> X-Spambayes-Classification: 	ham; 0.01
> 
> 
> 
> Hello Phil,
> 
> I'm trying to track down why i2c ioctl command defines and other 
> userland useful bits were left out of i2c-dev.h in the kernel includes. 

Do not use kernel headers in your userspace programs.  If you need them,
then duplicate the file in your own program like lmsensors does.

See the many discussions about this on the linux-kernel mailing list as
to why this is the current way of doing things.

thanks,

greg k-h
