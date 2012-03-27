From: Jaromir Capik <jcapik@redhat.com>
Date: Tue, 27 Mar 2012 16:01:21 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect : PCI bus is always required even if it might be missing on
Message-Id: <340cc1c3-c774-4f21-ad05-0e5926698258@zmail15.collab.prod.int.phx2.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_7861bae9-ad4d-4924-8a2a-f160e409ecc2"
List-Id: <lm-sensors.vger.kernel.org>
References: <c838afb8-7576-42c2-abf6-ea56ca84daa3@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <c838afb8-7576-42c2-abf6-ea56ca84daa3@zmail15.collab.prod.int.phx2.redhat.com>
To: lm-sensors@vger.kernel.org

--=_7861bae9-ad4d-4924-8a2a-f160e409ecc2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Sorry. It wasn't the mailer, it was my brain :]

It should be attached now ...

BR, J.

----- Original Message -----
From: "Guenter Roeck" <guenter.roeck@ericsson.com>
To: "Jaromir Capik" <jcapik@redhat.com>
Cc: lm-sensors@lm-sensors.org
Sent: Tuesday, March 27, 2012 5:47:19 PM
Subject: Re: [lm-sensors] [PATCH] sensors-detect : PCI bus is always required even if it might be missing on some platforms

On Tue, 2012-03-27 at 11:19 -0400, Jaromir Capik wrote:
> Hello guys.
> 
> I was trying to autodetect sensors on my ARM based device (PandaBoard).
> This board doesn't have a PCI bus, but the sensors-detect script
> always expect one and then fails with the following message:
> 
> /sys/bus/pci/devices: No such file or directory at ./sensors-detect.bak line 2895.
> 
> The attached patch should avoid dying and returns empty PCI device list instead.
> 
Did you send it as attachment ? If so, the mailer might have removed it.

Please re-send, but not as attachment.

Thanks,
Guenter



--=_7861bae9-ad4d-4924-8a2a-f160e409ecc2
Content-Type: text/x-patch; name=lm_sensors-pci-not-required.patch
Content-Disposition: attachment; filename=lm_sensors-pci-not-required.patch
Content-Transfer-Encoding: base64

SW5kZXg6IHByb2cvZGV0ZWN0L3NlbnNvcnMtZGV0ZWN0Cj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHByb2cvZGV0
ZWN0L3NlbnNvcnMtZGV0ZWN0CShyZXZpc2lvbiA2MDM3KQorKysgcHJvZy9kZXRlY3Qvc2Vuc29y
cy1kZXRlY3QJKHdvcmtpbmcgY29weSkKQEAgLTI5OTYsNyArMjk5Niw3IEBACiAJbXkgKCRkZXYs
IEBwY2lfbGlzdCk7CiAKIAlvcGVuZGlyKGxvY2FsICpERVZJQ0VTLCAiJGRldmljZXMiKQotCQlv
ciBkaWUgIiRkZXZpY2VzOiAkISI7CisJCW9yIHJldHVybiBcQHBjaV9saXN0OwogCiAJd2hpbGUg
KGRlZmluZWQoJGRldiA9IHJlYWRkaXIoREVWSUNFUykpKSB7CiAJCW15ICVyZWNvcmQ7Cg==

--=_7861bae9-ad4d-4924-8a2a-f160e409ecc2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=_7861bae9-ad4d-4924-8a2a-f160e409ecc2--
