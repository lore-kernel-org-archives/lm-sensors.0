From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 07 Oct 2011 11:11:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <4E8EDE45.5030507@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org> <20111005193359.GB26664@kroah.com> <20111006041011.GB2125@ubuntu.ubuntu-domain> <20111006182500.GA18607@kroah.com> <20111006190752.GA28455@ericsson.com> <20111007064240.GA2944@ubuntu.ubuntu-domain> <20111007065237.GA27805@kroah.com> <20111007095621.GB2944@ubuntu.ubuntu-domain>
In-Reply-To: <20111007095621.GB2944@ubuntu.ubuntu-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Chauhan <hschauhan@nulltrace.org>
Cc: Greg KH <greg@kroah.com>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>

On 10/07/11 10:56, Himanshu Chauhan wrote:
> On Thu, Oct 06, 2011 at 11:52:37PM -0700, Greg KH wrote:
>> On Fri, Oct 07, 2011 at 12:12:40PM +0530, Himanshu Chauhan wrote:
>>> On Thu, Oct 06, 2011 at 12:07:52PM -0700, Guenter Roeck wrote:
>>>> And why, and what for.
>>>
>>> The initial idea of posting to kernelnewbies was to get a hint on how
>>> the patch would be taken as. I wanted to know if developers will like
>>> the idea behind it or not. I guess, Guenter is not convinced with
>>> any of my reasoning. I am willing to clean it up further only if
>>> I get a positive hint. But it doesn't seem to be going anywhere.
>>>
>>> Thanks Guenter, Alan, and Greg for taking your time and reviewing it.
>>>
>>> Greg: To answer your last question, if this was taken positively, I
>>> was thinking of having functionality similar to misc device registration.
>>
>> But why?  What is that device node going to be used for?  Who would be
>> using it in userspace and where would it be tied into in the kernel?
>>
> The device node, as I said earlier, can be used for doing IOCTLS. In user space,
> applications that manage and monitor system environment will need to use this
> interface for querying the sensor's location, for example. In side the kernel,
> the driver that is driving the particular hardware sensor can register a char
> interface for all this and then register with hwmon with the same major/minor
> for usual sysfs export of data.
If location is useful info why not propose a sysfs interface for it?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
