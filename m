From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Problem with i2c-amd756.o
Message-Id: <3EE53484.7080003@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0306051208440.4183-100000@lancelot.cems.umn.edu>
In-Reply-To: <Pine.LNX.4.33.0306051208440.4183-100000@lancelot.cems.umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

something is accessing the bus every few seconds.
If things seem to be working anyway you can comment the messages out in the driver.

Shriram Ramanathan wrote:
> Hi,
> 
> I have a dual processor (AMD 1.8 GHz) machine with Redhat Linux installed.
> I have this awfully irritating message cropping up on my terminal every
> few seconds.
> 
> "i2c-amd756.o: Busy wait timeout! (0d00)
> i2c-amd756.o: Sending abort."
> 
> I dont know how to fix this (I havent tried rebooting the m/c as yet)
> Could you tell  me what is going wrong ?
> 
> Thanks.
> 
> Regards,
> shriram
> 
> PS : I am a newbie to sysadmin and so might need some
> elaboration on this....i.e. if it is not too much of a trouble for you.
> 
> 
