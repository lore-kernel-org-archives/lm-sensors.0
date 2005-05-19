From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <40DCA811.4080206@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

A clarification:

The w83l785ts error handling is in the 2.6 kernel version only.

The adm1021 driver has error handling in the 2.4 kernel version only.

mds


Jean Delvare wrote:
>>I was reading through the lm87 code and noted (unless I am missing
>>something...highly possible) that an error return code from the I2C layer
>>seems to be ignored.  First off, am I reading this right, and secondly
>>is this on purpose (i.e. is there some reason that this is the right thing
>>to do that I am not getting)?
>=20
>=20
> Please review the 50 other chip drivers. If you can find one which *does*
> handle i2c-layer errors properly, let me know ;) [1]
>=20
> More seriously, no, you're not missing anything. All our drivers are
> shamelessly ignoring errors. This has been reported many times, see for
> example these tickets:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticketQ7
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=855
> And there's probably more in both the ticket base and the mailing-list
> archive.
>=20
> The (bad) reason behind this is that most likely, if there are read
> errors, the driver will be unusable anyway.
>=20
> [1] The only driver handling the errors correctly as far as I know is the
> w83l785ts. I implemented it because there is a popular Asus board using
> this chip and Asus' C.O.P. "feature" interacts with the chip
> repeatedly, causing frequent (as in a few percents) read errors.
> Detecting such errors and retrying reading fixes the problem in most
> cases.
>=20
> A similar method could be implemented in other chips, but when people
> complain, we usually spend time trying to fix their bus (either driver
> or hardware) instead, since that's what is really needed.
>=20
> At any rate, I would not work on this in 2.4 anymore, but more likely in
> 2.6, where having more "serious" drivers would be welcome.
>=20
> Thanks,
> Jean Delvare
>=20
>=20
