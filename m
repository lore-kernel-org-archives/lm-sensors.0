From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Jun 2011 07:34:13 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <20110618093413.2989f098@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dave,

On Sat, 18 Jun 2011 04:58:51 +0100 (BST), everythingsfree@lineone.net wrote:
> I've installed and set-up msr-tools after a quick look on-line=20
> on how to do so ('sudo apt-get install msr-tools' followed by 'sudo=20
> modprobe msr', let me know if that's missing something) and I get the=20
> following for your commands:
>=20
> $ sudo rdmsr -p 0 -x 0x19c
> 8600000
> $ sudo rdmsr -p 1 -x 0x19c
> 8630000
> $ sudo rdmsr -p 2 -x 0x19c
> 8630000
> $ sudo rdmsr -p 3 -x 0x19c
> 8600000
>=20
> Hope that helps.

The valid reading bit (31) is indeed never set, which is why the driver
returns an error (and in turn "sensors" returns N/A.)

The readings themselves don't look good anyway. 0x60 and 0x63 would
translate to offset values of 96 and 99, respectively. With a critical
limit at 100=B0C, that would lead to readings of 4=B0C and 1=B0C,
respectively, which is obviously incorrect.

I am wondering if maybe the valid reading bit gets cleared when the
measured temperature is too low, because it is known that the
reliability and accuracy of the digital thermal sensor get very poor
when too far below the critical limit. Durgaross, Fenghua, do you know
if this is the case? The CPU in question is an Atom D525 (family 6,
model 28, stepping 10).

Dave, please try putting as much load as possible on your CPU (e.g. by
running "md5sum /dev/zero" 4 times in parallel), and then run the rdmsr
commands again, every 20 seconds or so, for 5 minutes. It will be
interesting to see if the readings decrease (meaning higher
temperatures over time) and if the valid reading bit will get set at
some point.

When done, don't forget to kill the md5sum commands ;)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
