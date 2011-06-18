From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Jun 2011 12:14:18 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <20110618141418.098eb036@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dave,

OK, I have no other idea then. Hopefully the Intel folks can help.

With regards to "top", you can switch to multi-cpu display by pressing
"1".

Jean

On Sat, 18 Jun 2011 12:39:38 +0100 (BST), everythingsfree@lineone.net wrote:
> Hi Jean,
>=20
> I did as you ask but the values being returned were no=20
> different to those before.  I checked with 'top' to make sure the CPU=20
> was being loaded and sure enough there were four 'md5sum' processes=20
> running at 100%, it also reported that the 'Cpu(s)' were around 92%us=20
> (oddly it only reported one line for the CPUs when I expected two lines=20
> for each core at least, perhaps even four lines given hyper-
> threading).  I let it run for ten minutes just to be sure.
>=20
> Hope that=20
> helps.
>=20
> Cheers,
> Dave
>=20
>=20
> >----Original Message----
> >From: khali@linux-fr.
> org
> >Date: 18/06/2011 8:34=20
> >To: "Dave"<everythingsfree@lineone.net>
>=20
> >Cc: <guenter.roeck@ericsson.com>, <lm-sensors@lm-sensors.org>,=20
> "Durgadoss R"<durgadoss.r@intel.com>, "Yu, Fenghua"<fenghua.yu@intel.
> com>
> >Subj: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
> >
> >Hi=20
> Dave,
> >
> >On Sat, 18 Jun 2011 04:58:51 +0100 (BST),=20
> everythingsfree@lineone.net wrote:
> >> I've installed and set-up msr-
> tools after a quick look on-line=20
> >> on how to do so ('sudo apt-get=20
> install msr-tools' followed by 'sudo=20
> >> modprobe msr', let me know if=20
> that's missing something) and I get the=20
> >> following for your=20
> commands:
> >>=20
> >> $ sudo rdmsr -p 0 -x 0x19c
> >> 8600000
> >> $ sudo rdmsr -
> p 1 -x 0x19c
> >> 8630000
> >> $ sudo rdmsr -p 2 -x 0x19c
> >> 8630000
> >> $=20
> sudo rdmsr -p 3 -x 0x19c
> >> 8600000
> >>=20
> >> Hope that helps.
> >
> >The=20
> valid reading bit (31) is indeed never set, which is why the driver
>=20
> >returns an error (and in turn "sensors" returns N/A.)
> >
> >The readings=20
> themselves don't look good anyway. 0x60 and 0x63 would
> >translate to=20
> offset values of 96 and 99, respectively. With a critical
> >limit at 100=B0
> C, that would lead to readings of 4=B0C and 1=B0C,
> >respectively, which is=20
> obviously incorrect.
> >
> >I am wondering if maybe the valid reading bit=20
> gets cleared when the
> >measured temperature is too low, because it is=20
> known that the
> >reliability and accuracy of the digital thermal sensor=20
> get very poor
> >when too far below the critical limit. Durgaross,=20
> Fenghua, do you know
> >if this is the case? The CPU in question is an=20
> Atom D525 (family 6,
> >model 28, stepping 10).
> >
> >Dave, please try=20
> putting as much load as possible on your CPU (e.g. by
> >running "md5sum=20
> /dev/zero" 4 times in parallel), and then run the rdmsr
> >commands=20
> again, every 20 seconds or so, for 5 minutes. It will be
> >interesting=20
> to see if the readings decrease (meaning higher
> >temperatures over=20
> time) and if the valid reading bit will get set at
> >some point.
> >
> >When=20
> done, don't forget to kill the md5sum commands ;)
> >
> >--=20
> >Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
