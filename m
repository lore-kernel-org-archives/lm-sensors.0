From: Igor Netkachev <netkachev@kolbas.it>
Date: Mon, 18 Jun 2012 08:30:59 +0000
Subject: Re: [lm-sensors] w83627 driver bug report
Message-Id: <CAJWOtEn4GppmtHmLM5xsjaA-Q1Emh4h-8fp0eiyFd5_cOintrg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0856026187273966246=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJWOtEk9=VgY_uS1ik91A1Pvh5iwM1vaC9rWGiGu3B+6wrajJw@mail.gmail.com>
In-Reply-To: <CAJWOtEk9=VgY_uS1ik91A1Pvh5iwM1vaC9rWGiGu3B+6wrajJw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0856026187273966246==
Content-Type: multipart/alternative; boundary=f46d04016d8f4d73c704c2bafc90

--f46d04016d8f4d73c704c2bafc90
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

We are a support service provider, so we had this bug on different machines
with different OSes (UNIX-based) in completely different datacenters. At
the moment we have two machines with this problem. Here comes BIOS and
motherboard info from dmidecode's output for both:

========
Machine 1
========
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1.2
        Release Date: 08/19/11
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 4096 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 kB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 8.16

System Information
        Manufacturer: Supermicro
        Product Name: X8SIE
        Version: 0123456789
        Serial Number: 0123456789
        UUID: 49434D53-0200-9008-2500-089025002931
        Wake-up Type: Power Switch
        SKU Number: To Be Filled By O.E.M.
        Family: To Be Filled By O.E.M.

Base Board Information
        Manufacturer: Supermicro
        Product Name: X8SIE
        Version: 0123456789
        Serial Number: 0123456789
        Asset Tag: To Be Filled By O.E.M.
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: To Be Filled By O.E.M.
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0


========
Machine 2
========
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1.1a
        Release Date: 09/27/10
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 4096 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 kB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 8.16

System Information
        Manufacturer: Supermicro
        Product Name: X8SIT
        Version: 0123456789
        Serial Number: 0123456789
        UUID: 49434D53-0200-900D-2500-0D902500453E
        Wake-up Type: Power Switch
        SKU Number: To Be Filled By O.E.M.
        Family: To Be Filled By O.E.M.

Base Board Information
        Manufacturer: Supermicro
        Product Name: X8SIT
        Version: 0123456789
        Serial Number: 0123456789
        Asset Tag: To Be Filled By O.E.M.
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: To Be Filled By O.E.M.
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0


-- 
Best regards, Igor Netkachev
NK support
netkachev@nksupport.com
http://www.nksupport.com


2012/6/15 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Igor,
>
> it almost looks like the chip might reset itself.
>
> Of course that could be caused by anything, but it is odd that it happens
> on multiple machines. Do those machines use IPMI or ACPI to access the
> chip,
> by any chance ? ASUS systems do that, for example, and the use of a hwmon
> chip
> driver is generally not recommended for such machines and may cause all
> sorts
> of issues.
>
> Thanks,
> Guenter
>
>

