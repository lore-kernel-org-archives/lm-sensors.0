From: kensai@tassie.net.au (John WICKS)
Date: Tue, 31 May 2005 05:29:54 +0000
Subject: [lm-sensors] sensors-detect failed to see my SMbus
Message-Id: <429BDA64.8040703@tassie.net.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A2ABC.1040809@sh.cvut.cz>
In-Reply-To: <429A2ABC.1040809@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


   G'day Rudolf,
   sorry about the subject, my mistake :-(
   below are the outputs from the commands requested.
   I would like to attempt to activate the bus as it would be handy considering
   I work in hot environments a lot.
   if its too risky can I still use the temp sensor in the hard drive as this
   is what I previously used in M$ windows
   thank you for your assistance and valuable time
   regards
   kensai
   [root@localhost root]# acpi -V
        Battery 1: discharging, 66%, 01:07:56 remaining
        Thermal 1: ok, 45.0 degrees C
     AC Adapter 1: off-line

   [root@localhost root]# uname -a
   Linux localhost 2.6.8.1-10mdk #1 Wed Sep 8 17:00:52 CEST 2004 i686 Mobile
   Intel(R) Pentium(R) 4 - M CPU 2.50GHz unknown GNU/Linux

   [root@localhost root]# lspci -n
   00:00.0 Class 0600: 8086:1a30 (rev 04)
   00:01.0 Class 0604: 8086:1a31 (rev 04)
   00:1d.0 Class 0c03: 8086:24c2 (rev 03)
   00:1d.1 Class 0c03: 8086:24c4 (rev 03)
   00:1d.2 Class 0c03: 8086:24c7 (rev 03)
   00:1d.7 Class 0c03: 8086:24cd (rev 03)
   00:1e.0 Class 0604: 8086:2448 (rev 83)
   00:1f.0 Class 0601: 8086:24cc (rev 03)
   00:1f.1 Class 0101: 8086:24ca (rev 03)
   00:1f.5 Class 0401: 8086:24c5 (rev 03)
   00:1f.6 Class 0703: 8086:24c6 (rev 03)
   01:00.0 Class 0300: 10de:0286 (rev a1)
   02:00.0 Class 0200: 14e4:4401 (rev 01)
   02:01.0 Class 0607: 104c:ac44 (rev 02)
   02:01.1 Class 0c00: 104c:8029

   John Wicks
   [1]kensai@tassie.net.au
   Ph: +61 3 6343 4358

   Rudolf Marek wrote:

G'day gentlemen/women,


Hi John :)



please excuse any fumbling questions as I am new to Linux


It is OK to ask, but nexttime dont forget to include proper subject please :)



sensors-detect failed to see my SMbus, I have a Dell Inspiron 8500
laptop with an Intel 82801 DBM SMbus controller (ICH4-M)
my question is do I use/will the i801 driver work? and what is the best
way to get it to work?


Yes there are ways to do it but on notebooks the chips for temp monitoring are
different.
So even if we forcibly enable it (this is somewhat bit dangerous) there will be
 no chip detected.



would Ilja Rauhut's p4b hack do the trick?


For kernel 2.4.x perhaps yes.
For kernel 2.6.x you need to take a look to pci/quirks.c

If you want to know your CPU temo you can try to get it from ACPI.
Just issue command acpi -V and you should see something.

If you really want to enable the bus I would need to know what kernel version y
ou have:
uname -a
and  output of:
lspci -n

But I can nearly guarantee there will be no sensor found.

Regards

Rudolf

References

   1. mailto:kensai@tassie.net.au
