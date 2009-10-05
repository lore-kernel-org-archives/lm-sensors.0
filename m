From: Thomas Backlund <tmb@mandriva.org>
Date: Mon, 05 Oct 2009 17:26:52 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <4ACA2C5C.6000402@mandriva.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com> <4AC21E7B.70000@mandriva.org> <51f3faa70909301638s4eff14edg46420e2e8877fd15@mail.gmail.com> <20091001085002.1dbc7eee@hyperion.delvare> <51f3faa70910010740s2a412d07qf29f56ad8a3c59eb@mail.gmail.com> <20091001144914.GA18675@nb-core2.darkstar.lan> <4AC4D6F5.6080005@mandriva.org> <68676e00910011205t506604e5y5a0a04fec0821dc0@mail.gmail.com> <20091002122636.GA25505@nb-core2.darkstar.lan> <4AC665E4.8060200@mandriva.org> <20091005152751.GA10011@nb-core2.darkstar.lan>
In-Reply-To: <20091005152751.GA10011@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>

Luca Tettamanti wrote:
> On Fri, Oct 02, 2009 at 11:43:16PM +0300, Thomas Backlund wrote:
>> Luca Tettamanti wrote:
>>> On Thu, Oct 01, 2009 at 09:05:36PM +0200, Luca Tettamanti wrote:
>>>> On Thu, Oct 1, 2009 at 6:21 PM, Thomas Backlund <tmb@mandriva.org> wrote:
>>>>> I tried your latest patch on a P7P55D Deluxe and get this:
>>>>>> [   10.419119] ACPI Error: Field [PR11] at 64 exceeds Buffer [NULL] size
>>>>>> 32 (bits) (20090903/dsopcode-596)
>>>>>> [   10.419125] ACPI Error (psparse-0537): Method parse/execution failed
>>>>>> [\_SB_.PCI0.SBRG.ASOC.GITM] (Node ffff88023f8147a0), AE_AML_BUFFER_LIMIT
>>>>>> [   10.419157] ATK0110 ATK0110:00: GITM[0x11060004] ACPI exception:
>>>>>> AE_AML_BUFFER_LIMIT
>>>>>> [   10.419158] ATK0110 ATK0110:00: Unable to query EC status
>>>>>> [   10.419161] ATK0110: probe of ATK0110:00 failed with error -5
>>>> I see. GITM probably expects the same buffer structure as SITM, though
>>>> in older models the upper bits were never used (hence I never noticed
>>>> the problem). Working on a patch.
>>> Ok, here it is:
>> no go...
> 
> Ok, I should have fixed the OOPS.
> 

Yep.
This one works so...

Tested-by: Thomas Backlund <tmb@mandriva.org>


Thanks!

--
Thomas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
