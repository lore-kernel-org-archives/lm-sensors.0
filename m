From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: 1250
Message-Id: <3EDE2064.5030604@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't know why you're having so much trouble...

It should be this simple:

[ppokorny@ppokorny sysctl_test]$ ls -l
total 716
-rw-r--r--    1    122846 Jun  4 09:21 i2c-2.7.0.tar.gz
-rw-rw-r--    1       543 Jun  4 09:12 lm_sensors-2.7.0-sysctl-1.patch
-rw-rw-r--    1    595379 Jun  4 09:12 lm_sensors-2.7.0.tar.gz
[sysctl_test]$ tar zxf i2c-2.7.0.tar.gz
[sysctl_test]$ cd i2c-2.7.0
[i2c-2.7.0]$ make
[i2c-2.7.0]$ ln -s kernel linux
[i2c-2.7.0]$ cd ..
[sysctl_test]$ tar zxf lm_sensors-2.7.0.tar.gz
[sysctl_test]$ cd lm_sensors-2.7.0
[lm_sensors-2.7.0]$ patch -p1 < ../lm_sensors-2.7.0-sysctl-1.patch
patching file lib/proc.c
[lm_sensors-2.7.0]$ make I2C_HEADERS=../i2c-2.7.0

Have you opened or edited the patch on a DOS system?  Perhaps the patch 
I sent you has been corrupted in transit or on it's way to your system.

As you see above, the patch applies without any complaints if you CD to 
the lm_sensors-2.7.0 directory and specify '-p1' to the patch command.

Best of luck,
:v)

David wrote:
> Got the tar file for the lm_sensors-2.7.0 and extracted it.
> Have no idea where or what makes libsensors.so so did a grep for
> parts of the patch. The closest match is the /lib/proc.c file.
> I wasn't sure how to change the header, but luckily the patch program
> asked me what I wanted to patch. Still nogo though.
> 
> I would assume that the patch looks for matching lines and patches the + line in there.
> Grep results showed that two lines it was looking for are not in any file (proc.c either)
> 
> sysctl_name[3] = the_feature->sysctl;
> and
> value *= 10.0;
> 
> The rest were all in /lib/proc.c  and one was in /lib/access.c  .  So the obvious 
> prospect from my limited knowledge was to patch /lib/proc.c  
> 
> Results:
> 
> File to patch: lib/proc.c
> Patching file lib/proc.c using Plan A...
> patch: **** malformed patch at line 4:    sysctl_name[3] = the_feature->sysctl;
> 
> Well, maybe my obvious idea didn't work. I removed those line and tried it just to see and 
> it said the same thing about the + line to add.
> 
> Well, thanks for the help. I don't want to waste your time with this, I'm sure you have better things
> to do.  I had some other guy write me wondering if anything was going on with this cause he has the 
> same problem.  If your bored then you might want to sink your teeth in further, otherwise Thanks. 
> Lm_sensors still works, just can't set anything.
> 
> Dave
> 
> On Tuesday 03 June 2003 05:40 pm, you wrote:
> 
>>The file you need to patch is part of the userspace library
>>/lib/libsensors.so
>>
>>If you had the lm_sensors.2.6.5 or lm_sensors-2.7.0 sources, you'd have
>>what you need.  _relion1x is a Penguin Computing product and happens to
>>be the directory where I had the original sources for the diff.
>>
>>Try and find the sources for the user space utilities (sensors,
>>sensors-detect, libsensors).  That's what you need to patch, not the
>>kernel...
>>
>>:v)
>>
>>David wrote:
>>
>>>Well nogo. Found the ebuild for lm_sensors-2.7.0 and installed it.
>>>Copied the patch to /usr/src/linux
>>>Tried to apply the patch
>>>
>>>patch -p1 < lm_sensors-2.7.0-sysctl-1.patch
>>>
>>>but all I got was:
>>>******************
>>>can't find file to patch at input line 4
>>>Perhaps you used the wrong -p or --strip option?
>>>The text leading up to this was:
>>>--------------------------
>>>
>>>|diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/lib/proc.c
>>>
>>>lm_sensors-2.7.0.adm1026/lib/proc.c
>>>
>>>|--- ../_relion1x/lm_sensors-2.7.0/lib/proc.c    Sun Nov 10 15:13:38 2002
>>>|+++ lm_sensors-2.7.0.adm1026/lib/proc.c Wed May 28 14:04:25 2003
>>>
>>>******************
>>>
>>>Tried to locate a 'relion' ..... but was unable to find it. So not sure
>>>what it needs to patch. Hmmm.
>>>
>>>Guess I backed up the src for nothing.
>>>
>>>Thanks again,
>>>Dave
>>>
>>>On Tuesday 03 June 2003 03:00 pm, you wrote:
>>>
>>>>The magic is in the 'sensors.strace' file that should have been created.
>>>>
>>>>
>>>>>>and post the last 20
>>>>>>or 30 lines of the sensors.strace file?.  I'm looking for pairs of
>>>>>>calls to sysctl where the first works and the second has a strange
>>>>>>(???) entry in the first argument to sysctl.
>>>>>
>>>>At this point it *does* look like the same problem I had on SuSE...
>>>>
>>>>I've attached the one-line fix...
>>>
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
