From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 24 Oct 2007 17:09:27 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471F7C47.4000704@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 22 Oct 2007 21:27:29 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Mon, 22 Oct 2007 15:15:51 +0200, Hans de Goede wrote:
>>>> Well with mine one can do:
>>>> #if (SENSORS_API_VERSION / 100) = 4
>>>>
>>>> But I'm fine with either.
>>> Ah right, I tend to forget that >> is nothing more than a division ;)
>>> But... still, I think I'd feel more confident if we used hexadecimal.
>> Ok, changed to hexadecimal
> 
> OK, thanks. Additionally, don't you think you should document it in
> libsensors.3? I guess that this is what application authors are
> reading, rather than sensors.h itself.
> 

I understand your pov, but I would rather not, it is better to have no 
documentation then to have incomplete / out of date documentation IMHO. I think 
it is best not to document this unless we also plan on keeping an complete list 
of which API additions where done between bumps of the value.

Also I don't know if I'm a typical userspace programmer, but I often look in 
header files, esp. when looking for things like library version defines.

Last but not least a programmer will already need to look at the sensors.h file 
for the meaning / possible values of sensors_subfeature_type for example.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
