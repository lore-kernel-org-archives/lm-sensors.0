From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 22 Oct 2008 07:34:41 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg move some io access from the
Message-Id: <48FED791.2090802@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FDE62B.7020607@redhat.com>
In-Reply-To: <48FDE62B.7020607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Tue, 21 Oct 2008 20:14:17 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Please use dev_info() instead.
>> Done.
> 
> I really meant dev_warn(), sorry. I'll fix that myself.
> 

I _really_ should have figured that out myself.

<snip>

>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> --- f71882fg.c.f71862fg	2008-10-21 15:34:41.000000000 +0200
>> +++ f71882fg.c	2008-10-21 19:56:11.000000000 +0200
> 
> You don't like paths, hmm? ;)
> 
> Really, you should use quilt. That would solve this problem.

I hear lots of good things about quilt I'll try to use it next time around.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
