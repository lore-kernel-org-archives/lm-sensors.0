From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 06 Jun 2007 16:54:56 +0000
Subject: Re: [lm-sensors] #2198: Would like support for HP nc6230 laptop
Message-Id: <191fb4ca0706060954tedb5b53p1b7f86671bb93194@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_32440_2290216.1181148896092"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_32440_2290216.1181148896092
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

David,

Can you please run the attached script and post the output?

Thanks
...juerg


On 5/30/07, David Corlette <dcorlette@novell.com> wrote:
> Not sure this will work, but:
>
> sensors:
> sensors version 2.10.0 with libsensors version 2.10.0
>
> sensors-detect:
> (downloaded today, actually)
>
> Output:
> # sensors-detect revision $Revision$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Sorry, no known PCI bus adapters found.
>
> We will now try to load each adapter module in turn.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): YES
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): YES
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x0f00
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3c00
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no): YES
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
>
>
>
> >>> On Fri, May 25, 2007 at  9:39 PM, in message
> <049.4d5647c53b7ff9614f4fa5edeae24e8a@lm-sensors.org>, "lm-sensors"
> <lm-sensors-notify@lm-sensors.org> wrote:
> > #2198: Would like support for HP nc6230 laptop
> > --------------------------+-------------------------------------------------
> >   Reporter:  ticket       |       Owner:  juergh
> >       Type:  enhancement  |      Status:  new
> >   Priority:  minor        |   Milestone:
> >  Component:  hardware     |     Version:
> > Resolution:               |    Keywords:  SMSC nc6230
> > --------------------------+-------------------------------------------------
> > Changes (by juergh):
> >
> >   * owner:  somebody => juergh
> >
> > Comment:
> >
> >  Could you please post the sensors-detect and sensors versions and the full
> >  output of sensors-detect?
> >
> >  I own a nc6000 and will try it over the next couple of days and report
> >  what I find.
> >
> >  ...juerg
> >
> > --
> > Ticket URL: <http://www.lm-sensors.org/ticket/2198#comment:1>
> > lm-sensors <http://lm-sensors.org/>
> > Linux hardware monitoring
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

------=_Part_32440_2290216.1181148896092
Content-Type: application/x-perl; name=lpcscan.pl
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2m1j1xh
Content-Disposition: attachment; filename="lpcscan.pl"

