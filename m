From: Robert Hancock <hancockrwd@gmail.com>
Date: Sun, 20 Sep 2009 22:53:53 +0000
Subject: Re: [lm-sensors] coretemp support for Core i5 CPU
Message-Id: <51f3faa70909201553y75cb9f8q8ab34e9659fe479b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AB5DE1F.1020004@gmail.com>
	 <20090920211620.1c18d7fb@hyperion.delvare>
In-Reply-To: <20090920211620.1c18d7fb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Sun, Sep 20, 2009 at 1:16 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Robert,
>
> On Sun, 20 Sep 2009 01:47:43 -0600, Robert Hancock wrote:
>> Trying to load the coretemp driver for CPU temperature monitoring on a
>> Core i5 750 CPU gives:
>>
>> coretemp: Unknown CPU model 1e
>> coretemp: Unknown CPU model 1e
>> coretemp: Unknown CPU model 1e
>> coretemp: Unknown CPU model 1e
>>
>> Looks like this model needs to be added to the list in
>> drivers/hwmon/coretemp.c. Though this doesn't really seem like a very
>> good approach as we'll keep having to update this driver whenever a new
>> CPU model gets released. Intel has a CPUID field that indicates if the
>> thermal sensor is supported: "The processor supports a digital thermal
>> sensor if CPUID.06H.EAX[0] = 1." We should likely be using this instead
>> of hard-coded CPU model checks..
>
> Supporting the digital thermal sensor is one thing, but it is totally
> insufficient. If you look at the coretemp driver, you'll see we need to
> figure out a number of calibration values which are model-dependent. So
> we will need to check this part before adding support for new CPU
> models anyway.

Well, I see there is the TCC activation temperature which the reading
is relative to, which is detected on the mobile CPUs via an MSR read,
so it would only be a problem if they changed this temperature on
other CPUs..

It might make sense to warn "unknown CPU model, temperature reading
may be suspect" or something, but I should think it should still load
as the temperature reading is likely still correct.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
