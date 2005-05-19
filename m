From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: voodoo3 3000, Fedora 2, lm_sensors, and tv-out
Message-Id: <4159F327.8080607@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


It sounds like you are very close.  For everything to look/work right, 
make sure you get your resolution set first, then configure the bt869. 
Make sure you set its resolution and other parameters (PAL vs. NTSC) to 
match what ever modeline you've got going in X.  The BT869 is a pretty 
dumb chip.  It receives a raw stream of video data but doesn't 
nessesarily know what the resolution is.  You have to tell it.

If you've got black-and-white on the TV, then you probably just need to 
set the settings while running in X to get things synced up.  What I 
mean by this is that you need to do things like 'echo "640 480" > 
/proc/sys/dev/sensors/bt869*/res' (or a path similar to this... this is 
off the top of my head).

I hope this helps.


Phil

Marion Bates wrote:
> Hi,
> 
> First of all, thank you for doing...whatever it is you did that got me 
> this far.  :)  I've got a dual-boot cheapo PC full of mpegs and AVIs, 
> and have been playing them back on my television using Win98 (yecchh) 
> because although I can find my way around Linux pretty well, I was quite 
> daunted by the prospect of kernel-hacking to get mplayer/X11 working 
> under RedHat 9. Last night I upgraded to Fedora Core 2, which uses the 
> 2.6 kernel, and through the use of your documentation at 
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/bt869 and the 
> howto written by Tomi Ollila, I was able to get quite a ways. I ended up 
> with a resolution that requires me to move the cursor to scroll around 
> the rest of the gnome desktop, but is still readable -- however, it's in 
> black and white. I know (?) that this isn't a TV or cabling problem, 
> since color is fine under Windows...I tried another cable and another TV 
> just in case, but no dice. I tried various modelines and restarts and 
> whatnot, but am still stuck.
> 
> I've been mining Google for more info, but I think I am in over my head 
> at this point. I simply don't know enough about the kernel, loadable 
> modules, etc. If it tells you anything, when I ran the sensors-detect 
> program, all seemed well and it told me what to paste in various config 
> files, and in the end when I ran lsmod, I saw output very similar to 
> that of Ollila's howto...however, I saw nothing related to bt869. I 
> don't know if this means it's missing, or if I shouldn't see it because 
> it's now part of the kernel, or what...I mean, would this be working at 
> ALL without it?
> 
> Sorry to bug you, and I will keep looking for information, but if you 
> have any newbie-oriented suggestions, I'd be very grateful.
> 
> Thanks again,
> 
> -- Marion
> 
