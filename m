From: Dag Wieers <dag@wieers.com>
Date: Wed, 06 Feb 2013 23:27:09 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302070020520.2736@pikachu.3ti.be>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="683428207-1295844495-1360192938=:2736"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--683428207-1295844495-1360192938=:2736
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15; FORMAT=flowed
Content-ID: <alpine.LRH.2.02.1302070022391.2736@pikachu.3ti.be>
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Feb 2013, Jean Delvare wrote:

> On Wed, 6 Feb 2013 15:00:58 +0100 (CET), Dag Wieers wrote:
>> On Wed, 6 Feb 2013, Jean Delvare wrote:
>>
>>> Not good. This can mean one of two things: either the chip has no
>>> register 0x3f and it nacks non-existent register read attempts, or it
>>> doesn't support SMBus read byte transactions at all. In the latter
>>> case, I strongly suggest that you leave the chip alone. As for the
>>> former case, there are a few thermal sensor chips which behave like,
>>> don't have a register at 0x3f and can use slave address 0x48: DS1621
>>> and similar, DS75, LM73.
>>
>> It now consistently returns 0x3d, could this be a thermal value, like =
61=B0C ?
>
> Could be, but for now all I see is that 0x3d =3D=3D 0x3f - 0x02, i.e. o=
nly
> one bit changed. You will need to take more samples before you can draw
> a conclusion. Also compare when CU is idle and when it's busy.

So I have been reading out different values over time, but when=20
repeatedly asked it provides the same value:

----
root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse=
!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n]
0x3d

root ~ # gputemp
46 C
----

----
root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse=
!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n]
0x43

root ~ # gputemp
52 C
----

----
root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse=
!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n]
0x4b

root ~ # gputemp
58 C
----

It pretty much looks like a thermal sensor, much in sync with the GPU=20
temperature. How would I continue ?

--=20
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]
--683428207-1295844495-1360192938=:2736
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--683428207-1295844495-1360192938=:2736--
