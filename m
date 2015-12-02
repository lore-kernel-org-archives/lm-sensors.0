From: Another Sillyname <anothersname@googlemail.com>
Date: Wed, 02 Dec 2015 09:19:33 +0000
Subject: [lm-sensors] Asus Gene VI and Gene VII...same chip.....different outcomes.....BIOS settings?
Message-Id: <CAOS+5GFZRvm+sxU52D4py88Ny7BXcTwGa61M4VoYkiCZ1kYvSw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have both an Asus Gene Vi and a Gene VII.

Both have the NCT6791D chip.

On the VI all the fan, temp and voltage sensors show and dmesg reports
no acpi conflicts.

On the VII dmesg reports the usual acpi conflict......

nct6775: Enabling hardware monitor logical device mappings.
nct6775: Found NCT6791D or compatible chip at 0x2e:0x290
ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296
conflicts with OpRegion 0x0000000000000290-0x0000000000000299
(\_GPE.HWM_) (20150619/utaddress-254)
ACPI: If an ACPI driver is available for this device, you should use
it instead of the native driver


As this is outside my experience I have to ask is there a BIOS setting
or anything that would cause the difference?

I'm a bit loath to use the acpi=lax kernel option as this box is going
to be a raid file server and I don't want to find after 3 months it's
been slowly corrupting data and I didn't notice.

All ideas and suggestions welcome....

If anyone wants anything in the way of debugs from the VII let me know
as it's currently in burn in test till January before going into
production.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
