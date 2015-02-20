From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Date: Fri, 20 Feb 2015 15:07:34 +0000
Subject: [lm-sensors] [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
Message-Id: <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

SGVsbG8gIQoKVGhlc2UgcGF0Y2hlcyByZXdvcmsgdGhlIGlibXBvd2VybnYgZHJpdmVyIHRvIHN1
cHBvcnQgdGhlIG5ldyBkZXZpY2UgCnRyZWUgYXMgcHJvcG9zZWQgYnkgdGhpcyBwYXRjaHNldCBv
biB0aGUgc2tpYm9vdCBtYWlsaW5nIGxpc3QgOgoKICBodHRwczovL2xpc3RzLm96bGFicy5vcmcv
cGlwZXJtYWlsL3NraWJvb3QvMjAxNS1GZWJydWFyeS8wMDA0NTcuaHRtbAoKVGhleSBhcmUgYmFz
ZWQgb24gTGludXggMy4xOSBhbmQgd2VyZSB0ZXN0ZWQgb24gSUJNIFBvd2VyIGFuZCBPcGVuIFBv
d2VyIApzeXN0ZW1zIHJ1bm5pbmcgdHJ1c3R5LgoKVGhlIG1haW4gaXNzdWUgaXMgdGhhdCB0aGUg
bmV3IGRldmljZSB0cmVlIGlzIGluY29tcGF0aWJsZSB3aXRoIHRoZSAKcHJldmlvdXMgaWJtcG93
ZXJudiBkcml2ZXJzLiBUaGUgY29uc2VxdWVuY2UgaXMgbm8gcG93ZXJudiBzZW5zb3JzIApvbiBz
eXN0ZW1zIHdpdGggc3VjaCBhIG9wYWwvbGludXggY29uZmlndXJhdGlvbi4KCkNoZWVycywKCkMu
CgoKQ8OpZHJpYyBMZSBHb2F0ZXIgKDMpOgogIHBvd2VycGMvcG93ZXJudjogQ2hlY2sgT1BBTCBz
ZW5zb3IgY2FsbHMgZXhpc3QKICBwb3dlcnBjL3Bvd2VybnY6IGhhbmRsZSBPUEFMX1NVQ0NFU1Mg
cmV0dXJuIGluIG9wYWxfc2Vuc29yX3JlYWQKICBod21vbjogKGlibXBvd2VybnYpIGFkZCBEVFMg
c3VwcG9ydAoKIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLXNlbnNvci5jIHwg
ICAzMiArKy0KIGRyaXZlcnMvaHdtb24vaWJtcG93ZXJudi5jICAgICAgICAgICAgICAgICAgIHwg
IDMzNiArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyMDIgaW5z
ZXJ0aW9ucygrKSwgMTY2IGRlbGV0aW9ucygtKQoKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbG0tc2Vuc29ycyBtYWlsaW5nIGxp
c3QKbG0tc2Vuc29yc0BsbS1zZW5zb3JzLm9yZwpodHRwOi8vbGlzdHMubG0tc2Vuc29ycy5vcmcv
bWFpbG1hbi9saXN0aW5mby9sbS1zZW5zb3Jz
