From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Date: Fri, 20 Feb 2015 15:07:35 +0000
Subject: [lm-sensors] [RFC PATCH 1/3] powerpc/powernv: Check OPAL sensor calls exist
Message-Id: <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0Bmci5pYm0uY29tPgotLS0KIGFy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLXNlbnNvci5jIHwgICAgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1zZW5zb3IuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cG93ZXJudi9vcGFsLXNlbnNvci5jCmluZGV4IDRhYjY3ZWY3YWJjOS4uNTQ0MjkyZjIwMjBmIDEw
MDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1zZW5zb3IuYwor
KysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1zZW5zb3IuYwpAQCAtNzIs
NiArNzIsOSBAQCBzdGF0aWMgX19pbml0IGludCBvcGFsX3NlbnNvcl9pbml0KHZvaWQpCiAJc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnNlbnNvcjsK
IAorCWlmICghb3BhbF9jaGVja190b2tlbihPUEFMX1NFTlNPUl9SRUFEKSkKKwkJcmV0dXJuIC1F
Tk9ERVY7CisKIAlzZW5zb3IgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiL2libSxvcGFsL3NlbnNv
cnMiKTsKIAlpZiAoIXNlbnNvcikgewogCQlwcl9lcnIoIk9wYWwgbm9kZSAnc2Vuc29ycycgbm90
IGZvdW5kXG4iKTsKLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbG0tc2Vuc29ycyBtYWlsaW5nIGxpc3QKbG0tc2Vuc29yc0BsbS1z
ZW5zb3JzLm9yZwpodHRwOi8vbGlzdHMubG0tc2Vuc29ycy5vcmcvbWFpbG1hbi9saXN0aW5mby9s
bS1zZW5zb3Jz
