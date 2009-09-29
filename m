From: Robert Hancock <hancockrwd@gmail.com>
Date: Tue, 29 Sep 2009 02:20:18 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <51f3faa70909281920x2782d8dfm1835ab24779abfa3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090923191240.GA15198@dreamland.darkstar.lan>
	 <51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com>
	 <20090928131700.GA19243@nb-core2.darkstar.lan>
In-Reply-To: <20090928131700.GA19243@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 28, 2009 at 7:17 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Wed, Sep 23, 2009 at 09:18:45PM -0600, Robert Hancock wrote:
>> On Wed, Sep 23, 2009 at 1:12 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> > With P7P55D (and newer) boards Asus extended the output buffer (ASBF)
>> > making the driver unable to read the data from the sensors.
>> > Change the driver to use dynamic buffers (allocated by ACPI core); the
>> > return value is cached, so the number of memory allocations is very low.
>> >
>> > Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
>> > Tested-by: Robert Hancock <hancockrwd@gmail.com>
>>
>> I just noticed a problem (either with this patch or some other issue
>> with the driver on this board): The readings don't seem to be
>> updating, I get the same values all the time. (Just now I started
>> compiling a kernel and coretemp reports temperatures in the 60 degree
>> plus range but atk0110-acpi still reports 35 degrees as it did
>> before..)
>
> Hi Robert,
> I have a new patch for you :)
> It contains the previous changes to handle the bigger ASBF buffer plus a new
> method to enable the EC as suggested by Asus. Be sure to compile with
> HWMON_DEBUG_CHIP enabled.

Excellent.. seems to work now and give actually updating sensor readings :-)

By the way, if you have any firmware-type contacts at Asus that know
about these boards, you might want to point them at this problem, the
BIOS DMAR tables point to invalid locations when Intel VT-d is
enabled. So far haven't gotten any useful response from tech support..

http://www.gossamer-threads.com/lists/linux/kernel/1131574

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
