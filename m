From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 02 Nov 2007 07:35:53 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <472AD359.3030008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 31 Oct 2007 16:29:44 +0100, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Assuming that you definitely excluded the possibility to retrieve the
>>> DMI data from the kernel
>> Definitely is a big word, I've looked at the DMI parser currently in the 
>> kernel, tried to come up with a way to get the info there which would be more 
>> generic then just being an fschmd specific hack and couldn't. Then I slept a 
>> night on it and still couldn't come up with something clean, esp since there 
>> are many type 185 entries in the DMI table of FSC machines, of which we need 
>> only one.
> 
> Please take a look at this completely untested patch. It might need
> some cleanups before it's ready for submission, but is there any reason
> why something like this wouldn't do the job?
> 

Good work Jean, yes that should do the job, I stared myself blind at adding a 
clean way to store the data for later retrieval to the existing __init parser, 
your way indeed will work and is much more generic.

I'll compile a kernel with the dmi_scan.c and dmi.h parts patched in and then 
start working on integrating this into fschmd.c

Question, what do we do if the dmi data doesn't get found, use some defaults I 
guess?

Mark,

Please drop the hwmon-fschmd-fscher-and-newer-no-fixed-scaling.patch from your 
queue (for now, might need to introduce it later if this won't work, but thats 
unlikely).

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
