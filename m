From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Wed, 03 Dec 2008 18:25:10 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <79c9d4530812031025x7aac673fxbf2f761dd7ebce2c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2008/12/3 Jean Delvare <khali@linux-fr.org>:
> Hi all,
>
> Over the past few days, I have been working a lot on sensors-detect. I
> implemented ideas I had exposed months ago but did not have the time to
> implement back then:
>
> id      summary
> 2322    The probe order in sensors-detect doesn't make sense
> 2325    sensors-detect: Drop support for Linux 2.4
> 2327    sensors-detect: Fix the bus numbering prediction magic
> 2328    sensors-detect: Get the bus driver names from the kernel
> 2329    sensors-detect: Unload drivers which we loaded ourselves
>
> I also made a huge amount of cleanups (including a complete
> reindentation of the source code), reducing the size of the
> sensors-detect script from 185 kB to roughly 145 kB.
>
> With so many changes, both in functionality and implementation, I
> expect some fallouts. I tested my work on several machines already, but
> there are so many possible combinations of devices that it is rather
> unlikely that I managed to get everything right.
>
> So, I would like users to give a try to the latest version of
> sensors-detect and report if it works fine for them or not. You can get
> the latest version of sensors-detect using the following svn command:
>
> svn export http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect
>
> Alternatively, you can get a copy from trac:
> http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt
>
> The behavior should be essentially the same as before, with the
> difference that probes are done in reverse order (CPU, Super I/O, ISA,
> SMBus), and ISA and SMBus probes default to no if a working Super I/O
> was found (as was discussed on the list before [1].)
>
> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023056.html
>
> Thanks,
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>



Hi Jean,

Here is what I have with your version:

Driver `it87':
  * ISA bus, address 0xe80
    Chip `ITE IT8720F Super IO Sensors' (confidence: 9)

Driver `to-be-written':
  * Chip `AMD K10 thermal sensors' (confidence: 9)


And here is what I had with the previous one:

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0xe80
    Chip `ITE IT8720 Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
  Detects correctly:
  * Chip `AMD K10 thermal sensors' (confidence: 9)


I'm not 100% sur why I had a K8 before and a K10 with this new
version. I remember that I have apply a patch in the kernel to handle
Phenom internal sensors, but since this is kernel related, I think it
should have no impact on the sensors-detect script. I will try to
install and compile a brand next 2.6.27.7 kernel and retest.

JM

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
