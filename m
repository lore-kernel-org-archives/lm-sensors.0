From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Wed, 11 Sep 2013 12:20:34 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Better documentation for sensors_init() and sensors_get_adapter
Message-Id: <52306012.3060505@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130621111158.30360f3c@endymion.delvare>
In-Reply-To: <20130621111158.30360f3c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/09/13 12:57, Jean Delvare wrote:
> On Fri, 21 Jun 2013 11:11:58 +0200, Jean Delvare wrote:
>> Extend the documentation of sensors_init() and
>> sensors_get_adapter_name(). Paul Crawford asked questions about these
>> as he found the original documentation unclear. I'm including my
>> answers to his questions here, reformatted, so that other developers
>> can benefit from them too.
>> ---
>> Paul, is this OK with you?
>>
>>   lib/init.c       |    2 ++
>>   lib/libsensors.3 |   27 +++++++++++++++++++++------
>>   2 files changed, 23 insertions(+), 6 deletions(-)
>> (...)
>
> No reply after over 2 months... I decided to commit this patch.

My apologies Jean, I had not realised you were waiting for a reply!

Regards,
Paul
-- 
Dr. Paul S. Crawford
Satellite Station
Dundee University
Small's Wynd, Dundee,
DD1 4HN, U.K.
Tel: +44 (0)1382 38 4687
Email: psc@sat.dundee.ac.uk
The University of Dundee is a Scottish Registered Charity, No. SC015096

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
