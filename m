From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 16 Apr 2008 16:07:02 +0000
Subject: Re: [lm-sensors] AMD K10 (Phenom) Sensor Module
Message-Id: <48062426.5040603@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060203090905070201080504"
List-Id: <lm-sensors.vger.kernel.org>
References: <47642FDA.6000801@cox.net>
In-Reply-To: <47642FDA.6000801@cox.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060203090905070201080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fred,

I think we can CC the list too, so others know that we work on this. I'm CCing 
some people which got interrested too.

> Now I'm down to the specifics peculiar to the k10 family.  I see that 
> the calculation for CurTmp is different for k10,
> but am a bit confused on the core selection code as pertains to the k10 
> and a bit lost in the AMD BKDG.  Seems to
> be a bit of conflict on how many sensors there are (1 vs. 4).  It also 

I think it is just one, It might be undocumented for any other sensors.

> appears that the k10 reports a relative temp rather
> than an absolute (referenced to 49) like the k8's did.

Yes the temperature is just non-physical. So to make the driver sense we need to 
know the MAX value. The thermal guide is still not published, but Jordan is 
hopefully still trying ;) There is some suspicion that it is 70C (TControlMAX 
from older processor family).

I'm trying too, but now I want to get sorted some errata problems - k8temps are 
sometimes wrong. Btw all K10 processors still suffers from errata 319 Inaccurate 
Temperature Measurement

Description
The internal thermal sensor used for CurTmp (F3xA4[31:21]), hardware thermal 
control (HTC), software thermal control (STC), and the sideband temperature 
sensor interface (SB-TSI) may report inconsistent values.


So question is if to go for the driver at all :/

> Eventually, I was thinking that this driver should be called kxtemp, or 
> something similar and support both k8/k10.
> There would need to be a bit more work on CPUID, but that shouldn't be 
> too difficult.  Anyway, as an example, I have:
> 
>    #define TEMP_FROM_REG_K08(val)   (((((val) >> 16) & 0xff) - 49) * 1000)
>    #define TEMP_FROM_REG_K10(val)   (((((val) >> 16) & 0xff) /  8) * 1000)

Hmm the reg is 0xA4 and temp is in bits 31:21 so perhaps >>16 is wrong too?

> Haven't subscribed to lm-sensors since it appears that you are basically 
> the only one working on this.  I need some guidance,
> but am willing to help.  Am an old (rusty) kernel hacker, though have 
> not played with CPU/NB registers before.  Mostly
> peripheral drivers and tcp/ip stack code tuning.

Well never mind I can certainly help.

> Look forward to working with you on this,

Question is if we can go just for one driver, it depends on amount of changes.
I'm attaching some striped down version driver, which MIGHT work. Quick hack, 
but well will see.

Just replace your k8temp.c with one attached and recompile kernel. Run 
sufficiently knew 'sensors' command, maybe it will print something useful ;)

Thanks,
Rudolf


--------------060203090905070201080504
Content-Type: application/octet;
 name="k8temp.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="k8temp.c"

