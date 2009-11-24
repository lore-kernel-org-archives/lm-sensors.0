From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 24 Nov 2009 13:48:03 +0000
Subject: Re: [lm-sensors] atk0110/BIOS discrepancies
Message-Id: <68676e00911240548r68421617k835eb163f70a9b00@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <951278.95878.qm@web86503.mail.ird.yahoo.com>
In-Reply-To: <951278.95878.qm@web86503.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 23, 2009 at 7:28 PM, false <spmurphy@talk21.com> wrote:
>> It seems likely. Note that the driver retrieves the label strings
>> directly from the system firmware (ACPI), it does not make them up;
>> those labels are used by Asus windows utility so I'd trust them.
>> Can you send me a dump of your DSDT table
>> (/sys/firmware/acpi/tables/DSDT)?
>
> Attached is a gz of 3 files from that directory.
[...]
> I wasn't sure whether to reply to you directly or to the sensor list,
> sorry if I chose incorrectly.

Both, so that the reply is archived and others may join the discussion.

The dump puzzles me... I understand that this is a very new motherboard, right?
There are two distinct interfaces for accessing the sensors (I call
them "old" and "new"); for period of time both interfaces were present
in the DSDT but the new one was only a stub (non functional), so -
when both interfaces are present - the driver prefers the "old" one.
The old interface eventually disappeared in newer boards... but
suddenly reappeared in your board :S
As you've noticed there's a discrepancy between the two interfaces;
for example "POWER" (sensor - old if) and "MB" (bios - new if) are the
same physical sensor.
The interfaces were reverse engineered so I'm probably missing
something (a version field, a feature bitmap, ...) for better
selecting the interface... will look into this.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
