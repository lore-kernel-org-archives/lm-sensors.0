From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: it works! now what...
Message-Id: <20020226091826.R471@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E16fbz8-0004xe-00@quince.jackman>
In-Reply-To: <E16fbz8-0004xe-00@quince.jackman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 25, 2002 at 11:25:14PM -0800, Shaun Jackman wrote:
> Alright, I have lm-sensors installed, and it works great! sensors gives me 
> the status of my box as I would expect it to. Now, what can I do with this 
> information? I was hoping you could give me some suggestions. As well, I have 
> a couple ideas and I'd like to know if they were possible.
> 
> 1. Is there an X (or preferably KDE) app that displays these values in pretty 
> ouptut?

There are some.  We don't make them, but you can find some of them at
http://www.freshmeat.net
 
> 2. Is it possible to turn on/off case fans using the SMbus (or any other 
> approach)? I would like to turn off as many fans as possible (make my box 
> quiet) and have them come on automatically if the case temperature rises 
> above a certain level.

It depends on which chips are used on your mobo and how they are
wired.  In most cases, no.  I'd read the documentation specific to
your mobo and chip used to see what is available.  Access to the
features of the chips is often available in /proc/sys/dev/sensors/


Phil

> (if it helps I have an ABIT BH6 motherboard)
> 
> Thanks!
> Shaun

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
