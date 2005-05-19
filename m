From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: lm_sensors2/doc/chips mic74
Message-Id: <4200D25E.4030407@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <gqUFWjmh.1107340522.3506030.khali@localhost>
In-Reply-To: <gqUFWjmh.1107340522.3506030.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

well you have a point there, but that comment also applies to pcf8574, for example.
I think this driver has potential for enhancement...
for example, if it's really used as a fan controller, the files could be
renamed as pwmx and then it would work with pwmconfig, etc.
So IMHO it was worth keeping.


Jean Delvare wrote:
> Hi Mark & all,
> 
> On 2/2/2005, "author@mordac.netroedge.com"
> <author@mordac.netroedge.com> wrote:
> 
> 
>>Added Files:
>>	mic74
>>Log Message:
>>(mds) lame attempt at a doc
> 
> 
> I don't see the point in having a kernel driver for this. The driver
> currently exposes all the registers directly to procfs, with arbitrary
> names. You could achieve the same goal with a user-space program relying
> on i2c-dev. I guess that this device is meant for a very specific use
> anyway.
> 
> Thanks,
> --
> Jean Delvare
> 
> 
