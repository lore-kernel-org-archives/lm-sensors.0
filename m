From: koko <citizenr@gmail.com>
Date: Sun, 01 Apr 2007 19:33:16 +0000
Subject: Re: [lm-sensors] repost: read the spd on A7V133 | without UTF-8
Message-Id: <3df49b7b0704011233g3e5686dvd3433b3e5ee36d1e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
	 <3df49b7b0703311629t317db7abt64e10cec7f661a04@mail.gmail.com>
	 <3df49b7b0704011025n397b164boc2d8c714c86ed9e@mail.gmail.com>
In-Reply-To: <3df49b7b0704011025n397b164boc2d8c714c86ed9e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On 4/1/07, koko <citizenr@gmail.com> wrote:
> >blabal

hmmm

> Mux 0 Asus IO mux, IO 0000e44dh, Ext 4267320

rasz@capek:~$ cat /proc/ioports|grep e4
e400-e47f : motherboard
  e400-e403 : ACPI PM1a_EVT_BLK
  e404-e405 : ACPI PM1a_CNT_BLK
  e408-e40b : ACPI PM_TMR
  e410-e415 : ACPI CPU throttle
  e420-e423 : ACPI GPE0_BLK

I decompiled ACPI DSDT from my bios and found this :

    OperationRegion (\SGPO, SystemIO, 0xE44C, 0x04)
    Field (SGPO, ByteAcc, NoLock, Preserve)
    {
        GPO0,   1,
                Offset (0x01),
        GPO8,   1,
            ,   2,
        GP11,   1,
                Offset (0x04)
    }

1 is my  ACPI broken? it doesnt claim 0xe44d as motherboard resource?
Or is Kernel ACPI handling broken? there are other e4xx regions in my
DSDT that are not claimed.
   OperationRegion (GPOB, SystemIO, 0xE42A, 0x02)
   OperationRegion (GPSC, SystemIO, 0xE42F, 0x01)
2 which bits exactly should I fiddle with? and how, is there a simple
way to play with them (like isaset/isadump for ports)?
3 Is work on i2c-virtual desired? or is this idea abandoned completely
by now and I should write a hack just for me?

-- 
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
