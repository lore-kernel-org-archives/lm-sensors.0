From: undersys <undersys@basstech.net>
Date: Tue, 06 Dec 2011 11:50:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <02522b23-689e-41ad-bcf3-cfe2628a5fce@basstech.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_fa66d15a-a5ea-4f91-a76b-bb839cc5df02"
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
To: lm-sensors@vger.kernel.org

--=_fa66d15a-a5ea-4f91-a76b-bb839cc5df02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----
From: "Jean Delvare" <khali@linux-fr.org>
To: undersys@basstech.net
Cc: lm-sensors@lm-sensors.org, "Durgadoss R" <Durgadoss.r@intel.com>, "guenter roeck" <guenter.roeck@ericsson.com>
Sent: Tuesday, 6 December, 2011 5:53:41 PM
Subject: Re: [PATCH] hwmon: (coretemp) Fix oops on driver load

On Tue, 06 Dec 2011 07:26:59 +0800 (HKT), undersys wrote:
> The microcode utility I am using is :-
> http://urbanmyth.org/microcode
> 
> The version of micro code I am using is "microcode-20110915.tgz" :-
> http://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=20429&lang=eng

Did you have to do that with previous kernels too?

undersys ->  I Did not ever need to use the microcode utility.
             Maybe i should in future...

> CPU is :-
> Intel Xeon sossaman, model=14, stepping=4. 
> I don't have the SPEC number on hand let me know if you need more information.

Is this a single or multi-cpu system?

undersys -> multi-cpu (dual socket)

I would like to see the contents of /proc/cpuinfo.

undersys -> attached

> Micro code was working on 2.6.29 and 2.6.39 , then I jumped to 3.0.6.

I admit I don't quite get it for now. While the device probing logic
was modified a lot in the coretemp driver of kernel 3.0, the microcode
check did not change, so I just don't get why the new driver would
behave differently from the previous ones in this respect.

