From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 05 Jul 2006 17:44:53 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44ABFA95.1060109@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Sunil,
> 
>> A related question: gkrellm2 (2.2.9) refuses to see my sensors as reported
>> by abit driver, but its able to see bogus sensors reported by w83627hf if I
>> modprobe it.  sensors and ksensors, both see the values correctly.
>>
>> Why would gkrellm not see them? Is there a configuration setting that
>> gkrellm reads which works for w83627hf but not for abituguru.
> 
> gkrellm accesses /sys directly instead of using libsensors. The
> consequence of this unfortunate choice is that the results you get with
> gkrellm can differ from what all other hardware monitoring frontends
> report, and when support for new chips is added gkrellm doesn't benefit
> from the libsensors update and must implement support on its own.
> 
> So you better complain to the gkrellm folks, there's nothing we can do
> about it.
> 

Jean,

I have complained (politely) and he is willing to take a patch to use
libsensors. Writing such a patch is on my todo, just like an abituguru2
driver and ... and .... and don't forget XXXX and YYYY etc. You get he
picture, right?

Regards,

Hans

