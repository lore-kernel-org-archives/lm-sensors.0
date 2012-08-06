From: =?UTF-8?B?TWljaGHFgiBQaW90cm93c2tp?= <michal@eventhorizon.pl>
Date: Mon, 06 Aug 2012 14:23:04 +0000
Subject: Re: [lm-sensors] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <501FD348.20602@eventhorizon.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010104040408090507090309"
List-Id: <lm-sensors.vger.kernel.org>
References: <20120806140716.GA26589@roeck-us.net>
In-Reply-To: <20120806140716.GA26589@roeck-us.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010104040408090507090309
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

W dniu 2012-08-06 16:07, Guenter Roeck pisze:
> On Mon, Aug 06, 2012 at 10:02:03AM +0200, Michał Piotrowski wrote:
>> Hi,
>>
>> Commit 41e58a1f2b90c88d94b4bd84beb9927a4c2704e9
>>
>> +       { "CPU  330", 125000 },
>>
>> I belive that value for Atom 330 should be 85000 instead of 125000.
>> Please see Tcase in spec
>> http://ark.intel.com/products/35641/Intel-Atom-Processor-330-(1M-Cache-1_60-GHz-533-MHz-FSB)
>>
> That is Tcase, not Tjmax.

I had the impression that both are the same.

>
> Tjmax is supposed to be 125 for Atom 330. Of course, with Intel, who knows;
> maybe they have variants with different Tjmax. Can you provide the output of
> /proc/cpuinfo ?

Attached.

>
> Thanks,
> Guenter
>
>> This patch series resulted in a significant increase in temperature
>> on my development server ;)
>>
>> 3.4.6-2.fc17.x86_64
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:       +42.0°C  (crit = +90.0°C)
>> Core 1:       +49.0°C  (crit = +90.0°C)
>>
>>
>>
>> 3.5.0-2.fc17.x86_64
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:       +77.0°C  (crit = +125.0°C)
>> Core 1:       +84.0°C  (crit = +125.0°C)
>>
>> --
>> Best regards,
>> Michal
>>
>> http://eventhorizon.pl/
>>


-- 
Best regards,
Michal

http://eventhorizon.pl/

--------------010104040408090507090309
Content-Type: text/plain; charset=windows-1250;
 name="cpuinfo"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cpuinfo"

cHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYK
bW9kZWwJCTogMjgKbW9kZWwgbmFtZQk6IEludGVsKFIpIEF0b20oVE0pIENQVSAgMzMwICAg
QCAxLjYwR0h6CnN0ZXBwaW5nCTogMgptaWNyb2NvZGUJOiAweDIxOQpjcHUgTUh6CQk6IDE1
OTkuOTk2CmNhY2hlIHNpemUJOiA1MTIgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTog
NApjb3JlIGlkCQk6IDAKY3B1IGNvcmVzCTogMgphcGljaWQJCTogMAppbml0aWFsIGFwaWNp
ZAk6IDAKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMTAK
d3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDgg
YXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4
c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggbG0gY29uc3RhbnRfdHNjIGFy
Y2hfcGVyZm1vbiBwZWJzIGJ0cyBub3BsIGFwZXJmbXBlcmYgcG5pIGR0ZXM2NCBtb25pdG9y
IGRzX2NwbCB0bTIgc3NzZTMgY3gxNiB4dHByIHBkY20gbW92YmUgbGFoZl9sbSBkdGhlcm0K
Ym9nb21pcHMJOiAzMTkyLjI0CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVudAk6
IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzMiBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwK
cG93ZXIgbWFuYWdlbWVudDoKCnByb2Nlc3Nvcgk6IDEKdmVuZG9yX2lkCTogR2VudWluZUlu
dGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDI4Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBB
dG9tKFRNKSBDUFUgIDMzMCAgIEAgMS42MEdIegpzdGVwcGluZwk6IDIKbWljcm9jb2RlCTog
MHgyMTkKY3B1IE1IegkJOiAxNTk5Ljk5NgpjYWNoZSBzaXplCTogNTEyIEtCCnBoeXNpY2Fs
IGlkCTogMApzaWJsaW5ncwk6IDQKY29yZSBpZAkJOiAxCmNwdSBjb3Jlcwk6IDIKYXBpY2lk
CQk6IDIKaW5pdGlhbCBhcGljaWQJOiAyCmZwdQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHll
cwpjcHVpZCBsZXZlbAk6IDEwCndwCQk6IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0
c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBjbGZs
dXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0IHRtIHBiZSBzeXNjYWxsIG54
IGxtIGNvbnN0YW50X3RzYyBhcmNoX3BlcmZtb24gcGVicyBidHMgbm9wbCBhcGVyZm1wZXJm
IHBuaSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdG0yIHNzc2UzIGN4MTYgeHRwciBwZGNtIG1v
dmJlIGxhaGZfbG0gZHRoZXJtCmJvZ29taXBzCTogMzE5Mi4yNApjbGZsdXNoIHNpemUJOiA2
NApjYWNoZV9hbGlnbm1lbnQJOiA2NAphZGRyZXNzIHNpemVzCTogMzIgYml0cyBwaHlzaWNh
bCwgNDggYml0cyB2aXJ0dWFsCnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiAyCnZl
bmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAyOAptb2Rl
bCBuYW1lCTogSW50ZWwoUikgQXRvbShUTSkgQ1BVICAzMzAgICBAIDEuNjBHSHoKc3RlcHBp
bmcJOiAyCm1pY3JvY29kZQk6IDB4MjE5CmNwdSBNSHoJCTogMTU5OS45OTYKY2FjaGUgc2l6
ZQk6IDUxMiBLQgpwaHlzaWNhbCBpZAk6IDAKc2libGluZ3MJOiA0CmNvcmUgaWQJCTogMApj
cHUgY29yZXMJOiAyCmFwaWNpZAkJOiAxCmluaXRpYWwgYXBpY2lkCTogMQpmcHUJCTogeWVz
CmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAxMAp3cAkJOiB5ZXMKZmxhZ3MJ
CTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBn
ZSBtY2EgY21vdiBwYXQgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBo
dCB0bSBwYmUgc3lzY2FsbCBueCBsbSBjb25zdGFudF90c2MgYXJjaF9wZXJmbW9uIHBlYnMg
YnRzIG5vcGwgYXBlcmZtcGVyZiBwbmkgZHRlczY0IG1vbml0b3IgZHNfY3BsIHRtMiBzc3Nl
MyBjeDE2IHh0cHIgcGRjbSBtb3ZiZSBsYWhmX2xtIGR0aGVybQpib2dvbWlwcwk6IDMxOTIu
MjQKY2xmbHVzaCBzaXplCTogNjQKY2FjaGVfYWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXpl
cwk6IDMyIGJpdHMgcGh5c2ljYWwsIDQ4IGJpdHMgdmlydHVhbApwb3dlciBtYW5hZ2VtZW50
OgoKcHJvY2Vzc29yCTogMwp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6
IDYKbW9kZWwJCTogMjgKbW9kZWwgbmFtZQk6IEludGVsKFIpIEF0b20oVE0pIENQVSAgMzMw
ICAgQCAxLjYwR0h6CnN0ZXBwaW5nCTogMgptaWNyb2NvZGUJOiAweDIxOQpjcHUgTUh6CQk6
IDE1OTkuOTk2CmNhY2hlIHNpemUJOiA1MTIgS0IKcGh5c2ljYWwgaWQJOiAwCnNpYmxpbmdz
CTogNApjb3JlIGlkCQk6IDEKY3B1IGNvcmVzCTogMgphcGljaWQJCTogMwppbml0aWFsIGFw
aWNpZAk6IDMKZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTog
MTAKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBj
eDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IGNsZmx1c2ggZHRzIGFjcGkgbW14
IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggbG0gY29uc3RhbnRfdHNj
IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyBub3BsIGFwZXJmbXBlcmYgcG5pIGR0ZXM2NCBtb25p
dG9yIGRzX2NwbCB0bTIgc3NzZTMgY3gxNiB4dHByIHBkY20gbW92YmUgbGFoZl9sbSBkdGhl
cm0KYm9nb21pcHMJOiAzMTkyLjI0CmNsZmx1c2ggc2l6ZQk6IDY0CmNhY2hlX2FsaWdubWVu
dAk6IDY0CmFkZHJlc3Mgc2l6ZXMJOiAzMiBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1
YWwKcG93ZXIgbWFuYWdlbWVudDoKCg==
--------------010104040408090507090309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010104040408090507090309--
