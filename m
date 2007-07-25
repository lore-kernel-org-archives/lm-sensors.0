From: cilly <cilly@cilly.mine.nu>
Date: Wed, 25 Jul 2007 00:24:03 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <A2B60EE6-455A-4E02-BAE3-EBB7B0E6AC4A@cilly.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jul 25, 2007, at 2:07 AM, Juerg Haefliger wrote:

Hi Juerg,

> Who knows? There are other things the VIA engineers did that I don't
> understand. For example not implementing fan control on the M10000.

Well, according to specs on via site, my board should have fancontrol:

http://www.via.com.tw/en/products/mainboards/motherboards.jsp? 
motherboard_idE1

however:

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

but, I think I do not care, since I don't have any fans connected. I  
now it pwmconfig did work while I had everything as a module, now I  
compiled the vt1211 stuff into the kernel. Probably, pwmconfig is  
using modprobe...

> Uh-huh, very nice case!

yes, but I had to dig many holes into it, since the heat didn't leave  
the case.

> I'm using the default:
> compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
>
> Even though it's for an Ezra and I don't really trust the readings. I
> couldn't get an answer from VIA whether this is the correct
> computation for the Nehemiah CPU or not.
>
> A while ago, somebody wrote to the list about not being happy with the
> default and investigating further. Maybe you can search the archives
> and contact that person to figure out what he found out. Or there's
> always the possibility of attaching a thermal probe to CPU case and
> use the thermal resistance values in the Nehemiah datasheet to
> correlate driver and voltmeter readings.

With that line the temperature readings are too low, at least for my  
board.

I use:

compute temp1 (@ - 65) / 0.9686, (@ * 0.9686) + 65

which I used for PD 6000 (Samuel) and now for my new PE 10000  
(Nehemiah), both have the same bridge.

Regards,

c.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
