From: David Kremer <david@david-kremer.fr>
Date: Wed, 14 Mar 2012 18:53:38 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <4F60E932.4060207@david-kremer.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000007090206040905060909"
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007090206040905060909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> The NCT chip supports it, and it works pretty well on my system (with
> NCT6775F). It is enabled if pwmX_enable is set to 5 after you
> force-loaded the w83627ehf module.
>
> I am working on an enhanced version of the nct6775/nct6776 driver which
> will let you configure automatic fan control. It is on github, so you
> could give it a try if you like (https://github.com/groeck/nct6775).
>
> Guenter
>
Thank you Guenter.

I slightly modified your makefile to make it suits the
archlinux installation.

See the attached patch.

Can you tell me if it's correct ?
<http://www.federationyoga.qc.ca/page-respiration.html>
<http://www.federationyoga.qc.ca/page-respiration.html>

--------------000007090206040905060909
Content-Type: text/plain;
 name="patch-makefile.p0"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-makefile.p0"

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggZjBmM2JkNS4uODM4MWYy
NSAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTEsMTQgKzEsMTQg
QEAKICMgRm9yIGJ1aWxkaW5nIGZvciB0aGUgY3VycmVudCBydW5uaW5nIHZlcnNpb24gb2Yg
TGludXgKIFRBUkdFVAkJOj0gJChzaGVsbCB1bmFtZSAtcikKLUhPTUU9JChzaGVsbCBwd2Qp
CitIT01FICAgICAgICAgICAgOj0gJChzaGVsbCBwd2QpCiAjIE9yIGZvciBhIHNwZWNpZmlj
IHZlcnNpb24KICNUQVJHRVQJCTo9IDIuNi4zMy41CiBLRVJORUxfTU9EVUxFUwk6PSAvbGli
L21vZHVsZXMvJChUQVJHRVQpCiAjIEtFUk5FTF9CVUlMRAk6PSAkKEtFUk5FTF9NT0RVTEVT
KS9idWlsZAotS0VSTkVMX0JVSUxECTo9IC91c3Ivc3JjL2xpbnV4LWhlYWRlcnMtJChUQVJH
RVQpCitLRVJORUxfQlVJTEQJOj0gL3Vzci9zcmMvbGludXgtJChUQVJHRVQpCiAKICNTWVNU
RU1fTUFQCTo9ICQoS0VSTkVMX0JVSUxEKS9TeXN0ZW0ubWFwCi1TWVNURU1fTUFQCTo9IC9i
b290L1N5c3RlbS5tYXAtJChUQVJHRVQpCitTWVNURU1fTUFQCTo9IC9saWIvbW9kdWxlcy8k
KFRBUkdFVCkvYnVpbGQvTW9kdWxlLnN5bXZlcnMKIAogRFJJVkVSIDo9IG5jdDY3NzUKIApA
QCAtMzMsNCArMzMsNCBAQCBpbnN0YWxsOiBtb2R1bGVzX2luc3RhbGwKIAogbW9kdWxlc19p
bnN0YWxsOgogCWNwICQoRFJJVkVSKS5rbyAkKEtFUk5FTF9NT0RVTEVTKS9rZXJuZWwvJChN
T0RfU1VCRElSKQotCWRlcG1vZCAtYSAtRiAkKFNZU1RFTV9NQVApICQoVEFSR0VUKQorCWRl
cG1vZCAtYSAtRSAkKFNZU1RFTV9NQVApICQoVEFSR0VUKQo=
--------------000007090206040905060909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000007090206040905060909--
