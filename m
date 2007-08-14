From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 14 Aug 2007 20:52:32 +0000
Subject: Re: [lm-sensors] prog/dump/util.c is GPL version 2 only licensed
Message-Id: <46C21610.9080108@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C0C758.5060509@hhs.nl>
In-Reply-To: <46C0C758.5060509@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 13 Aug 2007 23:04:24 +0200, Hans de Goede wrote:
>> Fedora is doing a license audit of ALL Fedora packages, to determine the exact 
>> license (version) of each package because of the coming of a number of GPL 
>> version 3 packages to the distro.
>>
>> I've been reviewing lm_sensors (amongst 150 other packages) and I've noticed 
>> that in the lib and prog dirs, there is one file which is not GPL version 2 or 
>> any later version, but just GPL version 2, I assume this is a mistake, can you 
>> please fix this?
> 
> This isn't a mistake, I did this on purpose. With all the discussions
> around the GPL v3, I realized that it wasn't safe to allow the
> distribution of my code under a license that did not yet exist. So as
> prog/dump/util.c was a new file, I decided to release it under GPL v2
> only.
> 
> Now I realize that it probably doesn't make much sense to release just
> one file with a different license, it hardly serves any practical
> purpose and can only add to confusion. If it has any legal value at
> all... So I am fine re-licensing that file if it makes you happy.
> 

Yes, please relicense it. Most people don't realize it but once libraries GPL 
v2 only code depends on become LGPL 3, then the GPL v2 only code can no longer 
be distributed (atleast not as part of a distribution containing LGPL v3 
versions of the libs the GPL v2 only code depends on).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
