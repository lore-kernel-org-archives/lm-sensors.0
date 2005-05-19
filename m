From: Joseph@mcquade.info (Joseph McQuade)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: ECS-k7s5a sensors
Message-Id: <200306172207.19882.Joseph@mcquade.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306161757.32702.Joseph@McQuade.info>
In-Reply-To: <200306161757.32702.Joseph@McQuade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After running the sensors-detect it said no sensors found. I am still new to 
working in config files on linux. I have been using Linux on and off for abut 
2 yrs. While self teaching myself Most of what I know... What would be a good 
reference manual to have For drake 9.0, That may help me out even more. For 
understanding different config files and what switch's to use when your in 
there.. That has been my biggest problem, with alot of it. I am a Microsoft 
hater. Thats why i'm hell bound on learning linux. My system is now 100% 
linux and will stay that way lol...


Thanks for your help

Joseph 




On Tuesday 17 June 2003 03:16 am, Jean Delvare wrote:
> > hi there... My name is Joseph. Im running a k7s5a motherboard. When I
> > try and use the lm-sensors progam it says I have no sensors. I know
> > the motherboard does, by useing MBM5 on Windows. I was wondering where
> > I can find a update So I can use the same senors under Gkrellm. If
> > there out there.. Thanks for the help in advance.
>
> Hi Joseph.
>
> You should run 'sensors-detect' as root. It will detect the sensors on
> your motherboard and tell you what changes are needed to your system
> config files in order to have them working (part of this will even be
> automated if your distribution is compliant).
>
> Let us know how it goes.

