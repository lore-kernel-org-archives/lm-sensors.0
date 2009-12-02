From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 02 Dec 2009 15:29:05 +0000
Subject: Re: [lm-sensors] atk0110/BIOS discrepancies
Message-Id: <68676e00912020729n114fc5d4m463f5d18bbcdeee1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <951278.95878.qm@web86503.mail.ird.yahoo.com>
In-Reply-To: <951278.95878.qm@web86503.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 24, 2009 at 2:48 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Mon, Nov 23, 2009 at 7:28 PM, false <spmurphy@talk21.com> wrote:
>>> It seems likely. Note that the driver retrieves the label strings
>>> directly from the system firmware (ACPI), it does not make them up;
>>> those labels are used by Asus windows utility so I'd trust them.
>>> Can you send me a dump of your DSDT table
>>> (/sys/firmware/acpi/tables/DSDT)?
>>
>> Attached is a gz of 3 files from that directory.
> [...]
> The dump puzzles me... I understand that this is a very new motherboard, right?
[...]
> The interfaces were reverse engineered so I'm probably missing
> something (a version field, a feature bitmap, ...) for better
> selecting the interface... will look into this.

Simon, are you able (and willing) to compile an external module?
I'd like you to try some tweaks on the driver.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
