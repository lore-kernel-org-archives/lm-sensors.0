From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Can't load modules usng new module-init-tools-3.0-pre4
Message-Id: <200401040819.59384.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 03 January 2004 21:01, Rusty Russell wrote:
>In message <200401030945.12667.gene.heskett@verizon.net> you write:
>> It did work, till I rebooted.

This is also going to the sensors list

>Did you run/not run depmod -a?

Yup, no errors

>> [root@coyote module-init-tools-3.0-pre4]# modprobe i2c-core
>> [root@coyote module-init-tools-3.0-pre4]# lsmod
>> Module                  Size  Used by
>> tuner                  15620  0
>> tvaudio                22400  0
>> bttv                  128288  0
>> video_buf              22784  1 bttv
>> i2c_algo_bit           10120  1 bttv
>> btcx_risc               5124  1 bttv
>> i2c_core               25732  4 tuner,tvaudio,bttv,i2c_algo_bit
>> lp                     10592  0
>> [root@coyote module-init-tools-3.0-pre4]#

Now, the diff seen above was because I'd startx'd!  IOW, startx loaded 
what you see above without any help from me.

>> WTF????  I haven't rebooted, it simply started working!  Says he,
>> beating head on keyboard????  But I had started tvtime once, which
>> gave me video only.  3 hours ago, you could give modprobe the full
>> path to the module to load and it would still claim it didn't
>> exist!!!!!!!!!!!!!!!!!
>
>modprobe doesn't take a full path, but a module name (which might
> also be an alias, an install command from the config file...). 
> It's supposed to be intelligent.  insmod is dumb: it takes a full
> path, and doesn't do dependencies or config files: useful if you're
> trying to debug an exact problem, but genernally useless.

Also only usefull if your $PATH contains the new modprobe's home dir 
*before* the old ones home dir.  And if your rc.sysconfig isn't 
hardcoded to use the old one, which mine was.  'tain't now, but while 
the errors it reported have gone away, it isn't working either.  
Nothing in dmesg to indicate it was even called.  Very frustrating.

>> Ok, I've now loaded them all,
Here is a present lsmod output:
--------------------
[root@coyote kernel]# lsmod
Module                  Size  Used by
snd_rtctimer            3340  0
snd_seq_midi            9632  0
snd_seq_oss            36352  0
snd_pcm_oss            61316  0
snd_mixer_oss          21120  1 snd_pcm_oss
snd_virmidi             4096  0
snd_seq_virmidi         7808  1 snd_virmidi
snd_seq_midi_event      8192  3 
snd_seq_midi,snd_seq_oss,snd_seq_virmidi
snd_seq                61936  6 
snd_seq_midi,snd_seq_oss,snd_seq_virmidi,snd_seq_midi_event
snd_via82xx            21696  0
snd_pcm               108544  2 snd_pcm_oss,snd_via82xx
snd_timer              27648  3 snd_rtctimer,snd_seq,snd_pcm
snd_ac97_codec         55428  1 snd_via82xx
snd_page_alloc         12676  2 snd_via82xx,snd_pcm
snd_mpu401_uart         8192  1 snd_via82xx
snd_rawmidi            26880  3 
snd_seq_midi,snd_seq_virmidi,snd_mpu401_uart
snd_seq_device          8580  4 
snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi
snd                    54532  15 
snd_seq_midi,snd_seq_oss,snd_pcm_oss,snd_mixer_oss,snd_virmidi,snd_seq_virmidi,snd_seq_midi_event,snd_seq,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
tuner                  15620  0
tvaudio                22400  0
bttv                  128288  0
video_buf              22784  1 bttv
i2c_algo_bit           10120  1 bttv
btcx_risc               5124  1 bttv
i2c_core               25732  4 tuner,tvaudio,bttv,i2c_algo_bit
lp                     10592  0
-----------------
 but sensors still reports:

>> [root@coyote module-init-tools-3.0-pre4]# sensors
>> Can't access /proc file
>> /proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
>> Make sure you have done 'modprobe i2c-proc'!

Which is not now part of the i2c stuff in the kernel srcs.

So obviously its not looking in the right place, the right place being 
/sys/bus/i2c

>If sensors needs to be updated for 2.6, that should be in
>Documentation/Changes.  But it's not.  Please contact author, to see
>if they've really abandoned /proc.

Apparently not Rusty, (my orig message also went there, and the one 
reply I got seemed to ignore the /proc to /sys switch issue) but the 
claim is that as of lm_sensors-2.8.2, it works but only if you only 
install the userland stuff, not the whole thing.  I did as instructed 
in the README, "make user", "make user_install" but when I checked, 
it hadn't updated the lm_sensors in /etc/init.d, nor the sensors and 
sensors-detect and libsensors were all older stuff.  Hand copying 
them in over the older ones got me a bit closer, but in the end its 
still looking in /proc/bus/i2c for its data.  And that doesn't exist 
anymore. :\

FWIW, kmix will not init now, even with everything loaded, it just 
hangs.  And to add insult, there is a big blurb in the README that 
says you cannot run anything related to bttv with sensors.  Since 
thats 80% of the tv cards on the planet, and apparently just doing a 
startx brings all the video portions of it in, this so-called bttv or 
me exclusivity has got to be fixed, along with working when not 
modularized.

They claim that the cvs version does run even better when it runs, but 
it may cause bleeding too.  I suppose I'll have to break out my old 
rusty cvs and try it.  IMO, if its working, then a snapshot of it 
labeled 3.0beta is in order.

We also need, and I haven't found, good docs on howto write to the new 
modprobe.conf file.  This sucks dead toads thru soda straws IMO.  Or 
did I miss something in the module-init-utils-3.0pre4 src tree?

For now, I'm going to put it all back in the kernel, where everything 
but sensors "just works".

-- 
Cheers Rusty, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
