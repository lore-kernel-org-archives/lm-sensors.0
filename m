From: Thomas Backlund <tmb@mandriva.org>
Date: Thu, 01 Oct 2009 16:21:09 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: add support for Asus P7P55D
Message-Id: <4AC4D6F5.6080005@mandriva.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <51f3faa70909232018v7e621190m84deb648b08d2135@mail.gmail.com> <20090928131700.GA19243@nb-core2.darkstar.lan> <51f3faa70909281920x2782d8dfm1835ab24779abfa3@mail.gmail.com> <51f3faa70909282134o1d60efekeded09f09b192df6@mail.gmail.com> <68676e00909290707u70d192f2j2f2d4dd07bd07234@mail.gmail.com> <51f3faa70909290740l4f4df186w114bf48e1db3a948@mail.gmail.com> <4AC21E7B.70000@mandriva.org> <51f3faa70909301638s4eff14edg46420e2e8877fd15@mail.gmail.com> <20091001085002.1dbc7eee@hyperion.delvare> <51f3faa70910010740s2a412d07qf29f56ad8a3c59eb@mail.gmail.com> <20091001144914.GA18675@nb-core2.darkstar.lan>
In-Reply-To: <20091001144914.GA18675@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>

Luca Tettamanti wrote:
> On Thu, Oct 01, 2009 at 08:40:59AM -0600, Robert Hancock wrote:
>> On Thu, Oct 1, 2009 at 12:50 AM, Jean Delvare <khali@linux-fr.org> wrote:
>>> On Wed, 30 Sep 2009 17:38:21 -0600, Robert Hancock wrote:
>>>> On Tue, Sep 29, 2009 at 8:49 AM, Thomas Backlund <tmb@mandriva.org> wrote:
>>>>> Try this one:
>>>>> http://marc.info/?l=linux-kernel&m5421276407283&w=2
>>>> With that patch it's lasted almost a day with no timeouts, previously
>>>> I was getting about one every hour. Has that patch been submitted?
>>> Do you mean you're still getting timeouts but they are less frequent,
>>> or you did not get any timeout at all so far?
>> So far no timeout at all (after about 36 hours).
> 
> Good. I have a new patch for you then :P
> 
> This version checks whether the EC is already enabled or not before touching it
> and also restore the state when the module is unloaded.
> You should check that the driver keeps working when is unloaded and reloaded.
> 

I tried your latest patch on a P7P55D Deluxe and get this:
> [   10.419119] ACPI Error: Field [PR11] at 64 exceeds Buffer [NULL] size 32 (bits) (20090903/dsopcode-596)
> [   10.419125] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.ASOC.GITM] (Node ffff88023f8147a0), AE_AML_BUFFER_LIMIT
> [   10.419157] ATK0110 ATK0110:00: GITM[0x11060004] ACPI exception: AE_AML_BUFFER_LIMIT
> [   10.419158] ATK0110 ATK0110:00: Unable to query EC status
> [   10.419161] ATK0110: probe of ATK0110:00 failed with error -5

Your earlier patch did only report this:
[   10.632195] ATK0110 ATK0110:00: EC enabled


--
Thomas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
