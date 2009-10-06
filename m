From: Robert Hancock <hancockrwd@gmail.com>
Date: Tue, 06 Oct 2009 01:44:43 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <51f3faa70910051844u5a09887cm778bfa1b44bfa23d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com>
	 <20091001085002.1dbc7eee@hyperion.delvare>
	 <51f3faa70910010740s2a412d07qf29f56ad8a3c59eb@mail.gmail.com>
	 <20091001144914.GA18675@nb-core2.darkstar.lan>
	 <4AC4D6F5.6080005@mandriva.org>
	 <68676e00910011205t506604e5y5a0a04fec0821dc0@mail.gmail.com>
	 <20091002122636.GA25505@nb-core2.darkstar.lan>
	 <4AC665E4.8060200@mandriva.org>
	 <20091005152751.GA10011@nb-core2.darkstar.lan>
	 <4ACA2C5C.6000402@mandriva.org>
In-Reply-To: <4ACA2C5C.6000402@mandriva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Backlund <tmb@mandriva.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>

On Mon, Oct 5, 2009 at 11:26 AM, Thomas Backlund <tmb@mandriva.org> wrote:
>>>>> I see. GITM probably expects the same buffer structure as SITM, though
>>>>> in older models the upper bits were never used (hence I never noticed
>>>>> the problem). Working on a patch.
>>>>
>>>> Ok, here it is:
>>>
>>> no go...
>>
>> Ok, I should have fixed the OOPS.
>>
>
> Yep.
> This one works so...
>
> Tested-by: Thomas Backlund <tmb@mandriva.org>

Works for me as well.

Tested-by: Robert Hancock <hancockrwd@gmail.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
