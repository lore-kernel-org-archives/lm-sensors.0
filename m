From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Date: Wed, 01 Apr 2015 10:15:02 +0000
Subject: [lm-sensors] [PATCH 0/4]  hwmon: (ibmpowernv) add DTS support
Message-Id: <1427883306-32528-1-git-send-email-clg@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, Jean Delvare <jdelvare@suse.de>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>

SGVsbG8gIQoKVGhlc2UgcGF0Y2hlcyBleHRlbmQgdGhlIGlibXBvd2VybnYgZHJpdmVyIHRvIHN1
cHBvcnQgdGhlIG5ldyBPUEFMIGZpcm13YXJlIAp3aGljaCBub3cgZXhwb3NlcyBpbiBpdHMgZGV2
aWNlIHRyZWUgdGhlIERpZ2l0YWwgVGVtcGVyYXR1cmUgU2Vuc29ycyBvZiAKYSBQOCBzeXN0ZW0u
CgpUaGV5IGFyZSBiYXNlZCBvbiBMaW51eCA0LjAuMC1yYzYgKyB0aGUgaW5pdGlhbCBjbGVhbnVw
IHNlcmllIDoKCiAgICAgaHR0cDovL2xpc3RzLmxtLXNlbnNvcnMub3JnL3BpcGVybWFpbC9sbS1z
ZW5zb3JzLzIwMTUtTWFyY2gvMDQzNjcwLmh0bWwKCmFuZCB3ZXJlIHRlc3RlZCBvbiBJQk0gUG93
ZXIgYW5kIE9wZW4gUG93ZXIgc3lzdGVtcyBydW5uaW5nIFRydXN0eS4KCkNoZWVycywKCkMuCgpD
w6lkcmljIExlIEdvYXRlciAoNCk6CiAgaHdtb246IChpYm1wb3dlcm52KSBhZGQgYSBoZWxwZXIg
cm91dGluZSBjcmVhdGVfaHdtb25fYXR0cgogIGh3bW9uOiAoaWJtcG93ZXJudikgYWRkIHN1cHBv
cnQgZm9yIHRoZSBuZXcgZGV2aWNlIHRyZWUKICBod21vbjogKGlibXBvd2VybnYpIGFkZCBhIGxh
YmVsIGF0dHJpYnV0ZQogIGh3bW9uOiAoaWJtcG93ZXJudikgcHJldHR5IHByaW50IGxhYmVscwoK
IGRyaXZlcnMvaHdtb24vaWJtcG93ZXJudi5jIHwgIDE0MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCsp
LCAxOCBkZWxldGlvbnMoLSkKCi0tIAoxLjcuMTAuNAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxtLXNlbnNvcnMgbWFpbGluZyBsaXN0CmxtLXNlbnNv
cnNAbG0tc2Vuc29ycy5vcmcKaHR0cDovL2xpc3RzLmxtLXNlbnNvcnMub3JnL21haWxtYW4vbGlz
dGluZm8vbG0tc2Vuc29ycw=
