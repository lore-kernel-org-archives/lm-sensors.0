From: paul@astropaul.com (Paul Reilly)
Date: Sun, 18 Feb 2007 00:16:54 +0000
Subject: [lm-sensors] IPMI sysfs support for 2.6.16.x
Message-Id: <1171757814.45d79af660169@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1171733778.45d73d12edf0a@mail.third-rock.net>
In-Reply-To: <1171733778.45d73d12edf0a@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Can I just copy the whole drivers/char/ipmi/  dir from a 2.6.17 kernel,
> > and put it in my 2.6.16.33 ?
> >
> That is probably the easiest way to handle this.  There may be one or
> two things that need to be fixed, but not much.

OK, Thanks Corey. I tried that and it bails out during the kernel compile
with problems with function declarations:

  CC      drivers/char/ipmi/ipmi_msghandler.o
drivers/char/ipmi/ipmi_msghandler.c: In function
?&#128;&#152;ipmi_init_msghandler?&#128;&#153;:
drivers/char/ipmi/ipmi_msghandler.c:3762: warning: implicit declaration of
function ?&#128;&#152;atomic_notifier_chain_register?&#128;&#153;
drivers/char/ipmi/ipmi_msghandler.c: In function
?&#128;&#152;cleanup_ipmi?&#128;&#153;:
drivers/char/ipmi/ipmi_msghandler.c:3782: warning: implicit declaration of
function ?&#128;&#152;atomic_notifier_chain_unregister?&#128;&#153;
  CC      drivers/char/ipmi/ipmi_devintf.o
  CC      drivers/char/ipmi/ipmi_si_intf.o
drivers/char/ipmi/ipmi_si_intf.c:240: warning: type defaults to
?&#128;&#152;int?&#128;&#153; in declaration of
?&#128;&#152;ATOMIC_NOTIFIER_HEAD?&#128;&#153;
drivers/char/ipmi/ipmi_si_intf.c:240: warning: parameter names (without types)
in function declaration
drivers/char/ipmi/ipmi_si_intf.c: In function
?&#128;&#152;register_xaction_notifier?&#128;&#153;:
drivers/char/ipmi/ipmi_si_intf.c:243: warning: implicit declaration of function
?&#128;&#152;atomic_notifier_chain_register?&#128;&#153;
drivers/char/ipmi/ipmi_si_intf.c:243: error:
?&#128;&#152;xaction_notifier_list?&#128;&#153; undeclared (first use in this
function)
drivers/char/ipmi/ipmi_si_intf.c:243: error: (Each undeclared identifier is
reported only once
drivers/char/ipmi/ipmi_si_intf.c:243: error: for each function it appears in.)
drivers/char/ipmi/ipmi_si_intf.c: In function
?&#128;&#152;start_next_msg?&#128;&#153;:
drivers/char/ipmi/ipmi_si_intf.c:305: warning: implicit declaration of function
?&#128;&#152;atomic_notifier_call_chain?&#128;&#153;
drivers/char/ipmi/ipmi_si_intf.c:305: error:
?&#128;&#152;xaction_notifier_list?&#128;&#153; undeclared (first use in this
function)
make[3]: *** [drivers/char/ipmi/ipmi_si_intf.o] Error 1
make[2]: *** [drivers/char/ipmi] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


This is what I did:
# rm -rf linux-2.6.16.33/drivers/char/ipmi/
# cp -pR linux-2.6.17.1/drivers/char/ipmi/ linux-2.6.16.33/drivers/char/
# cp linux-2.6.17.1/include/linux/ipmi* linux-2.6.16.33/include/linux/
# patch -p1 < /sources/local/bmcsensors/ipmisensors-20060805-0622.diff
patching file drivers/char/ipmi/ipmi_msghandler.c
Hunk #1 succeeded at 1749 (offset 5 lines).
Hunk #2 succeeded at 3839 (offset 8 lines).
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 164 (offset -16 lines).
patching file drivers/hwmon/Makefile
Hunk #1 succeeded at 24 with fuzz 1 (offset -2 lines).
patching file drivers/hwmon/ipmisensors.c
patching file drivers/hwmon/ipmisensors.h
patching file include/linux/ipmi.h
Hunk #1 succeeded at 288 (offset 4 lines).
patching file include/linux/ipmi_msgdefs.h

# cd linux-2.6.16.33
# make menuconfig
# make

Should I be doing something different with the include files?
Any tips on how to fix this?

Paul
-- 

