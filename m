From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Sat, 01 Feb 2020 00:16:47 +0000
Subject: Re: [RFC] why do sensors break CPU scaling
Message-Id: <CAKR_QVLKtkfVy5AAKj+ay0cQ2NPWrW7CPb8SGF6urD2ooM=VXQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
 <20200131223547.GA7334@amd>
In-Reply-To: <20200131223547.GA7334@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lm-sensors@vger.kernel.org

On 31/01/2020, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2019-11-20 21:42:12, Tom Psyborg wrote:
>> Hi
>>
>> Recently I've needed to set lowest CPU scaling profile, running ubuntu
>> 16.04.06 I used standard approach - echoing powersave to
>> /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
>> This did not work as the
>> /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
>> max scaling freq.
>
> Noone noticed, right?
>
> If you still believe that's problem, you may want to look at
> MAINTAINERS file, and put sensors maintainers in the Cc list.
>
> Best regards,
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>

it is definitely a problem. i've installed radeon-profile and can
monitor both CPU and GPU temps from there without CPU scaling
breakage. CCing related list
