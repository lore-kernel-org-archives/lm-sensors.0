From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 10 Mar 2007 01:19:26 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now
Message-Id: <4dfa50520703091719j5b46d5bcxa2fa695cb8d527ed@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1E8C0.6040504@assembler.cz>
In-Reply-To: <45F1E8C0.6040504@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> On 3/9/07, Rudolf Marek <r.marek at assembler.cz> wrote:
> > Hello all,
> >
> > Jean asked me to help to covert the remaining i2c-isa drivers. Situation is
> > following:
> >
> > it87.c -  montjoie is working on it, Jean can test
> > lm78.c - special ISA, Jean can test
> > pc87360.c
> > sis5595.c
> > smsc47b397.c - I can test but bit complicated - it is a server
> > smsc47m1.c
> > via686a.c
> > vt8231.c
> > w83627hf.c - Jean can test
> > w83627ehf.c - I can test on monday/sunday, passing to David right now ;)
> > w83781d.c - special ISA
> >
> > Of course my test platform does not boot via the WOL :/  So I cant test the EHF
> > driver right now. David, please can you help with that? (the request resource
> > part is still missing, please check the Jean's pending patches, the patch
> > compiles OK thats all I know) If you don't have time, never mind.
> >
> > I will try to reboot my workstation on Sunday with new kernel, but I need it
> > tomorrow for for some VHDL development.
> >
> > Maybe others may help? If we finish this in time, we can move to pending patches
> > ;) I will convert perhaps smsc47b397 tomorrow.
> >
> > Thanks,
> > Rudolf
>
> I'll test out the patch on my machine. Can you send the URL?

Sorry about that, I should have waited. Anyway, the patch applies
cleanly. I'm running 2.6.21-rc3, and I get "Permission Denied" when I
modprobe the new module. I get the following messages in dmesg:

[721.798516] kobject_add failed for w83627ehf/dhg (-13)
[721.798520]
[721.798521] Call Trace:
[721.798529]  [<ffffffff80335040>] kobject_shadow_add+0x190/0x1e0
[721.798534]  [<ffffffff803351d8>] kobject_register+0x28/0x50
[721.798538]  [<ffffffff803a0f7b>] bus_add_driver+0x6b/0x1d0
[721.798544]  [<ffffffff88032181>] :w83627ehf:sensors_w83627ehf_init+0x41/0x120
[721.798551]  [<ffffffff802abfef>] sys_init_module+0x16af/0x1850
[721.798559]  [<ffffffff8020d3f0>] file_read_actor+0x0/0x180
[721.798564]  [<ffffffff8026206e>] system_call+0x7e/0x83

The error occurs at line 1416 in sensors_w83627ehf_init():
        err = platform_driver_register(&w83627ehf_driver);

platform_driver_register calls driver_register. driver_register calls
bus_add_driver. bus_add_driver calls kobject_register, which I think
creates the kobj, but this seems to be the problem. I'm not sure if
this is really the problem, it's just as far as I could tell.

I would also suggest a change to this in the patch:
+#define DRVNAME "w83627ehf/dhg"

I wouldn't change the name of the driver to w83627ehf/dhg. I think it
should be w83627ehf. After all, the w83627ehf driver supports the
w83627ehf and w83627ehg chips, and now the w83627dhg. I don't think we
should change the driver name just because we added DHG support. If
it's confusing to end users, we should add an explanatory note to the
output of sensors-detect.

Hmm, patch doesn't work on my machine. I can also test on the
w83627dhg tonight, but we'll need to fix the kobject_register problem.

David

