From: Andy Poling <poling@econnectix.com>
Date: Fri, 12 Dec 2008 21:45:35 +0000
Subject: Re: [lm-sensors] sensord exits on any error
Message-Id: <alpine.DEB.2.00.0812121519170.9967@andydesk.realbig.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="658177-1136499035-1229118341=:9967"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
In-Reply-To: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658177-1136499035-1229118341=:9967
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Fri, 12 Dec 2008, Jean Delvare wrote:
>> I'll put together updated patches for sensord and the w83793 driver and send
>> them to the list.
>
> Any news from the sensord patch? I am waiting for it before I release
> lm-sensors 2.10.8, and I'd really like to release it before I leave for
> vacation.

My apologies - for some reason I was holding this until we also had the
updated patch for w83793.c ready.

It is kind of embarrassingly simple.  I hope a unified diff is acceptable.

-Andy
--658177-1136499035-1229118341=:9967
Content-Type: IMAGE/x-coreldrawpattern; name=sensord.c.pat
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.0812121545350.9967@andydesk.realbig.com>
Content-Description: sensord.c.pat
Content-Disposition: attachment; filename=sensord.c.pat

LS0tIHNlbnNvcmQuYy5vcmlnCTIwMDgtMTItMTIgMTU6MjQ6MzYuMTMzMzY0
MTAzIC0wNjAwCisrKyBzZW5zb3JkLmMJMjAwOC0xMi0xMiAxNTozOToxNS43
NjQzNjIyODAgLTA2MDAKQEAgLTg1LDI3ICs4NSwyOSBAQAogCiAgIHNlbnNv
ckxvZyAoTE9HX0lORk8sICJzZW5zb3JkIHN0YXJ0ZWQiKTsKIAotICB3aGls
ZSAoIWRvbmUgJiYgKHJldCA9PSAwKSkgewotICAgIGlmIChyZXQgPT0gMCkK
LSAgICAgIHJldCA9IHJlbG9hZExpYiAoKTsKKyAgd2hpbGUgKCFkb25lKSB7
CisgICAgcmV0ID0gcmVsb2FkTGliICgpOwogICAgIGlmICgocmV0ID09IDAp
ICYmIHNjYW5UaW1lKSB7IC8qIHNob3VsZCBJIHNjYW4gb24gdGhlIHJlYWQg
Y3ljbGU/ICovCi0gICAgICByZXQgPSBzY2FuQ2hpcHMgKCk7CisgICAgICBp
ZiAoKHJldCA9IHNjYW5DaGlwcyAoKSkpCisgICAgICAgIHN5c2xvZyhMT0df
Tk9USUNFLCAic2Vuc29yIHNjYW4gZXJyb3I6ICVtIik7CiAgICAgICBpZiAo
c2NhblZhbHVlIDw9IDApCiAgICAgICAgIHNjYW5WYWx1ZSArPSBzY2FuVGlt
ZTsKICAgICB9CiAgICAgaWYgKChyZXQgPT0gMCkgJiYgbG9nVGltZSAmJiAo
bG9nVmFsdWUgPD0gMCkpIHsKLSAgICAgIHJldCA9IHJlYWRDaGlwcyAoKTsK
KyAgICAgIGlmICgocmV0ID0gcmVhZENoaXBzICgpKSkKKyAgICAgICAgc3lz
bG9nKExPR19OT1RJQ0UsICJzZW5zb3IgcmVhZCBlcnJvcjogJW0iKTsKICAg
ICAgIGxvZ1ZhbHVlICs9IGxvZ1RpbWU7CiAgICAgfQogICAgIGlmICgocmV0
ID09IDApICYmIHJyZFRpbWUgJiYgcnJkRmlsZSAmJiAocnJkVmFsdWUgPD0g
MCkpIHsKLSAgICAgIHJldCA9IHJyZFVwZGF0ZSAoKTsKKyAgICAgIGlmICgo
cmV0ID0gcnJkVXBkYXRlICgpKSkKKyAgICAgICAgc3lzbG9nKExPR19OT1RJ
Q0UsICJycmQgdXBkYXRlIGVycm9yOiAlbSIpOwogICAgICAgLyoKICAgICAg
ICAqIFRoZSBhbW91bnQgb2YgdGltZSB0byB3YWl0IGlzIGNvbXB1dGVkIHVz
aW5nIHRoZSBzYW1lIG1ldGhvZCBhcwogICAgICAgICogaW4gUlJEIGluc3Rl
YWQgb2Ygc2ltcGx5IGFkZGluZyB0aGUgaW50ZXJ2YWwuCiAgICAgICAgKi8K
ICAgICAgIHJyZFZhbHVlID0gcnJkVGltZSAtIHRpbWUoTlVMTCkgJSBycmRU
aW1lOwogICAgIH0KLSAgICBpZiAoIWRvbmUgJiYgKHJldCA9PSAwKSkgewor
ICAgIGlmICghZG9uZSkgewogICAgICAgaW50IGEgPSBsb2dUaW1lID8gbG9n
VmFsdWUgOiBJTlRfTUFYOwogICAgICAgaW50IGIgPSBzY2FuVGltZSA/IHNj
YW5WYWx1ZSA6IElOVF9NQVg7CiAgICAgICBpbnQgYyA9IChycmRUaW1lICYm
IHJyZEZpbGUpID8gcnJkVmFsdWUgOiBJTlRfTUFYOwpAQCAtMTE3LDEwICsx
MTksNyBAQAogICAgIH0KICAgfQogCi0gIGlmIChyZXQpCi0gICAgc2Vuc29y
TG9nIChMT0dfSU5GTywgInNlbnNvcmQgZmFpbGVkICglZCkiLCByZXQpOwot
ICBlbHNlCi0gICAgc2Vuc29yTG9nIChMT0dfSU5GTywgInNlbnNvcmQgc3Rv
cHBlZCIpOworICBzZW5zb3JMb2cgKExPR19JTkZPLCAic2Vuc29yZCBzdG9w
cGVkIik7CiAKICAgcmV0dXJuIHJldDsKIH0K

--658177-1136499035-1229118341=:9967
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--658177-1136499035-1229118341=:9967--
