From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: lm_sensors and thinkpad
Message-Id: <3D38AD3F.400@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D38A745.6A1F696C@bellsouth.net>
In-Reply-To: <3D38A745.6A1F696C@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here's the latest.
The issue is not resolved. We stopped getting help from IBM
several months ago.
The kernel patches (and kernels like Red Hat that have had sensors
included for quite a while now) only contain individual modules.
They don't 'sense' any particular model of board - they look for
a device they support, and either do nothing or exit if they
don't find it.

The tool that's been the problem for IBM users is sensors-detect,
our hardware detection script. It is a userspace tool and is not
part of the kernel patches.

Unless a kernel user (whether 2.5, redhat, whatever) starts
modprobing sensors modules he can't get hurt.
We haven't heard any complaints from IBM users in quite a while -
and as I said Red Hat has been shipping our package for over a year, IIRC.

Sorry you toasted your thinkpad. Believe me if we had the info
from IBM we needed we would try to fix it.

mds



Albert Cranford wrote:
> I understand and fully appreciate your comments.
> I'm sure that this is not resolved in our current 2.6.3
> version that I'm currently integrating into linux-2.5.26.
> 
> Today we released i2c&lm_sensors 2.6.4 with new IBM drivers
> but this is for PPC and considered Beta testing at the
> moment.
> 
> I will make a change in the Config.in to warn 600x laptop
> users to stay away.
> 
> Thanks alot,
> Albert
> 
> Jerry Cooperstein wrote:
> 
>>Hi:
>>
>>Having fried one motherboard on my 600x Thinkpad by use of
>>sensor-detect (I'm not blaming anyone but myself for reading
>>documentation a little too late--and I got it replaced on
>>warranty) I'm kind of nervous about whether the lm_sensors
>>patches going into the kernel are sensitive to the Thinkpad
>>issue, either by resolving it, or sensing it is a Thinkpad
>>and staying away from it.
>>
>>I haven't been able to find any recent documentation on this,
>>so I'd appreciate it if you could bring me up to date.  Besides
>>my own fears, I have nightmares about distributions using
>>such kernels and frying up laptops on unsuspecting users.  I
>>know from checking things out in the past the blame belonged
>>to IBM and/or Intel, not Linux, but I'm not sure everyone
>>would see it that way :<
>>
>>Thanks,
>>
>>coop
>>
>>===================================
>> Jerry Cooperstein, PhD        <coop@axian.com>
>> Senior Consultant
>>                                            ____       _
>> Axian, Inc.   <info@axian.com>              // |_  __(_) ___  _ __
>> 4800 SW Griffith Dr., Ste. 202             //| |\\/ /| |/ _ \| '_ \
>> Beaverton, OR  97005 USA             _____//_| | / / | | |_| | | | |
>> Voice: (541)758-8020                ((   //  |_|/_/\\|_|\_/|_|_| |_|
>>                                      ``-''          ``-''
>> http://www.axian.com/               Software Consulting and Training
>>===================================
> 
> 