For testing purposes, I made the 2.6.39 version of the coretemp driver
available as a standalone driver:
http://khali.linux-fr.org/devel/misc/coretemp_old/
(Instructions at http://khali.linux-fr.org/devel/misc/INSTALL )

I would like you to test it on your 3.0 kernel and report whether it is
working or not. You'll have to rmmod the original coretemp driver
before loading coretemp_old, you can't have both loaded at once.

If coretemp_old works, then please rmmod it and modprobe coretemp
again, and see if it then works.

undersys ->

I built your module(coretemp_old), works fine no kernel opps.
The only lines printed to "dmesg" are :-
[  133.603204] coretemp coretemp.0: Errata AE18 not fixed, update BIOS or microcode of the CPU!
[  133.603277] coretemp coretemp.1: Errata AE18 not fixed, update BIOS or microcode of the CPU!
[  133.603329] coretemp coretemp.2: Errata AE18 not fixed, update BIOS or microcode of the CPU!
[  133.603379] coretemp coretemp.3: Errata AE18 not fixed, update BIOS or microcode of the CPU!

If i remove it and then attempt to re-probe the new one, the new one fails.


-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html


Hi Jean,

Answers are inline.

Thanks for your time!

--=_fa66d15a-a5ea-4f91-a76b-bb839cc5df02
Content-Type: text/plain; name=cpuinfo.txt
Content-Disposition: attachment; filename=cpuinfo.txt
Content-Transfer-Encoding: base64

IyBjYXQgL3Byb2MvY3B1aW5mbyAKcHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50
ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMTQKbW9kZWwgbmFtZQk6IEludGVsKFIpIER1YWwg
UGVudGl1bShSKSBNIENQVSAgIDAwMCAgQCAxLjgzR0h6CnN0ZXBwaW5nCTogNApjcHUgTUh6CQk6
IDk5Ni4wMDAKY2FjaGUgc2l6ZQk6IDIwNDggS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTog
Mgpjb3JlIGlkCQk6IDAKY3B1IGNvcmVzCTogMgphcGljaWQJCTogMAppbml0aWFsIGFwaWNpZAk6
IDAKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5vCmYwMGZfYnVnCTogbm8KY29tYV9idWcJOiBu
bwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiA2CndwCQk6IHll
cwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10
cnIgcGdlIG1jYSBjbW92IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIg
c3MgaHQgdG0gcGJlIG54IGNvbnN0YW50X3RzYyBidHMgcG5pIG1vbml0b3Igdm14IGVzdCB0bTIg
eHRwciBkdHMKYm9nb21pcHMJOiAzNjY3LjA5CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdu
bWVudAk6IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzNiBiaXRzIHBoeXNpY2FsLCAzMiBiaXRzIHZpcnR1
YWwKcG93ZXIgbWFuYWdlbWVudDoKCnByb2Nlc3Nvcgk6IDEKdmVuZG9yX2lkCTogR2VudWluZUlu
dGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDE0Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBEdWFs
IFBlbnRpdW0oUikgTSBDUFUgICAwMDAgIEAgMS44M0dIegpzdGVwcGluZwk6IDQKY3B1IE1IegkJ
OiA5OTYuMDAwCmNhY2hlIHNpemUJOiAyMDQ4IEtCCnBoeXNpY2FsIGlkCTogMwpzaWJsaW5ncwk6
IDIKY29yZSBpZAkJOiAwCmNwdSBjb3Jlcwk6IDIKYXBpY2lkCQk6IDYKaW5pdGlhbCBhcGljaWQJ
OiA2CmZkaXZfYnVnCTogbm8KaGx0X2J1ZwkJOiBubwpmMDBmX2J1Zwk6IG5vCmNvbWFfYnVnCTog
bm8KZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogNgp3cAkJOiB5
ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBt
dHJyIHBnZSBtY2EgY21vdiBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2Uy
IHNzIGh0IHRtIHBiZSBueCBjb25zdGFudF90c2MgYnRzIHBuaSBtb25pdG9yIHZteCBlc3QgdG0y
IHh0cHIgZHRzCmJvZ29taXBzCTogMzY2Ni4xNgpjbGZsdXNoIHNpemUJOiA2NApjYWNoZV9hbGln
bm1lbnQJOiA2NAphZGRyZXNzIHNpemVzCTogMzYgYml0cyBwaHlzaWNhbCwgMzIgYml0cyB2aXJ0
dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiAyCnZlbmRvcl9pZAk6IEdlbnVpbmVJ
bnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAxNAptb2RlbCBuYW1lCTogSW50ZWwoUikgRHVh
bCBQZW50aXVtKFIpIE0gQ1BVICAgMDAwICBAIDEuODNHSHoKc3RlcHBpbmcJOiA0CmNwdSBNSHoJ
CTogOTk2LjAwMApjYWNoZSBzaXplCTogMjA0OCBLQgpwaHlzaWNhbCBpZAk6IDAKc2libGluZ3MJ
OiAyCmNvcmUgaWQJCTogMQpjcHUgY29yZXMJOiAyCmFwaWNpZAkJOiAxCmluaXRpYWwgYXBpY2lk
CTogMQpmZGl2X2J1Zwk6IG5vCmhsdF9idWcJCTogbm8KZjAwZl9idWcJOiBubwpjb21hX2J1Zwk6
IG5vCmZwdQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDYKd3AJCTog
eWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAg
bXRyciBwZ2UgbWNhIGNtb3YgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3Nl
MiBzcyBodCB0bSBwYmUgbnggY29uc3RhbnRfdHNjIGJ0cyBwbmkgbW9uaXRvciB2bXggZXN0IHRt
MiB4dHByIGR0cwpib2dvbWlwcwk6IDM2NjYuMTYKY2xmbHVzaCBzaXplCTogNjQKY2FjaGVfYWxp
Z25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDM2IGJpdHMgcGh5c2ljYWwsIDMyIGJpdHMgdmly
dHVhbApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogMwp2ZW5kb3JfaWQJOiBHZW51aW5l
SW50ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMTQKbW9kZWwgbmFtZQk6IEludGVsKFIpIER1
YWwgUGVudGl1bShSKSBNIENQVSAgIDAwMCAgQCAxLjgzR0h6CnN0ZXBwaW5nCTogNApjcHUgTUh6
CQk6IDk5Ni4wMDAKY2FjaGUgc2l6ZQk6IDIwNDggS0IKcGh5c2ljYWwgaWQJOiAzCnNpYmxpbmdz
CTogMgpjb3JlIGlkCQk6IDEKY3B1IGNvcmVzCTogMgphcGljaWQJCTogNwppbml0aWFsIGFwaWNp
ZAk6IDcKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5vCmYwMGZfYnVnCTogbm8KY29tYV9idWcJ
OiBubwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiA2CndwCQk6
IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2Vw
IG10cnIgcGdlIG1jYSBjbW92IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNz
ZTIgc3MgaHQgdG0gcGJlIG54IGNvbnN0YW50X3RzYyBidHMgcG5pIG1vbml0b3Igdm14IGVzdCB0
bTIgeHRwciBkdHMKYm9nb21pcHMJOiAzNjY2LjE2CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2Fs
aWdubWVudAk6IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzNiBiaXRzIHBoeXNpY2FsLCAzMiBiaXRzIHZp
cnR1YWwKcG93ZXIgbWFuYWdlbWVudDoKCg==

--=_fa66d15a-a5ea-4f91-a76b-bb839cc5df02
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=_fa66d15a-a5ea-4f91-a76b-bb839cc5df02--
