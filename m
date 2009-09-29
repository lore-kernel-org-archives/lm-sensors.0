From: Thomas Backlund <tmb@mandriva.org>
Date: Tue, 29 Sep 2009 14:49:31 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <4AC21E7B.70000@mandriva.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090923191240.GA15198@dreamland.darkstar.lan>	 <51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com>	 <20090928131700.GA19243@nb-core2.darkstar.lan>	 <51f3faa70909281920x2782d8dfm1835ab24779abfa3@mail.gmail.com>	 <51f3faa70909282134o1d60efekeded09f09b192df6@mail.gmail.com>	 <68676e00909290707u70d192f2j2f2d4dd07bd07234@mail.gmail.com> <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com>
In-Reply-To: <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Robert Hancock skrev:
> On Tue, Sep 29, 2009 at 8:07 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>>>>> Hi Robert,
>>>>> I have a new patch for you :)
>>>>> It contains the previous changes to handle the bigger ASBF buffer plus a new
>>>>> method to enable the EC as suggested by Asus. Be sure to compile with
>>>>> HWMON_DEBUG_CHIP enabled.
>>>> Excellent.. seems to work now and give actually updating sensor readings :-)
>>> Have seen a couple of these though, looks like about once an hour:
>>>
>>> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl]
>>> (20090903/evregion-424)
>>> ACPI Error (psparse-0537): Method parse/execution failed
>>> [\_SB_.PCI0.SBRG.ASOC.GIT6] (Node ffff88013ba778c0), AE_TIME
>>> ACPI Error (psparse-0537): Method parse/execution failed
>>> [\_SB_.PCI0.SBRG.ASOC.GITM] (Node ffff88013ba6ea40), AE_TIME
>>> ATK0110 ATK0110:00: atk_read_value_new: ACPI exception: AE_TIME
>>>
>>> Maybe sometimes the embedded controller takes longer than the timeout
>>> to process, or something?
>> Is there a message like "input buffer is not empty" before that?
> 
> Nope, that's all I'm getting each time it happens. Suggestions/debug
> patches welcome..
> 

Try this one:
http://marc.info/?l=linux-kernel&m5421276407283&w=2

--
Thomas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
