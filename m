From: Jaromir Capik <jcapik@redhat.com>
Date: Thu, 25 Jul 2013 16:49:51 +0000
Subject: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_6909988_1225775452.1374770991356"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_6909988_1225775452.1374770991356
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello.

The attached patch fixes <STDIN> handling when the user
input is taken from /dev/null.
I know this way of generating the config is undocumented
and therefore unsupported, but it seems people use it
that way as the script doesn't support running in 
batch mode.

The patch was created for 3.3.4, but can be directly
applied on the latest sources too.

Please, merge the fix.

Thanks in advance.

Regards,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / BaseOS

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 



------=_Part_6909988_1225775452.1374770991356
Content-Type: text/x-patch;
 name=lm_sensors-3.3.4-sensors-detect-null-input.patch
Content-Disposition: attachment;
 filename=lm_sensors-3.3.4-sensors-detect-null-input.patch
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1ciBsbV9zZW5zb3JzLTMuMy40Lm9yaWcvcHJvZy9kZXRlY3Qvc2Vuc29ycy1kZXRl
Y3QgbG1fc2Vuc29ycy0zLjMuNC9wcm9nL2RldGVjdC9zZW5zb3JzLWRldGVjdAotLS0gbG1fc2Vu
c29ycy0zLjMuNC5vcmlnL3Byb2cvZGV0ZWN0L3NlbnNvcnMtZGV0ZWN0CTIwMTMtMDUtMjAgMjE6
MjU6MjIuMDAwMDAwMDAwICswMjAwCisrKyBsbV9zZW5zb3JzLTMuMy40L3Byb2cvZGV0ZWN0L3Nl
bnNvcnMtZGV0ZWN0CTIwMTMtMDctMjUgMTg6MjQ6NDEuNjM2ODA3NDEwICswMjAwCkBAIC0zNzA3
LDcgKzM3MDcsNyBAQAogCSAgICAgICAiRG8geW91IHdhbnQgdG8gc2NhbiBpdD8gKFwlcy9zZWxl
Y3RpdmVseSk6ICIsCiAJICAgICAgICRkZWZhdWx0ID8gIllFUy9ubyIgOiAieWVzL05PIjsKIAot
CSRpbnB1dCA9IDxTVERJTj47CisJJGlucHV0ID0gPFNURElOPiB8fCAnJzsKIAlpZiAoJGlucHV0
ID1+IC9eXHMqbi9pCiAJIHx8ICghJGRlZmF1bHQgJiYgJGlucHV0ICF+IC9eXHMqW3lzXS9pKSkg
ewogCQlwcmludCAiXG4iOwpAQCAtMzcxOCw3ICszNzE4LDcgQEAKIAkJcHJpbnQgIlBsZWFzZSBl
bnRlciBvbmUgb3IgbW9yZSBhZGRyZXNzZXMgbm90IHRvIHNjYW4uIFNlcGFyYXRlIHRoZW0gd2l0
aCBjb21tYXMuXG4iLAogCQkgICAgICAiWW91IGNhbiBzcGVjaWZ5IGEgcmFuZ2UgYnkgdXNpbmcg
ZGFzaGVzLiBFeGFtcGxlOiAweDU4LTB4NWYsMHg2OS5cbiIsCiAJCSAgICAgICJBZGRyZXNzZXM6
ICI7Ci0JCSRpbnB1dCA9IDxTVERJTj47CisJCSRpbnB1dCA9IDxTVERJTj4gfHwgJyc7CiAJCWNo
b21wKCRpbnB1dCk7CiAJCUBub3RfdG9fc2NhbiA9IHBhcnNlX25vdF90b19zY2FuKDB4MDMsIDB4
NzcsICRpbnB1dCk7CiAJfSBlbHNpZiAoKCRjbGFzcyAmIDB4ZmYwMCkgPT0gMHgwMzAwKSB7CkBA
IC02ODU5LDcgKzY4NTksNyBAQAogCQkgICAgICAgInNhZmUgdGhvdWdoLiBZZXMsIHlvdSBkbyBo
YXZlIElTQSBJL08gcG9ydHMgZXZlbiBpZiB5b3UgZG8gbm90IGhhdmUgYW55XG4iLgogCQkgICAg
ICAgIklTQSBzbG90cyEgRG8geW91IHdhbnQgdG8gc2NhbiB0aGUgSVNBIEkvTyBwb3J0cz8gKFwl
cyk6ICIsCiAJCSAgICAgICAkc3VwZXJpb19mZWF0dXJlcyA/ICJ5ZXMvTk8iIDogIllFUy9ubyI7
Ci0JCSRpbnB1dCA9IDxTVERJTj47CisJCSRpbnB1dCA9IDxTVERJTj4gfHwgJyc7CiAJCXVubGVz
cyAoJGlucHV0ID1+IC9eXHMqbi9pCiAJCSAgICAgfHwgKCRzdXBlcmlvX2ZlYXR1cmVzICYmICRp
bnB1dCAhfiAvXlxzKnkvaSkpIHsKIAkJCWlmIChpbml0aWFsaXplX2lvcG9ydHMoKSkgewo=
------=_Part_6909988_1225775452.1374770991356
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_6909988_1225775452.1374770991356--
