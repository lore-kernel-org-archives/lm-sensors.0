From: Tom Metro <tmetro@tommetro.com>
Date: Fri, 29 Nov 2013 21:41:37 +0000
Subject: Re: [lm-sensors] coretemp readings are static/constant
Message-Id: <52990A11.8060001@tommetro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20131119T072701-70@post.gmane.org>
In-Reply-To: <loom.20131119T072701-70@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Tom Metro wrote:
>> % sensors
>> [...]
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:       +33.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>> Core 1:       +33.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>>
>> The values reported by coretemp are always 33000 millidegrees:
>=20
> You should really stress the CPU and see what happens.

I ran:

% stress --cpu 2 --timeout 7200
stress: info: [14967] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
stress: info: [14967] successful run completed in 7200s

And just to be sure, I also thew in a couple of these:

% dd bs=3D10 if=3D/dev/urandom | bzip2 -z -s -9 -c > /dev/null &

and let the latter run for 8 hours.

I saw some new peaks on the 'acpitz-virtual-0' sensors, but the
'coretemp-isa-0000' sensors didn't budge.


> Another possibility is that this particular incarnation of the sensors
> do not report values below 33=B0C.=20

Right, that was the theory I was going on based on the FAQ entry I
quoted. Apparently not the case here.


So this would appear to be a problem with the coretemp kernel module.
This CPU (Intel Core 2 Duo P8400) is from the right era to be supported
by coretemp. Where is the best place to go to file a bug against that
module?

Thanks for the suggestions.

 -Tom

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
