From: tparcina@lama.hr (=?iso-8859-2?Q?Tomislav_Par=E8ina?=)
Date: Mon, 21 Aug 2006 08:21:28 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <79337FA3BA80774F9FE87BF809C9F356430A87@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede [mailto:j.w.r.degoede at hhs.nl] 
> Sent: 21. kolovoz 2006 8:22
> To: Tomislav Par?ina
> Cc: lm-sensors at lm-sensors.org
> Subject: Re: [lm-sensors] Call for 2.10.1
> 
> I missed the original post (to many mails, so trigger happy delete
> finger) as already described I'm working on an abituguru2 
> driver for a new much different version of the abituguru2. I 
> would like to merge the userspace support for this (and only 
> the userspace) before 2.10.1 if there is some time for this, 
> so 1 questions:
> 1) is it ok to merge userspace support for a not yet released kernel
>    driver?
> 2) how much time do I have before 2.10.1 ?

Hi Hans!

Here is original post.

Bye.

****

Hi all,

I think it's about time to release lm_sensors 2.10.1. The list of
changes since our last release, 2.10.0, is getting quite long. The most
important changes are probably:
* Many fixes in libsensors
* decode-dimms.pl completely reworked
* Many cleanups and improvements to sensors-detect
And of course support added for many new chips.

As far as I am concerned, the only thing I'd like to merge before this
upcoming release is the set of changes needed to make the Linux 2.6
vt1211 driver work properly. If you think of other things that need to
be done before the release, please speak up.

Proposed schedule:
September 5th: SVN freeze
September 6th-20th: Testing
September 21st: Release

Phil, will you continue taking care of the release? Our
doc/developers/checklist probably needs some adjustements to reflect
our move to SVN, amongst others.

Thanks,
-- 
Jean Delvare

