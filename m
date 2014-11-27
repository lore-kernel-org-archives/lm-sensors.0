From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Nov 2014 17:32:42 +0000
Subject: Re: [lm-sensors] libsensors license question - GPL or LGPL ?
Message-Id: <5477603A.70105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <54762A5A.7030601@roeck-us.net>
In-Reply-To: <54762A5A.7030601@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 11/27/2014 02:24 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Wed, 26 Nov 2014 11:30:34 -0800, Guenter Roeck wrote:
>> libsensors is supposed to be licensed under LGPL as far as I can see
>> and recall. However, doc/developers/applications reads:
>>
>>      Note that libsensors falls under the GPL, not the LGPL.
>>      In more human language, that means it is FORBIDDEN to link any application
>>      to the library, even to the shared version, if the application itself
>>      does not fall under the GPL. This may or may not be changed in the future.
>>      Contact us if you wish to discuss your application.
>>
>> Is that an oversight from earlier versions or on purpose ?
>> The source refers to LGPL as far as I can see, and the comment in
>> lib/libsensors.3 states that it is distributed under LGPL.
>
> This is an horrible oversight. libsensors was originally under GPL,
> but I changed the license to LGPL with the approval of all authors and
> copyright holders:
> http://www.lm-sensors.org/wiki/LibsensorsLicense
>
> So starting with version 3.2.0, the only license for libsensors is LGPL.
>
> I'll fix the documentation immediately, thanks for pointing out my
> mistake.
>
No problem, thanks for the clarification.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
