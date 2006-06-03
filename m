From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 03 Jun 2006 07:12:52 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <44813674.50505@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
>>> I don't know of any better ways to automatically identify mainboards.
>>> However, I've been mulling over an idea to make manual configuration
>>> easier.  Rather than distribute a single giant sensors.conf.eg as we
>>> do now, we could distribute a tree of conf files, one per board:
>>>
>>> /etc/sensors/
>>> /etc/sensors/asus/
>>> /etc/sensors/asus/p4s333.conf
>>> /etc/sensors/asus/p4c800-e-deluxe.conf
>> I personally think this is a good idea, but how big will this become? 
>> Any idea how many motherboards there are out there? lots but how much?
> 
> The Motherboard Monitor project had around 1100 known motherboards when
> it stopped 2 years ago. So depending on how successful we get, the
> number of configuration files could range from a few hundreds to 2000
> or so.
> 

Say worst case scenario is 2000 files each taking 4kb that sums up to
8Mb diskspace, sounds acceptable to me, what do others think?

Regards,

Hans