--f46d04016d8f4d73c704c2bafc90
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGkgR3VlbnRlciw8YnI+PGJyPldlIGFyZSBhIHN1cHBvcnQgc2VydmljZSBwcm92aWRlciwgc28g
d2UgaGFkIHRoaXMgYnVnIG9uIGRpZmZlcmVudCBtYWNoaW5lcyB3aXRoIGRpZmZlcmVudCBPU2Vz
IChVTklYLWJhc2VkKSBpbiBjb21wbGV0ZWx5IGRpZmZlcmVudCBkYXRhY2VudGVycy4gQXQgdGhl
IG1vbWVudCB3ZSBoYXZlIHR3byBtYWNoaW5lcyB3aXRoIHRoaXMgcHJvYmxlbS4gSGVyZSBjb21l
cyBCSU9TIGFuZCBtb3RoZXJib2FyZCBpbmZvIGZyb20gZG1pZGVjb2RlJiMzOTtzIG91dHB1dCBm
b3IgYm90aDo8YnI+Cjxicj49PT09PT09PTxicj5NYWNoaW5lIDE8YnI+PT09PT09PT08YnI+QklP
UyBJbmZvcm1hdGlvbjxicj6goKCgoKCgIFZlbmRvcjogQW1lcmljYW4gTWVnYXRyZW5kcyBJbmMu
PGJyPqCgoKCgoKAgVmVyc2lvbjogMS4yoKCgoKCgIDxicj6goKCgoKCgIFJlbGVhc2UgRGF0ZTog
MDgvMTkvMTGgIDxicj6goKCgoKCgIEFkZHJlc3M6IDB4RjAwMDA8YnI+oKCgoKCgoCBSdW50aW1l
IFNpemU6IDY0IGtCPGJyPgqgoKCgoKCgIFJPTSBTaXplOiA0MDk2IGtCPGJyPqCgoKCgoKAgQ2hh
cmFjdGVyaXN0aWNzOjxicj6goKCgoKCgoKCgoKCgoKAgSVNBIGlzIHN1cHBvcnRlZDxicj6goKCg
oKCgoKCgoKCgoKAgUENJIGlzIHN1cHBvcnRlZDxicj6goKCgoKCgoKCgoKCgoKAgUE5QIGlzIHN1
cHBvcnRlZDxicj6goKCgoKCgoKCgoKCgoKAgQklPUyBpcyB1cGdyYWRlYWJsZTxicj6goKCgoKCg
oKCgoKCgoKAgQklPUyBzaGFkb3dpbmcgaXMgYWxsb3dlZDxicj4KoKCgoKCgoKCgoKCgoKCgIEVT
Q0Qgc3VwcG9ydCBpcyBhdmFpbGFibGU8YnI+oKCgoKCgoKCgoKCgoKCgIEJvb3QgZnJvbSBDRCBp
cyBzdXBwb3J0ZWQ8YnI+oKCgoKCgoKCgoKCgoKCgIFNlbGVjdGFibGUgYm9vdCBpcyBzdXBwb3J0
ZWQ8YnI+oKCgoKCgoKCgoKCgoKCgIEJJT1MgUk9NIGlzIHNvY2tldGVkPGJyPqCgoKCgoKCgoKCg
oKCgoCBFREQgaXMgc3VwcG9ydGVkPGJyPqCgoKCgoKCgoKCgoKCgoCA1LjI1JnF1b3Q7LzEuMiBN
QiBmbG9wcHkgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50IDEzaCk8YnI+CqCgoKCgoKCgoKCg
oKCgoCAzLjUmcXVvdDsvNzIwIGtCIGZsb3BweSBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQg
MTNoKTxicj6goKCgoKCgoKCgoKCgoKAgMy41JnF1b3Q7LzIuODggTUIgZmxvcHB5IHNlcnZpY2Vz
IGFyZSBzdXBwb3J0ZWQgKGludCAxM2gpPGJyPqCgoKCgoKCgoKCgoKCgoCBQcmludCBzY3JlZW4g
c2VydmljZSBpcyBzdXBwb3J0ZWQgKGludCA1aCk8YnI+oKCgoKCgoKCgoKCgoKCgIDgwNDIga2V5
Ym9hcmQgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50IDloKTxicj4KoKCgoKCgoKCgoKCgoKCg
IFNlcmlhbCBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTRoKTxicj6goKCgoKCgoKCgoKCg
oKAgUHJpbnRlciBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTdoKTxicj6goKCgoKCgoKCg
oKCgoKAgQ0dBL21vbm8gdmlkZW8gc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50IDEwaCk8YnI+
oKCgoKCgoKCgoKCgoKCgIEFDUEkgaXMgc3VwcG9ydGVkPGJyPgqgoKCgoKCgoKCgoKCgoKAgVVNC
IGxlZ2FjeSBpcyBzdXBwb3J0ZWQ8YnI+oKCgoKCgoKCgoKCgoKCgIExTLTEyMCBib290IGlzIHN1
cHBvcnRlZDxicj6goKCgoKCgoKCgoKCgoKAgQVRBUEkgWmlwIGRyaXZlIGJvb3QgaXMgc3VwcG9y
dGVkPGJyPqCgoKCgoKCgoKCgoKCgoCBCSU9TIGJvb3Qgc3BlY2lmaWNhdGlvbiBpcyBzdXBwb3J0
ZWQ8YnI+oKCgoKCgoKCgoKCgoKCgIFRhcmdldGVkIGNvbnRlbnQgZGlzdHJpYnV0aW9uIGlzIHN1
cHBvcnRlZDxicj4KoKCgoKCgoCBCSU9TIFJldmlzaW9uOiA4LjE2PGJyPjxicj5TeXN0ZW0gSW5m
b3JtYXRpb248YnI+oKCgoKCgoCBNYW51ZmFjdHVyZXI6IFN1cGVybWljcm88YnI+oKCgoKCgoCBQ
cm9kdWN0IE5hbWU6IFg4U0lFPGJyPqCgoKCgoKAgVmVyc2lvbjogMDEyMzQ1Njc4OTxicj6goKCg
oKCgIFNlcmlhbCBOdW1iZXI6IDAxMjM0NTY3ODk8YnI+oKCgoKCgoCBVVUlEOiA0OTQzNEQ1My0w
MjAwLTkwMDgtMjUwMC0wODkwMjUwMDI5MzE8YnI+CqCgoKCgoKAgV2FrZS11cCBUeXBlOiBQb3dl
ciBTd2l0Y2g8YnI+oKCgoKCgoCBTS1UgTnVtYmVyOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uPGJy
PqCgoKCgoKAgRmFtaWx5OiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uPGJyPjxicj5CYXNlIEJvYXJk
IEluZm9ybWF0aW9uPGJyPqCgoKCgoKAgTWFudWZhY3R1cmVyOiBTdXBlcm1pY3JvPGJyPqCgoKCg
oKAgUHJvZHVjdCBOYW1lOiBYOFNJRTxicj4KoKCgoKCgoCBWZXJzaW9uOiAwMTIzNDU2Nzg5PGJy
PqCgoKCgoKAgU2VyaWFsIE51bWJlcjogMDEyMzQ1Njc4OTxicj6goKCgoKCgIEFzc2V0IFRhZzog
VG8gQmUgRmlsbGVkIEJ5IE8uRS5NLjxicj6goKCgoKCgIEZlYXR1cmVzOjxicj6goKCgoKCgoKCg
oKCgoKAgQm9hcmQgaXMgYSBob3N0aW5nIGJvYXJkPGJyPqCgoKCgoKCgoKCgoKCgoCBCb2FyZCBp
cyByZXBsYWNlYWJsZTxicj6goKCgoKCgIExvY2F0aW9uIEluIENoYXNzaXM6IFRvIEJlIEZpbGxl
ZCBCeSBPLkUuTS48YnI+CqCgoKCgoKAgQ2hhc3NpcyBIYW5kbGU6IDB4MDAwMzxicj6goKCgoKCg
IFR5cGU6IE1vdGhlcmJvYXJkPGJyPqCgoKCgoKAgQ29udGFpbmVkIE9iamVjdCBIYW5kbGVzOiAw
PGJyPjxicj48YnI+PT09PT09PT08YnI+Ck1hY2hpbmUgMjxicj49PT09PT09PTxicj5CSU9TIElu
Zm9ybWF0aW9uPGJyPqCgoKCgoKAgVmVuZG9yOiBBbWVyaWNhbiBNZWdhdHJlbmRzIEluYy48YnI+
oKCgoKCgoCBWZXJzaW9uOiAxLjFhoKCgoKAgPGJyPqCgoKCgoKAgUmVsZWFzZSBEYXRlOiAwOS8y
Ny8xMKAgPGJyPqCgoKCgoKAgQWRkcmVzczogMHhGMDAwMDxicj6goKCgoKCgIFJ1bnRpbWUgU2l6
ZTogNjQga0I8YnI+oKCgoKCgoCBST00gU2l6ZTogNDA5NiBrQjxicj4KoKCgoKCgoCBDaGFyYWN0
ZXJpc3RpY3M6PGJyPqCgoKCgoKCgoKCgoKCgoCBJU0EgaXMgc3VwcG9ydGVkPGJyPqCgoKCgoKCg
oKCgoKCgoCBQQ0kgaXMgc3VwcG9ydGVkPGJyPqCgoKCgoKCgoKCgoKCgoCBQTlAgaXMgc3VwcG9y
dGVkPGJyPqCgoKCgoKCgoKCgoKCgoCBCSU9TIGlzIHVwZ3JhZGVhYmxlPGJyPqCgoKCgoKCgoKCg
oKCgoCBCSU9TIHNoYWRvd2luZyBpcyBhbGxvd2VkPGJyPqCgoKCgoKCgoKCgoKCgoCBFU0NEIHN1
cHBvcnQgaXMgYXZhaWxhYmxlPGJyPgqgoKCgoKCgoKCgoKCgoKAgQm9vdCBmcm9tIENEIGlzIHN1
cHBvcnRlZDxicj6goKCgoKCgoKCgoKCgoKAgU2VsZWN0YWJsZSBib290IGlzIHN1cHBvcnRlZDxi
cj6goKCgoKCgoKCgoKCgoKAgQklPUyBST00gaXMgc29ja2V0ZWQ8YnI+oKCgoKCgoKCgoKCgoKCg
IEVERCBpcyBzdXBwb3J0ZWQ8YnI+oKCgoKCgoKCgoKCgoKCgIDUuMjUmcXVvdDsvMS4yIE1CIGZs
b3BweSBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTNoKTxicj4KoKCgoKCgoKCgoKCgoKCg
IDMuNSZxdW90Oy83MjAga0IgZmxvcHB5IHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxM2gp
PGJyPqCgoKCgoKCgoKCgoKCgoCAzLjUmcXVvdDsvMi44OCBNQiBmbG9wcHkgc2VydmljZXMgYXJl
IHN1cHBvcnRlZCAoaW50IDEzaCk8YnI+oKCgoKCgoKCgoKCgoKCgIFByaW50IHNjcmVlbiBzZXJ2
aWNlIGlzIHN1cHBvcnRlZCAoaW50IDVoKTxicj6goKCgoKCgoKCgoKCgoKAgODA0MiBrZXlib2Fy
ZCBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgOWgpPGJyPgqgoKCgoKCgoKCgoKCgoKAgU2Vy
aWFsIHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxNGgpPGJyPqCgoKCgoKCgoKCgoKCgoCBQ
cmludGVyIHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxN2gpPGJyPqCgoKCgoKCgoKCgoKCg
oCBDR0EvbW9ubyB2aWRlbyBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTBoKTxicj6goKCg
oKCgoKCgoKCgoKAgQUNQSSBpcyBzdXBwb3J0ZWQ8YnI+CqCgoKCgoKCgoKCgoKCgoCBVU0IgbGVn
YWN5IGlzIHN1cHBvcnRlZDxicj6goKCgoKCgoKCgoKCgoKAgTFMtMTIwIGJvb3QgaXMgc3VwcG9y
dGVkPGJyPqCgoKCgoKCgoKCgoKCgoCBBVEFQSSBaaXAgZHJpdmUgYm9vdCBpcyBzdXBwb3J0ZWQ8
YnI+oKCgoKCgoKCgoKCgoKCgIEJJT1MgYm9vdCBzcGVjaWZpY2F0aW9uIGlzIHN1cHBvcnRlZDxi
cj6goKCgoKCgoKCgoKCgoKAgVGFyZ2V0ZWQgY29udGVudCBkaXN0cmlidXRpb24gaXMgc3VwcG9y
dGVkPGJyPgqgoKCgoKCgIEJJT1MgUmV2aXNpb246IDguMTY8YnI+PGJyPlN5c3RlbSBJbmZvcm1h
dGlvbjxicj6goKCgoKCgIE1hbnVmYWN0dXJlcjogU3VwZXJtaWNybzxicj6goKCgoKCgIFByb2R1
Y3QgTmFtZTogWDhTSVQ8YnI+oKCgoKCgoCBWZXJzaW9uOiAwMTIzNDU2Nzg5PGJyPqCgoKCgoKAg
U2VyaWFsIE51bWJlcjogMDEyMzQ1Njc4OTxicj6goKCgoKCgIFVVSUQ6IDQ5NDM0RDUzLTAyMDAt
OTAwRC0yNTAwLTBEOTAyNTAwNDUzRTxicj4KoKCgoKCgoCBXYWtlLXVwIFR5cGU6IFBvd2VyIFN3
aXRjaDxicj6goKCgoKCgIFNLVSBOdW1iZXI6IFRvIEJlIEZpbGxlZCBCeSBPLkUuTS48YnI+oKCg
oKCgoCBGYW1pbHk6IFRvIEJlIEZpbGxlZCBCeSBPLkUuTS48YnI+PGJyPkJhc2UgQm9hcmQgSW5m
b3JtYXRpb248YnI+oKCgoKCgoCBNYW51ZmFjdHVyZXI6IFN1cGVybWljcm88YnI+oKCgoKCgoCBQ
cm9kdWN0IE5hbWU6IFg4U0lUPGJyPgqgoKCgoKCgIFZlcnNpb246IDAxMjM0NTY3ODk8YnI+oKCg
oKCgoCBTZXJpYWwgTnVtYmVyOiAwMTIzNDU2Nzg5PGJyPqCgoKCgoKAgQXNzZXQgVGFnOiBUbyBC
ZSBGaWxsZWQgQnkgTy5FLk0uPGJyPqCgoKCgoKAgRmVhdHVyZXM6PGJyPqCgoKCgoKCgoKCgoKCg
oCBCb2FyZCBpcyBhIGhvc3RpbmcgYm9hcmQ8YnI+oKCgoKCgoKCgoKCgoKCgIEJvYXJkIGlzIHJl
cGxhY2VhYmxlPGJyPqCgoKCgoKAgTG9jYXRpb24gSW4gQ2hhc3NpczogVG8gQmUgRmlsbGVkIEJ5
IE8uRS5NLjxicj4KoKCgoKCgoCBDaGFzc2lzIEhhbmRsZTogMHgwMDAzPGJyPqCgoKCgoKAgVHlw
ZTogTW90aGVyYm9hcmQ8YnI+oKCgoKCgoCBDb250YWluZWQgT2JqZWN0IEhhbmRsZXM6IDA8YnI+
PGJyPjxicj48YSBuYW1lPSI1NTg1NyI+LS0gPGJyPgpCZXN0IHJlZ2FyZHMsIElnb3IgTmV0a2Fj
aGV2PGJyPgpOSyBzdXBwb3J0PGJyPgo8L2E+PGEgaHJlZj0ibWFpbHRvOm5ldGthY2hldkBua3N1
cHBvcnQuY29tIj5uZXRrYWNoZXZAbmtzdXBwb3J0LmNvbTwvYT48YnI+CjxhIGhyZWY9Imh0dHA6
Ly93d3cubmtzdXBwb3J0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cubmtzdXBwb3J0
LmNvbTwvYT48YnI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMi82LzE1IEd1
ZW50ZXIgUm9lY2sgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Z3VlbnRlci5y
b2Vja0Blcmljc3Nvbi5jb20iIHRhcmdldD0iX2JsYW5rIj5ndWVudGVyLnJvZWNrQGVyaWNzc29u
LmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PGRpdiBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+CjwvZGl2Pjwv
ZGl2PkhpIElnb3IsPGJyPgo8YnI+Cml0IGFsbW9zdCBsb29rcyBsaWtlIHRoZSBjaGlwIG1pZ2h0
IHJlc2V0IGl0c2VsZi48YnI+Cjxicj4KT2YgY291cnNlIHRoYXQgY291bGQgYmUgY2F1c2VkIGJ5
IGFueXRoaW5nLCBidXQgaXQgaXMgb2RkIHRoYXQgaXQgaGFwcGVuczxicj4Kb24gbXVsdGlwbGUg
bWFjaGluZXMuIERvIHRob3NlIG1hY2hpbmVzIHVzZSBJUE1JIG9yIEFDUEkgdG8gYWNjZXNzIHRo
ZSBjaGlwLDxicj4KYnkgYW55IGNoYW5jZSA/IEFTVVMgc3lzdGVtcyBkbyB0aGF0LCBmb3IgZXhh
bXBsZSwgYW5kIHRoZSB1c2Ugb2YgYSBod21vbiBjaGlwPGJyPgpkcml2ZXIgaXMgZ2VuZXJhbGx5
IG5vdCByZWNvbW1lbmRlZCBmb3Igc3VjaCBtYWNoaW5lcyBhbmQgbWF5IGNhdXNlIGFsbCBzb3J0
czxicj4Kb2YgaXNzdWVzLjxicj4KPGJyPgpUaGFua3MsPGJyPgpHdWVudGVyPGJyPgo8YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+Cg==
--f46d04016d8f4d73c704c2bafc90--


--===============0856026187273966246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0856026187273966246==--