LyoKICogazEwdGVtcC5jIC0gTGludXgga2VybmVsIG1vZHVsZSBmb3IgaGFyZHdhcmUgbW9u
aXRvcmluZwogKgogKiBDb3B5cmlnaHQgKEMpIDIwMDggUnVkb2xmIE1hcmVrIDxyLm1hcmVr
QGFzc2VtYmxlci5jej4KICoKICogSW5zcGlyZWQgZnJvbSB0aGUgazh0ZW1wIGRyaXZlci4K
ICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICogdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IK
ICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogVGhpcyBwcm9n
cmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
CiAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVk
IHdhcnJhbnR5IG9mCiAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
Zm9yIG1vcmUgZGV0YWlscy4KICoKICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKICogYWxvbmcgd2l0aCB0aGlz
IHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKICogRm91bmRh
dGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QQogKiAwMjExMC0xMzAxIFVTQS4KICovCgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPgojaW5jbHVkZSA8bGludXgvaW5pdC5oPgojaW5jbHVk
ZSA8bGludXgvc2xhYi5oPgojaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgojaW5jbHVkZSA8
bGludXgvcGNpLmg+CiNpbmNsdWRlIDxsaW51eC9od21vbi5oPgojaW5jbHVkZSA8bGludXgv
aHdtb24tc3lzZnMuaD4KI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgojaW5jbHVkZSA8bGludXgv
bXV0ZXguaD4KCi8qIDEwMDAgLyA4ID0gMTI1IG5vIG1hc2sgYmVjYXVzZSB3ZSBzaGlmdCBm
cm9tIGJpdCAzMSAqLwojZGVmaW5lIFRFTVBfRlJPTV9SRUcodmFsKQkoKCh2YWwpID4+IDIx
KSAqIDEyNSkKI2RlZmluZSBSRUdfVEVNUAkweGE0CgpzdHJ1Y3QgazEwdGVtcF9kYXRhIHsK
CXN0cnVjdCBkZXZpY2UgKmh3bW9uX2RldjsKCXN0cnVjdCBtdXRleCB1cGRhdGVfbG9jazsK
CWNvbnN0IGNoYXIgKm5hbWU7CgljaGFyIHZhbGlkOwkJLyogemVybyB1bnRpbCBmb2xsb3dp
bmcgZmllbGRzIGFyZSB2YWxpZCAqLwoJdW5zaWduZWQgbG9uZyBsYXN0X3VwZGF0ZWQ7CS8q
IGluIGppZmZpZXMgKi8KCgkvKiByZWdpc3RlcnMgdmFsdWVzICovCgl1MzIgdGVtcDsJCS8q
IHJhdyB2YWx1ZSAqLwp9OwoKc3RhdGljIHN0cnVjdCBrMTB0ZW1wX2RhdGEgKmsxMHRlbXBf
dXBkYXRlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpCnsKCXN0cnVjdCBrMTB0ZW1wX2Rh
dGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKCXN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gdG9fcGNpX2RldihkZXYpOwoJdTggdG1wOwoKCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0
ZV9sb2NrKTsKCglpZiAoIWRhdGEtPnZhbGlkCgkgICAgfHwgdGltZV9hZnRlcihqaWZmaWVz
LCBkYXRhLT5sYXN0X3VwZGF0ZWQgKyBIWikpIHsKCgoJCXBjaV9yZWFkX2NvbmZpZ19kd29y
ZChwZGV2LCBSRUdfVEVNUCwgJmRhdGEtPnRlbXApOwoKCQlkYXRhLT5sYXN0X3VwZGF0ZWQg
PSBqaWZmaWVzOwoJCWRhdGEtPnZhbGlkID0gMTsKCX0KCgltdXRleF91bmxvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKCXJldHVybiBkYXRhOwp9CgovKgogKiBTeXNmcyBzdHVmZgogKi8K
CnN0YXRpYyBzc2l6ZV90IHNob3dfbmFtZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBk
ZXZpY2VfYXR0cmlidXRlCgkJCSAqZGV2YXR0ciwgY2hhciAqYnVmKQp7CglzdHJ1Y3QgazEw
dGVtcF9kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7CgoJcmV0dXJuIHNwcmlu
dGYoYnVmLCAiJXNcbiIsIGRhdGEtPm5hbWUpOwp9CgoKc3RhdGljIHNzaXplX3Qgc2hvd190
ZW1wKHN0cnVjdCBkZXZpY2UgKmRldiwKCQkJIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpk
ZXZhdHRyLCBjaGFyICpidWYpCnsKCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZV8y
ICphdHRyID0KCSAgICB0b19zZW5zb3JfZGV2X2F0dHJfMihkZXZhdHRyKTsKCWludCBjb3Jl
ID0gYXR0ci0+bnI7CglpbnQgcGxhY2UgPSBhdHRyLT5pbmRleDsKCXN0cnVjdCBrMTB0ZW1w
X2RhdGEgKmRhdGEgPSBrMTB0ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2KTsKCglyZXR1cm4gc3By
aW50ZihidWYsICIlZFxuIiwKCQkgICAgICAgVEVNUF9GUk9NX1JFRyhkYXRhLT50ZW1wKSk7
Cn0KCi8qIGNvcmUsIHBsYWNlICovCgpzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSXzIodGVt
cDFfaW5wdXQsIFNfSVJVR08sIHNob3dfdGVtcCwgTlVMTCwgMCwgMCk7CnN0YXRpYyBERVZJ
Q0VfQVRUUihuYW1lLCBTX0lSVUdPLCBzaG93X25hbWUsIE5VTEwpOwoKc3RhdGljIHN0cnVj
dCBwY2lfZGV2aWNlX2lkIGsxMHRlbXBfaWRzW10gPSB7Cgl7IFBDSV9ERVZJQ0UoUENJX1ZF
TkRPUl9JRF9BTUQsIDB4MTIwMykgfSwKCXsgMCB9LAp9OwoKTU9EVUxFX0RFVklDRV9UQUJM
RShwY2ksIGsxMHRlbXBfaWRzKTsKCnN0YXRpYyBpbnQgX19kZXZpbml0IGsxMHRlbXBfcHJv
YmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCgkJCQkgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkICppZCkKewoJaW50IGVycjsKCXU4IHNjZmc7Cgl1MzIgdGVtcDsKCXN0cnVjdCBrMTB0
ZW1wX2RhdGEgKmRhdGE7CgoJaWYgKCEoZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBr
MTB0ZW1wX2RhdGEpLCBHRlBfS0VSTkVMKSkpIHsKCQllcnIgPSAtRU5PTUVNOwoJCWdvdG8g
ZXhpdDsKCX0KCglkYXRhLT5uYW1lID0gImsxMHRlbXAiOwoJbXV0ZXhfaW5pdCgmZGF0YS0+
dXBkYXRlX2xvY2spOwoJZGV2X3NldF9kcnZkYXRhKCZwZGV2LT5kZXYsIGRhdGEpOwoKCS8q
IFJlZ2lzdGVyIHN5c2ZzIGhvb2tzICovCgllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoJnBk
ZXYtPmRldiwKCQkJICAgJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9pbnB1dC5kZXZfYXR0cik7
CglpZiAoZXJyKQoJCWdvdG8gZXhpdF9yZW1vdmU7CgoJZXJyID0gZGV2aWNlX2NyZWF0ZV9m
aWxlKCZwZGV2LT5kZXYsICZkZXZfYXR0cl9uYW1lKTsKCWlmIChlcnIpCgkJZ290byBleGl0
X3JlbW92ZTsKCglkYXRhLT5od21vbl9kZXYgPSBod21vbl9kZXZpY2VfcmVnaXN0ZXIoJnBk
ZXYtPmRldik7CgoJaWYgKElTX0VSUihkYXRhLT5od21vbl9kZXYpKSB7CgkJZXJyID0gUFRS
X0VSUihkYXRhLT5od21vbl9kZXYpOwoJCWdvdG8gZXhpdF9yZW1vdmU7Cgl9CgoJcmV0dXJu
IDA7CgpleGl0X3JlbW92ZToKCWRldmljZV9yZW1vdmVfZmlsZSgmcGRldi0+ZGV2LAoJCQkg
ICAmc2Vuc29yX2Rldl9hdHRyX3RlbXAxX2lucHV0LmRldl9hdHRyKTsKCWRldmljZV9yZW1v
dmVfZmlsZSgmcGRldi0+ZGV2LCAmZGV2X2F0dHJfbmFtZSk7CmV4aXRfZnJlZToKCWRldl9z
ZXRfZHJ2ZGF0YSgmcGRldi0+ZGV2LCBOVUxMKTsKCWtmcmVlKGRhdGEpOwpleGl0OgoJcmV0
dXJuIGVycjsKfQoKc3RhdGljIHZvaWQgX19kZXZleGl0IGsxMHRlbXBfcmVtb3ZlKHN0cnVj
dCBwY2lfZGV2ICpwZGV2KQp7CglzdHJ1Y3QgazEwdGVtcF9kYXRhICpkYXRhID0gZGV2X2dl
dF9kcnZkYXRhKCZwZGV2LT5kZXYpOwoKCWh3bW9uX2RldmljZV91bnJlZ2lzdGVyKGRhdGEt
Pmh3bW9uX2Rldik7CglkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRldiwKCQkJICAgJnNl
bnNvcl9kZXZfYXR0cl90ZW1wMV9pbnB1dC5kZXZfYXR0cik7CglkZXZpY2VfcmVtb3ZlX2Zp
bGUoJnBkZXYtPmRldiwgJmRldl9hdHRyX25hbWUpOwoJZGV2X3NldF9kcnZkYXRhKCZwZGV2
LT5kZXYsIE5VTEwpOwoJa2ZyZWUoZGF0YSk7Cn0KCnN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZl
ciBrMTB0ZW1wX2RyaXZlciA9IHsKCS5uYW1lID0gImsxMHRlbXAiLAoJLmlkX3RhYmxlID0g
azEwdGVtcF9pZHMsCgkucHJvYmUgPSBrMTB0ZW1wX3Byb2JlLAoJLnJlbW92ZSA9IF9fZGV2
ZXhpdF9wKGsxMHRlbXBfcmVtb3ZlKSwKfTsKCnN0YXRpYyBpbnQgX19pbml0IGsxMHRlbXBf
aW5pdCh2b2lkKQp7CglyZXR1cm4gcGNpX3JlZ2lzdGVyX2RyaXZlcigmazEwdGVtcF9kcml2
ZXIpOwp9CgpzdGF0aWMgdm9pZCBfX2V4aXQgazEwdGVtcF9leGl0KHZvaWQpCnsKCXBjaV91
bnJlZ2lzdGVyX2RyaXZlcigmazEwdGVtcF9kcml2ZXIpOwp9CgpNT0RVTEVfQVVUSE9SKCJS
dWRvbGYgTWFyZWsgPHIubWFyZWtAYXNzZW1ibGVyLmN6PiIpOwpNT0RVTEVfREVTQ1JJUFRJ
T04oIkFNRCBLMTAgY29yZSB0ZW1wZXJhdHVyZSBtb25pdG9yIik7Ck1PRFVMRV9MSUNFTlNF
KCJHUEwiKTsKCm1vZHVsZV9pbml0KGsxMHRlbXBfaW5pdCkKbW9kdWxlX2V4aXQoazEwdGVt
cF9leGl0KQo=
--------------060203090905070201080504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060203090905070201080504--
