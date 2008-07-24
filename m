From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 24 Jul 2008 12:32:36 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <48887664.70209@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com> <20080723191918.GC26938@trinity.fluff.org>
In-Reply-To: <20080723191918.GC26938@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br, Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Ben Nizette <bn@niasdigital.com>

Ben Dooks wrote:
> On Wed, Jul 23, 2008 at 06:00:29PM +0100, Jonathan Cameron wrote:
>> Dear All,
>>
>> The need for an industrialio subsystem was discussed in
>> http://lkml.org/lkml/2008/5/20/135
> 
> The name is really bad, this sounds like something for doing large
> scale industrial process control.
To a certain extent I agree, it's a pretty hideous name and I'm happy to change
it if someone can come up with a better one whilst maintaining the flexibility
to handle devices that do a range of different sensing and output tasks.
 
>> Firstly thanks to all the people who have contributed to the discussion
>> of this in the past.
>>
>> In brief the intention is provide a kernel subsystem directed towards the
>> handling on sensors (and later related output devices) such as ADC's,
>> accelerometers and many others.
> 
> We've already got an perfectly good hwmon framework, do we really need
> to do this again?
On this, see the original discussion (where using that was one of the options)
discussed.  Basically it comes down to a different set of requirements with
the ability to handle events from the device, ring buffering and higher (non
cached) update rates.  Whilst we could have bludgeoned the functionality into
that framework, it was decided that it was better to start afresh. 

Thanks,

--
Jonathan Cameron
 




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
