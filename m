From: Jaromir Capik <jcapik@redhat.com>
Date: Tue, 10 Sep 2013 11:37:54 +0000
Subject: [lm-sensors] [PATCH] sensors-detect : Fixing use of uninitialised value 'vendor_id' on ppc64
Message-Id: <1301926956.10694212.1378813074661.JavaMail.root@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_10694210_1044517163.1378813074659"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_10694210_1044517163.1378813074659
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello.

There's no vendor_id entry in the /proc/cpuinfo file in case of PPC64
systems and consequently the script returns 3 screens full of the
following errors:

Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6444
Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6459
Use of uninitialized value in string eq at /usr/sbin/sensors-detect line 6473

The attached patch fixes that.

Please, merge.

Thanks in advance.

Regards,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / Secondary Arch

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 



------=_Part_10694210_1044517163.1378813074659
Content-Type: text/x-patch;
 name=lm_sensors-3.3.4-sensors-detect-ppc-missing-vendor_id.patch
Content-Disposition: attachment;
 filename=lm_sensors-3.3.4-sensors-detect-ppc-missing-vendor_id.patch
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1ciBsbV9zZW5zb3JzLTMuMy40Lm9yaWcvcHJvZy9kZXRlY3Qvc2Vuc29ycy1kZXRl
Y3QgbG1fc2Vuc29ycy0zLjMuNC9wcm9nL2RldGVjdC9zZW5zb3JzLWRldGVjdAotLS0gbG1fc2Vu
c29ycy0zLjMuNC5vcmlnL3Byb2cvZGV0ZWN0L3NlbnNvcnMtZGV0ZWN0CTIwMTMtMDgtMDcgMDk6
NDY6NTkuMDAwMDAwMDAwIC0wNDAwCisrKyBsbV9zZW5zb3JzLTMuMy40L3Byb2cvZGV0ZWN0L3Nl
bnNvcnMtZGV0ZWN0CTIwMTMtMDktMDkgMTM6NTk6MDkuNzUzMjY2MDMzIC0wNDAwCkBAIC0yNjU3
LDYgKzI2NTcsNyBAQAogCQlpZiAobS9ecHJvY2Vzc29yXHMqOlxzKihcZCspLykgewogCQkJcHVz
aCBAY3B1LCAkZW50cnkgaWYgc2NhbGFyIGtleXMoJXskZW50cnl9KTsgIyBQcmV2aW91cyBlbnRy
eQogCQkJJGVudHJ5ID0geyBuciA9PiAkMSB9OyAjIE5ldyBlbnRyeQorCQkJJGVudHJ5LT57dmVu
ZG9yX2lkfSA9ICJ1bmRlZmluZWQiOwogCQkJbmV4dDsKIAkJfQogCQlpZiAobS9eKHZlbmRvcl9p
ZHxjcHUgZmFtaWx5fG1vZGVsfG1vZGVsIG5hbWV8c3RlcHBpbmd8Y3B1aWQgbGV2ZWwpXHMqOlxz
KiguKykkLykgewo=
------=_Part_10694210_1044517163.1378813074659
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_10694210_1044517163.1378813074659--
