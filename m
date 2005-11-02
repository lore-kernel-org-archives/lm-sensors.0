From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 02 Nov 2005 22:52:53 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <43693686.7040500@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:

> No. What you are providing right now IS bad support. I've read the
> thread by Matthew Stamp on this list, and I know it's only the first
> one of a long series of "doesn't work for me" posts about the uGuru.
> This is the unavoidable consequence of writing drivers without any
> technical documentation.
> 

That is not really fair, Matthew's problem has been fixed by a simple 
module option, one which was already present in the module before he 
posted about his problem because I already knew the detection code was 
weak. I'm currently looking into this problem with Matthew and my goal 
is to fix the driver so that Matthew will no longer need the option.

Also this driver is less then a month old and his seen very little 
testing, if when it has matured it still generates lots of problems I 
might come around to your point of view, but untill then I'll do my very 
best to make the abituguru driver as good as possible.

<snip> lots of other discussion about if its a good idea to try to 
support undocumented IC's or not </snip>

I'm happy that in the end we both have the same goals. Lets just say we 
agree that we disagree on how to get there.


Regards,

Hans