IyEvdXNyL2Jpbi9wZXJsCgp1c2Ugc3RyaWN0Owp1c2UgRmNudGw7CgpzdWIgaW5iCnsKICAgIG15
ICgkbnVtLCAkdmFsKTsKCiAgICAjIHByaW50ZigiaW5iKCUwMngpIiwgJF9bMF0pOwogICAgc3lz
c2VlayhJT1BPUlQsICRfWzBdLCAwKSBvciBwcmludCAiXG5DYW5ub3Qgc2VlayAvZGV2L3BvcnQ6
ICQhXG4iOwogICAgbXkgJG51bSA9IHN5c3JlYWQoSU9QT1JULCAkdmFsLCAxKTsKICAgIGlmICgk
bnVtID09IDEpIHsKCSR2YWwgPSB1bnBhY2soIkMiLCAkdmFsKTsKCSMgcHJpbnRmKCIgPSAlMDJ4
XG4iLCAkdmFsKTsKCXJldHVybiAkdmFsOwogICAgfSBlbHNlIHsKCXByaW50ICJcbkNhbm5vdCBy
ZWFkIHBvcnQ6ICQhXG4iOwogICAgfQp9CgpzdWIgb3V0Ygp7CiAgICBteSAoJHZhbCwgJG51bSk7
CgogICAgIyBwcmludGYoIm91dGIoJTAyeCwgJTAyeClcbiIsICRfWzBdLCAkX1sxXSk7CiAgICBz
eXNzZWVrKElPUE9SVCwgJF9bMF0sIDApIG9yIHByaW50ICJDYW5ub3Qgc2VlayAvZGV2L3BvcnQ6
ICQhXG4iOwogICAgJHZhbCA9IHBhY2soIkMiLCAkX1sxXSk7CiAgICAkbnVtID0gc3lzd3JpdGUo
SU9QT1JULCAkdmFsLCAxKTsKICAgIHByaW50ICJDYW5ub3Qgd3JpdGUgL2Rldi9wb3J0OiAkIVxu
IiBpZiAoJG51bSAhPSAxKTsKfQoKc3ViIG1haW4KewogICAgbXkgQGVudGVyID0gKDB4NTUpOyAj
KDB4ODcsIDB4ODcpOyAjKDB4NTUpOwogICAgbXkgQGV4aXQgID0gKDB4YWEpOwojICAgIG15IEBs
ZG4gICA9ICgweDBhKTsKCW15IEBsZG4gPSAoMCwxLDIsMyw0LDUsNiw3LDgsOSwweGEsMHhiKTsK
CiAgICBzeXNvcGVuKElPUE9SVCwgIi9kZXYvcG9ydCIsIE9fUkRXUikgb3IgZGllICJjYW5ub3Qg
b3BlbiAvZGV2L3BvcnQ6ICQhXG4iOwogICAgYmlubW9kZSBJT1BPUlQ7CgogICAgbXkgKCRhZGRy
LCAkZGF0YSwgJHJlZyk7CiAgICBmb3JlYWNoICRhZGRyICgweDJlLCAweDRlKSB7CglwcmludGYo
IlxuVHJ5aW5nIDB4JTB4IC4uLiBcbiIsICRhZGRyKTsKCgkjIGVudGVyIGNvbmZpZ3VyYXRpb24g
bW9kZQoJb3V0YigkYWRkciwgJF8pIGZvcmVhY2ggQGVudGVyOwoKCSMgZHVtcCBzb21lIGJhc2lj
IHJlZ2lzdGVycwoJZm9yZWFjaCAkcmVnICgweDBkLCAweDBlLCAweDEyLCAweDEzLCAweDIwLCAw
eDIxLCAweDI0LCAweDI2LCAweDI3KSB7CgkgICAgb3V0YigkYWRkciwgJHJlZyk7CgkgICAgJGRh
dGEgPSBpbmIoJGFkZHIrMSk7CgkgICAgcHJpbnRmKCIweCUwMnggOiAweCUwMnhcbiIsICRyZWcs
ICRkYXRhKTsKCX0KCQoJIyBsZWF2ZSBjb25maWd1cmF0aW9uIG1vZGUKCW91dGIoJGFkZHIsICRf
KSBmb3JlYWNoIEBleGl0OwoKCSMgZHVtcCB0aGUgTEROcwoJZm9yZWFjaCAoQGxkbikgewoJICAg
IHByaW50ZigiXG5MRE4gMHglMDJ4OlxuIiwgJF8pOwoKCSAgICAjIGVudGVyIGNvbmZpZ3VyYXRp
b24gbW9kZQoJICAgIG91dGIoJGFkZHIsICRfKSBmb3JlYWNoIEBlbnRlcjsKCgkgICAgIyBzZWxl
Y3QgTEROCgkgICAgb3V0YigkYWRkciwgMHgwNyk7CgkgICAgb3V0YigkYWRkcisxLCAkXyk7CgoJ
ICAgIHByaW50ZigiICAgICAwICAxICAyICAzICA0ICA1ICA2ICA3ICA4ICA5ICBhICBiICBjICBk
ICBlICBmIik7CgkgICAgZm9yZWFjaCAkcmVnICgwLi4weGZmKSB7CgkJcHJpbnRmKCJcbiUwMng6
ICIsICRyZWcgJiAweGYwKSBpZiAoKCRyZWcgJSAxNikgPT0gMCk7CgkJb3V0YigkYWRkciwgJHJl
Zyk7CgkJJGRhdGEgPSBpbmIoJGFkZHIrMSk7CgkJcHJpbnRmKCIlMDJ4ICIsICRkYXRhKTsKCSAg
ICB9CgkgICAgcHJpbnRmKCJcbiIpOwoJCgkgICAgIyBsZWF2ZSBjb25maWd1cmF0aW9uIG1vZGUK
CSAgICBvdXRiKCRhZGRyLCAkXykgZm9yZWFjaCBAZXhpdDsKCX0KICAgIH0KCiAgICBjbG9zZShJ
T1BPUlQpOwp9CgombWFpbjsK
------=_Part_32440_2290216.1181148896092
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_32440_2290216.1181148896092--
