From: Jaromir Capik <jcapik@redhat.com>
Date: Wed, 23 Jan 2013 12:17:34 +0000
Subject: Re: [lm-sensors] [PATCH] avoid unwanted sensors-detect termination when the /dev/port is missing
Message-Id: <1101909607.14015637.1358943454592.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1978493810.11074933.1358435561516.JavaMail.root@redhat.com>
In-Reply-To: <1978493810.11074933.1358435561516.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jaromir,
> 

Hi Jean.

> On Thu, 17 Jan 2013 10:12:41 -0500 (EST), Jaromir Capik wrote:
> > Hello guys.
> > 
> > The device file /dev/port might be missing in some cases
> > and the sensors detection is terminated when the user
> > tries to detect sensors dependent on it's existence.
> > That's not correct -> it's not a reason for terminating
> > the detection.
> 
> I admit that dying in this case is a little abrupt. That being said,
> without /dev/port, you won't be able to detect Super-I/O chips, ISA
> chips and I/O-based IPMI interfaces, which only leave you with
> I2C/SMBus-based, PCI-based and MSR-based sensors. Are there really
> systems out there without /dev/proc where any of these is present?

Yes, such systems exist. I had the pleasure to debug the issue 
directly on 2 systems where the /dev/port was missing, but
I2C bus was present. One of the systems even didn't have
any PCI bus. And I believe that we can expect more hardware
like that in the future. With ARM based boards even more oddities
can appear. The detection script needs to be as flexible
as possible to handle such situations.


> I am not particularly interested in tweaking sensors-detect for
> theoretical-only cases.
> 
> > The attached patch solves the issue, so that a warning
> > is displayed and the detection continues.
> 
> This is a first step forward, but from a user-friendliness
> perspective
> I'd say it is insufficient. If /dev/port isn't there then you
> shouldn't
> even try to open it, even less try 4 times and display 4 times the
> same
> error message. Instead, you should check for /dev/port absence
> upfront,
> let the user know about that and the limitations it implies, and then
> plain skip all detection steps which you know have no chance of
> succeeding.

Yes, that sounds better. I'm not against any future
modifications. That was just the kick off. 


> 
> > The patch can be applied on the current trunk version.
> > Please, check the patch and merge it if possible.
> 
> I have applied it [1], with an additional STDERR for the error
> message
> destination.

Oh yes, you're right. It needs to go to STDERR.


> 
> [1] http://www.lm-sensors.org/changeset/6116
> 
> --
> Jean Delvare
> 

Thank you.

Regards,
Jaromir.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
